import fs from 'fs';
import csv from 'csv-parser';

const results = [];
// fs.createReadStream doesn't support setting encoding to utf16le nicely for csv-parser which expects strings or buffers and handles its own encoding sometimes
// Instead, read the file and strip BOM, then parse
const content = fs.readFileSync('/Users/tunited/Projects/fullstack-postgres-app/customer_contract.csv', 'utf16le');
import { Readable } from 'stream';
const stream = Readable.from(content);

stream
  .pipe(csv({ separator: '\t' }))
  .on('data', (data) => results.push(data))
  .on('end', () => {
    console.log(results.slice(0, 2));
  });
