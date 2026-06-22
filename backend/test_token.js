import jwt from 'jsonwebtoken';
const token = jwt.sign({ id: 1, role: 'admin' }, 'your_jwt_secret', { expiresIn: '1h' });
console.log(token);
