import React, { useState, useEffect } from 'react';
import { useAuth } from '../context/AuthContext';

export default function CustomerDashboard({ onViewTicket, refreshKey }) {
  const { user, token, API_URL } = useAuth();
  const [tickets, setTickets] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [statusFilter, setStatusFilter] = useState('active'); // Add status filter
  const [sortOption, setSortOption] = useState('date_desc'); // Add sort option
  const [ownerFilter, setOwnerFilter] = useState('all'); // 'all' or 'me'
  
  // Pagination state
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage, setItemsPerPage] = useState(20);

  useEffect(() => {
    setCurrentPage(1);
  }, [statusFilter, sortOption, ownerFilter]);
  // Dynamic configuration lists

  const [dbModules, setDbModules] = useState([]);
  const [dbProgramTypes, setDbProgramTypes] = useState([]);
  const [dbIssueTypes, setDbIssueTypes] = useState([]);
  const [dbCustomers, setDbCustomers] = useState([]);
  const [custNum, setCustNum] = useState('');

  const fetchTickets = async () => {
    try {
      const response = await fetch(`${API_URL}/tickets`, {
        headers: {
          'Authorization': `Bearer ${token}`
        }
      });

      if (!response.ok) {
        throw new Error('Failed to fetch your support tickets.');
      }

      const data = await response.json();
      setTickets(data);
    } catch (err) {
      console.error(err);
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const fetchConfig = async () => {
    try {
      const modRes = await fetch(`${API_URL}/tickets/config/modules`, {
        headers: { 'Authorization': `Bearer ${token}` }
      });
      if (modRes.ok) {
        const modData = await modRes.json();
        setDbModules(modData);
        if (modData.length > 0) setModule(modData[0].name);
      }

      const progRes = await fetch(`${API_URL}/tickets/config/program-types`, {
        headers: { 'Authorization': `Bearer ${token}` }
      });
      if (progRes.ok) {
        const progData = await progRes.json();
        setDbProgramTypes(progData);
        if (progData.length > 0) setProgramType(progData[0].name);
      }

      const issueRes = await fetch(`${API_URL}/tickets/config/issue-types`, {
        headers: { 'Authorization': `Bearer ${token}` }
      });
      if (issueRes.ok) {
        const issueData = await issueRes.json();
        setDbIssueTypes(issueData);
        if (issueData.length > 0) setIssueType(issueData[0].name);
      }

      const custRes = await fetch(`${API_URL}/customers`, {
        headers: { 'Authorization': `Bearer ${token}` }
      });
      if (custRes.ok) {
        const custData = await custRes.json();
        setDbCustomers(custData);
        if (custData.length > 0) {
          const matchedCustomer = custData.find(c => c.cust_name === user?.name);
          if (matchedCustomer) {
            setCustNum(matchedCustomer.cust_num);
          } else {
            setCustNum(custData[0].cust_num);
          }
        }
      }
    } catch (err) {
      console.error('Error fetching config:', err);
    }
  };

  useEffect(() => {
    if (token) {
      fetchTickets();
      fetchConfig();
    }
  }, [token, refreshKey]);

  // Filter by owner first
  const ownedFilteredTickets = tickets.filter(t => {
    if (ownerFilter === 'me') return t.customer_id === user?.id;
    return true;
  });

  // Stat calculations based on owner filter
  const totalTickets = ownedFilteredTickets.length;
  const activeTickets = ownedFilteredTickets.filter(t => [null, '', 'open', 'O', 'I', 'assigned'].includes(t.status)).length;
  const resolvedTickets = ownedFilteredTickets.filter(t => ['C', 'resolved'].includes(t.status)).length;

  // Filter and sort tickets for display
  const displayedTickets = ownedFilteredTickets
    .filter(t => {
      if (statusFilter === 'all') return true;
      if (statusFilter === 'active') return [null, '', 'open', 'O', 'I', 'assigned'].includes(t.status);
      if (statusFilter === 'resolved') return ['C', 'resolved'].includes(t.status);
      return true;
    })
    .sort((a, b) => {
      if (sortOption === 'date_desc') return new Date(b.created_at) - new Date(a.created_at);
      if (sortOption === 'date_asc') return new Date(a.created_at) - new Date(b.created_at);
      if (sortOption === 'id_desc') return b.id - a.id;
      if (sortOption === 'id_asc') return a.id - b.id;
      return 0;
    });

  const totalPages = Math.ceil(displayedTickets.length / itemsPerPage);
  const startIndex = (currentPage - 1) * itemsPerPage;
  const paginatedTickets = displayedTickets.slice(startIndex, startIndex + itemsPerPage);

  return (
    <div className="main-content">
      {/* Header section */}
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem', flexWrap: 'wrap', gap: '1rem' }}>
        <div>
          <h1 className="page-title-gradient">ศูนย์ช่วยเหลือของคุณ</h1>
          <p className="subtitle-text" style={{ marginBottom: 0 }}>ส่งคำขอความช่วยเหลือ ติดตามผล และพูดคุยกับเจ้าหน้าที่ของเราได้ตลอด 24 ชั่วโมง</p>
        </div>
      </div>

      {/* Stats row */}
      <div className="stats-grid">
        <div 
          className={`glass-card stat-card glow-purple ${statusFilter === 'active' ? 'selected' : ''}`} 
          style={{ '--card-border-color': 'var(--accent-purple)', cursor: 'pointer', transform: statusFilter === 'active' ? 'scale(1.02)' : 'none', border: statusFilter === 'active' ? '2px solid var(--accent-purple)' : '' }}
          onClick={() => setStatusFilter('active')}
        >
          <div className="stat-info">
            <span className="stat-label">อยู่ระหว่างดำเนินการ</span>
            <span className="stat-value">{activeTickets}</span>
          </div>
          <span className="stat-icon">⏳</span>
        </div>
        <div 
          className={`glass-card stat-card glow-cyan ${statusFilter === 'resolved' ? 'selected' : ''}`} 
          style={{ '--card-border-color': 'var(--status-resolved)', cursor: 'pointer', transform: statusFilter === 'resolved' ? 'scale(1.02)' : 'none', border: statusFilter === 'resolved' ? '2px solid var(--status-resolved)' : '' }}
          onClick={() => setStatusFilter('resolved')}
        >
          <div className="stat-info">
            <span className="stat-label">แก้ไขเสร็จสิ้นแล้ว</span>
            <span className="stat-value">{resolvedTickets}</span>
          </div>
          <span className="stat-icon">✅</span>
        </div>
        <div 
          className={`glass-card stat-card glow-cyan ${statusFilter === 'all' ? 'selected' : ''}`} 
          style={{ '--card-border-color': '#e2e8f0', cursor: 'pointer', transform: statusFilter === 'all' ? 'scale(1.02)' : 'none', border: statusFilter === 'all' ? '2px solid #94a3b8' : '' }}
          onClick={() => setStatusFilter('all')}
        >
          <div className="stat-info">
            <span className="stat-label">{ownerFilter === 'me' ? 'เคสทั้งหมดที่ฉันเปิด' : 'เคสทั้งหมดของบริษัท'}</span>
            <span className="stat-value">{totalTickets}</span>
          </div>
          <span className="stat-icon">📂</span>
        </div>
      </div>

      {/* Main Board Content */}
      <div className="dashboard-layout">
        <div className="tickets-container">
          <div className="section-header" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', flexWrap: 'wrap', gap: '1rem', borderBottom: '1px solid var(--glass-border)', paddingBottom: '1rem', marginBottom: '1.5rem' }}>
            <div style={{ display: 'flex', alignItems: 'baseline', gap: '1rem', flexWrap: 'wrap' }}>
              <h2 className="section-title" style={{ margin: 0, borderBottom: 'none', paddingBottom: 0, marginBottom: 0 }}>
                <span>📋</span> {ownerFilter === 'me' ? 'รายการคำขอช่วยเหลือที่คุณเปิด' : 'รายการคำขอช่วยเหลือของบริษัท'}
              </h2>
              <span style={{ fontSize: '0.85rem', color: '#64748b' }}>อัปเดตแบบเรียลไทม์</span>
            </div>
            <div style={{ display: 'flex', gap: '0.5rem', flexWrap: 'wrap', alignItems: 'center' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                <span style={{ fontSize: '0.85rem', color: '#475569' }}>แสดงหน้าละ:</span>
                <select 
                  className="glass-input" 
                  value={itemsPerPage} 
                  onChange={(e) => { setItemsPerPage(Number(e.target.value)); setCurrentPage(1); }}
                  style={{ margin: 0, padding: '0.35rem 1rem', fontSize: '0.85rem', width: 'auto', minWidth: '80px', borderRadius: '8px' }}
                >
                  <option value={20}>20</option>
                  <option value={30}>30</option>
                  <option value={40}>40</option>
                  <option value={50}>50</option>
                  <option value={100}>100</option>
                </select>
              </div>
              <select 
                className="glass-input" 
                value={ownerFilter} 
                onChange={(e) => setOwnerFilter(e.target.value)}
                style={{ margin: 0, padding: '0.35rem 1rem', fontSize: '0.85rem', width: 'auto', minWidth: '180px', borderRadius: '8px' }}
              >
                <option value="all">ดูเคสทั้งหมดของบริษัท</option>
                <option value="me">ดูเฉพาะเคสที่ฉันเป็นคนเปิด</option>
              </select>
              <select 
                className="glass-input" 
                value={sortOption} 
                onChange={(e) => setSortOption(e.target.value)}
                style={{ margin: 0, padding: '0.35rem 1rem', fontSize: '0.85rem', width: 'auto', minWidth: '220px', borderRadius: '8px' }}
              >
                <option value="date_desc">เรียง: วันที่เปิดเคส (ใหม่ล่าสุด)</option>
                <option value="date_asc">เรียง: วันที่เปิดเคส (เก่าสุด)</option>
                <option value="id_desc">เรียง: Ticket ID (มาก-น้อย)</option>
                <option value="id_asc">เรียง: Ticket ID (น้อย-มาก)</option>
              </select>
            </div>
          </div>

          {error && (
            <div className="alert-box alert-error">
              <span>{error}</span>
            </div>
          )}

          {loading ? (
            <div style={{ textAlign: 'center', padding: '4rem 0' }}>
              <div style={{ display: 'inline-block', width: '30px', height: '30px', border: '3px solid rgba(255,255,255,0.1)', borderTopColor: 'var(--accent-cyan)', borderRadius: '50%', animation: 'spin 1s linear infinite' }}></div>
              <p style={{ marginTop: '1rem', color: '#64748b' }}>กำลังโหลดข้อมูลเคสซัพพอร์ต...</p>
              <style>{`@keyframes spin { to { transform: rotate(360deg); } }`}</style>
            </div>
          ) : tickets.length === 0 ? (
            <div className="glass-card empty-state">
              <span className="empty-icon">📨</span>
              <h3>ยังไม่มีเคสหรือเคสช่วยเหลือ</h3>
              <p>หากคุณพบปัญหาการทำงานหรือต้องการข้อมูลสนับสนุน สามารถกดสร้างเคสใหม่ได้จากเมนู</p>
            </div>
          ) : displayedTickets.length === 0 ? (
            <div className="glass-card empty-state">
              <span className="empty-icon">📨</span>
              <h3>ไม่พบเคสที่ตรงตามเงื่อนไข</h3>
              <p>ไม่มีข้อมูลเคสช่วยเหลือในสถานะที่คุณเลือก</p>
            </div>
          ) : (
            <>
              {paginatedTickets.map(ticket => (
                <div key={ticket.id} className="glass-card ticket-card interactive glow-cyan">
                  <div className="ticket-main">
                    <div className="ticket-header">
                      <span className="ticket-id">{ticket.ticket_number || '#' + String(ticket.id).padStart(3, '0')}</span>
                      <span className={`badge ${
                        [null, '', 'open', 'O'].includes(ticket.status) ? 'badge-status-open' :
                        ['I', 'assigned'].includes(ticket.status) ? 'badge-status-assigned' : 'badge-status-resolved'
                      }`}>
                        {[null, '', 'open', 'O'].includes(ticket.status) ? '• รอดำเนินการ' : 
                        ['I', 'assigned'].includes(ticket.status) ? '• กำลังแก้ไข' : '• ปิดเคสแล้ว'}
                      </span>

                      <span className="badge badge-module">🧩 {ticket.module}</span>
                      <span className="badge" style={{ background: 'rgba(236, 72, 153, 0.1)', color: '#ec4899', border: '1px solid rgba(236, 72, 153, 0.2)' }}>
                        💻 {ticket.program_type || 'Standard'}
                      </span>
                      <span className="badge" style={{ background: 'rgba(245, 158, 11, 0.1)', color: '#d97706', border: '1px solid rgba(245, 158, 11, 0.2)' }}>
                        🐛 {ticket.issue_type || 'Technical'}
                      </span>
                      <span className={`badge badge-priority-${ticket.priority}`}>
                        {ticket.priority === 'low' ? 'ต่ำ' :
                         ticket.priority === 'medium' ? 'ปานกลาง' : 'สูง !!'}
                      </span>
                    </div>
                    <h3 className="ticket-title" onClick={() => onViewTicket(ticket.id)}>{ticket.title}</h3>
                    <p style={{ color: '#94a3b8', fontSize: '0.9rem', overflow: 'hidden', textOverflow: 'ellipsis', display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical' }}>
                      {ticket.description}
                    </p>
                    <div className="ticket-meta">
                      <span className="meta-item">
                        🗓️ ส่งเมื่อ: {new Date(ticket.created_at).toLocaleDateString('th-TH', { hour: '2-digit', minute: '2-digit' })}
                      </span>
                      <span className="meta-item" style={{ color: '#0ea5e9' }}>
                        👤 เปิดเคสโดย: {ticket.contact_name || ticket.user_name || 'ไม่ระบุ'}
                      </span>
                      {ticket.agent_name ? (
                        <span className="meta-item" style={{ color: 'var(--accent-purple)', fontWeight: 500 }}>
                          👤 เจ้าหน้าที่ดูแล: {ticket.agent_name}
                        </span>
                      ) : (
                        <span className="meta-item" style={{ color: '#64748b' }}>
                          👤 เจ้าหน้าที่ดูแล: ยังไม่มีเจ้าหน้าที่รับเคส
                        </span>
                      )}
                    </div>
                  </div>
                  <div className="ticket-actions">
                    <button className="btn btn-secondary" onClick={() => onViewTicket(ticket.id)}>
                      ดูรายละเอียด & แชท
                      <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" style={{ marginLeft: '0.25rem' }}>
                        <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
                      </svg>
                    </button>
                  </div>
                </div>
              ))}
              
              <div style={{ display: 'flex', justifyContent: 'flex-end', alignItems: 'center', marginTop: '1.5rem', flexWrap: 'wrap', gap: '1rem', padding: '1rem', background: 'rgba(255,255,255,0.5)', borderRadius: '12px', border: '1px solid var(--glass-border)' }}>
                
                {totalPages > 1 && (
                  <div style={{ display: 'flex', alignItems: 'center', gap: '1rem' }}>
                    <button 
                      className="btn btn-secondary" 
                      disabled={currentPage === 1} 
                      onClick={() => setCurrentPage(p => Math.max(1, p - 1))}
                      style={{ padding: '0.35rem 1rem', fontSize: '0.85rem', margin: 0, borderRadius: '6px' }}
                    >
                      ◀ ก่อนหน้า
                    </button>
                    <span style={{ fontSize: '0.85rem', color: '#475569', fontWeight: 600 }}>
                      หน้า {currentPage} จาก {totalPages}
                    </span>
                    <button 
                      className="btn btn-secondary" 
                      disabled={currentPage === totalPages} 
                      onClick={() => setCurrentPage(p => Math.min(totalPages, p + 1))}
                      style={{ padding: '0.35rem 1rem', fontSize: '0.85rem', margin: 0, borderRadius: '6px' }}
                    >
                      ถัดไป ▶
                    </button>
                  </div>
                )}
              </div>
            </>
          )}
        </div>

        {/* Sidebar help widget */}
        <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
          <div className="glass-card sidebar-panel">
            <h3 style={{ fontSize: '1.1rem', marginBottom: '0.5rem', background: 'linear-gradient(135deg, var(--accent-cyan), var(--accent-purple))', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent' }}>
              คู่มือแนะนำเบื้องต้น
            </h3>
            <p style={{ fontSize: '0.85rem', color: '#475569', lineHeight: 1.6 }}>
              เคสช่วยเหลือแต่ละใบสามารถใช้พิมพ์คุยกับเจ้าหน้าที่ได้แบบเรียลไทม์ คุณจะได้รับอีเมลตอบกลับหรือแจ้งเตือนเมื่อเจ้าหน้าที่รับเคลมเคสของคุณ
            </p>
            <hr style={{ border: 'none', borderBottom: '1px solid var(--glass-border)', margin: '0.5rem 0' }} />
            <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem', fontSize: '0.8rem', color: '#334155' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                <span style={{ color: 'var(--status-open)' }}>●</span> รอดำเนินการ = เคสเข้าระบบ รอเจ้าหน้าที่มากดรับ
              </div>
              <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                <span style={{ color: 'var(--status-assigned)' }}>●</span> กำลังแก้ไข = มีเจ้าหน้าที่รับเรื่องดูแลแล้ว
              </div>
              <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                <span style={{ color: 'var(--status-resolved)' }}>●</span> ปิดเคสแล้ว = แก้ไขปัญหาเรียบร้อย
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
