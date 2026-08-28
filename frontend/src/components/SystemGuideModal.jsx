import React, { useState } from 'react';

export default function SystemGuideModal({ isOpen, onClose }) {
  const [activeTab, setActiveTab] = useState('overview');

  if (!isOpen) return null;

  return (
    <div className="modal-overlay" style={{ zIndex: 999999 }}>
      <div 
        className="glass-card modal-content glow-purple" 
        style={{ 
          maxWidth: '1000px', 
          width: '95%', 
          maxHeight: '90vh', 
          display: 'flex', 
          flexDirection: 'column',
          textAlign: 'left', 
          padding: '2rem',
          overflow: 'hidden'
        }}
      >
        {/* Header */}
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.25rem', borderBottom: '1px solid var(--glass-border)', paddingBottom: '1rem' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
            <span style={{ fontSize: '2rem' }}>📘</span>
            <div>
              <h2 style={{ 
                margin: 0, 
                fontSize: '1.4rem',
                background: 'linear-gradient(135deg, #6366f1, #00e5ff)', 
                WebkitBackgroundClip: 'text', 
                WebkitTextFillColor: 'transparent', 
                fontWeight: 'bold' 
              }}>
                คู่มือโครงสร้างและการใช้งานระบบ PPCC Care
              </h2>
              <span style={{ fontSize: '0.8rem', color: '#94a3b8' }}>
                (สำหรับผู้ดูแลระบบ / Administrator Documentation)
              </span>
            </div>
          </div>
          <button className="modal-close" onClick={onClose} style={{ fontSize: '1.75rem', cursor: 'pointer' }}>&times;</button>
        </div>

        {/* Sub Navigation Tabs */}
        <div style={{ display: 'flex', gap: '0.5rem', marginBottom: '1.25rem', overflowX: 'auto', paddingBottom: '0.5rem' }}>
          {[
            { id: 'overview', label: '🏗️ ภาพรวมระบบ' },
            { id: 'backend', label: '⚙️ Backend & DB' },
            { id: 'frontend', label: '🎨 Frontend Structure' },
            { id: 'menus', label: '📌 เมนูหลัก (Header)' },
            { id: 'pages', label: '📄 หน้าจอต่างๆ (Pages)' },
            { id: 'workflow', label: '🛠️ Workflow การทำงาน' },
          ].map(tab => (
            <button
              key={tab.id}
              onClick={() => setActiveTab(tab.id)}
              style={{
                padding: '0.5rem 1rem',
                borderRadius: '10px',
                border: activeTab === tab.id ? '1px solid var(--accent-cyan)' : '1px solid var(--glass-border)',
                background: activeTab === tab.id ? 'rgba(0, 229, 255, 0.15)' : 'rgba(255, 255, 255, 0.05)',
                color: activeTab === tab.id ? 'var(--accent-cyan)' : '#94a3b8',
                cursor: 'pointer',
                fontWeight: activeTab === tab.id ? 700 : 500,
                fontSize: '0.85rem',
                whiteSpace: 'nowrap',
                transition: 'all 0.2s'
              }}
            >
              {tab.label}
            </button>
          ))}
        </div>

        {/* Modal Scrollable Content */}
        <div style={{ flex: 1, overflowY: 'auto', paddingRight: '0.5rem', fontSize: '0.9rem', lineHeight: '1.6', color: '#e2e8f0' }}>
          
          {/* TAB 1: OVERVIEW */}
          {activeTab === 'overview' && (
            <div>
              <h3 style={{ color: '#00e5ff', marginTop: 0 }}>🏗️ ภาพรวมโครงสร้างระบบ (Architecture Overview)</h3>
              <p>
                ระบบ <strong>PPCC Care</strong> เป็นเว็บแอปพลิเคชันประเภท Fullstack Customer Support & Ticket Desk System พัฒนาด้วย 
                <strong>Node.js (Express), PostgreSQL</strong> ในส่วน Backend และ <strong>React (Vite) + Vanilla CSS Glassmorphic Design</strong> ในส่วน Frontend
              </p>

              <div style={{ background: 'rgba(99, 102, 241, 0.08)', padding: '1rem 1.25rem', borderRadius: '12px', border: '1px solid rgba(99, 102, 241, 0.2)', marginBottom: '1.5rem' }}>
                <h4 style={{ margin: '0 0 0.75rem 0', color: '#818cf8' }}>👥 สิทธิ์ของผู้ใช้งาน 3 ระดับ (User Roles):</h4>
                <ul style={{ margin: 0, paddingLeft: '1.25rem' }}>
                  <li><strong>Customer (ลูกค้า)</strong>: แจ้งเคสปัญหา ติดตามสถานะ สนทนากับเจ้าหน้าที่ ตอบรับการแก้ไขเคส</li>
                  <li><strong>Agent (เจ้าหน้าที่ Support)</strong>: กดรับเคส (Claim), อัปเดตสถานะ, บันทึกวิธีแก้ไข (Solution/Workaround), สื่อสารกับลูกค้า / บันทึกโน้ตภายใน (Internal Note)</li>
                  <li><strong>Admin (ผู้ดูแลระบบ)</strong>: ทำหน้าที่เหมือน Agent + ดูรายงานสรุปสถิติผู้บริหาร (Executive Dashboard) + จัดการข้อมูลหลักระบบ (Master Data Config)</li>
                </ul>
              </div>

              <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', gap: '1rem' }}>
                <div className="glass-card" style={{ padding: '1rem' }}>
                  <h4 style={{ color: '#10b981', margin: '0 0 0.5rem 0' }}>🔐 Security & Authentication</h4>
                  <p style={{ fontSize: '0.825rem', margin: 0, color: '#94a3b8' }}>
                    ใช้ระบบ JWT (JSON Web Token) เก็บลง localStorage มีระบบ Verification และ Automatic Mail Notifications ผ่าน SMTP
                  </p>
                </div>
                <div className="glass-card" style={{ padding: '1rem' }}>
                  <h4 style={{ color: '#a855f7', margin: '0 0 0.5rem 0' }}>🔔 Real-time Notifications</h4>
                  <p style={{ fontSize: '0.825rem', margin: 0, color: '#94a3b8' }}>
                    ระบบแจ้งเตือน In-App Bell ซิงค์ข้อมูลทุก 15 วินาที แจ้งเตือนเมื่อมีเคสใหม่ เคสถูกรับ หรือสถานะถูกอัปเดต
                  </p>
                </div>
              </div>
            </div>
          )}

          {/* TAB 2: BACKEND & DB */}
          {activeTab === 'backend' && (
            <div>
              <h3 style={{ color: '#00e5ff', marginTop: 0 }}>⚙️ โครงสร้างฝั่ง Backend และ ฐานข้อมูล</h3>
              
              <h4 style={{ color: '#818cf8', marginBottom: '0.5rem' }}>📁 โครงสร้างไฟล์ใน backend/src:</h4>
              <ul style={{ paddingLeft: '1.25rem' }}>
                <li><code>config/db.js</code> - ตัวจัดการ Connection Pool ของ PostgreSQL (`pg`)</li>
                <li><code>controllers/authController.js</code> - สมัครสมาชิก, ล็อกอิน, ซิงค์โปรไฟล์, ลืม/เปลี่ยนรหัสผ่าน</li>
                <li><code>controllers/ticketController.js</code> - CRUD ทิคเก็ต, กดรับเคส, อัปเดตสถานะ, บันทึก Solution/Workaround, ระบบแชท</li>
                <li><code>controllers/reportController.js</code> - คำนวณรายงานสถิติ KPI, กรองตามเวลา/ลูกค้า, มิติวิเคราะห์ Insights</li>
                <li><code>controllers/customerController.js</code> - จัดการมาสเตอร์ข้อมูลบริษัทลูกค้า และรายชื่อผู้ติดต่อ</li>
                <li><code>services/emailService.js</code> - ส่งอีเมลแจ้งเตือนอัตโนมัติ (สร้างเคส, รับเคส, เปลี่ยนสถานะ, ปิดเคส)</li>
              </ul>

              <h4 style={{ color: '#818cf8', marginBottom: '0.5rem', marginTop: '1.5rem' }}>🗄️ ตารางหลักใน PostgreSQL Database:</h4>
              <div style={{ overflowX: 'auto' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.825rem', textAlign: 'left' }}>
                  <thead>
                    <tr style={{ background: 'rgba(255,255,255,0.08)', color: '#00e5ff' }}>
                      <th style={{ padding: '0.5rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}>ชื่อตาราง (Table Name)</th>
                      <th style={{ padding: '0.5rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}>หน้าที่และการเก็บข้อมูล</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td style={{ padding: '0.5rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}><code>users</code></td>
                      <td style={{ padding: '0.5rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}>เก็บข้อมูลผู้ใช้งาน, password_hash, role (Admin/Agent/Customer), cust_num</td>
                    </tr>
                    <tr>
                      <td style={{ padding: '0.5rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}><code>tickets</code></td>
                      <td style={{ padding: '0.5rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}>เก็บข้อมูลทิคเก็ต (ticket_number, title, status, customer_id, agent_id, solution, workaround)</td>
                    </tr>
                    <tr>
                      <td style={{ padding: '0.5rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}><code>ticket_messages</code></td>
                      <td style={{ padding: '0.5rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}>เก็บข้อความแชทโต้ตอบในทิคเก็ต (รวมทั้งข้อความปกติ และ Internal Note)</td>
                    </tr>
                    <tr>
                      <td style={{ padding: '0.5rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}><code>ticket_attachments</code></td>
                      <td style={{ padding: '0.5rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}>เก็บไฟล์แนบตั้งต้นของทิคเก็ต</td>
                    </tr>
                    <tr>
                      <td style={{ padding: '0.5rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}><code>notifications</code></td>
                      <td style={{ padding: '0.5rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}>เก็บการแจ้งเตือน In-App Bell ของผู้ใช้แต่ละคน</td>
                    </tr>
                    <tr>
                      <td style={{ padding: '0.5rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}><code>customers</code> & <code>customer_contacts</code></td>
                      <td style={{ padding: '0.5rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}>ข้อมูลบริษัทลูกค้า (cust_num, cust_name) และผู้ติดต่อประจำบริษัท</td>
                    </tr>
                    <tr>
                      <td style={{ padding: '0.5rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}><code>modules</code>, <code>program_types</code>, <code>issue_types</code> ฯลฯ</td>
                      <td style={{ padding: '0.5rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}>ตารางข้อมูล Master Config สำหรับ Dropdown ตัวเลือกต่างๆ ในระบบ</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          )}

          {/* TAB 3: FRONTEND */}
          {activeTab === 'frontend' && (
            <div>
              <h3 style={{ color: '#00e5ff', marginTop: 0 }}>🎨 โครงสร้างฝั่ง Frontend (React + Vite)</h3>
              
              <p>
                Frontend ถูกออกแบบโดยใช้ <strong>Glassmorphic Dark Theme Design System</strong> มีองค์ประกอบหลักประกอบด้วย:
              </p>

              <ul style={{ paddingLeft: '1.25rem' }}>
                <li><strong>Context Layer (`AuthContext.jsx`)</strong>: จัดการ Global Auth State, Token Sync, Login/Logout, Profile Update, Change/Forgot Password</li>
                <li><strong>Main Container (`App.jsx`)</strong>: จัดการ Routing ตาม Role, Header Bar, Global Notification Bell, Cookie Consent Bar, Modal Triggers</li>
                <li><strong>Pages (หน้าจอหลัก)</strong>:
                  <ul>
                    <li><code>CustomerDashboard.jsx</code> - หน้าจอสำหรับลูกค้า</li>
                    <li><code>AgentDashboard.jsx</code> - หน้าจอทำงานสำหรับ Agent และหน้าจอ Config สำหรับ Admin</li>
                    <li><code>AdminDashboard.jsx</code> - หน้าจอรายงานสถิติผู้บริหาร</li>
                    <li><code>TicketDetail.jsx</code> - หน้าจอรายละเอียดทิคเก็ตและการแชท</li>
                    <li><code>Login.jsx</code>, <code>Register.jsx</code>, <code>ForgotPassword.jsx</code>, <code>ResetPassword.jsx</code></li>
                  </ul>
                </li>
                <li><strong>Global Modals (ป๊อปอัป)</strong>:
                  <ul>
                    <li><code>CreateTicketModal.jsx</code> - ป๊อปอัปสร้างทิคเก็ตขอความช่วยเหลือ</li>
                    <li><code>EditTicketModal.jsx</code> - ป๊อปอัปแก้ไขข้อมูลรายละเอียดทิคเก็ต</li>
                    <li><code>ProfileModal</code> - ป๊อปอัปแก้ไขข้อมูลส่วนตัวและเปลี่ยนรหัสผ่าน</li>
                    <li><code>SystemGuideModal</code> - ป๊อปอัปคู่มือระบบ (สำหรับ Admin)</li>
                  </ul>
                </li>
              </ul>
            </div>
          )}

          {/* TAB 4: MENUS */}
          {activeTab === 'menus' && (
            <div>
              <h3 style={{ color: '#00e5ff', marginTop: 0 }}>📌 รายละเอียดเมนูหลักบน Navigation Bar (Header)</h3>
              
              <div style={{ overflowX: 'auto' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.85rem', textAlign: 'left' }}>
                  <thead>
                    <tr style={{ background: 'rgba(255,255,255,0.08)', color: '#00e5ff' }}>
                      <th style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}>ชื่อเมนู / ปุ่ม</th>
                      <th style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}>สิทธิ์ที่มองเห็น (Role)</th>
                      <th style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}>หน้าที่และการทำงาน</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)', fontWeight: 'bold' }}>🌱 โลโก้ PPCC Care</td>
                      <td style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}>ทุก Role</td>
                      <td style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}>คลิกเพื่อกลับสู่หน้าหลัก Dashboard ตามสิทธิ์ของตนเอง</td>
                    </tr>
                    <tr>
                      <td style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)', fontWeight: 'bold' }}>📊 ดูรายงานสรุป / 📂 จัดการทิคเก็ต</td>
                      <td style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}><span className="badge-role admin">Admin</span></td>
                      <td style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}>สลับมุมมองระหว่าง <strong>หน้าสถิติผู้บริหาร (Admin Dashboard)</strong> กับ <strong>หน้าจัดการเคส (Agent Dashboard)</strong></td>
                    </tr>
                    <tr>
                      <td style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)', fontWeight: 'bold' }}>⚙️ จัดการระบบ</td>
                      <td style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}><span className="badge-role admin">Admin</span></td>
                      <td style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}>เปิดเข้าสู่หน้าจัดการข้อมูลหลัก Master Data Config (สมาชิก, บริษัทลูกค้า, โมดูลระบบ ฯลฯ)</td>
                    </tr>
                    <tr>
                      <td style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)', fontWeight: 'bold' }}>📘 คู่มือระบบ</td>
                      <td style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}><span className="badge-role admin">Admin</span></td>
                      <td style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}>เปิดหน้าต่างป๊อปอัปคู่มืออธิบายโครงสร้างและการทำงานของระบบแบบละเอียด</td>
                    </tr>
                    <tr>
                      <td style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)', fontWeight: 'bold' }}>➕ สร้างเคสใหม่</td>
                      <td style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}>ทุก Role</td>
                      <td style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}>เปิดหน้าต่าง Modal สร้างทิคเก็ตขอความช่วยเหลือ</td>
                    </tr>
                    <tr>
                      <td style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)', fontWeight: 'bold' }}>🔔 การแจ้งเตือน (Bell)</td>
                      <td style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}>ทุก Role</td>
                      <td style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}>แสดงรายการแจ้งเตือนล่าสุดพร้อม Badge ตัวเลข (ซิงค์ทุก 15 วินาที) คลิกเพื่อไปยังทิคเก็ตเป้าหมาย</td>
                    </tr>
                    <tr>
                      <td style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)', fontWeight: 'bold' }}>👤 ชื่อผู้ใช้งาน & Badge Role</td>
                      <td style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}>ทุก Role</td>
                      <td style={{ padding: '0.6rem 0.75rem', borderBottom: '1px solid var(--glass-border)' }}>คลิกเพื่อเปิด Profile Settings Modal (แก้ไขชื่อ / เปลี่ยนรหัสผ่าน)</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          )}

          {/* TAB 5: PAGES */}
          {activeTab === 'pages' && (
            <div>
              <h3 style={{ color: '#00e5ff', marginTop: 0 }}>📄 รายละเอียดการทำงานของแต่ละหน้าจอ (Pages Deep Dive)</h3>

              <div style={{ display: 'flex', flexDirection: 'column', gap: '1.25rem' }}>
                
                <div className="glass-card" style={{ padding: '1.25rem' }}>
                  <h4 style={{ color: '#818cf8', margin: '0 0 0.5rem 0' }}>1. Customer Dashboard (`CustomerDashboard.jsx`)</h4>
                  <p style={{ fontSize: '0.85rem', color: '#94a3b8' }}>หน้าสำหรับลูกค้าใช้ติดตามเคสของตนเอง</p>
                  <ul style={{ paddingLeft: '1.25rem', margin: 0, fontSize: '0.85rem' }}>
                    <li><strong>KPI Cards</strong>: แสดงจำนวน "เคสรอดำเนินการ/กำลังแก้ไข", "เคสปิดแล้ว", "เคสทั้งหมด"</li>
                    <li><strong>Filters & Search</strong>: ช่องค้นหาทิคเก็ต, ตัวกรองสถานะ (รอดำเนินการ/ปิดแล้ว/ทั้งหมด), เรียงตามวันที่ล่าสุด/เก่าสุด, ตัวกรอง "เคสทั้งหมดในบริษัท" VS "เคสที่ฉันแจ้ง"</li>
                    <li><strong>Ticket Table</strong>: แสดงรหัสทิคเก็ต, หัวข้อเรื่อง, โมดูล, วันที่แจ้ง, Badge สถานะสีต่าง ๆ และชื่อ Agent ผู้รับดูแล</li>
                  </ul>
                </div>

                <div className="glass-card" style={{ padding: '1.25rem' }}>
                  <h4 style={{ color: '#818cf8', margin: '0 0 0.5rem 0' }}>2. Agent Dashboard (`AgentDashboard.jsx`)</h4>
                  <p style={{ fontSize: '0.85rem', color: '#94a3b8' }}>หน้าทำงานหลักของ Agent และ Admin</p>
                  <ul style={{ paddingLeft: '1.25rem', margin: 0, fontSize: '0.85rem' }}>
                    <li><strong>📥 แท็บ คิวงานรอรับเรื่อง (Queue)</strong>: แสดงเคสใหม่ที่ยังไม่มีเจ้าหน้าที่ดูแล (agent_id = null) พร้อมปุ่ม <strong>"📥 รับเคสดูแล"</strong></li>
                    <li><strong>💼 แท็บ งานของฉัน (My Tasks)</strong>: แสดงเฉพาะเคสที่ Agent คนนี้เป็นผู้กดรับดูแลอยู่</li>
                    <li><strong>📋 แท็บ เคสทั้งหมด (All Tickets)</strong>: แสดงเคสทั้งหมดในระบบ พร้อมตัวกรองแยกตามสถานะ และตามบริษัทลูกค้า</li>
                    <li><strong>⚙️ แท็บ ตั้งค่าระบบ (Config - Admin)</strong>: จัดการข้อมูล Master Data (Members, Categories, Customers, Roles, Support Stats)</li>
                  </ul>
                </div>

                <div className="glass-card" style={{ padding: '1.25rem' }}>
                  <h4 style={{ color: '#818cf8', margin: '0 0 0.5rem 0' }}>3. Admin Executive Dashboard (`AdminDashboard.jsx`)</h4>
                  <p style={{ fontSize: '0.85rem', color: '#94a3b8' }}>หน้าสถิติและรายงานสรุปสำหรับผู้บริหาร</p>
                  <ul style={{ paddingLeft: '1.25rem', margin: 0, fontSize: '0.85rem' }}>
                    <li><strong>KPI Summary Cards</strong>: จำนวนเคสทั้งหมด, เคสที่กำลังดำเนินการ, เคสที่ปิดแล้ว, <strong>ระยะเวลาแก้ไขเฉลี่ย (Avg Resolution Time)</strong></li>
                    <li><strong>Filters</strong>: เลือกช่วงเวลา (ทั้งหมด / รายวัน / รายสัปดาห์ / รายเดือน) และเลือกบริษัทลูกค้า</li>
                    <li><strong>Pivot & Insights Analytics</strong>: สถิติวิเคราะห์เปรียบเทียบเชิงลึกตามปี, รายเดือน, รายบริษัท และรายเจ้าหน้าที่ผู้ดูแล</li>
                  </ul>
                </div>

                <div className="glass-card" style={{ padding: '1.25rem' }}>
                  <h4 style={{ color: '#818cf8', margin: '0 0 0.5rem 0' }}>4. Ticket Details Page (`TicketDetail.jsx`)</h4>
                  <p style={{ fontSize: '0.85rem', color: '#94a3b8' }}>หน้าศูนย์รวมข้อมูล รายละเอียด แชท และบันทึกการแก้ไขปัญหา</p>
                  <ul style={{ paddingLeft: '1.25rem', margin: 0, fontSize: '0.85rem' }}>
                    <li><strong>Header & Action Bar</strong>: รหัสทิคเก็ต, หัวข้อเรื่อง, Badge สถานะ/ความสำคัญ, ปุ่มกดรับเรื่อง, Dropdown เปลี่ยนสถานะ, ปุ่มแก้ไขเคส</li>
                    <li><strong>Problem Overview & Attachments</strong>: รายละเอียดปัญหาแบบเต็ม, โมดูล, ประเภทโปรแกรม, รายการไฟล์แนบ (เปิดดูรูปขยาย Lightbox ได้)</li>
                    <li><strong>Solution & Workaround Box</strong>: ช่องบันทึกวิธีแก้ปัญหาถาวร (Solution) และวิธีแก้ปัญหาชั่วคราว (Workaround) พร้อมปุ่มบันทึก</li>
                    <li><strong>Conversation Timeline & Internal Note</strong>: ประวัติแชทโต้ตอบ รองรับการสลับเป็น <strong>Internal Note (โน้ตภายใน)</strong> เพื่อคุยกันเฉพาะทีม Agent/Admin โดยที่ลูกค้าจะไม่เห็นข้อความนี้</li>
                  </ul>
                </div>

              </div>
            </div>
          )}

          {/* TAB 6: WORKFLOW */}
          {activeTab === 'workflow' && (
            <div>
              <h3 style={{ color: '#00e5ff', marginTop: 0 }}>🛠️ ลำดับขั้นตอนการทำงานหลัก (System Workflow)</h3>

              <ol style={{ paddingLeft: '1.25rem', lineHeight: 1.8 }}>
                <li><strong>การสร้างเคส (Create Ticket)</strong>: ลูกค้ากดปุ่ม "➕ สร้างเคสใหม่" กรอกรายละเอียดและแนบไฟล์ ระบบจะสร้างทิคเก็ต บันทึกลง PostgreSQL และส่งอีเมลยืนยันไปยังลูกค้า พร้อมส่งสัญญาณแจ้งเตือน In-App Bell ไปยังทีม Agent</li>
                <li><strong>การรับเรื่อง (Claim Ticket)</strong>: เจ้าหน้าที่ Agent เข้าไปที่หน้า "📥 คิวงานรอรับเรื่อง" กดปุ่ม "📥 รับเคสดูแล" ระบบจะอัปเดต `agent_id` และเปลี่ยนสถานะเป็นกำลังดำเนินการ พร้อมส่งอีเมลแจ้งลูกค้าว่ามีเจ้าหน้าที่รับเรื่องดูแลแล้ว</li>
                <li><strong>การสื่อสารโต้ตอบ (Communication)</strong>: ลูกค้าและ Agent สามารถพิมพ์ข้อความและแนบรูปภาพคุยกันในหน้า Ticket Detail ได้ตลอดเวลา โดย Agent สามารถเลือกส่งเป็น **Internal Note** หากต้องการบันทึกข้อมูลส่วนตัวระหว่างทีม</li>
                <li><strong>การแก้ปัญหาและปิดงาน (Resolution & Close)</strong>: เมื่อแก้ไขปัญหาเสร็จแล้ว Agent จะกรอกข้อมูล **Solution** หรือ **Workaround** และเปลี่ยนสถานะเป็นปิดเคส (`C`) ระบบจะส่งอีเมลและแจ้งเตือนแจ้งลูกค้าว่าเคสแก้ไขเรียบร้อยแล้ว</li>
              </ol>
            </div>
          )}

        </div>

        {/* Footer */}
        <div style={{ marginTop: '1rem', paddingTop: '1rem', borderTop: '1px solid var(--glass-border)', display: 'flex', justifyContent: 'flex-end' }}>
          <button className="btn btn-secondary" onClick={onClose}>
            ปิดหน้าต่าง
          </button>
        </div>

      </div>
    </div>
  );
}
