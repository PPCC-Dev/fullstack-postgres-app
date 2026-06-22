import React, { useState, useEffect } from 'react';
import { useAuth } from '../../context/AuthContext';

export default function CustomerContactManagement() {
  const { token, API_URL } = useAuth();
  const [contacts, setContacts] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');
  
  // Pagination
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage, setItemsPerPage] = useState(10);
  const [searchQuery, setSearchQuery] = useState('');
  const [customers, setCustomers] = useState([]);

  // Form State
  const [isEditing, setIsEditing] = useState(false);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [formData, setFormData] = useState({
    id: null,
    contact_name: '',
    cust_num: '',
    first_name: '',
    last_name: '',
    department: '',
    email: '',
    phone: '',
    tel: ''
  });

  const fetchContacts = async () => {
    setLoading(true);
    try {
      const response = await fetch(`${API_URL}/contacts`, {
        headers: { 'Authorization': `Bearer ${token}` }
      });
      if (response.ok) {
        const data = await response.json();
        setContacts(data);
      } else {
        throw new Error('Failed to fetch contacts');
      }
    } catch (err) {
      console.error(err);
      setError('ไม่สามารถโหลดข้อมูลสัญญาลูกค้าได้');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchContacts();
    
    const fetchCustomers = async () => {
      try {
        const response = await fetch(`${API_URL}/customers`, {
          headers: { 'Authorization': `Bearer ${token}` }
        });
        if (response.ok) {
          const data = await response.json();
          setCustomers(data);
        }
      } catch (err) {
        console.error('Error fetching customers:', err);
      }
    };
    
    if (token) {
      fetchCustomers();
    }
  }, [token]);

  useEffect(() => {
    if (success || error) {
      const timer = setTimeout(() => {
        setSuccess('');
        setError('');
      }, 3000);
      return () => clearTimeout(timer);
    }
  }, [success, error]);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  };

  const handleEdit = (contact) => {
    setFormData(contact);
    setIsEditing(true);
    setIsModalOpen(true);
  };

  const handleCancel = () => {
    setFormData({ id: null, contact_name: '', cust_num: '', first_name: '', last_name: '', department: '', email: '', phone: '', tel: '' });
    setIsEditing(false);
    setIsModalOpen(false);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setSuccess('');
    setLoading(true);

    try {
      const url = isEditing ? `${API_URL}/contacts/${formData.id}` : `${API_URL}/contacts`;
      const method = isEditing ? 'PUT' : 'POST';

      const response = await fetch(url, {
        method,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify(formData)
      });

      const data = await response.json();
      if (!response.ok) throw new Error(data.error || 'Operation failed');

      setSuccess(isEditing ? 'อัปเดตข้อมูลเรียบร้อยแล้ว' : 'เพิ่มข้อมูลเรียบร้อยแล้ว');
      handleCancel();
      await fetchContacts();
    } catch (err) {
      console.error(err);
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id) => {
    if (!window.confirm('คุณแน่ใจหรือไม่ที่จะลบข้อมูลนี้?')) return;
    setError('');
    setSuccess('');
    setLoading(true);

    try {
      const response = await fetch(`${API_URL}/contacts/${id}`, {
        method: 'DELETE',
        headers: {
          'Authorization': `Bearer ${token}`
        }
      });

      if (!response.ok) {
        const data = await response.json();
        throw new Error(data.error || 'Failed to delete');
      }

      setSuccess('ลบข้อมูลเรียบร้อยแล้ว');
      await fetchContacts();
    } catch (err) {
      console.error(err);
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  // Filter and Pagination
  const filteredContacts = contacts.filter(c => 
    (c.contact_name || '').toLowerCase().includes(searchQuery.toLowerCase()) ||
    (c.cust_num || '').toLowerCase().includes(searchQuery.toLowerCase()) ||
    (c.first_name || '').toLowerCase().includes(searchQuery.toLowerCase()) ||
    (c.email || '').toLowerCase().includes(searchQuery.toLowerCase())
  );

  const totalPages = Math.ceil(filteredContacts.length / itemsPerPage);
  const startIndex = (currentPage - 1) * itemsPerPage;
  const currentItems = filteredContacts.slice(startIndex, startIndex + itemsPerPage);

  return (
    <div className="glass-card" style={{ padding: '2rem', textAlign: 'left' }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.25rem', borderBottom: '1px solid var(--glass-border)', paddingBottom: '0.75rem' }}>
        <h3 style={{ fontSize: '1.25rem', color: '#0f172a', margin: 0 }}>
          📋 ข้อมูลผู้ติดต่อ (Customer Contacts)
        </h3>
        <button 
          onClick={() => { setIsEditing(false); setIsModalOpen(true); }} 
          className="btn btn-primary" 
          style={{ padding: '0.5rem 1.25rem', display: 'flex', alignItems: 'center', gap: '0.5rem', borderRadius: '10px', fontSize: '0.9rem' }}
        >
          <span>➕ เพิ่มข้อมูล</span>
        </button>
      </div>

      {error && <div className="alert-box alert-error" style={{ marginBottom: '1rem' }}><span>{error}</span></div>}
      {success && <div className="alert-box alert-success" style={{ marginBottom: '1rem', background: 'rgba(16,185,129,0.15)', border: '1px solid rgba(16,185,129,0.3)', color: '#10b981' }}><span>{success}</span></div>}

      {/* Modal Popup Form for Adding/Editing Contact */}
      {isModalOpen && (
        <div style={{
          position: 'fixed',
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          background: 'rgba(15, 23, 42, 0.45)',
          backdropFilter: 'blur(8px)',
          display: 'flex',
          justifyContent: 'center',
          alignItems: 'center',
          zIndex: 1000
        }}>
          <div className="glass-card" style={{
            width: '100%',
            maxWidth: '650px',
            padding: '2rem',
            background: '#ffffff',
            boxShadow: '0 20px 25px -5px rgba(0,0,0,0.1), 0 10px 10px -5px rgba(0,0,0,0.04)',
            borderRadius: '16px',
            border: '1px solid var(--glass-border)',
            textAlign: 'left',
            maxHeight: '90vh',
            overflowY: 'auto'
          }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem', borderBottom: '1px solid var(--glass-border)', paddingBottom: '0.75rem' }}>
              <h4 style={{ fontSize: '1.15rem', fontWeight: 700, color: '#0f172a', margin: 0 }}>
                {isEditing ? '✏️ แก้ไขข้อมูลผู้ติดต่อ (Edit Contact)' : '➕ เพิ่มข้อมูลผู้ติดต่อ (Add Contact)'}
              </h4>
              <button 
                onClick={handleCancel}
                style={{ background: 'none', border: 'none', fontSize: '1.25rem', cursor: 'pointer', color: '#64748b' }}
              >
                ✕
              </button>
            </div>

            <form onSubmit={handleSubmit}>
              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem', marginBottom: '1.5rem' }}>
                <div style={{ gridColumn: 'span 2' }}>
                  <label style={{ display: 'block', fontSize: '0.82rem', fontWeight: 600, color: '#475569', marginBottom: '0.35rem' }}>Contact Name *</label>
                  <input type="text" name="contact_name" className="glass-input" placeholder="Contact Name *" value={formData.contact_name} onChange={handleInputChange} required style={{ margin: 0, width: '100%' }} />
                </div>
                <div>
                  <label style={{ display: 'block', fontSize: '0.82rem', fontWeight: 600, color: '#475569', marginBottom: '0.35rem' }}>CustNum</label>
                  <select name="cust_num" className="glass-input" value={formData.cust_num} onChange={handleInputChange} style={{ margin: 0, width: '100%' }}>
                    <option value="">-- ไม่ระบุ (None) --</option>
                    {customers.map(c => (
                      <option key={c.id || c.cust_num} value={c.cust_num}>{c.cust_num} - {c.cust_name}</option>
                    ))}
                  </select>
                </div>
                <div>
                  <label style={{ display: 'block', fontSize: '0.82rem', fontWeight: 600, color: '#475569', marginBottom: '0.35rem' }}>First Name *</label>
                  <input type="text" name="first_name" className="glass-input" placeholder="First Name *" value={formData.first_name} onChange={handleInputChange} required style={{ margin: 0, width: '100%' }} />
                </div>
                <div>
                  <label style={{ display: 'block', fontSize: '0.82rem', fontWeight: 600, color: '#475569', marginBottom: '0.35rem' }}>Last Name</label>
                  <input type="text" name="last_name" className="glass-input" placeholder="Last Name" value={formData.last_name} onChange={handleInputChange} style={{ margin: 0, width: '100%' }} />
                </div>
                <div>
                  <label style={{ display: 'block', fontSize: '0.82rem', fontWeight: 600, color: '#475569', marginBottom: '0.35rem' }}>Department</label>
                  <input type="text" name="department" className="glass-input" placeholder="Department" value={formData.department} onChange={handleInputChange} style={{ margin: 0, width: '100%' }} />
                </div>
                <div style={{ gridColumn: 'span 2' }}>
                  <label style={{ display: 'block', fontSize: '0.82rem', fontWeight: 600, color: '#475569', marginBottom: '0.35rem' }}>E-mail</label>
                  <input type="email" name="email" className="glass-input" placeholder="E-mail" value={formData.email} onChange={handleInputChange} style={{ margin: 0, width: '100%' }} />
                </div>
                <div>
                  <label style={{ display: 'block', fontSize: '0.82rem', fontWeight: 600, color: '#475569', marginBottom: '0.35rem' }}>Phone</label>
                  <input type="text" name="phone" className="glass-input" placeholder="Phone" value={formData.phone} onChange={handleInputChange} style={{ margin: 0, width: '100%' }} />
                </div>
                <div>
                  <label style={{ display: 'block', fontSize: '0.82rem', fontWeight: 600, color: '#475569', marginBottom: '0.35rem' }}>Tel.</label>
                  <input type="text" name="tel" className="glass-input" placeholder="Tel." value={formData.tel} onChange={handleInputChange} style={{ margin: 0, width: '100%' }} />
                </div>
              </div>
              
              <div style={{ display: 'flex', gap: '0.75rem', justifyContent: 'flex-end', borderTop: '1px solid var(--glass-border)', paddingTop: '1.25rem' }}>
                <button type="button" className="btn btn-secondary" onClick={handleCancel} disabled={loading} style={{ padding: '0.6rem 1.5rem' }}>
                  ยกเลิก
                </button>
                <button type="submit" className="btn btn-primary" disabled={loading} style={{ padding: '0.6rem 1.75rem' }}>
                  {loading ? 'กำลังประมวลผล...' : (isEditing ? '💾 บันทึกการแก้ไข' : '💾 บันทึกข้อมูล')}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1rem', flexWrap: 'wrap', gap: '1rem' }}>
        <input 
          type="text" 
          placeholder="🔍 ค้นหา (Name, CustNum, Email)..." 
          className="glass-input" 
          style={{ width: '250px', margin: 0 }}
          value={searchQuery}
          onChange={(e) => { setSearchQuery(e.target.value); setCurrentPage(1); }}
        />
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', fontSize: '0.9rem' }}>
          <span>แสดง</span>
          <select 
            value={itemsPerPage} 
            onChange={(e) => { setItemsPerPage(Number(e.target.value)); setCurrentPage(1); }}
            className="glass-input"
            style={{ margin: 0, padding: '0.25rem 0.5rem' }}
          >
            <option value={10}>10</option>
            <option value={20}>20</option>
            <option value={50}>50</option>
          </select>
          <span>รายการ/หน้า</span>
        </div>
      </div>

      <div style={{ overflowX: 'auto' }}>
        <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.85rem' }}>
          <thead>
            <tr style={{ borderBottom: '2px solid var(--glass-border)', color: '#475569', textAlign: 'left', background: 'rgba(0,0,0,0.02)' }}>
              <th style={{ padding: '0.75rem' }}>ContactName</th>
              <th style={{ padding: '0.75rem' }}>CustNum</th>
              <th style={{ padding: '0.75rem' }}>Name</th>
              <th style={{ padding: '0.75rem' }}>Department</th>
              <th style={{ padding: '0.75rem' }}>Contact</th>
              <th style={{ padding: '0.75rem', textAlign: 'center' }}>Action</th>
            </tr>
          </thead>
          <tbody>
            {currentItems.length === 0 ? (
              <tr><td colSpan="6" style={{ textAlign: 'center', padding: '2rem', color: '#64748b' }}>ไม่มีข้อมูล</td></tr>
            ) : (
              currentItems.map(c => (
                <tr key={c.id} style={{ borderBottom: '1px solid var(--glass-border)', transition: 'background-color 0.2s' }} onMouseEnter={(e) => e.currentTarget.style.backgroundColor = 'rgba(0,0,0,0.02)'} onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'transparent'}>
                  <td style={{ padding: '0.75rem', fontWeight: 600 }}>{c.contact_name}</td>
                  <td style={{ padding: '0.75rem' }}>{c.cust_num}</td>
                  <td style={{ padding: '0.75rem' }}>{c.first_name} {c.last_name}</td>
                  <td style={{ padding: '0.75rem' }}>{c.department || '-'}</td>
                  <td style={{ padding: '0.75rem' }}>
                    <div>✉️ {c.email || '-'}</div>
                    {c.phone && <div>📱 {c.phone}</div>}
                    {c.tel && <div>☎️ {c.tel}</div>}
                  </td>
                  <td style={{ padding: '0.75rem', textAlign: 'center' }}>
                    <div style={{ display: 'flex', gap: '0.4rem', justifyContent: 'center' }}>
                      <button onClick={() => handleEdit(c)} className="btn btn-secondary" style={{ padding: '0.2rem 0.5rem', fontSize: '0.75rem' }}>✏️</button>
                      <button onClick={() => handleDelete(c.id)} className="btn btn-danger" style={{ padding: '0.2rem 0.5rem', fontSize: '0.75rem' }}>🗑️</button>
                    </div>
                  </td>
                </tr>
              ))
            )}
          </tbody>
        </table>
      </div>
      
      {totalPages > 1 && (
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: '1.5rem', fontSize: '0.85rem' }}>
          <button className="btn btn-secondary" onClick={() => setCurrentPage(p => Math.max(1, p - 1))} disabled={currentPage === 1} style={{ padding: '0.4rem 0.8rem' }}>&larr; ก่อนหน้า</button>
          <span>หน้า {currentPage} จาก {totalPages} (ทั้งหมด {filteredContacts.length} รายการ)</span>
          <button className="btn btn-secondary" onClick={() => setCurrentPage(p => Math.min(totalPages, p + 1))} disabled={currentPage === totalPages} style={{ padding: '0.4rem 0.8rem' }}>ถัดไป &rarr;</button>
        </div>
      )}
    </div>
  );
}
