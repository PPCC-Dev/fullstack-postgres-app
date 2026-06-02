import pool from '../config/db.js';

// 1. Get all notifications for current user
export const getNotifications = async (req, res) => {
  const userId = req.user.id;
  try {
    const result = await pool.query(
      `SELECT * FROM notifications 
       WHERE user_id = $1 
       ORDER BY created_at DESC 
       LIMIT 100`,
      [userId]
    );
    return res.status(200).json(result.rows);
  } catch (error) {
    console.error('Error fetching notifications:', error);
    return res.status(500).json({ error: 'Server error while fetching notifications.' });
  }
};

// 2. Mark a notification as read
export const markAsRead = async (req, res) => {
  const userId = req.user.id;
  const notificationId = req.params.id;
  try {
    const result = await pool.query(
      `UPDATE notifications 
       SET is_read = TRUE 
       WHERE id = $1 AND user_id = $2 
       RETURNING *`,
      [notificationId, userId]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Notification not found or access denied.' });
    }

    return res.status(200).json(result.rows[0]);
  } catch (error) {
    console.error('Error marking notification as read:', error);
    return res.status(500).json({ error: 'Server error while updating notification.' });
  }
};

// 3. Mark all notifications of current user as read
export const markAllAsRead = async (req, res) => {
  const userId = req.user.id;
  try {
    await pool.query(
      `UPDATE notifications 
       SET is_read = TRUE 
       WHERE user_id = $1`,
      [userId]
    );
    return res.status(200).json({ message: 'All notifications marked as read successfully.' });
  } catch (error) {
    console.error('Error marking all notifications as read:', error);
    return res.status(500).json({ error: 'Server error while updating notifications.' });
  }
};
