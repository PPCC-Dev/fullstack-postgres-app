import React, { useState, useEffect } from 'react';
import { useAuth } from '../context/AuthContext';

export default function CreateTicketModal({ onClose, onSuccess }) {
  const { user, token, API_URL } = useAuth();
  
  const [title, setTitle] = useState('');
  const [description, setDescription] = useState('');
  const [module, setModule] = useState('');
  const [programType, setProgramType] = useState('');
  const [issueType, setIssueType] = useState('');
  const [formName, setFormName] = useState('');
  const [additionalEmail, setAdditionalEmail] = useState('');
  const [priority, setPriority] = useState('medium');
  const [custNum, setCustNum] = useState('');
  const [attachmentFiles, setAttachmentFiles] = useState([]);

  const [formError, setFormError] = useState('');
  const [formSubmitting, setFormSubmitting] = useState(false);

  const [dbModules, setDbModules] = useState([]);
  const [dbProgramTypes, setDbProgramTypes] = useState([]);
  const [dbIssueTypes, setDbIssueTypes] = useState([]);
  const [dbCustomers, setDbCustomers] = useState([]);

  useEffect(() => {
    fetchConfig();
    // eslint-disable-next-line
  }, [token]);

  const fetchConfig = async () => {
    try {
      const modRes = await fetch(`${API_URL}/tickets/config/modules`, { headers: { 'Authorization': `Bearer ${token}` } });
      if (modRes.ok) {
        const modData = await modRes.json();
        setDbModules(modData);
        if (modData.length > 0) setModule(modData[0].name);
      }

      const progRes = await fetch(`${API_URL}/tickets/config/program-types`, { headers: { 'Authorization': `Bearer ${token}` } });
      if (progRes.ok) {
        const progData = await progRes.json();
        setDbProgramTypes(progData);
        if (progData.length > 0) setProgramType(progData[0].name);
      }

      const issueRes = await fetch(`${API_URL}/tickets/config/issue-types`, { headers: { 'Authorization': `Bearer ${token}` } });
      if (issueRes.ok) {
        const issueData = await issueRes.json();
        setDbIssueTypes(issueData);
        if (issueData.length > 0) setIssueType(issueData[0].name);
      }

      if (user?.role !== 'customer') {
        const custRes = await fetch(`${API_URL}/customers`, { headers: { 'Authorization': `Bearer ${token}` } });
        if (custRes.ok) {
          const custData = await custRes.json();
          setDbCustomers(custData);
          if (custData.length > 0) {
            setCustNum(custData[0].cust_num);
          }
        }
      }
    } catch (err) {
      console.error('Error fetching config for modal:', err);
    }
  };

  const handleCreateTicket = async (e) => {
    e.preventDefault();
    setFormError('');
    setFormSubmitting(true);

    if (!title || !description || (user?.role !== 'customer' && !custNum)) {
      setFormError('กรุณากรอกหัวข้อ รายละเอียด และเลือกลูกค้า');
      setFormSubmitting(false);
      return;
    }

    try {
      const formData = new FormData();
      formData.append('title', title);
      formData.append('description', description);
      formData.append('module', module);
      formData.append('program_type', programType);
      formData.append('issue_type', issueType);
      formData.append('form_name', formName);
      formData.append('additional_email', additionalEmail);
      formData.append('priority', priority);
      if (user?.role !== 'customer') {
        formData.append('cust_num', custNum);
      }
      
      if (attachmentFiles && attachmentFiles.length > 0) {
        attachmentFiles.forEach(file => {
          formData.append('attachments', file);
        });
      }

      const response = await fetch(`${API_URL}/tickets`, {
        method: 'POST',
        headers: { 'Authorization': `Bearer ${token}` },
        body: formData
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.error || 'Failed to submit ticket');
      }

      onSuccess();
    } catch (err) {
      setFormError(err.message);
    } finally {
      setFormSubmitting(false);
    }
  };

  return (
    <div className="modal-overlay" style={{ position: 'fixed', top: 0, left: 0, right: 0, bottom: 0, background: 'rgba(15, 23, 42, 0.45)', backdropFilter: 'blur(8px)', display: 'flex', justifyContent: 'center', alignItems: 'center', zIndex: 10000 }}>
      <div className="glass-card modal-content glow-purple" style={{ width: '100%', maxWidth: '800px', padding: '2rem', background: '#ffffff', borderRadius: '16px', border: '1px solid var(--glass-border)', textAlign: 'left', maxHeight: '90vh', overflowY: 'auto', position: 'relative' }}>
        <button className="modal-close" onClick={onClose} style={{ position: 'absolute', top: '1.5rem', right: '1.5rem', background: 'none', border: 'none', fontSize: '1.5rem', cursor: 'pointer', color: '#64748b' }}>×</button>
        <h2 style={{ marginBottom: '1.5rem', background: 'linear-gradient(135deg, #004bb5, #6366f1)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', fontWeight: 'bold', fontSize: '1.5rem', marginTop: 0 }}>
          สร้างคำขอความช่วยเหลือใหม่
        </h2>

        {formError && (
          <div className="alert-box alert-error" style={{ background: '#fee2e2', color: '#ef4444', padding: '1rem', borderRadius: '8px', marginBottom: '1.5rem', fontSize: '0.9rem' }}>
            <span>{formError}</span>
          </div>
        )}

        <form onSubmit={handleCreateTicket}>
          <div className="form-group" style={{ marginBottom: '1rem' }}>
            <label htmlFor="ticket-title" style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '0.4rem' }}>หัวข้อของปัญหา (Title)</label>
            <input
              type="text"
              id="ticket-title"
              className="glass-input"
              placeholder="เช่น ไม่สามารถดาวน์โหลดไฟล์รายงานได้ หรือ ต้องการขอใบกำกับภาษี"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              disabled={formSubmitting}
              required
              style={{ width: '100%' }}
            />
          </div>

          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem', marginBottom: '1rem' }}>
            <div className="form-group">
              <label htmlFor="ticket-additional-email" style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '0.4rem' }}>อีเมลเพิ่มเติม (CC)</label>
              <input
                type="email"
                id="ticket-additional-email"
                className="glass-input"
                placeholder="เช่น user@example.com (ใส่ได้ 1 อีเมล)"
                value={additionalEmail}
                onChange={(e) => setAdditionalEmail(e.target.value)}
                disabled={formSubmitting}
                style={{ width: '100%' }}
              />
            </div>
            
            {user?.role !== 'customer' && (
              <div className="form-group">
                <label htmlFor="ticket-customer" style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '0.4rem' }}>ลูกค้า (Customer Name)</label>
                <select
                  id="ticket-customer"
                  className="glass-input"
                  value={custNum}
                  onChange={(e) => setCustNum(e.target.value)}
                  disabled={formSubmitting || dbCustomers.length === 0}
                  style={{ background: '#f8fafc', cursor: 'pointer', width: '100%' }}
                  required
                >
                  {dbCustomers.length === 0 && <option value="">ไม่มีข้อมูลลูกค้า</option>}
                  {dbCustomers.map(cust => (
                    <option key={cust.id} value={cust.cust_num}>{cust.cust_name}</option>
                  ))}
                </select>
              </div>
            )}

            <div className="form-group">
              <label htmlFor="ticket-form-name" style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '0.4rem' }}>FormName</label>
              <input
                type="text"
                id="ticket-form-name"
                className="glass-input"
                placeholder="เช่น AR-001 หรือ หน้าจอออกใบแจ้งหนี้"
                value={formName}
                onChange={(e) => setFormName(e.target.value)}
                disabled={formSubmitting}
                style={{ width: '100%' }}
              />
            </div>
          </div>

          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem', marginBottom: '1rem' }}>
            <div className="form-group">
              <label htmlFor="ticket-module" style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '0.4rem' }}>Module</label>
              <select
                id="ticket-module"
                className="glass-input"
                value={module}
                onChange={(e) => setModule(e.target.value)}
                disabled={formSubmitting}
                style={{ background: '#f8fafc', cursor: 'pointer', width: '100%' }}
              >
                {dbModules.map(mod => (
                  <option key={mod.id} value={mod.name}>{mod.name}</option>
                ))}
              </select>
            </div>

            <div className="form-group">
              <label htmlFor="ticket-priority" style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '0.4rem' }}>Priority</label>
              <select
                id="ticket-priority"
                className="glass-input"
                value={priority}
                onChange={(e) => setPriority(e.target.value)}
                disabled={formSubmitting}
                style={{ background: '#f8fafc', cursor: 'pointer', width: '100%' }}
              >
                <option value="low">ต่ำ (Low)</option>
                <option value="medium">ปานกลาง (Medium)</option>
                <option value="high">สูง (High - เร่งด่วน)</option>
              </select>
            </div>
          </div>

          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem', marginBottom: '1rem' }}>
            <div className="form-group">
              <label htmlFor="ticket-program-type" style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '0.4rem' }}>ProgramType</label>
              <select
                id="ticket-program-type"
                className="glass-input"
                value={programType}
                onChange={(e) => setProgramType(e.target.value)}
                disabled={formSubmitting || dbProgramTypes.length === 0}
                style={{ background: '#f8fafc', cursor: 'pointer', width: '100%' }}
                required
              >
                {dbProgramTypes.length === 0 && <option value="">กำลังโหลด...</option>}
                {dbProgramTypes.map(pt => (
                  <option key={pt.id} value={pt.name}>{pt.name}</option>
                ))}
              </select>
            </div>
            <div className="form-group">
              <label htmlFor="ticket-issue-type" style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '0.4rem' }}>IssueType</label>
              <select
                id="ticket-issue-type"
                className="glass-input"
                value={issueType}
                onChange={(e) => setIssueType(e.target.value)}
                disabled={formSubmitting || dbIssueTypes.length === 0}
                style={{ background: '#f8fafc', cursor: 'pointer', width: '100%' }}
                required
              >
                {dbIssueTypes.length === 0 && <option value="">กำลังโหลด...</option>}
                {dbIssueTypes.map(it => (
                  <option key={it.id} value={it.name}>{it.name}</option>
                ))}
              </select>
            </div>
          </div>

          <div className="form-group" style={{ marginBottom: '1rem' }}>
            <label htmlFor="ticket-desc" style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '0.4rem' }}>รายละเอียดปัญหาอย่างละเอียด (Description)</label>
            <textarea
              id="ticket-desc"
              className="glass-input"
              rows="5"
              placeholder="กรุณาเขียนรายละเอียดของปัญหา ขั้นตอนการเกิดปัญหาอย่างครบถ้วน เพื่อให้เจ้าหน้าที่วิเคราะห์ได้อย่างรวดเร็ว"
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              disabled={formSubmitting}
              required
              style={{ resize: 'vertical', width: '100%', padding: '0.75rem' }}
            ></textarea>
          </div>

          <div className="form-group" style={{ marginBottom: '1.5rem' }}>
            <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '0.4rem' }}>แนบไฟล์ภาพหรือเอกสารอ้างอิง</label>
            <input 
              type="file" 
              multiple 
              accept="image/*,.pdf,.doc,.docx,.xls,.xlsx,.csv,.txt,.zip,.rar"
              className="glass-input" 
              onChange={(e) => {
                if(e.target.files) {
                  const newFiles = Array.from(e.target.files);
                  setAttachmentFiles(prev => [...prev, ...newFiles]);
                }
              }}
              disabled={formSubmitting}
              style={{ width: '100%' }}
            />
            {attachmentFiles.length > 0 && (
              <div style={{ marginTop: '0.5rem', fontSize: '0.8rem', color: '#64748b' }}>
                เลือกแล้ว {attachmentFiles.length} ไฟล์
                <button 
                  type="button" 
                  onClick={() => setAttachmentFiles([])}
                  style={{ marginLeft: '1rem', background: 'none', border: 'none', color: '#ef4444', cursor: 'pointer', textDecoration: 'underline' }}
                >
                  ล้างไฟล์แนบ
                </button>
              </div>
            )}
          </div>

          <button 
            type="submit" 
            className="btn btn-primary" 
            style={{ width: '100%', padding: '0.75rem', fontWeight: 'bold', fontSize: '1rem' }}
            disabled={formSubmitting}
          >
            {formSubmitting ? '⏳ กำลังส่งข้อมูล...' : '📩 ยืนยันการส่งคำขอความช่วยเหลือ'}
          </button>
        </form>
      </div>
    </div>
  );
}
