import React, { useState, useEffect } from 'react';
import { useAuth } from '../../context/AuthContext';

const SupportStatManagement = () => {
  const { API_URL, token } = useAuth();
  const [items, setItems] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [success, setSuccess] = useState(null);
  const [page, setPage] = useState(1);
  const [limit, setLimit] = useState(10);

  // Add form state
  const [newStat, setNewStat] = useState('');
  const [newDescription, setNewDescription] = useState('');
  const [newRemark, setNewRemark] = useState('');

  // Edit inline state
  const [editingId, setEditingId] = useState(null);
  const [editingDescription, setEditingDescription] = useState('');
  const [editingRemark, setEditingRemark] = useState('');

  const totalItems = items.length;
  const totalPages = Math.ceil(totalItems / limit);
  const indexOfLastItem = page * limit;
  const indexOfFirstItem = indexOfLastItem - limit;
  const currentItems = items.slice(indexOfFirstItem, indexOfLastItem);

  const fetchItems = async () => {
    try {
      const response = await fetch(`${API_URL}/tickets/config/support-stats`, {
        headers: { 'Authorization': `Bearer ${token}` }
      });
      if (!response.ok) throw new Error('Failed to fetch SupportStats');
      const data = await response.json();
      setItems(data);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchItems();
  }, []);

  const handleAdd = async (e) => {
    e.preventDefault();
    if (!newStat.trim() || !newDescription.trim()) return;
    setError(null);
    setSuccess(null);
    try {
      const response = await fetch(`${API_URL}/tickets/config/support-stats`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify({
          stat: newStat.toUpperCase().trim(),
          description: newDescription.trim(),
          remark: newRemark.trim()
        })
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || 'Failed to add SupportStat');
      }

      await fetchItems();
      setNewStat('');
      setNewDescription('');
      setNewRemark('');
      setSuccess('เพิ่มสถานะ SupportStat สำเร็จแล้ว! 🎉');
      setTimeout(() => setSuccess(null), 3000);
    } catch (err) {
      setError(err.message);
    }
  };

  const handleUpdate = async (stat) => {
    if (!editingDescription.trim()) return;
    setError(null);
    setSuccess(null);
    try {
      const response = await fetch(`${API_URL}/tickets/config/support-stats/${stat}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify({
          description: editingDescription.trim(),
          remark: editingRemark.trim()
        })
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || 'Failed to update SupportStat');
      }

      await fetchItems();
      setEditingId(null);
      setEditingDescription('');
      setEditingRemark('');
      setSuccess('อัปเดตสถานะ SupportStat สำเร็จแล้ว! 💾');
      setTimeout(() => setSuccess(null), 3000);
    } catch (err) {
      setError(err.message);
    }
  };

  const handleDelete = async (stat) => {
    if (!window.confirm(`คุณต้องการลบสถานะ SupportStat "${stat}" ใช่หรือไม่? ❌`)) return;
    setError(null);
    setSuccess(null);
    try {
      const response = await fetch(`${API_URL}/tickets/config/support-stats/${stat}`, {
        method: 'DELETE',
        headers: { 'Authorization': `Bearer ${token}` }
      });
      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || 'Failed to delete SupportStat');
      }
      await fetchItems();
      setSuccess('ลบสถานะ SupportStat สำเร็จแล้ว! 🗑️');
      setTimeout(() => setSuccess(null), 3000);
    } catch (err) {
      setError(err.message);
    }
  };

  if (loading) return (
    <div style={{ textAlign: 'center', padding: '4rem 0' }}>
      <div style={{ display: 'inline-block', width: '30px', height: '30px', border: '3px solid rgba(0,0,0,0.1)', borderTopColor: 'var(--accent-purple, #8b5cf6)', borderRadius: '50%', animation: 'spin 1s linear infinite' }}></div>
      <p style={{ marginTop: '1rem', color: '#64748b' }}>กำลังโหลดข้อมูล SupportStat...</p>
    </div>
  );

  return (
    <div className="glass-card" style={{ padding: '2rem', textAlign: 'left' }}>
      <h3 style={{ fontSize: '1.25rem', marginBottom: '1.25rem', color: '#0f172a', borderBottom: '1px solid var(--glass-border)', paddingBottom: '0.75rem' }}>
        📊 จัดการสถานะและผลดำเนินงาน (SupportStat)
      </h3>

      {error && <div className="alert-box alert-error" style={{ marginBottom: '1rem' }}><span>{error}</span></div>}
      {success && <div className="alert-box alert-success" style={{ marginBottom: '1rem', background: 'rgba(16, 185, 129, 0.1)', color: '#10b981', border: '1px solid rgba(16, 185, 129, 0.2)' }}><span>{success}</span></div>}

      <form onSubmit={handleAdd} style={{ display: 'flex', gap: '0.75rem', marginBottom: '1.5rem', flexWrap: 'wrap' }}>
        <input
          type="text"
          className="glass-input"
          placeholder="Stat Code (เช่น C, D)"
          value={newStat}
          onChange={(e) => setNewStat(e.target.value)}
          maxLength={5}
          required
          style={{ margin: 0, flex: 1, minWidth: '120px' }}
        />
        <input
          type="text"
          className="glass-input"
          placeholder="รายละเอียด (เช่น 999-Closed)"
          value={newDescription}
          onChange={(e) => setNewDescription(e.target.value)}
          required
          style={{ margin: 0, flex: 2, minWidth: '200px' }}
        />
        <input
          type="text"
          className="glass-input"
          placeholder="หมายเหตุ (Remark)"
          value={newRemark}
          onChange={(e) => setNewRemark(e.target.value)}
          style={{ margin: 0, flex: 2, minWidth: '200px' }}
        />
        <button type="submit" className="btn btn-primary" disabled={!newStat.trim() || !newDescription.trim()} style={{ padding: '0.75rem 2.5rem', whiteSpace: 'nowrap' }}>
          ➕ เพิ่มสถานะ
        </button>
      </form>

      {/* Pagination Controls Top */}
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1rem', fontSize: '0.9rem' }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
          <span>แสดง</span>
          <select 
            value={limit} 
            onChange={(e) => { setLimit(Number(e.target.value)); setPage(1); }}
            className="glass-input"
            style={{ margin: 0, padding: '0.2rem 0.5rem', minWidth: '60px' }}
          >
            <option value={10}>10</option>
            <option value={20}>20</option>
            <option value={40}>40</option>
            <option value={80}>80</option>
            <option value={100}>100</option>
          </select>
          <span>รายการ/หน้า</span>
        </div>
        <div style={{ color: '#64748b' }}>
          รวม {totalItems} รายการ (หน้า {page}/{totalPages || 1})
        </div>
      </div>

      <div style={{ overflowX: 'auto', marginBottom: '1rem' }}>
        <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.95rem', color: '#0f172a' }}>
          <thead>
            <tr style={{ borderBottom: '2.5px solid var(--glass-border)', color: '#475569', fontWeight: 600, fontSize: '0.85rem', textTransform: 'uppercase', letterSpacing: '0.04em', background: 'rgba(0, 0, 0, 0.015)' }}>
              <th style={{ padding: '1rem 0.75rem', textAlign: 'left', width: '20%' }}>Stat</th>
              <th style={{ padding: '1rem 0.75rem', textAlign: 'left', width: '35%' }}>Description</th>
              <th style={{ padding: '1rem 0.75rem', textAlign: 'left', width: '25%' }}>Remark</th>
              <th style={{ padding: '1rem 0.75rem', textAlign: 'center', width: '20%' }}>Action</th>
            </tr>
          </thead>
          <tbody>
            {items.length === 0 ? (
              <tr>
                <td colSpan="4" style={{ textAlign: 'center', padding: '2rem', color: '#64748b' }}>ยังไม่มีข้อมูล SupportStat</td>
              </tr>
            ) : (
              currentItems.map(item => (
                <tr key={item.stat} style={{ borderBottom: '1px solid var(--glass-border)', transition: 'background-color 0.2s' }}
                    onMouseEnter={(e) => e.currentTarget.style.backgroundColor = 'rgba(0, 75, 181, 0.02)'}
                    onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'transparent'}>
                  <td style={{ padding: '1rem 0.75rem', fontWeight: 600 }}>
                    {item.stat}
                  </td>
                  <td style={{ padding: '1rem 0.75rem' }}>
                    {editingId === item.stat ? (
                      <input
                        type="text"
                        className="glass-input"
                        value={editingDescription}
                        onChange={(e) => setEditingDescription(e.target.value)}
                        style={{ margin: 0, padding: '0.25rem 0.5rem', fontSize: '0.95rem', width: '100%' }}
                        autoFocus
                      />
                    ) : (
                      item.description
                    )}
                  </td>
                  <td style={{ padding: '1rem 0.75rem', color: '#64748b' }}>
                    {editingId === item.stat ? (
                      <input
                        type="text"
                        className="glass-input"
                        value={editingRemark}
                        onChange={(e) => setEditingRemark(e.target.value)}
                        style={{ margin: 0, padding: '0.25rem 0.5rem', fontSize: '0.95rem', width: '100%' }}
                      />
                    ) : (
                      item.remark || '-'
                    )}
                  </td>
                  <td style={{ padding: '0.5rem 0.75rem', textAlign: 'center' }}>
                    {editingId === item.stat ? (
                      <div style={{ display: 'flex', gap: '0.5rem', justifyContent: 'center' }}>
                        <button className="btn btn-primary" onClick={() => handleUpdate(item.stat)} style={{ padding: '0.35rem 0.75rem', fontSize: '0.8rem', borderRadius: '8px', whiteSpace: 'nowrap' }}>
                          💾 บันทึก
                        </button>
                        <button className="btn btn-secondary" onClick={() => { setEditingId(null); setEditingDescription(''); setEditingRemark(''); }} style={{ padding: '0.35rem 0.75rem', fontSize: '0.8rem', borderRadius: '8px', whiteSpace: 'nowrap' }}>
                          ❌ ยกเลิก
                        </button>
                      </div>
                    ) : (
                      <div style={{ display: 'flex', gap: '0.5rem', justifyContent: 'center' }}>
                        <button
                          className="btn btn-secondary"
                          onClick={() => {
                            setEditingId(item.stat);
                            setEditingDescription(item.description);
                            setEditingRemark(item.remark || '');
                          }}
                          style={{ padding: '0.35rem 0.75rem', fontSize: '0.8rem', borderRadius: '8px', whiteSpace: 'nowrap' }}
                        >
                          ✏️ แก้ไข
                        </button>
                        <button
                          className="btn btn-danger"
                          onClick={() => handleDelete(item.stat)}
                          style={{ padding: '0.35rem 0.75rem', fontSize: '0.8rem', borderRadius: '8px', whiteSpace: 'nowrap' }}
                        >
                          🗑️ ลบ
                        </button>
                      </div>
                    )}
                  </td>
                </tr>
              ))
            )}
          </tbody>
        </table>
      </div>

      {/* Pagination Controls Bottom */}
      {totalPages > 1 && (
        <div style={{ display: 'flex', justifyContent: 'center', gap: '0.5rem', marginTop: '1rem' }}>
          <button 
            className="btn btn-secondary" 
            disabled={page === 1}
            onClick={() => setPage(page - 1)}
            style={{ padding: '0.5rem 1rem' }}
          >
            &laquo; ก่อนหน้า
          </button>
          
          <div style={{ display: 'flex', alignItems: 'center', padding: '0 1rem', fontWeight: 600 }}>
            {page} / {totalPages}
          </div>

          <button 
            className="btn btn-secondary" 
            disabled={page >= totalPages}
            onClick={() => setPage(page + 1)}
            style={{ padding: '0.5rem 1rem' }}
          >
            ถัดไป &raquo;
          </button>
        </div>
      )}
    </div>
  );
};

export default SupportStatManagement;
