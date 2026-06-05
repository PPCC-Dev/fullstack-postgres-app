const fs = require('fs');

const path = '/Users/tunited/.gemini/antigravity-ide/scratch/fullstack-postgres-app/frontend/src/pages/AgentDashboard.jsx';
let content = fs.readFileSync(path, 'utf8');

// 1. Remove category stats
content = content.replace(/\s*category:\s*\{\},/g, '');

// 2. Remove states
content = content.replace(/\s*const \[configCategories, setConfigCategories\] = useState\(\[\]\);/g, '');
content = content.replace(/\s*const \[newCatName, setNewCatName\] = useState\(''\);/g, '');
content = content.replace(/\s*const \[editingCategoryName, setEditingCategoryName\] = useState\(null\);/g, '');
content = content.replace(/\s*const \[editingCategoryNewName, setEditingCategoryNewName\] = useState\(''\);/g, '');
content = content.replace(/\s*const \[categoriesPage, setCategoriesPage\] = useState\(1\);/g, '');
content = content.replace(/\s*const \[categoriesLimit, setCategoriesLimit\] = useState\(10\);/g, '');

// 3. Remove fetch category
const fetchRegex = /\s*const catRes = await fetch\(`\$\{API_URL\}\/tickets\/config\/categories`, \{[\s\S]*?if \(catRes\.ok\) setConfigCategories\(catData\);/g;
content = content.replace(fetchRegex, '');

// 4. Remove handleAddCategory, handleUpdateCategory, handleDeleteCategory
const handlersRegex = /\s*const handleAddCategory = async \(e\) => \{[\s\S]*?const handleDeleteCategory = async \(name\) => \{[\s\S]*?finally \{\s*setConfigLoading\(false\);\s*\}\s*\};/g;
content = content.replace(handlersRegex, '');

// 5. Remove ticket.category badges
content = content.replace(/<span className="badge badge-category">\{ticket\.category\}<\/span>/g, '');

// 6. Config sub tab for categories - wait, we also need to remove the sub tab button and the panel.
// Removing the sub tab button:
content = content.replace(/\s*<button\s*className=\{\`sub-tab-btn \$\{configSubTab === 'categories' \? 'active' : ''\}\`\}\s*onClick=\{\(\) => setConfigSubTab\('categories'\)\}\s*>\s*📂 หมวดหมู่ \(Categories\)\s*<\/button>/g, '');

// Removing the categories config panel:
// I'll leave the panel for a manual multi_replace since it's large and regex might be risky.

fs.writeFileSync(path, content, 'utf8');
console.log('Cleaned AgentDashboard.jsx');
