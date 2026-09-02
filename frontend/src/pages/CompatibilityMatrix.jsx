import React, { useState, useEffect } from 'react';
import { useAuth } from '../context/AuthContext';

export default function CompatibilityMatrix() {
  const { user, API_URL } = useAuth();

  // Data states
  const [matrixData, setMatrixData] = useState([]);
  const [stats, setStats] = useState({ total: 0, supported: 0, deprecated: 0, total_csi_versions: 0, total_components: 0, total_categories: 0 });
  const [filterOptions, setFilterOptions] = useState({ csi_versions: [], components: [], categories: [], integrated_apps: [], statuses: [] });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [reimporting, setReimporting] = useState(false);

  // Filter states
  const [search, setSearch] = useState('');
  const [selectedCsiVersion, setSelectedCsiVersion] = useState('all');
  const [selectedComponent, setSelectedComponent] = useState('all');
  const [selectedCategory, setSelectedCategory] = useState('all');
  const [selectedApp, setSelectedApp] = useState('all');
  const [selectedStatus, setSelectedStatus] = useState('all');

  // Display states
  const [viewMode, setViewMode] = useState('table'); // 'table' | 'cards'

  // Fetch filter options on mount
  useEffect(() => {
    fetchFilterOptions();
  }, []);

  // Fetch matrix data whenever filters change
  useEffect(() => {
    fetchMatrixData();
  }, [search, selectedCsiVersion, selectedComponent, selectedCategory, selectedApp, selectedStatus]);

  const fetchFilterOptions = async () => {
    try {
      const res = await fetch(`${API_URL}/compatibility/filters`);
      if (res.ok) {
        const data = await res.json();
        setFilterOptions(data);
      }
    } catch (err) {
      console.error('Failed to fetch filter options:', err);
    }
  };

  const fetchMatrixData = async () => {
    setLoading(true);
    setError(null);
    try {
      const params = new URLSearchParams();
      if (search.trim()) params.append('search', search.trim());
      if (selectedCsiVersion !== 'all') params.append('csi_version', selectedCsiVersion);
      if (selectedComponent !== 'all') params.append('component', selectedComponent);
      if (selectedCategory !== 'all') params.append('category', selectedCategory);
      if (selectedApp !== 'all') params.append('integrated_app', selectedApp);
      if (selectedStatus !== 'all') params.append('status', selectedStatus);

      const res = await fetch(`${API_URL}/compatibility?${params.toString()}`);
      if (res.ok) {
        const json = await res.json();
        setMatrixData(json.data || []);
        if (json.stats) {
          setStats(json.stats);
        }
      } else {
        setError('ไม่สามารถดึงข้อมูล Compatibility Matrix ได้');
      }
    } catch (err) {
      console.error('Error fetching compatibility matrix:', err);
      setError('เกิดข้อผิดพลาดในการเชื่อมต่อกับเซิร์ฟเวอร์');
    } finally {
      setLoading(false);
    }
  };

  const fileInputRef = React.useRef(null);
  const [uploading, setUploading] = useState(false);

  const handleFileUploadClick = () => {
    if (fileInputRef.current) {
      fileInputRef.current.click();
    }
  };

  const handleFileChange = async (e) => {
    const file = e.target.files[0];
    if (!file) return;

    if (!file.name.match(/\.(xlsm|xlsx)$/i)) {
      alert('กรุณาเลือกไฟล์ Excel นามสกุล .xlsm หรือ .xlsx เท่านั้น');
      return;
    }

    const formData = new FormData();
    formData.append('file', file);

    setUploading(true);
    try {
      const res = await fetch(`${API_URL}/compatibility/upload`, {
        method: 'POST',
        body: formData
      });
      const json = await res.json();
      if (json.success) {
        alert(`อัปโหลดและอัปเดตข้อมูลสำเร็จ! นำเข้าทั้งหมด ${json.count} รายการ จากไฟล์ "${file.name}"`);
        fetchFilterOptions();
        fetchMatrixData();
      } else {
        alert(`เกิดข้อผิดพลาดในการนำเข้าไฟล์: ${json.error}`);
      }
    } catch (err) {
      alert(`เกิดข้อผิดพลาดในการอัปโหลดไฟล์: ${err.message}`);
    } finally {
      setUploading(false);
      e.target.value = '';
    }
  };

  const handleReimport = async () => {
    if (!window.confirm('คุณต้องการซิงค์ข้อมูลใหม่จากไฟล์ SyteLine_Compatibility_Matrix.xlsm ล่าสุด ใช่หรือไม่?')) return;
    setReimporting(true);
    try {
      const res = await fetch(`${API_URL}/compatibility/reimport`, { method: 'POST' });
      const json = await res.json();
      if (json.success) {
        alert(`ซิงค์ข้อมูลสำเร็จ! นำเข้าทั้งหมด ${json.count} รายการ จากทุกเวอร์ชัน CSI`);
        fetchFilterOptions();
        fetchMatrixData();
      } else {
        alert(`เกิดข้อผิดพลาดในการโหลดข้อมูล: ${json.error}`);
      }
    } catch (err) {
      alert(`เกิดข้อผิดพลาดในการส่งคำขอ: ${err.message}`);
    } finally {
      setReimporting(false);
    }
  };

  const handleClearFilters = () => {
    setSearch('');
    setSelectedCsiVersion('all');
    setSelectedComponent('all');
    setSelectedCategory('all');
    setSelectedApp('all');
    setSelectedStatus('all');
  };

  const hasActiveFilters = search || selectedCsiVersion !== 'all' || selectedComponent !== 'all' || selectedCategory !== 'all' || selectedApp !== 'all' || selectedStatus !== 'all';

  // Helper icon getter
  const getComponentIcon = (comp) => {
    switch (comp) {
      case 'Application Server': return '🖥️';
      case 'Client System': return '💻';
      case 'Database Server': return '🗄️';
      case 'Web Server': return '🌐';
      case 'Virtualization': return '☁️';
      case 'Mobile Client': return '📱';
      case 'Reporting Server': return '📊';
      case 'OLAP Server': return '📈';
      default: return '⚙️';
    }
  };

  return (
    <div style={{ padding: '2rem 1.5rem', maxWidth: '1400px', margin: '0 auto', color: '#1e293b' }}>
      {/* Hidden File Input */}
      <input 
        type="file" 
        ref={fileInputRef} 
        accept=".xlsm,.xlsx" 
        onChange={handleFileChange} 
        style={{ display: 'none' }} 
      />

      {/* Top Banner Header - Harmonized PPCC Light Glass Theme */}
      <div style={{
        background: 'linear-gradient(135deg, rgba(255, 255, 255, 0.95), rgba(241, 245, 249, 0.85))',
        backdropFilter: 'blur(16px)',
        border: '1px solid rgba(0, 0, 0, 0.08)',
        borderRadius: '20px',
        padding: '1.75rem 2rem',
        marginBottom: '1.75rem',
        boxShadow: '0 10px 30px rgba(0, 0, 0, 0.05), 0 1px 3px rgba(0, 0, 0, 0.02)',
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center',
        flexWrap: 'wrap',
        gap: '1.5rem'
      }}>
        <div>
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', marginBottom: '0.35rem', flexWrap: 'wrap' }}>
            <span style={{ fontSize: '1.85rem' }}>🔍</span>
            <h1 className="page-title-gradient" style={{ margin: 0, fontSize: '1.75rem', fontWeight: 800 }}>
              SyteLine Compatibility Matrix
            </h1>
            <span style={{ background: 'rgba(2, 132, 199, 0.08)', border: '1px solid rgba(2, 132, 199, 0.25)', color: '#0284c7', fontSize: '0.75rem', fontWeight: 700, padding: '0.25rem 0.65rem', borderRadius: '12px' }}>
              ทุกเวอร์ชัน (8.03.x - 10.00.00)
            </span>
          </div>
          <p style={{ margin: 0, color: '#64748b', fontSize: '0.9rem' }}>
            ระบบค้นหา ตรวจสอบ และเปรียบเทียบความเข้ากันได้ของระบบ Infor SyteLine / CloudSuite Industrial ครอบคลุมทุกเวอร์ชัน
          </p>
        </div>

        {user?.role === 'admin' && (
          <div style={{ display: 'flex', gap: '0.75rem', alignItems: 'center', flexWrap: 'wrap' }}>
            <button
              onClick={handleFileUploadClick}
              disabled={uploading || reimporting}
              style={{
                background: 'linear-gradient(135deg, #0284c7, #4f46e5)',
                border: 'none',
                color: '#ffffff',
                padding: '0.65rem 1.25rem',
                borderRadius: '12px',
                fontWeight: 700,
                fontSize: '0.85rem',
                cursor: 'pointer',
                display: 'flex',
                alignItems: 'center',
                gap: '0.5rem',
                transition: 'all 0.2s ease',
                boxShadow: '0 4px 14px rgba(2, 132, 199, 0.3)'
              }}
              onMouseEnter={(e) => {
                e.currentTarget.style.transform = 'translateY(-2px)';
                e.currentTarget.style.boxShadow = '0 6px 18px rgba(2, 132, 199, 0.4)';
              }}
              onMouseLeave={(e) => {
                e.currentTarget.style.transform = 'none';
                e.currentTarget.style.boxShadow = '0 4px 14px rgba(2, 132, 199, 0.3)';
              }}
              title="คลิกเพื่อ Browse เลือกไฟล์ SyteLine_Compatibility_Matrix.xlsm จากเครื่องของคุณ"
            >
              <span>{uploading ? '⏳ กำลังอัปโหลด...' : '📤 Browse อัปโหลดไฟล์ Excel (.xlsm)'}</span>
            </button>

            <button
              onClick={handleReimport}
              disabled={uploading || reimporting}
              style={{
                background: '#ffffff',
                border: '1px solid #cbd5e1',
                color: '#475569',
                padding: '0.65rem 1rem',
                borderRadius: '12px',
                fontWeight: 600,
                fontSize: '0.85rem',
                cursor: 'pointer',
                display: 'flex',
                alignItems: 'center',
                gap: '0.4rem',
                transition: 'all 0.2s ease'
              }}
              title="รีเฟรชนำเข้าข้อมูลจากไฟล์ล่าสุด"
            >
              <span>{reimporting ? '🔄 ซิงค์อยู่...' : '🔁 รีเฟรชข้อมูล'}</span>
            </button>
          </div>
        )}
      </div>

      {/* Main Filter Toolbar - Light Glass Theme */}
      <div style={{
        background: 'rgba(255, 255, 255, 0.9)',
        border: '1px solid rgba(0, 0, 0, 0.08)',
        borderRadius: '18px',
        padding: '1.5rem',
        marginBottom: '1.75rem',
        backdropFilter: 'blur(16px)',
        boxShadow: '0 10px 25px rgba(0, 0, 0, 0.04)'
      }}>
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(180px, 1fr))', gap: '1rem', marginBottom: '1.25rem' }}>
          
          {/* Search Box */}
          <div style={{ gridColumn: 'span 2' }}>
            <label style={{ display: 'block', fontSize: '0.8rem', fontWeight: 600, color: '#475569', marginBottom: '0.35rem' }}>
              🔍 ค้นหาข้อความ
            </label>
            <input
              type="text"
              placeholder="ค้นหาชื่อ OS, Browser, SQL, เวอร์ชัน..."
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              style={{
                width: '100%',
                padding: '0.65rem 1rem',
                borderRadius: '12px',
                background: '#f8fafc',
                border: '1px solid #cbd5e1',
                color: '#0f172a',
                fontSize: '0.9rem',
                outline: 'none',
                boxSizing: 'border-box'
              }}
            />
          </div>

          {/* SyteLine Version Filter */}
          <div>
            <label style={{ display: 'block', fontSize: '0.8rem', fontWeight: 700, color: '#0284c7', marginBottom: '0.35rem' }}>
              📦 เวอร์ชัน SyteLine
            </label>
            <select
              value={selectedCsiVersion}
              onChange={(e) => setSelectedCsiVersion(e.target.value)}
              style={{
                width: '100%',
                padding: '0.65rem 1rem',
                borderRadius: '12px',
                background: '#f0f9ff',
                border: '1px solid rgba(2, 132, 199, 0.4)',
                color: '#0284c7',
                fontWeight: 700,
                fontSize: '0.9rem',
                outline: 'none'
              }}
            >
              <option value="all">ทุกเวอร์ชัน ({filterOptions.csi_versions ? filterOptions.csi_versions.length : 0})</option>
              {filterOptions.csi_versions && filterOptions.csi_versions.map(v => (
                <option key={v} value={v}>{v.replace(/^csi\s*/i, '')}</option>
              ))}
            </select>
          </div>

          {/* Component Filter */}
          <div>
            <label style={{ display: 'block', fontSize: '0.8rem', fontWeight: 600, color: '#475569', marginBottom: '0.35rem' }}>
              🏛️ Component
            </label>
            <select
              value={selectedComponent}
              onChange={(e) => setSelectedComponent(e.target.value)}
              style={{
                width: '100%',
                padding: '0.65rem 1rem',
                borderRadius: '12px',
                background: '#f8fafc',
                border: '1px solid #cbd5e1',
                color: '#0f172a',
                fontSize: '0.9rem',
                outline: 'none'
              }}
            >
              <option value="all">ทั้งหมด ({filterOptions.components.length})</option>
              {filterOptions.components.map(c => (
                <option key={c} value={c}>{c}</option>
              ))}
            </select>
          </div>

          {/* Status Filter */}
          <div>
            <label style={{ display: 'block', fontSize: '0.8rem', fontWeight: 600, color: '#475569', marginBottom: '0.35rem' }}>
              ✅ สถานะ (Status)
            </label>
            <select
              value={selectedStatus}
              onChange={(e) => setSelectedStatus(e.target.value)}
              style={{
                width: '100%',
                padding: '0.65rem 1rem',
                borderRadius: '12px',
                background: '#f8fafc',
                border: '1px solid #cbd5e1',
                color: '#0f172a',
                fontSize: '0.9rem',
                outline: 'none'
              }}
            >
              <option value="all">ทั้งหมด</option>
              <option value="Supported">Supported (รองรับ)</option>
              <option value="Deprecated">Deprecated (ยกเลิก)</option>
            </select>
          </div>

        </div>

        {/* Filter Action Bar (Active Filters Tag + View Mode Toggle) */}
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', flexWrap: 'wrap', gap: '1rem', borderTop: '1px solid rgba(0, 0, 0, 0.06)', paddingTop: '1rem' }}>
          
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', flexWrap: 'wrap' }}>
            <span style={{ fontSize: '0.85rem', color: '#64748b' }}>
              พบข้อมูล <strong style={{ color: '#0284c7' }}>{matrixData.length}</strong> รายการ {selectedCsiVersion !== 'all' && `(สำหรับเวอร์ชัน ${selectedCsiVersion.replace(/^csi\s*/i, '')})`}
            </span>
            {hasActiveFilters && (
              <button
                onClick={handleClearFilters}
                style={{
                  background: 'rgba(239, 68, 68, 0.1)',
                  border: '1px solid rgba(239, 68, 68, 0.3)',
                  color: '#dc2626',
                  padding: '0.25rem 0.75rem',
                  borderRadius: '16px',
                  fontSize: '0.75rem',
                  fontWeight: 600,
                  cursor: 'pointer',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.35rem'
                }}
              >
                <span>✖ ล้างตัวกรองทั้งหมด</span>
              </button>
            )}
          </div>

          {/* View Toggle */}
          <div style={{ display: 'flex', background: '#f1f5f9', padding: '0.25rem', borderRadius: '12px', border: '1px solid #e2e8f0' }}>
            <button
              onClick={() => setViewMode('table')}
              style={{
                padding: '0.45rem 0.85rem',
                borderRadius: '9px',
                border: 'none',
                background: viewMode === 'table' ? 'linear-gradient(135deg, #0284c7, #4f46e5)' : 'transparent',
                color: viewMode === 'table' ? '#ffffff' : '#64748b',
                fontWeight: 700,
                fontSize: '0.8rem',
                cursor: 'pointer',
                display: 'flex',
                alignItems: 'center',
                gap: '0.35rem',
                boxShadow: viewMode === 'table' ? '0 2px 8px rgba(2, 132, 199, 0.3)' : 'none',
                transition: 'all 0.2s'
              }}
            >
              <span>📋</span>
              <span>ตาราง (Table)</span>
            </button>
            <button
              onClick={() => setViewMode('cards')}
              style={{
                padding: '0.45rem 0.85rem',
                borderRadius: '9px',
                border: 'none',
                background: viewMode === 'cards' ? 'linear-gradient(135deg, #0284c7, #4f46e5)' : 'transparent',
                color: viewMode === 'cards' ? '#ffffff' : '#64748b',
                fontWeight: 700,
                fontSize: '0.8rem',
                cursor: 'pointer',
                display: 'flex',
                alignItems: 'center',
                gap: '0.35rem',
                boxShadow: viewMode === 'cards' ? '0 2px 8px rgba(2, 132, 199, 0.3)' : 'none',
                transition: 'all 0.2s'
              }}
            >
              <span>🎴</span>
              <span>การ์ด (Cards)</span>
            </button>
          </div>

        </div>
      </div>

      {/* Main Content List / Table */}
      {loading ? (
        <div style={{ textAlign: 'center', padding: '4rem 2rem', color: '#64748b' }}>
          <div style={{ display: 'inline-block', width: '36px', height: '36px', border: '3px solid rgba(2, 132, 199, 0.2)', borderTopColor: '#0284c7', borderRadius: '50%', animation: 'spin 1s linear infinite' }}></div>
          <p style={{ marginTop: '1rem', fontWeight: 600 }}>กำลังโหลดข้อมูลความเข้ากันได้...</p>
        </div>
      ) : error ? (
        <div style={{ textAlign: 'center', padding: '3rem 2rem', background: 'rgba(239, 68, 68, 0.08)', borderRadius: '20px', border: '1px solid rgba(239, 68, 68, 0.2)', color: '#dc2626' }}>
          <h3>เกิดข้อผิดพลาดในการโหลดข้อมูล</h3>
          <p>{error}</p>
          <button onClick={fetchMatrixData} style={{ marginTop: '1rem', padding: '0.5rem 1.25rem', background: '#dc2626', color: '#fff', border: 'none', borderRadius: '10px', cursor: 'pointer', fontWeight: 600 }}>
            ลองใหม่อีกครั้ง
          </button>
        </div>
      ) : matrixData.length === 0 ? (
        <div style={{ textAlign: 'center', padding: '4rem 2rem', background: 'rgba(255, 255, 255, 0.8)', borderRadius: '20px', border: '1px solid rgba(0, 0, 0, 0.08)' }}>
          <span style={{ fontSize: '3rem' }}>🔍</span>
          <h3 style={{ color: '#1e293b', marginTop: '0.75rem', marginBottom: '0.35rem' }}>ไม่พบข้อมูลที่ตรงตามเงื่อนไข</h3>
          <p style={{ color: '#64748b', margin: '0 0 1.5rem 0', fontSize: '0.9rem' }}>ลองปรับเปลี่ยนคำค้นหาหรือเลือกตัวกรองใหม่อีกครั้ง</p>
          <button onClick={handleClearFilters} style={{ padding: '0.55rem 1.25rem', background: 'linear-gradient(135deg, #0284c7, #4f46e5)', color: '#ffffff', border: 'none', borderRadius: '12px', fontWeight: 700, cursor: 'pointer' }}>
            🔄 ล้างตัวกรองทั้งหมด
          </button>
        </div>
      ) : viewMode === 'table' ? (
        /* TABLE VIEW - Light Glass Theme */
        <div style={{
          background: '#ffffff',
          borderRadius: '20px',
          border: '1px solid #e2e8f0',
          overflow: 'hidden',
          boxShadow: '0 10px 30px rgba(0, 0, 0, 0.05)'
        }}>
          <div style={{ overflowX: 'auto' }}>
            <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left', fontSize: '0.875rem' }}>
              <thead>
                <tr style={{ background: 'linear-gradient(135deg, #f8fafc, #f1f5f9)', borderBottom: '1px solid #e2e8f0', color: '#475569' }}>
                  <th style={{ padding: '1rem 1.25rem', fontWeight: 700, color: '#0284c7' }}>SyteLine Version</th>
                  <th style={{ padding: '1rem 1.25rem', fontWeight: 700 }}>Component</th>
                  <th style={{ padding: '1rem 1.25rem', fontWeight: 700 }}>Category</th>
                  <th style={{ padding: '1rem 1.25rem', fontWeight: 700 }}>Integrated Application</th>
                  <th style={{ padding: '1rem 1.25rem', fontWeight: 700 }}>Version</th>
                  <th style={{ padding: '1rem 1.25rem', fontWeight: 700, textAlign: 'center' }}>Status</th>
                  <th style={{ padding: '1rem 1.25rem', fontWeight: 700 }}>SyteLine Support Info</th>
                </tr>
              </thead>
              <tbody>
                {matrixData.map((item, index) => {
                  const isSupported = item.supported_status === 'Supported';
                  return (
                    <tr 
                      key={item.id || index}
                      style={{
                        borderBottom: '1px solid #f1f5f9',
                        transition: 'background 0.2s ease'
                      }}
                      onMouseEnter={(e) => e.currentTarget.style.background = '#f8fafc'}
                      onMouseLeave={(e) => e.currentTarget.style.background = 'transparent'}
                    >
                      {/* CSI Version */}
                      <td style={{ padding: '1rem 1.25rem', whiteSpace: 'nowrap' }}>
                        <span style={{ background: 'rgba(2, 132, 199, 0.08)', border: '1px solid rgba(2, 132, 199, 0.25)', color: '#0284c7', padding: '0.2rem 0.65rem', borderRadius: '10px', fontWeight: 700, fontSize: '0.8rem' }}>
                          {item.csi_version.replace(/^csi\s*/i, '')}
                        </span>
                      </td>

                      {/* Component */}
                      <td style={{ padding: '1rem 1.25rem', whiteSpace: 'nowrap' }}>
                        <span style={{ display: 'inline-flex', alignItems: 'center', gap: '0.5rem', fontWeight: 600, color: '#1e293b' }}>
                          <span>{getComponentIcon(item.component)}</span>
                          <span>{item.component}</span>
                        </span>
                      </td>

                      {/* Category */}
                      <td style={{ padding: '1rem 1.25rem', color: '#475569' }}>
                        <span style={{ background: '#f1f5f9', padding: '0.2rem 0.6rem', borderRadius: '8px', fontSize: '0.8rem', border: '1px solid #e2e8f0' }}>
                          {item.category}
                        </span>
                      </td>

                      {/* Integrated Application */}
                      <td style={{ padding: '1rem 1.25rem', fontWeight: 700, color: '#4f46e5' }}>
                        {item.integrated_app}
                      </td>

                      {/* Version */}
                      <td style={{ padding: '1rem 1.25rem', color: '#0f172a', fontWeight: 500 }}>
                        {item.app_version || '-'}
                      </td>

                      {/* Status Badge */}
                      <td style={{ padding: '1rem 1.25rem', textAlign: 'center' }}>
                        <span style={{
                          display: 'inline-flex',
                          alignItems: 'center',
                          gap: '0.35rem',
                          padding: '0.3rem 0.75rem',
                          borderRadius: '20px',
                          fontSize: '0.775rem',
                          fontWeight: 700,
                          background: isSupported ? 'rgba(16, 185, 129, 0.12)' : 'rgba(239, 68, 68, 0.12)',
                          color: isSupported ? '#059669' : '#dc2626',
                          border: isSupported ? '1px solid rgba(16, 185, 129, 0.3)' : '1px solid rgba(239, 68, 68, 0.3)'
                        }}>
                          <span>{isSupported ? '✓' : '⚠'}</span>
                          <span>{item.supported_status}</span>
                        </span>
                      </td>

                      {/* SyteLine Support Info */}
                      <td style={{ padding: '1rem 1.25rem', color: '#64748b', fontSize: '0.825rem' }}>
                        {item.syteline_subversion || item.notes || `Infor SyteLine ${item.csi_version} Support`}
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        </div>
      ) : (
        /* CARDS VIEW - Light Theme */
        <div style={{
          display: 'grid',
          gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))',
          gap: '1.25rem'
        }}>
          {matrixData.map((item, index) => {
            const isSupported = item.supported_status === 'Supported';
            return (
              <div
                key={item.id || index}
                style={{
                  background: '#ffffff',
                  border: isSupported ? '1px solid rgba(16, 185, 129, 0.25)' : '1px solid rgba(239, 68, 68, 0.25)',
                  borderRadius: '16px',
                  padding: '1.25rem',
                  boxShadow: '0 4px 15px rgba(0,0,0,0.04)',
                  transition: 'all 0.2s ease',
                  display: 'flex',
                  flexDirection: 'column',
                  justifyContent: 'space-between'
                }}
                onMouseEnter={(e) => {
                  e.currentTarget.style.transform = 'translateY(-3px)';
                  e.currentTarget.style.boxShadow = '0 12px 25px rgba(0, 0, 0, 0.08)';
                }}
                onMouseLeave={(e) => {
                  e.currentTarget.style.transform = 'none';
                  e.currentTarget.style.boxShadow = '0 4px 15px rgba(0,0,0,0.04)';
                }}
              >
                <div>
                  <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '0.75rem' }}>
                    <span style={{ fontSize: '0.75rem', background: 'rgba(2, 132, 199, 0.08)', color: '#0284c7', padding: '0.2rem 0.6rem', borderRadius: '10px', fontWeight: 700, border: '1px solid rgba(2, 132, 199, 0.2)' }}>
                      {item.csi_version.replace(/^csi\s*/i, '')}
                    </span>
                    <span style={{
                      padding: '0.2rem 0.65rem',
                      borderRadius: '12px',
                      fontSize: '0.725rem',
                      fontWeight: 700,
                      background: isSupported ? 'rgba(16, 185, 129, 0.12)' : 'rgba(239, 68, 68, 0.12)',
                      color: isSupported ? '#059669' : '#dc2626',
                      border: isSupported ? '1px solid rgba(16, 185, 129, 0.3)' : '1px solid rgba(239, 68, 68, 0.3)'
                    }}>
                      {item.supported_status}
                    </span>
                  </div>

                  <h3 style={{ margin: '0 0 0.35rem 0', fontSize: '1.1rem', color: '#4f46e5', fontWeight: 700 }}>
                    {item.integrated_app}
                  </h3>

                  <div style={{ fontSize: '0.85rem', color: '#1e293b', marginBottom: '0.5rem' }}>
                    เวอร์ชัน: <strong style={{ color: '#0284c7' }}>{item.app_version || 'N/A'}</strong>
                  </div>

                  <div style={{ fontSize: '0.8rem', color: '#64748b', marginBottom: '0.75rem' }}>
                    {getComponentIcon(item.component)} {item.component} ({item.category})
                  </div>
                </div>

                <div style={{ borderTop: '1px solid #f1f5f9', paddingTop: '0.65rem', fontSize: '0.775rem', color: '#94a3b8' }}>
                  {item.syteline_subversion || item.notes || `SyteLine ${item.csi_version}`}
                </div>
              </div>
            );
          })}
        </div>
      )}

    </div>
  );
}
