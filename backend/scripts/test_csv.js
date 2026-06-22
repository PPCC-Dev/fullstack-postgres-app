const fs = require('fs');
const { parse } = require('csv-parse/sync');

const fileContent = fs.readFileSync('../support_log.csv', 'utf16le');
const records = parse(fileContent, {
  columns: true,
  skip_empty_lines: true,
  delimiter: '\t'
});

const agents = new Set();
records.forEach(row => {
  if (row['Responsible']) agents.add(row['Responsible']);
});
console.log("Agents:", Array.from(agents));
