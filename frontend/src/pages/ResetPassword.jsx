import React, { useState } from 'react';
import { useAuth } from '../context/AuthContext';

export default function ResetPassword({ onToggleView, token }) {
  const { resetPassword } = useAuth();
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [message, setMessage] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setMessage('');
    
    if (!newPassword || !confirmPassword) {
      setError('กรุณากรอกรหัสผ่านใหม่ให้ครบถ้วน');
      return;
    }
    
    if (newPassword !== confirmPassword) {
      setError('รหัสผ่านและการยืนยันรหัสผ่านไม่ตรงกัน');
      return;
    }

    setLoading(true);

    const result = await resetPassword(token, newPassword);
    setLoading(false);

    if (result.success) {
      setMessage('ตั้งรหัสผ่านใหม่สำเร็จแล้ว กรุณาเข้าสู่ระบบด้วยรหัสผ่านใหม่ของคุณ');
      setTimeout(() => {
        onToggleView('login');
      }, 3000);
    } else {
      setError(result.error || 'เกิดข้อผิดพลาดในการตั้งรหัสผ่านใหม่');
    }
  };

  return (
    <div className="auth-page">
      <div className="auth-card-mockup">
        <h2 style={{ color: '#f8fafc', marginBottom: '1.5rem', textAlign: 'center' }}>ตั้งรหัสผ่านใหม่</h2>

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
                <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
              </svg>
            </div>
            <input
              type="password"
              className="input-pill-field"
              placeholder="รหัสผ่านใหม่"
              value={newPassword}
              onChange={(e) => setNewPassword(e.target.value)}
              disabled={loading}
              required
            />
          </div>

          <div className="input-pill-group">
            <div className="input-icon-badge">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                <polyline points="20 6 9 17 4 12"></polyline>
              </svg>
            </div>
            <input
              type="password"
              className="input-pill-field"
              placeholder="ยืนยันรหัสผ่านใหม่"
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
              disabled={loading}
              required
            />
          </div>

          <div style={{ fontSize: '0.75rem', color: '#64748b', textAlign: 'left', margin: '0.25rem 0' }}>
            รหัสผ่านต้องมีความยาวอย่างน้อย 6 ตัวอักษร ประกอบด้วยตัวพิมพ์เล็ก, พิมพ์ใหญ่, ตัวเลข, และอักขระพิเศษ
          </div>

          <button type="submit" className="btn-signin-pill" disabled={loading} style={{ background: 'linear-gradient(135deg, #10b981, #059669)' }}>
            {loading ? 'กำลังบันทึก...' : 'บันทึกรหัสผ่านใหม่'}
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
