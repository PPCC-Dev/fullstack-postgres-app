const fs = require('fs');
const path = require('path');

function replaceInDir(dir) {
  const files = fs.readdirSync(dir);
  for (const file of files) {
    const fullPath = path.join(dir, file);
    if (fs.statSync(fullPath).isDirectory()) {
      replaceInDir(fullPath);
    } else if (fullPath.endsWith('.js') || fullPath.endsWith('.jsx')) {
      const content = fs.readFileSync(fullPath, 'utf8');
      if (content.includes('ตั๋ว')) {
        const newContent = content.replace(/ตั๋ว/g, 'เคส');
        fs.writeFileSync(fullPath, newContent);
        console.log('Updated', fullPath);
      }
    }
  }
}

replaceInDir(path.join(__dirname, 'backend', 'src'));
replaceInDir(path.join(__dirname, 'frontend', 'src'));

console.log('Replacement complete.');
