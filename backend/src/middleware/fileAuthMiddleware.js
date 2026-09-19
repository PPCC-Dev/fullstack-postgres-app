import jwt from 'jsonwebtoken';
import dotenv from 'dotenv';
import path from 'path';
import pool from '../config/db.js';

dotenv.config();

const JWT_SECRET = process.env.JWT_SECRET;

if (!JWT_SECRET) {
  throw new Error('JWT_SECRET must be configured.');
}

/**
 * Middleware to secure static uploads access.
 * Accepts JWT from Authorization header OR ?token= query parameter (for <img> tags / browser tabs).
 * Enforces ownership check: Agents/Admins have full access, while Customers can only access files from tickets they own.
 */
export const fileAuthMiddleware = async (req, res, next) => {
  try {
    // 1. Extract token from header or query param
    const authHeader = req.headers['authorization'];
    const headerToken = authHeader && authHeader.split(' ')[1];
    const queryToken = req.query.token;
    const token = headerToken || queryToken;

    if (!token) {
      return res.status(401).json({ error: 'Access denied. Authentication token required to access uploaded files.' });
    }

    // 2. Verify JWT
    let verified;
    try {
      verified = jwt.verify(token, JWT_SECRET);
    } catch (jwtErr) {
      return res.status(403).json({ error: 'Invalid or expired token.' });
    }

    // 3. Fetch fresh user role and cust_num
    const userResult = await pool.query(
      `SELECT u.id, u.role as user_role, COALESCE(r.base_role, u.role) as base_role, u.cust_num
       FROM users u
       LEFT JOIN roles r ON LOWER(u.role) = LOWER(r.name)
       WHERE u.id = $1`,
      [verified.id]
    );

    if (userResult.rows.length === 0) {
      return res.status(401).json({ error: 'User not found.' });
    }

    const user = userResult.rows[0];
    const userRole = (user.base_role || user.user_role || '').toLowerCase();

    // 4. Admin and Agent have access to all ticket files
    if (userRole === 'admin' || userRole === 'agent') {
      return next();
    }

    // 5. Customer: verify ownership of the ticket the file is attached to
    const requestedFileName = path.basename(req.path);

    // Check ticket_attachments table
    const attachmentCheck = await pool.query(
      `SELECT t.customer_id, t.cust_num 
       FROM ticket_attachments ta
       JOIN tickets t ON ta.ticket_id = t.id
       WHERE ta.file_url LIKE $1
       LIMIT 1`,
      [`%${requestedFileName}`]
    );

    if (attachmentCheck.rows.length > 0) {
      const ticket = attachmentCheck.rows[0];
      const isOwner = ticket.customer_id === user.id || (user.cust_num && ticket.cust_num === user.cust_num);
      if (isOwner) {
        return next();
      }
      return res.status(403).json({ error: 'Access denied. You do not have permission to view this attachment.' });
    }

    // Check legacy tickets.attachment_url
    const legacyCheck = await pool.query(
      `SELECT customer_id, cust_num FROM tickets WHERE attachment_url LIKE $1 LIMIT 1`,
      [`%${requestedFileName}`]
    );

    if (legacyCheck.rows.length > 0) {
      const ticket = legacyCheck.rows[0];
      const isOwner = ticket.customer_id === user.id || (user.cust_num && ticket.cust_num === user.cust_num);
      if (isOwner) {
        return next();
      }
      return res.status(403).json({ error: 'Access denied. You do not have permission to view this attachment.' });
    }

    // If file is not associated with any customer ticket, restrict to admin/agent
    return res.status(403).json({ error: 'Access denied. File not accessible.' });
  } catch (err) {
    console.error('File auth middleware error:', err);
    return res.status(500).json({ error: 'Internal server error validating file access.' });
  }
};

