import React, { useState } from 'react';
import { useAuth } from '../context/AuthContext';

export default function ForgotPassword({ onToggleView }) {
  const { forgotPassword } = useAuth();
  const [email, setEmail] = useState('');
  const [message, setMessage] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setMessage('');
    setLoading(true);

    if (!email) {
      setError('กรุณากรอกอีเมลที่ใช้สมัครสมาชิก');
      setLoading(false);
      return;
    }

    const result = await forgotPassword(email);
    setLoading(false);

    if (result.success) {
      setMessage(result.message || 'ส่งลิงก์รีเซ็ตรหัสผ่านไปยังอีเมลของคุณเรียบร้อยแล้ว');
      setEmail('');
    } else {
      setError(result.error || 'เกิดข้อผิดพลาดในการส่งคำขอ');
    }
  };

  return (
    <div className="auth-page">
      <div className="auth-card-mockup">
        <h2 style={{ color: '#f8fafc', marginBottom: '1.5rem', textAlign: 'center' }}>ลืมรหัสผ่าน</h2>
        <p style={{ color: '#94a3b8', fontSize: '0.85rem', marginBottom: '1.5rem', textAlign: 'center' }}>
          กรอกอีเมลของคุณเพื่อรับลิงก์สำหรับตั้งรหัสผ่านใหม่
        </p>

        {error && (
          <div className="alert-box alert-error" style={{ marginBottom: '1.25rem', borderRadius: '12px' }}>
            <span>{error}</span>
          </div>
        )}
        {message && (
          <div className="alert-box alert-success" style={{ marginBottom: '1.25rem', borderRadius: '12px', background: 'rgba(16,185,129,0.15)', border: '1px solid rgba(16,185,129,0.3)', color: '#10b981' }}>
            <span>{message}</span>
          </div>
        )}

        <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
          <div className="input-pill-group">
            <div className="input-icon-badge">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
                <polyline points="22,6 12,13 2,6"></polyline>
              </svg>
            </div>
            <input
              type="email"
              className="input-pill-field"
              placeholder="Email Address"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              disabled={loading}
              required
            />
          </div>

          <button type="submit" className="btn-signin-pill" disabled={loading} style={{ background: 'linear-gradient(135deg, #0ea5e9, #3b82f6)' }}>
            {loading ? 'กำลังส่ง...' : 'ส่งลิงก์รีเซ็ตรหัสผ่าน'}
          </button>
        </form>

        <div className="auth-footer-mockup" style={{ marginTop: '1.5rem' }}>
          <a href="#" className="auth-link-mockup" onClick={(e) => { e.preventDefault(); onToggleView('login'); }}>
            &larr; กลับไปหน้าเข้าสู่ระบบ
          </a>
        </div>
      </div>
    </div>
  );
}
