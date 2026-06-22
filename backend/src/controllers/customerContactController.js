import pool from '../config/db.js';

// Get all customer contacts
export const getContacts = async (req, res) => {
  try {
    let result;
    if (req.user.role === 'customer') {
      result = await pool.query('SELECT * FROM customer_contacts WHERE cust_num = $1 ORDER BY contact_name ASC', [req.user.cust_num]);
    } else {
      result = await pool.query('SELECT * FROM customer_contacts ORDER BY contact_name ASC');
    }
    res.status(200).json(result.rows);
  } catch (error) {
    console.error('Error fetching customer contacts:', error);
    res.status(500).json({ error: 'Server error while fetching customer contacts' });
  }
};

// Create a new customer contact
export const createContact = async (req, res) => {
  const { contact_name, cust_num, first_name, last_name, department, email, phone, tel } = req.body;
  try {
    const result = await pool.query(
      `INSERT INTO customer_contacts (contact_name, cust_num, first_name, last_name, department, email, phone, tel)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *`,
      [contact_name, cust_num, first_name, last_name, department, email, phone, tel]
    );
    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error('Error creating customer contact:', error);
    res.status(500).json({ error: 'Server error while creating customer contact' });
  }
};

// Update an existing customer contact
export const updateContact = async (req, res) => {
  const { id } = req.params;
  const { contact_name, cust_num, first_name, last_name, department, email, phone, tel } = req.body;
  try {
    const result = await pool.query(
      `UPDATE customer_contacts
       SET contact_name = $1, cust_num = $2, first_name = $3, last_name = $4, department = $5, email = $6, phone = $7, tel = $8, updated_at = CURRENT_TIMESTAMP
       WHERE id = $9 RETURNING *`,
      [contact_name, cust_num, first_name, last_name, department, email, phone, tel, id]
    );

    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'Customer contact not found' });
    }

    res.status(200).json(result.rows[0]);
  } catch (error) {
    console.error('Error updating customer contact:', error);
    res.status(500).json({ error: 'Server error while updating customer contact' });
  }
};

// Delete a customer contact
export const deleteContact = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await pool.query('DELETE FROM customer_contacts WHERE id = $1 RETURNING *', [id]);
    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'Customer contact not found' });
    }
    res.status(200).json({ message: 'Customer contact deleted successfully' });
  } catch (error) {
    console.error('Error deleting customer contact:', error);
    res.status(500).json({ error: 'Server error while deleting customer contact' });
  }
};
