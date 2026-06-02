import React, { useState, useEffect } from 'react';
import { useAuth } from '../context/AuthContext';

export default function AdminDashboard({ onNavigateToTickets, onViewTicket }) {
  const { user, API_URL } = useAuth();
  const [filter, setFilter] = useState('all'); // 'daily', 'weekly', 'monthly', 'all'
  const [custNumFilter, setCustNumFilter] = useState('all');
  const [customers, setCustomers] = useState([]);
  const [report, setReport] = useState({
    totalCases: 0,
    activeCases: 0,
    closedCases: 0,
    avgResolutionSeconds: 0
  });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const [selectedBlock, setSelectedBlock] = useState(null); // 'total', 'active', 'closed'
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage, setItemsPerPage] = useState(20);
  const [searchQuery, setSearchQuery] = useState('');
  const [priorityFilter, setPriorityFilter] = useState('all');

  useEffect(() => {
    setCurrentPage(1);
  }, [selectedBlock, filter, custNumFilter, searchQuery, priorityFilter]);

  useEffect(() => {
    fetchCustomers();
  }, []);

  useEffect(() => {
    fetchReport();
    setSelectedBlock(null); // Reset selection when filter changes
  }, [filter, custNumFilter]);

  const fetchCustomers = async () => {
    try {
      const token = localStorage.getItem('apex_token');
      const response = await fetch(`${API_URL}/customers`, {
        headers: { 'Authorization': `Bearer ${token}` }
      });
      if (response.ok) {
        const data = await response.json();
        setCustomers(data);
      }
    } catch (err) {
      console.error('Failed to fetch customers:', err);
    }
  };

  const fetchReport = async () => {
    setLoading(true);
    setError(null);
    try {
      const token = localStorage.getItem('apex_token');
      const response = await fetch(`${API_URL}/reports/summary?filter=${filter}&custNum=${custNumFilter}`, {
        headers: {
          'Authorization': `Bearer ${token}`
        }
      });
      
      if (!response.ok) {
        throw new Error('Failed to fetch report');
      }
      
      const data = await response.json();
      setReport(data);
    } catch (err) {
      console.error(err);
      setError('ไม่สามารถดึงข้อมูลรายงานได้');
    } finally {
      setLoading(false);
    }
  };

  const formatTime = (seconds) => {
    if (!seconds || seconds === 0) return <div>0 นาที</div>;
    if (seconds < 60) return <div>&lt; 1 นาที</div>;
    const h = Math.floor(seconds / 3600);
    const m = Math.floor((seconds % 3600) / 60);
    
    if (h > 0) {
      return (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.2rem' }}>
          <div>{h} ชั่วโมง</div>
          <div>{m} นาที</div>
        </div>
      );
    }
    return <div>{m} นาที</div>;
  };

  const getFilteredTickets = (rawTickets) => {
    if (!rawTickets) return [];
    return rawTickets.filter(t => {
      const matchSearch = searchQuery.trim() === '' || 
        (t.title && t.title.toLowerCase().includes(searchQuery.toLowerCase())) ||
        (t.ticket_number && t.ticket_number.toLowerCase().includes(searchQuery.toLowerCase())) ||
        (t.description && t.description.toLowerCase().includes(searchQuery.toLowerCase()));
      
      const matchPriority = priorityFilter === 'all' || t.priority === priorityFilter;
      
      return matchSearch && matchPriority;
    });
  };

  const handleExportCSV = (ticketsToExport) => {
    if (!ticketsToExport || ticketsToExport.length === 0) return;
    
    // Header columns
    const headers = [
      'Ticket Number',
      'Title',
      'Customer',
      'Priority',
      'Category',
      'Module',
      'Status',
      'Created At',
      'Resolved At',
      'Agent'
    ];
    
    const rows = ticketsToExport.map(t => [
      t.ticket_number || ('#' + t.id),
      t.title.replace(/"/g, '""'),
      (t.user_name || t.customer_name) + ' (' + (t.actual_customer_name || t.customer_cust_num || '-') + ')',
      t.priority,
      t.category,
      t.module,
      t.status === 'open' ? 'รอดำเนินการ' : t.status === 'assigned' ? 'กำลังแก้ไข' : 'ปิดเคสแล้ว',
      new Date(t.created_at).toLocaleString('th-TH'),
      t.resolved_at ? new Date(t.resolved_at).toLocaleString('th-TH') : '-',
      t.agent_name || '-'
    ]);
    
    const csvContent = "\uFEFF" + [
      headers.join(','),
      ...rows.map(e => e.map(val => `"${val}"`).join(","))
    ].join("\n");
    
    const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
    const url = URL.createObjectURL(blob);
    const link = document.createElement("a");
    link.setAttribute("href", url);
    link.setAttribute("download", `ppcc_care_report_${filter}_${new Date().toISOString().slice(0,10)}.csv`);
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  };

  const renderTicketTable = (title, tickets, emptyMessage, colorClass, colorHex) => {
    const totalPages = Math.ceil((tickets?.length || 0) / itemsPerPage);
    const startIndex = (currentPage - 1) * itemsPerPage;
    const paginatedTickets = tickets ? tickets.slice(startIndex, startIndex + itemsPerPage) : [];

    return (
      <div className={`glass-card ${colorClass}`} style={{ overflowX: 'auto', background: 'rgba(255, 255, 255, 0.9)' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1rem', flexWrap: 'wrap' }}>
          <h3 style={{ margin: '0.5rem 0 0 0.75rem', color: colorHex }}>{title} ({tickets?.length || 0})</h3>
          {tickets && tickets.length > 0 && (
            <div style={{ display: 'flex', alignItems: 'center', gap: '1rem', paddingRight: '1rem' }}>
              <label style={{ fontSize: '0.85rem', color: '#475569', display: 'flex', alignItems: 'center' }}>
                แสดงหน้าละ:
                <select 
                  className="glass-input" 
                  value={itemsPerPage} 
                  onChange={(e) => { setItemsPerPage(Number(e.target.value)); setCurrentPage(1); }}
                  style={{ marginLeft: '0.5rem', padding: '0.2rem 1.5rem 0.2rem 0.5rem', width: 'auto', minWidth: '70px', height: '30px' }}
                >
                  <option value={20}>20</option>
                  <option value={30}>30</option>
                  <option value={50}>50</option>
                </select>
              </label>
            </div>
          )}
        </div>

        {tickets && tickets.length > 0 ? (
          <>
            <div style={{ overflowX: 'auto', width: '100%', WebkitOverflowScrolling: 'touch' }}>
              <table className="glass-table" style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left', minWidth: '700px' }}>
              <thead>
                <tr style={{ borderBottom: '2px solid #e2e8f0' }}>
                  <th style={{ padding: '0.75rem', color: '#475569', fontWeight: 'bold' }}>หัวข้อ (Title)</th>
                  <th style={{ padding: '0.75rem', color: '#475569', fontWeight: 'bold' }}>ผู้แจ้งเรื่อง (RequestBy)</th>
                  <th style={{ padding: '0.75rem', color: '#475569', fontWeight: 'bold' }}>สถานะ (Status)</th>
                  <th style={{ padding: '0.75rem', color: '#475569', fontWeight: 'bold' }}>เวลาอัปเดต (Time)</th>
                  <th style={{ padding: '0.75rem', color: '#475569', fontWeight: 'bold' }}>ผู้รับผิดชอบ (Agent)</th>
                </tr>
              </thead>
              <tbody>
                {paginatedTickets.map(ticket => (
                  <tr key={ticket.id} style={{ borderBottom: '1px solid #f1f5f9' }}>
                    <td 
                      style={{ padding: '0.75rem', color: '#1e293b', fontWeight: '500', cursor: 'pointer', textDecoration: 'underline', textDecorationColor: 'rgba(0,0,0,0.15)' }}
                      onClick={() => window.open(`/?ticketId=${ticket.id}`, '_blank')}
                      title="คลิกเพื่อดูรายละเอียด (เปิดในแท็บใหม่)"
                    >
                      {ticket.ticket_number || '#' + ticket.id} {ticket.title}
                    </td>
                    <td style={{ padding: '0.75rem', color: '#334155' }}>{ticket.user_name || ticket.customer_name} <span style={{fontSize: '0.85em', color: '#64748b'}}>({ticket.actual_customer_name || ticket.user_cust_num || ticket.customer_cust_num || '-'})</span></td>
                    <td style={{ padding: '0.75rem' }}>
                      <span className={`badge-status ${ticket.status}`}>
                        {ticket.status === 'open' ? 'รอดำเนินการ' : ticket.status === 'assigned' ? 'กำลังแก้ไข' : 'ปิดเคสแล้ว'}
                      </span>
                    </td>
                    <td style={{ padding: '0.75rem', color: '#334155' }}>
                      {new Date(ticket.status === 'resolved' && ticket.resolved_at ? ticket.resolved_at : ticket.created_at).toLocaleString('th-TH')}
                    </td>
                    <td style={{ padding: '0.75rem', color: '#475569' }}>{ticket.agent_name || (ticket.status === 'resolved' ? '-' : 'ยังไม่มีเจ้าหน้าที่รับเคส')}</td>
                  </tr>
                ))}
              </tbody>
            </table>
            </div>

            {totalPages > 1 && (
              <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', gap: '1rem', marginTop: '1.5rem', marginBottom: '0.5rem' }}>
                <button 
                  className="btn btn-secondary" 
                  disabled={currentPage === 1} 
                  onClick={() => setCurrentPage(p => Math.max(1, p - 1))}
                  style={{ padding: '0.35rem 1rem', fontSize: '0.85rem', margin: 0 }}
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
                  style={{ padding: '0.35rem 1rem', fontSize: '0.85rem', margin: 0 }}
                >
                  ถัดไป ▶
                </button>
              </div>
            )}
          </>
        ) : (
          <p style={{ color: '#64748b', padding: '1rem 0.75rem' }}>{emptyMessage}</p>
        )}
      </div>
    );
  };

  // Calculate dynamic stats for the selected report interval
  let ticketsForAnalytics = report.tickets || [];
  if (selectedBlock === 'active') {
    ticketsForAnalytics = report.activeTickets || [];
  } else if (selectedBlock === 'closed') {
    ticketsForAnalytics = report.closedTickets || [];
  }

  const stats = {
    priority: { low: 0, medium: 0, high: 0 },
    category: {},
    module: {},
    total: ticketsForAnalytics.length
  };

  ticketsForAnalytics.forEach(ticket => {
    // Priority
    if (ticket.priority === 'low') stats.priority.low++;
    else if (ticket.priority === 'medium') stats.priority.medium++;
    else if (ticket.priority === 'high') stats.priority.high++;

    // Category
    if (ticket.category) {
      stats.category[ticket.category] = (stats.category[ticket.category] || 0) + 1;
    }

    // Module
    if (ticket.module) {
      stats.module[ticket.module] = (stats.module[ticket.module] || 0) + 1;
    }
  });

  const getPercent = (value) => {
    if (stats.total === 0) return '0%';
    return `${Math.round((value / stats.total) * 100)}%`;
  };

  return (
    <div className="dashboard-container" style={{ padding: '2rem', maxWidth: '1200px', margin: '0 auto' }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
        <h1 style={{ background: 'linear-gradient(135deg, #a855f7, #00e5ff)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent' }}>
          📊 Admin Summary Report
        </h1>
          <div style={{ display: 'flex', gap: '1rem' }}>
            <select 
              className="glass-input" 
              style={{ margin: 0, minWidth: '150px' }}
              value={custNumFilter} 
              onChange={(e) => setCustNumFilter(e.target.value)}
            >
              <option value="all">ลูกค้าทั้งหมด (All Customers)</option>
              {customers.map(c => (
                <option key={c.id} value={c.cust_num}>{c.cust_num} - {c.cust_name}</option>
              ))}
            </select>
          <select 
            className="glass-input" 
            value={filter} 
            onChange={(e) => setFilter(e.target.value)}
            style={{ margin: 0, width: 'auto', minWidth: '150px' }}
          >
            <option value="all">ทั้งหมด (All Time)</option>
            <option value="daily">รายวัน (Daily)</option>
            <option value="weekly">รายสัปดาห์ (Weekly)</option>
            <option value="monthly">รายเดือน (Monthly)</option>
          </select>

        </div>
      </div>

      {error && (
        <div className="alert-box alert-error" style={{ marginBottom: '2rem' }}>
          {error}
        </div>
      )}

      {loading ? (
        <div style={{ display: 'flex', justifyContent: 'center', padding: '4rem' }}>
          <div className="spinner" style={{ width: '40px', height: '40px', border: '3px solid rgba(255,255,255,0.1)', borderTopColor: '#00e5ff', borderRadius: '50%', animation: 'spin 1s linear infinite' }}></div>
        </div>
      ) : (
        <div className="dashboard-stats" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1rem', marginBottom: '2rem' }}>
          
          <div 
            className={`glass-card stat-card glow-cyan clickable-card ${selectedBlock === 'total' ? 'selected' : ''}`}
            onClick={() => setSelectedBlock('total')}
            style={{ padding: '0.75rem 1rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}
          >
            <h3 style={{ color: '#64748b', fontSize: '0.8rem', marginBottom: '0', fontWeight: 600 }}>📁 จำนวนเคสทั้งหมด</h3>
            <div style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#0ea5e9' }}>{report.totalCases}</div>
          </div>
          
          <div 
            className={`glass-card stat-card glow-purple clickable-card ${selectedBlock === 'active' ? 'selected' : ''}`}
            onClick={() => setSelectedBlock('active')}
            style={{ padding: '0.75rem 1rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}
          >
            <h3 style={{ color: '#64748b', fontSize: '0.8rem', marginBottom: '0', fontWeight: 600 }}>⏳ กำลังดำเนินการ</h3>
            <div style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#8b5cf6' }}>{report.activeCases}</div>
          </div>
          
          <div 
            className={`glass-card stat-card glow-green clickable-card ${selectedBlock === 'closed' ? 'selected' : ''}`} 
            style={{ borderTop: '3px solid #10b981', padding: '0.75rem 1rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}
            onClick={() => setSelectedBlock('closed')}
          >
            <h3 style={{ color: '#64748b', fontSize: '0.8rem', marginBottom: '0', fontWeight: 600 }}>✅ ปิดเคสแล้ว</h3>
            <div style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#10b981' }}>{report.closedCases}</div>
          </div>

          <div className="glass-card stat-card glow-orange" style={{ borderTop: '3px solid #f59e0b', padding: '0.75rem 1rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <h3 style={{ color: '#64748b', fontSize: '0.8rem', marginBottom: '0', fontWeight: 600 }}>⏱️ เวลาเฉลี่ยต่อเคส</h3>
            <div style={{ fontSize: '1.25rem', fontWeight: 'bold', color: '#f59e0b', textAlign: 'right' }}>
              {formatTime(report.avgResolutionSeconds)}
            </div>
          </div>

        </div>
      )}

      {/* 🔍 Advanced Search, Filters Panel & Export CSV */}
      {!loading && !error && report && (
        <div className="search-filter-panel">
          <div className="filter-row">
            <div className="filter-item">
              <input
                type="text"
                className="glass-input"
                placeholder="🔍 ค้นหาด้วยคำสำคัญ (หัวข้อ, รายละเอียด, รหัสตั๋ว)..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                style={{ margin: 0 }}
              />
            </div>
            <div className="filter-item-small">
              <select
                className="glass-input"
                value={priorityFilter}
                onChange={(e) => setPriorityFilter(e.target.value)}
                style={{ margin: 0 }}
              >
                <option value="all">ความเร่งด่วน (ทั้งหมด)</option>
                <option value="high">สูง (High)</option>
                <option value="medium">ปานกลาง (Medium)</option>
                <option value="low">ต่ำ (Low)</option>
              </select>
            </div>
            <button
              className="btn btn-export-csv"
              onClick={() => handleExportCSV(getFilteredTickets(selectedBlock === 'active' ? report.activeTickets : selectedBlock === 'closed' ? report.closedTickets : report.tickets))}
              disabled={getFilteredTickets(selectedBlock === 'active' ? report.activeTickets : selectedBlock === 'closed' ? report.closedTickets : report.tickets).length === 0}
              style={{ margin: 0, display: 'inline-flex', alignItems: 'center', gap: '0.4rem', fontWeight: 600 }}
            >
              📥 ส่งออกข้อมูล ({getFilteredTickets(selectedBlock === 'active' ? report.activeTickets : selectedBlock === 'closed' ? report.closedTickets : report.tickets).length}) CSV
            </button>
          </div>
        </div>
      )}

      {/* Tables for tickets */}
      {!loading && !error && report && selectedBlock && (
        <div style={{ display: 'grid', gap: '2rem', marginBottom: '2rem' }}>
          {selectedBlock === 'total' && renderTicketTable('📁 จำนวนเคสทั้งหมด', getFilteredTickets(report.tickets), 'ไม่มีเคสในระบบ', 'glow-cyan', '#0ea5e9')}
          {selectedBlock === 'active' && renderTicketTable('⏳ เคสที่กำลังดำเนินการ', getFilteredTickets(report.activeTickets), 'ไม่มีเคสที่กำลังดำเนินการ', 'glow-purple', '#8b5cf6')}
          {selectedBlock === 'closed' && renderTicketTable('✅ เคสที่ปิดแล้ว', getFilteredTickets(report.closedTickets), 'ไม่มีเคสที่ถูกปิดในช่วงเวลานี้', 'glow-green', '#10b981')}
        </div>
      )}

      {/* Analytics breakdown panel */}
      {!loading && !error && report && report.tickets && (
        <div className="glass-card" style={{ padding: '2rem', textAlign: 'left', background: 'rgba(255, 255, 255, 0.8)', marginBottom: '2rem' }}>
          <div style={{ marginBottom: '1.5rem', borderBottom: '1px solid var(--glass-border)', paddingBottom: '1rem' }}>
            <h3 style={{ fontSize: '1.3rem', marginBottom: '0.25rem', background: 'linear-gradient(135deg, var(--accent-cyan), var(--accent-purple))', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent' }}>
              📊 บทวิเคราะห์ข้อมูลและสัดส่วนตั๋วบริการ (Ticket Analytics)
            </h3>
            <p style={{ fontSize: '0.85rem', color: '#64748b' }}>สรุปวิเคราะห์เปรียบเทียบสัดส่วนตั๋วบริการช่วยเหลือในรูปแบบกราฟวิเคราะห์ผล</p>
          </div>

          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', gap: '2rem' }}>
            {/* Priority Section */}
            <div className="chart-glass-card" style={{ padding: '1.5rem', alignItems: 'stretch', textAlign: 'left' }}>
              <span className="chart-title">🔴 ระดับความเร่งด่วน (Priority Ratio)</span>
              <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem', flexGrow: 1, justifyContent: 'center' }}>
                <div className="analytics-bar-item">
                  <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.82rem', fontWeight: 700, marginBottom: '0.35rem' }}>
                    <span style={{ color: '#ef4444' }}>สูง (High)</span>
                    <span>{stats.priority.high} เคส ({getPercent(stats.priority.high)})</span>
                  </div>
                  <div style={{ height: '8px', background: 'rgba(0,0,0,0.05)', borderRadius: '4px', overflow: 'hidden' }}>
                    <div style={{ width: getPercent(stats.priority.high), height: '100%', backgroundColor: 'var(--priority-high)', borderRadius: '4px', transition: 'width 0.6s ease' }}></div>
                  </div>
                </div>
                
                <div className="analytics-bar-item">
                  <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.82rem', fontWeight: 700, marginBottom: '0.35rem' }}>
                    <span style={{ color: '#d97706' }}>ปานกลาง (Medium)</span>
                    <span>{stats.priority.medium} เคส ({getPercent(stats.priority.medium)})</span>
                  </div>
                  <div style={{ height: '8px', background: 'rgba(0,0,0,0.05)', borderRadius: '4px', overflow: 'hidden' }}>
                    <div style={{ width: getPercent(stats.priority.medium), height: '100%', backgroundColor: 'var(--priority-medium)', borderRadius: '4px', transition: 'width 0.6s ease' }}></div>
                  </div>
                </div>

                <div className="analytics-bar-item">
                  <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.82rem', fontWeight: 700, marginBottom: '0.35rem' }}>
                    <span style={{ color: '#475569' }}>ต่ำ (Low)</span>
                    <span>{stats.priority.low} เคส ({getPercent(stats.priority.low)})</span>
                  </div>
                  <div style={{ height: '8px', background: 'rgba(0,0,0,0.05)', borderRadius: '4px', overflow: 'hidden' }}>
                    <div style={{ width: getPercent(stats.priority.low), height: '100%', backgroundColor: 'var(--priority-low)', borderRadius: '4px', transition: 'width 0.6s ease' }}></div>
                  </div>
                </div>
              </div>
            </div>

            {/* Category Donut Chart Section */}
            <div className="chart-glass-card">
              <span className="chart-title">🏷️ สัดส่วนหมวดหมู่ยอดนิยม (Categories)</span>
              
              <div className="svg-donut-wrapper">
                <svg width="100%" height="100%" viewBox="0 0 100 100">
                  <circle cx="50" cy="50" r="40" fill="transparent" stroke="rgba(0,0,0,0.03)" strokeWidth="10" />
                  {(() => {
                    const colors = ['#8b5cf6', '#0ea5e9', '#10b981', '#f59e0b'];
                    const donutData = Object.keys(stats.category).map((cat, index) => {
                      const count = stats.category[cat];
                      const pct = stats.total === 0 ? 0 : (count / stats.total) * 100;
                      return { label: cat, count, pct, color: colors[index % colors.length] };
                    });
                    
                    let cumulativePercent = 0;
                    return donutData.map((d) => {
                      const strokeDasharray = 251.2;
                      const strokeDashoffset = strokeDasharray - (strokeDasharray * d.pct) / 100;
                      const rotationAngle = -90 + (cumulativePercent * 3.6);
                      cumulativePercent += d.pct;
                      return (
                        <circle
                          key={d.label}
                          cx="50"
                          cy="50"
                          r="40"
                          fill="transparent"
                          stroke={d.color}
                          strokeWidth="10"
                          strokeDasharray={strokeDasharray}
                          strokeDashoffset={strokeDashoffset}
                          className="svg-donut-circle"
                          style={{
                            transform: `rotate(${rotationAngle}deg)`,
                            transformOrigin: '50px 50px'
                          }}
                        />
                      );
                    });
                  })()}
                </svg>
                <div className="donut-center-info">
                  <span className="donut-center-number">{stats.total}</span>
                  <span className="donut-center-label">เคสรวม</span>
                </div>
              </div>

              <div className="chart-legend">
                {Object.keys(stats.category).map((cat, index) => {
                  const colors = ['#8b5cf6', '#0ea5e9', '#10b981', '#f59e0b'];
                  const color = colors[index % colors.length];
                  return (
                    <div key={cat} className="legend-item">
                      <span className="legend-color-dot" style={{ backgroundColor: color }}></span>
                      <span>{cat} ({stats.category[cat]})</span>
                    </div>
                  );
                })}
              </div>
            </div>

            {/* Modules Bar Chart Section */}
            <div className="chart-glass-card">
              <span className="chart-title">🧩 โมดูลระบบงานยอดนิยม (Modules Frequency)</span>
              
              {Object.keys(stats.module).length === 0 ? (
                <div style={{ flexGrow: 1, display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#64748b', fontSize: '0.85rem' }}>
                  ยังไม่มีข้อมูลโมดูลตั๋วในระบบ
                </div>
              ) : (
                <div style={{ width: '100%', flexGrow: 1, display: 'flex', flexDirection: 'column', justifyContent: 'flex-end' }}>
                  <div className="bar-chart-container">
                    {Object.keys(stats.module).slice(0, 6).map((mod, index) => {
                      const count = stats.module[mod];
                      const maxCount = Math.max(...Object.values(stats.module), 1);
                      const heightPercent = `${Math.round((count / maxCount) * 100)}%`;
                      const colors = ['#004bb5', '#8b5cf6', '#06b6d4', '#f59e0b', '#ec4899', '#10b981'];
                      const color = colors[index % colors.length];
                      return (
                        <div key={mod} className="bar-column">
                          <div className="bar-rect" style={{ height: heightPercent, backgroundColor: color }}>
                            <span className="bar-tooltip">{mod}: {count} เคส ({getPercent(count)})</span>
                          </div>
                          <div className="bar-label" title={mod}>{mod}</div>
                        </div>
                      );
                    })}
                  </div>
                </div>
              )}
            </div>
          </div>
        </div>
      )}
      
      <style>{`
        @keyframes spin { to { transform: rotate(360deg); } }
        .glass-table th { font-weight: 600; }
        .badge-status { padding: 0.25rem 0.6rem; border-radius: 9999px; font-size: 0.8rem; font-weight: 600; }
        .badge-status.open { background: #fee2e2; color: #ef4444; border: 1px solid #fca5a5; }
        .badge-status.assigned { background: #fef3c7; color: #d97706; border: 1px solid #fcd34d; }
        .badge-status.resolved { background: #d1fae5; color: #059669; border: 1px solid #6ee7b7; }
        
        .clickable-card {
          cursor: pointer;
          transition: all 0.2s ease-in-out;
        }
        .clickable-card:hover {
          transform: translateY(-5px);
          box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1);
        }
        .clickable-card.selected {
          border: 2px solid #0ea5e9;
          transform: translateY(-2px);
          background: rgba(255, 255, 255, 0.8);
        }
      `}</style>
    </div>
  );
}
