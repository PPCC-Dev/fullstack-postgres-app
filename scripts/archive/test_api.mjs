async function test() {
  let loginRes = await fetch('http://localhost:5001/api/auth/login', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email: 'supachai.a@ppcc.co.th', password: 'password123' })
  });
  let loginData = await loginRes.json();
  if (!loginData.token) {
    loginRes = await fetch('http://localhost:5001/api/auth/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email: 'natcha@ad-castingth.com', password: 'password123' })
    });
    loginData = await loginRes.json();
  }
  
  console.log('Login:', loginData.user?.role || 'failed');
  const res = await fetch('http://localhost:5001/api/reports/summary?filter=all&custNum=all', {
    headers: { 'Authorization': `Bearer ${loginData.token}` }
  });
  
  console.log('Status:', res.status);
  const text = await res.text();
  console.log('Body:', text.substring(0, 500));
}

test();
