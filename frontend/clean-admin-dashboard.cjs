const fs = require('fs');

const path = '/Users/tunited/.gemini/antigravity-ide/scratch/fullstack-postgres-app/frontend/src/pages/AdminDashboard.jsx';
let content = fs.readFileSync(path, 'utf8');

// 1. Remove category stats
content = content.replace(/\s*category:\s*\{\},/g, '');

// 2. Remove category parsing in ticketsForAnalytics.forEach
const categoryLoopRegex = /\s*\/\/\s*Category\s*if\s*\(ticket\.category\)\s*\{\s*stats\.category\[ticket\.category\]\s*=\s*\(stats\.category\[ticket\.category\]\s*\|\|\s*0\)\s*\+\s*1;\s*\}/g;
content = content.replace(categoryLoopRegex, '');

// 3. Remove Donut Chart Section
// To remove the donut chart section safely, I will replace lines that contain 'Category Donut Chart Section' and 'Modules Bar Chart Section'.
// Let's use string split and replace
const startMarker = '{/* Category Donut Chart Section */}';
const endMarker = '{/* Modules Bar Chart Section */}';

if (content.includes(startMarker) && content.includes(endMarker)) {
  const startIndex = content.indexOf(startMarker);
  const endIndex = content.indexOf(endMarker);
  content = content.substring(0, startIndex) + content.substring(endIndex);
}

// 4. Remove CSV column for category
content = content.replace(/\s*'Category',/g, '');
content = content.replace(/\s*t\.category,/g, '');

fs.writeFileSync(path, content, 'utf8');
console.log('Cleaned AdminDashboard.jsx');
