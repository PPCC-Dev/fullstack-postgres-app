import fs from 'fs';
import csv from 'csv-parser';

fs.createReadStream('../support_log_utf8.csv')
  .pipe(csv({ separator: '\t', headers: false }))
  .on('data', (row) => {
    if (row[0] === 'Log Id') {
      console.log('Headers:');
      for(let i=0; i<47; i++) {
        console.log(i, row[i]);
      }
      process.exit(0);
    }
  });
