import { useState, useEffect } from 'react';
import { useAuth } from '../../context/AuthContext';

const CustomerManagement = () => {
  const { API_URL, token } = useAuth();
  const [customers, setCustomers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [page, setPage] = useState(1);
  const [limit, setLimit] = useState(10);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedCustomer, setSelectedCustomer] = useState(null);
  const [searchQuery, setSearchQuery] = useState('');
  const [versionFilter, setVersionFilter] = useState('all');
  const [ownerFilter, setOwnerFilter] = useState('all');
  const [maFilter, setMaFilter] = useState('all');

  // Add form state
  const [newCustNum, setNewCustNum] = useState('');
  const [newCustName, setNewCustName] = useState('');
  const [newPrefix, setNewPrefix] = useState('');
  const [newContactEmail, setNewContactEmail] = useState('');
  const [newVersion, setNewVersion] = useState('');
  const [newLicense, setNewLicense] = useState('');
  const [newAccountOwner, setNewAccountOwner] = useState('');
  const [newInforMA, setNewInforMA] = useState('');
  const [newPpccAppMA, setNewPpccAppMA] = useState('');
  const [newPpccCustMA, setNewPpccCustMA] = useState('');
  const [newPpccTechMA, setNewPpccTechMA] = useState('');

  // Edit inline state
  const [editingId, setEditingId] = useState(null);
  const [editingCustNum, setEditingCustNum] = useState('');
  const [editingCustName, setEditingCustName] = useState('');
  const [editingPrefix, setEditingPrefix] = useState('');
  const [editingContactEmail, setEditingContactEmail] = useState('');
  const [editingVersion, setEditingVersion] = useState('');
  const [editingLicense, setEditingLicense] = useState('');
  const [editingAccountOwner, setEditingAccountOwner] = useState('');
  const [editingInforMA, setEditingInforMA] = useState('');
  const [editingPpccAppMA, setEditingPpccAppMA] = useState('');
  const [editingPpccCustMA, setEditingPpccCustMA] = useState('');
  const [editingPpccTechMA, setEditingPpccTechMA] = useState('');

  const getMaCount = (customer) => [
    customer.infor_ma,
    customer.ppcc_app_ma,
    customer.ppcc_cust_ma,
    customer.ppcc_tech_ma
  ].filter(value => String(value || '').toUpperCase() === 'YES').length;

  const filteredCustomers = customers.filter((customer) => {
    const query = searchQuery.trim().toLowerCase();
    const matchesSearch = !query || [customer.cust_num, customer.cust_name, customer.version, customer.account_owner]
      .some(value => String(value || '').toLowerCase().includes(query));
    const matchesVersion = versionFilter === 'all' || customer.version === versionFilter;
    const matchesOwner = ownerFilter === 'all' || customer.account_owner === ownerFilter;
    const maCount = getMaCount(customer);
    const matchesMa = maFilter === 'all'
      || (maFilter === 'complete' && maCount === 4)
      || (maFilter === 'attention' && maCount < 4);

    return matchesSearch && matchesVersion && matchesOwner && matchesMa;
  });

  const versionOptions = [...new Set(customers.map(customer => customer.version).filter(Boolean))].sort();
  const ownerOptions = [...new Set(customers.map(customer => customer.account_owner).filter(Boolean))].sort();
  const completeMaCount = customers.filter(customer => getMaCount(customer) === 4).length;
  const needsAttentionCount = customers.filter(customer => getMaCount(customer) < 4).length;

  const totalItems = filteredCustomers.length;
  const totalPages = Math.ceil(totalItems / limit);
  const safePage = Math.min(page, Math.max(totalPages, 1));
  const safeIndexOfLastItem = safePage * limit;
  const safeIndexOfFirstItem = safeIndexOfLastItem - limit;
  const currentCustomers = filteredCustomers.slice(safeIndexOfFirstItem, safeIndexOfLastItem);

  const fetchCustomers = async () => {
    try {
      const response = await fetch(`${API_URL}/customers`, {
        headers: { 'Authorization': `Bearer ${token}` }
      });
      if (!response.ok) throw new Error('Failed to fetch customers');
      const data = await response.json();
      setCustomers(data);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    // The effect is intentionally responsible for the initial external API request.
    // eslint-disable-next-line react-hooks/set-state-in-effect
    fetchCustomers();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const resetNewForm = () => {
    setNewCustNum('');
    setNewCustName('');
    setNewPrefix('');
    setNewContactEmail('');
    setNewVersion('');
    setNewLicense('');
    setNewAccountOwner('');
    setNewInforMA('');
    setNewPpccAppMA('');
    setNewPpccCustMA('');
    setNewPpccTechMA('');
  };

  const handleAddCustomer = async (e) => {
    e.preventDefault();
    setError(null);
    try {
      const response = await fetch(`${API_URL}/customers`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify({
          cust_num: newCustNum,
          cust_name: newCustName,
          prefix: newPrefix,
          contact_email: newContactEmail,
          version: newVersion,
          license: newLicense,
          account_owner: newAccountOwner,
          infor_ma: newInforMA,
          ppcc_app_ma: newPpccAppMA,
          ppcc_cust_ma: newPpccCustMA,
          ppcc_tech_ma: newPpccTechMA
        })
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || 'Failed to add customer');
      }

      await fetchCustomers();
      resetNewForm();
      setIsModalOpen(false);
    } catch (err) {
      setError(err.message);
    }
  };

  const handleUpdateCustomer = async (id) => {
    setError(null);
    try {
      const response = await fetch(`${API_URL}/customers/${id}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify({
          cust_num: editingCustNum,
          cust_name: editingCustName,
          prefix: editingPrefix,
          contact_email: editingContactEmail,
          version: editingVersion,
          license: editingLicense,
          account_owner: editingAccountOwner,
          infor_ma: editingInforMA,
          ppcc_app_ma: editingPpccAppMA,
          ppcc_cust_ma: editingPpccCustMA,
          ppcc_tech_ma: editingPpccTechMA
        })
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || 'Failed to update customer');
      }

      await fetchCustomers();
      setEditingId(null);
      setSelectedCustomer(null);
      setEditingCustNum('');
      setEditingCustName('');
      setEditingPrefix('');
      setEditingContactEmail('');
      setEditingVersion('');
      setEditingLicense('');
      setEditingAccountOwner('');
      setEditingInforMA('');
      setEditingPpccAppMA('');
      setEditingPpccCustMA('');
      setEditingPpccTechMA('');
    } catch (err) {
      setError(err.message);
    }
  };

  const handleDelete = async (id) => {
    if (!window.confirm('Are you sure you want to delete this customer?')) return;
    try {
      const response = await fetch(`${API_URL}/customers/${id}`, {
        method: 'DELETE',
        headers: { 'Authorization': `Bearer ${token}` }
      });
      if (!response.ok) throw new Error('Failed to delete customer');
      await fetchCustomers();
    } catch (err) {
      setError(err.message);
    }
  };



  if (loading) return (
    <div style={{ textAlign: 'center', padding: '4rem 0' }}>
      <div style={{ display: 'inline-block', width: '30px', height: '30px', border: '3px solid rgba(0,0,0,0.1)', borderTopColor: 'var(--accent-purple, #8b5cf6)', borderRadius: '50%', animation: 'spin 1s linear infinite' }}></div>
      <p style={{ marginTop: '1rem', color: '#64748b' }}>กำลังโหลดข้อมูลลูกค้า...</p>
    </div>
  );

  return (
    <div className="glass-card" style={{ padding: '2rem', textAlign: 'left' }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.25rem', borderBottom: '1px solid var(--glass-border)', paddingBottom: '0.75rem' }}>
        <h3 style={{ fontSize: '1.25rem', color: '#0f172a', margin: 0 }}>
          🤝 จัดการลูกค้า (Customers)
        </h3>
        <button 
          onClick={() => setIsModalOpen(true)} 
          className="btn btn-primary" 
          style={{ padding: '0.5rem 1.25rem', display: 'flex', alignItems: 'center', gap: '0.5rem', borderRadius: '10px', fontSize: '0.9rem' }}
        >
          <span>➕ เพิ่มข้อมูล</span>
        </button>
      </div>
      
      {error && <div style={{ background: '#fee2e2', color: '#ef4444', padding: '1rem', borderRadius: '8px', marginBottom: '1.5rem', fontSize: '0.9rem' }}>{error}</div>}

      {/* Modal Popup Form for Adding Customer */}
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
                ➕ เพิ่มข้อมูลลูกค้าใหม่ (Add Customer)
              </h4>
              <button 
                onClick={() => {
                  setIsModalOpen(false);
                  resetNewForm();
                }}
                style={{ background: 'none', border: 'none', fontSize: '1.25rem', cursor: 'pointer', color: '#64748b' }}
              >
                ✕
              </button>
            </div>

            <form onSubmit={handleAddCustomer}>
              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem', marginBottom: '1.5rem' }}>
                <div style={{ gridColumn: 'span 2' }}>
                  <label style={{ display: 'block', fontSize: '0.82rem', fontWeight: 600, color: '#475569', marginBottom: '0.35rem' }}>ชื่อลูกค้า (Customer Name) *</label>
                  <input
                    type="text"
                    className="glass-input"
                    placeholder="ระบุชื่อบริษัท/ชื่อลูกค้า"
                    value={newCustName}
                    onChange={(e) => setNewCustName(e.target.value)}
                    required
                    style={{ margin: 0, width: '100%' }}
                  />
                </div>

                <div>
                  <label style={{ display: 'block', fontSize: '0.82rem', fontWeight: 600, color: '#475569', marginBottom: '0.35rem' }}>รหัสลูกค้า (Cust Num) *</label>
                  <input
                    type="text"
                    className="glass-input"
                    placeholder="เช่น ADI, ART"
                    value={newCustNum}
                    onChange={(e) => setNewCustNum(e.target.value)}
                    required
                    style={{ margin: 0, width: '100%' }}
                  />
                </div>

                <div>
                  <label style={{ display: 'block', fontSize: '0.82rem', fontWeight: 600, color: '#475569', marginBottom: '0.35rem' }}>Prefix (นำหน้า Ticket ID)</label>
                  <input
                    type="text"
                    className="glass-input"
                    placeholder="เช่น ABC"
                    value={newPrefix}
                    onChange={(e) => setNewPrefix(e.target.value)}
                    style={{ margin: 0, width: '100%' }}
                  />
                </div>

                <div>
                  <label style={{ display: 'block', fontSize: '0.82rem', fontWeight: 600, color: '#475569', marginBottom: '0.35rem' }}>เวอร์ชัน (Version)</label>
                  <input
                    type="text"
                    className="glass-input"
                    placeholder="เช่น SL90110"
                    value={newVersion}
                    onChange={(e) => setNewVersion(e.target.value)}
                    style={{ margin: 0, width: '100%' }}
                  />
                </div>

                <div>
                  <label style={{ display: 'block', fontSize: '0.82rem', fontWeight: 600, color: '#475569', marginBottom: '0.35rem' }}>อีเมลติดต่อ (Contact Email)</label>
                  <input
                    type="email"
                    className="glass-input"
                    placeholder="contact@company.com"
                    value={newContactEmail}
                    onChange={(e) => setNewContactEmail(e.target.value)}
                    style={{ margin: 0, width: '100%' }}
                  />
                </div>



                <div>
                  <label style={{ display: 'block', fontSize: '0.82rem', fontWeight: 600, color: '#475569', marginBottom: '0.35rem' }}>License</label>
                  <input
                    type="text"
                    className="glass-input"
                    placeholder="ระบุสิทธิ์ใช้งาน"
                    value={newLicense}
                    onChange={(e) => setNewLicense(e.target.value)}
                    style={{ margin: 0, width: '100%' }}
                  />
                </div>

                <div>
                  <label style={{ display: 'block', fontSize: '0.82rem', fontWeight: 600, color: '#475569', marginBottom: '0.35rem' }}>Account Owner</label>
                  <input
                    type="text"
                    className="glass-input"
                    placeholder="ผู้รับผิดชอบดูแลลูกค้า"
                    value={newAccountOwner}
                    onChange={(e) => setNewAccountOwner(e.target.value)}
                    style={{ margin: 0, width: '100%' }}
                  />
                </div>

                <div>
                  <label style={{ display: 'block', fontSize: '0.82rem', fontWeight: 600, color: '#475569', marginBottom: '0.35rem' }}>Infor MA</label>
                  <input
                    type="text"
                    className="glass-input"
                    placeholder="เช่น YES, NO"
                    value={newInforMA}
                    onChange={(e) => setNewInforMA(e.target.value)}
                    style={{ margin: 0, width: '100%' }}
                  />
                </div>

                <div>
                  <label style={{ display: 'block', fontSize: '0.82rem', fontWeight: 600, color: '#475569', marginBottom: '0.35rem' }}>PPCC App MA</label>
                  <input
                    type="text"
                    className="glass-input"
                    placeholder="เช่น YES, NO"
                    value={newPpccAppMA}
                    onChange={(e) => setNewPpccAppMA(e.target.value)}
                    style={{ margin: 0, width: '100%' }}
                  />
                </div>

                <div>
                  <label style={{ display: 'block', fontSize: '0.82rem', fontWeight: 600, color: '#475569', marginBottom: '0.35rem' }}>PPCC Cust MA</label>
                  <input
                    type="text"
                    className="glass-input"
                    placeholder="เช่น YES, NO"
                    value={newPpccCustMA}
                    onChange={(e) => setNewPpccCustMA(e.target.value)}
                    style={{ margin: 0, width: '100%' }}
                  />
                </div>

                <div>
                  <label style={{ display: 'block', fontSize: '0.82rem', fontWeight: 600, color: '#475569', marginBottom: '0.35rem' }}>PPCC Tech MA</label>
                  <input
                    type="text"
                    className="glass-input"
                    placeholder="เช่น YES, NO"
                    value={newPpccTechMA}
                    onChange={(e) => setNewPpccTechMA(e.target.value)}
                    style={{ margin: 0, width: '100%' }}
                  />
                </div>
              </div>

              <div style={{ display: 'flex', gap: '0.75rem', justifyContent: 'flex-end', borderTop: '1px solid var(--glass-border)', paddingTop: '1.25rem' }}>
                <button 
                  type="button" 
                  className="btn btn-secondary" 
                  onClick={() => {
                    setIsModalOpen(false);
                    resetNewForm();
                  }}
                  style={{ padding: '0.6rem 1.5rem' }}
                >
                  ยกเลิก
                </button>
                <button 
                  type="submit" 
                  className="btn btn-primary" 
                  disabled={!newCustNum.trim() || !newCustName.trim()} 
                  style={{ padding: '0.6rem 1.75rem' }}
                >
                  💾 บันทึกข้อมูล
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      <div className="customer-toolbar">
        <input
          type="search"
          className="glass-input customer-search"
          placeholder="ค้นหาชื่อลูกค้า, รหัส, version หรือผู้ดูแล..."
          value={searchQuery}
          onChange={(event) => setSearchQuery(event.target.value)}
          aria-label="ค้นหาลูกค้า"
        />
        <select className="glass-input" value={versionFilter} onChange={(event) => setVersionFilter(event.target.value)} aria-label="กรอง Version">
          <option value="all">ทุก Version</option>
          {versionOptions.map(version => <option key={version} value={version}>{version}</option>)}
        </select>
        <select className="glass-input" value={ownerFilter} onChange={(event) => setOwnerFilter(event.target.value)} aria-label="กรอง Account Owner">
          <option value="all">ทุก Account Owner</option>
          {ownerOptions.map(owner => <option key={owner} value={owner}>{owner}</option>)}
        </select>
        <select className="glass-input" value={maFilter} onChange={(event) => setMaFilter(event.target.value)} aria-label="กรองสถานะ MA">
          <option value="all">ทุกสถานะ MA</option>
          <option value="complete">MA ครบ 4 รายการ</option>
          <option value="attention">ต้องตรวจสอบ</option>
        </select>
      </div>

      <div className="customer-summary-grid">
        <div><strong>{customers.length}</strong><span>ลูกค้าทั้งหมด</span></div>
        <div><strong>{completeMaCount}</strong><span>MA ครบ 4 รายการ</span></div>
        <div><strong>{needsAttentionCount}</strong><span>ต้องตรวจสอบ</span></div>
      </div>

      <div className="customer-table-meta">
        <span>พบ {totalItems} รายการ</span>
        <label>แสดง
          <select value={limit} onChange={(event) => setLimit(Number(event.target.value))} className="glass-input">
            <option value={10}>10</option><option value={20}>20</option><option value={40}>40</option>
          </select>
          รายการ/หน้า
        </label>
      </div>

      <div className="customer-table-wrap">
        <table className="customer-compact-table">
          <thead>
            <tr>
              <th>ลูกค้า</th><th>รหัส</th><th>Version</th><th>Account Owner</th><th>MA Status</th><th>Action</th>
            </tr>
          </thead>
          <tbody>
            {currentCustomers.length === 0 ? (
              <tr><td colSpan="6" className="customer-empty">ไม่พบข้อมูลลูกค้าที่ตรงกับเงื่อนไข</td></tr>
            ) : currentCustomers.map(customer => {
              const maCount = getMaCount(customer);
              return (
                <tr key={customer.id} onClick={() => setSelectedCustomer(customer)}>
                  <td><strong>{customer.cust_name}</strong><small>{customer.contact_email || 'ไม่มีอีเมลติดต่อ'}</small></td>
                  <td><span className="customer-code">{customer.cust_num}</span></td>
                  <td>{customer.version || '-'}</td>
                  <td>{customer.account_owner || '-'}</td>
                  <td><span className={`ma-status ${maCount === 4 ? 'complete' : 'attention'}`}>{maCount}/4 {maCount === 4 ? 'ครบ' : 'ตรวจสอบ'}</span></td>
                  <td onClick={(event) => event.stopPropagation()}>
                    <button className="customer-action-button" onClick={() => setSelectedCustomer(customer)} aria-label={`ดูรายละเอียด ${customer.cust_name}`}>ดูรายละเอียด</button>
                    <button className="customer-delete-button" onClick={() => handleDelete(customer.id)} aria-label={`ลบ ${customer.cust_name}`}>ลบ</button>
                  </td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>

      {selectedCustomer && (
        <div className="customer-drawer-backdrop" onClick={() => setSelectedCustomer(null)}>
          <aside className="customer-drawer" role="dialog" aria-modal="true" aria-labelledby="customer-detail-title" onClick={(event) => event.stopPropagation()}>
            <div className="customer-drawer-header">
              <div><span className="eyebrow">CUSTOMER DETAIL</span><h4 id="customer-detail-title">{selectedCustomer.cust_name}</h4><span className="customer-code">{selectedCustomer.cust_num}</span></div>
              <button className="modal-close" onClick={() => setSelectedCustomer(null)} aria-label="ปิดรายละเอียดลูกค้า">×</button>
            </div>
            <section><h5>ข้อมูลหลัก</h5><dl className="customer-detail-list"><dt>Prefix</dt><dd>{selectedCustomer.prefix || '-'}</dd><dt>Contact Email</dt><dd>{selectedCustomer.contact_email || '-'}</dd><dt>Account Owner</dt><dd>{selectedCustomer.account_owner || '-'}</dd></dl></section>
            <section><h5>ระบบและ License</h5><dl className="customer-detail-list"><dt>Version</dt><dd>{selectedCustomer.version || '-'}</dd><dt>License</dt><dd>{selectedCustomer.license || '-'}</dd></dl></section>
            <section><h5>สถานะ MA</h5><div className="ma-detail-grid">{[['Infor MA', selectedCustomer.infor_ma], ['PPCC App MA', selectedCustomer.ppcc_app_ma], ['PPCC Cust MA', selectedCustomer.ppcc_cust_ma], ['PPCC Tech MA', selectedCustomer.ppcc_tech_ma]].map(([label, value]) => <div key={label}><span>{label}</span><strong className={String(value || '').toUpperCase() === 'YES' ? 'yes' : 'no'}>{value || '-'}</strong></div>)}</div></section>
            {editingId === selectedCustomer.id ? (
              <form className="customer-edit-form" onSubmit={(event) => { event.preventDefault(); handleUpdateCustomer(selectedCustomer.id); }}>
                <h5>แก้ไขข้อมูลลูกค้า</h5>
                <input className="glass-input" value={editingCustName} onChange={(event) => setEditingCustName(event.target.value)} placeholder="ชื่อลูกค้า" required />
                <div className="customer-edit-grid">
                  <input className="glass-input" value={editingCustNum} onChange={(event) => setEditingCustNum(event.target.value)} placeholder="รหัสลูกค้า" required />
                  <input className="glass-input" value={editingPrefix} onChange={(event) => setEditingPrefix(event.target.value)} placeholder="Prefix" />
                  <input className="glass-input" value={editingVersion} onChange={(event) => setEditingVersion(event.target.value)} placeholder="Version" />
                  <input className="glass-input" value={editingLicense} onChange={(event) => setEditingLicense(event.target.value)} placeholder="License" />
                  <input className="glass-input" value={editingAccountOwner} onChange={(event) => setEditingAccountOwner(event.target.value)} placeholder="Account Owner" />
                  <input className="glass-input" type="email" value={editingContactEmail} onChange={(event) => setEditingContactEmail(event.target.value)} placeholder="Contact Email" />
                </div>
                <div className="customer-edit-grid">
                  <input className="glass-input" value={editingInforMA} onChange={(event) => setEditingInforMA(event.target.value)} placeholder="Infor MA" />
                  <input className="glass-input" value={editingPpccAppMA} onChange={(event) => setEditingPpccAppMA(event.target.value)} placeholder="PPCC App MA" />
                  <input className="glass-input" value={editingPpccCustMA} onChange={(event) => setEditingPpccCustMA(event.target.value)} placeholder="PPCC Cust MA" />
                  <input className="glass-input" value={editingPpccTechMA} onChange={(event) => setEditingPpccTechMA(event.target.value)} placeholder="PPCC Tech MA" />
                </div>
                <div className="customer-drawer-actions"><button type="button" className="btn btn-secondary" onClick={() => setEditingId(null)}>ยกเลิก</button><button type="submit" className="btn btn-primary">บันทึกการแก้ไข</button></div>
              </form>
            ) : (
              <div className="customer-drawer-actions"><button className="btn btn-secondary" onClick={() => {
                setEditingId(selectedCustomer.id);
                setEditingCustNum(selectedCustomer.cust_num || '');
                setEditingCustName(selectedCustomer.cust_name || '');
                setEditingPrefix(selectedCustomer.prefix || '');
                setEditingContactEmail(selectedCustomer.contact_email || '');
                setEditingVersion(selectedCustomer.version || '');
                setEditingLicense(selectedCustomer.license || '');
                setEditingAccountOwner(selectedCustomer.account_owner || '');
                setEditingInforMA(selectedCustomer.infor_ma || '');
                setEditingPpccAppMA(selectedCustomer.ppcc_app_ma || '');
                setEditingPpccCustMA(selectedCustomer.ppcc_cust_ma || '');
                setEditingPpccTechMA(selectedCustomer.ppcc_tech_ma || '');
              }}>แก้ไขข้อมูล</button><button className="btn btn-secondary" onClick={() => setSelectedCustomer(null)}>ปิด</button><button className="btn btn-danger" onClick={() => { setSelectedCustomer(null); handleDelete(selectedCustomer.id); }}>ลบลูกค้า</button></div>
            )}
          </aside>
        </div>
      )}

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

export default CustomerManagement;
