import React, { useState, useEffect } from 'react';
import { useAuth } from '../context/AuthContext';

export default function EditTicketModal({ ticket, onClose, onSuccess }) {
  const { token, API_URL } = useAuth();
  
  const [title, setTitle] = useState(ticket.title || '');
  const [description, setDescription] = useState(ticket.description || '');
  const [module, setModule] = useState(ticket.module || '');
  const [programType, setProgramType] = useState(ticket.program_type || '');
  const [issueType, setIssueType] = useState(ticket.issue_type || '');
  const [formName, setFormName] = useState(ticket.form_name || '');
  const [additionalEmail, setAdditionalEmail] = useState(ticket.additional_email || '');
  const [priority, setPriority] = useState(ticket.priority || 'medium');
  const [contactName, setContactName] = useState(ticket.contact_name || '');
  
  const [requestDate, setRequestDate] = useState(
    ticket.request_date ? new Date(ticket.request_date).toISOString().split('T')[0] : ''
  );
  const [requestTime, setRequestTime] = useState(
    ticket.request_time ? ticket.request_time.substring(0, 5) : ''
  );

  const [formError, setFormError] = useState('');
  const [formSubmitting, setFormSubmitting] = useState(false);

  const [dbModules, setDbModules] = useState([]);
  const [dbProgramTypes, setDbProgramTypes] = useState([]);
  const [dbIssueTypes, setDbIssueTypes] = useState([]);

  useEffect(() => {
    fetchConfig();
    // eslint-disable-next-line
  }, [token]);

  const fetchConfig = async () => {
    try {
      const modRes = await fetch(`${API_URL}/tickets/config/modules`, { headers: { 'Authorization': `Bearer ${token}` } });
      if (modRes.ok) setDbModules(await modRes.json());

      const progRes = await fetch(`${API_URL}/tickets/config/program-types`, { headers: { 'Authorization': `Bearer ${token}` } });
      if (progRes.ok) setDbProgramTypes(await progRes.json());

      const issueRes = await fetch(`${API_URL}/tickets/config/issue-types`, { headers: { 'Authorization': `Bearer ${token}` } });
      if (issueRes.ok) setDbIssueTypes(await issueRes.json());
    } catch (err) {
      console.error('Error fetching config for modal:', err);
    }
  };

  const handleUpdateTicket = async (e) => {
    e.preventDefault();
    setFormError('');
    setFormSubmitting(true);

    if (!title || !description || !module) {
      setFormError('กรุณากรอกข้อมูลที่จำเป็น (หัวข้อ, รายละเอียด, โมดูล)');
      setFormSubmitting(false);
      return;
    }

    try {
      const payload = {
        title,
        description,
        module,
        program_type: programType,
        issue_type: issueType,
        form_name: formName,
        additional_email: additionalEmail,
        priority,
        contact_name: contactName,
        request_date: requestDate || null,
        request_time: requestTime || null
      };

      const response = await fetch(`${API_URL}/tickets/${ticket.id}`, {
        method: 'PUT',
        headers: { 
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(payload)
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.error || 'Failed to update ticket details');
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
          ✏️ แก้ไขข้อมูลเคส (Edit Ticket)
        </h2>

        {formError && (
          <div className="alert-box alert-error" style={{ background: '#fee2e2', color: '#ef4444', padding: '1rem', borderRadius: '8px', marginBottom: '1.5rem', fontSize: '0.9rem' }}>
            <span>{formError}</span>
          </div>
        )}

        <form onSubmit={handleUpdateTicket}>
          <div className="form-group" style={{ marginBottom: '1rem' }}>
            <label htmlFor="ticket-title" style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '0.4rem' }}>หัวข้อของปัญหา (Title)</label>
            <input
              type="text"
              id="ticket-title"
              className="glass-input"
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
                value={additionalEmail}
                onChange={(e) => setAdditionalEmail(e.target.value)}
                disabled={formSubmitting}
                style={{ width: '100%' }}
              />
            </div>
            
            <div className="form-group">
              <label htmlFor="ticket-contract" style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '0.4rem' }}>ผู้ติดต่อ (Contact Name)</label>
              <input
                type="text"
                id="ticket-contract"
                className="glass-input"
                value={contactName}
                onChange={(e) => setContactName(e.target.value)}
                disabled={formSubmitting}
                style={{ width: '100%' }}
              />
            </div>
          </div>

          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem', marginBottom: '1rem', padding: '1rem', background: 'rgba(241, 245, 249, 0.5)', borderRadius: '8px', border: '1px dashed #cbd5e1' }}>
            <div className="form-group" style={{ marginBottom: 0 }}>
              <label htmlFor="ticket-request-date" style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '0.4rem' }}>วันที่แจ้ง (Request Date)</label>
              <input
                type="date"
                id="ticket-request-date"
                className="glass-input"
                value={requestDate}
                onChange={(e) => setRequestDate(e.target.value)}
                disabled={formSubmitting}
                style={{ width: '100%', margin: 0 }}
              />
            </div>
            <div className="form-group" style={{ marginBottom: 0 }}>
              <label htmlFor="ticket-request-time" style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '0.4rem' }}>เวลาที่แจ้ง (Request Time)</label>
              <input
                type="time"
                id="ticket-request-time"
                className="glass-input"
                value={requestTime}
                onChange={(e) => setRequestTime(e.target.value)}
                disabled={formSubmitting}
                style={{ width: '100%', margin: 0 }}
              />
            </div>
          </div>

          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem', marginBottom: '1rem' }}>
            <div className="form-group">
              <label htmlFor="ticket-form-name" style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '0.4rem' }}>FormName</label>
              <input
                type="text"
                id="ticket-form-name"
                className="glass-input"
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
                disabled={formSubmitting}
                style={{ background: '#f8fafc', cursor: 'pointer', width: '100%' }}
              >
                <option value="">-- ไม่ระบุ --</option>
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
                disabled={formSubmitting}
                style={{ background: '#f8fafc', cursor: 'pointer', width: '100%' }}
              >
                <option value="">-- ไม่ระบุ --</option>
                {dbIssueTypes.map(it => (
                  <option key={it.id} value={it.name}>{it.name}</option>
                ))}
              </select>
            </div>
          </div>

          <div className="form-group" style={{ marginBottom: '1.5rem' }}>
            <label htmlFor="ticket-desc" style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#475569', marginBottom: '0.4rem' }}>รายละเอียดปัญหาอย่างละเอียด (Description)</label>
            <textarea
              id="ticket-desc"
              className="glass-input"
              rows="5"
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              disabled={formSubmitting}
              required
              style={{ resize: 'vertical', width: '100%', padding: '0.75rem' }}
            ></textarea>
          </div>

          <button 
            type="submit" 
            className="btn btn-primary" 
            style={{ width: '100%', padding: '0.75rem', fontWeight: 'bold', fontSize: '1rem' }}
            disabled={formSubmitting}
          >
            {formSubmitting ? '⏳ กำลังบันทึกข้อมูล...' : '💾 บันทึกการแก้ไขข้อมูล'}
          </button>
        </form>
      </div>
    </div>
  );
}
