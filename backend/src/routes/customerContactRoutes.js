import express from 'express';
import {
  getContacts,
  createContact,
  updateContact,
  deleteContact
} from '../controllers/customerContactController.js';
import { authenticateToken, requireAgent } from '../middleware/authMiddleware.js';

const router = express.Router();

// All routes require authentication
router.use(authenticateToken);

// GET is accessible by everyone (filtered in controller)
router.get('/', getContacts);

// Create, Update, Delete require Agent or Admin role
router.use(requireAgent);
router.post('/', createContact);
router.put('/:id', updateContact);
router.delete('/:id', deleteContact);

export default router;
