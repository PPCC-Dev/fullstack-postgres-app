import xlsx from 'xlsx';
import path from 'path';
import fs from 'fs';
import { fileURLToPath } from 'url';
import pool from '../config/db.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

/**
 * Ensures table exists and imports records from SyteLine_Compatibility_Matrix.xlsm (OCMRawData + Technical Data)
 * @param {boolean} force - If true, clears table and re-imports
 * @param {string|null} customFilePath - Custom uploaded file path
 */
export async function initAndImportCompatibilityMatrix(force = false, customFilePath = null) {
  try {
    console.log('🔄 Checking syteline_compatibility_matrix table...');

    // 1. Create table with csi_version column if not exists
    await pool.query(`
      CREATE TABLE IF NOT EXISTS syteline_compatibility_matrix (
        id SERIAL PRIMARY KEY,
        csi_version VARCHAR(100) NOT NULL DEFAULT '10.00.00',
        component VARCHAR(150) NOT NULL,
        category VARCHAR(150) NOT NULL,
        integrated_app VARCHAR(255) NOT NULL,
        app_version VARCHAR(150),
        supported_status VARCHAR(50) NOT NULL,
        syteline_subversion VARCHAR(255),
        notes TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
      
      -- Ensure csi_version column exists if table was created previously without it
      ALTER TABLE syteline_compatibility_matrix ADD COLUMN IF NOT EXISTS csi_version VARCHAR(100) DEFAULT '10.00.00';
      ALTER TABLE syteline_compatibility_matrix ADD COLUMN IF NOT EXISTS notes TEXT;

      CREATE INDEX IF NOT EXISTS idx_compatibility_csi_version ON syteline_compatibility_matrix(csi_version);
      CREATE INDEX IF NOT EXISTS idx_compatibility_component ON syteline_compatibility_matrix(component);
      CREATE INDEX IF NOT EXISTS idx_compatibility_category ON syteline_compatibility_matrix(category);
      CREATE INDEX IF NOT EXISTS idx_compatibility_status ON syteline_compatibility_matrix(supported_status);
      CREATE INDEX IF NOT EXISTS idx_compatibility_app ON syteline_compatibility_matrix(integrated_app);
    `);

    // 2. Check current count
    const countRes = await pool.query('SELECT COUNT(*) FROM syteline_compatibility_matrix');
    const totalCount = parseInt(countRes.rows[0].count, 10);

    // If already has >100 records and not forced/custom, skip import
    if (totalCount > 100 && !force && !customFilePath) {
      console.log(`✅ syteline_compatibility_matrix already populated with ${totalCount} records.`);
      return { success: true, count: totalCount, imported: false };
    }

    // 3. Locate xlsm file
    let filePath = customFilePath;

    if (!filePath || !fs.existsSync(filePath)) {
      const possiblePaths = [
        path.resolve(__dirname, '../../../SyteLine_Compatibility_Matrix.xlsm'),
        path.resolve(__dirname, '../../../../SyteLine_Compatibility_Matrix.xlsm'),
        path.resolve(process.cwd(), 'SyteLine_Compatibility_Matrix.xlsm'),
        '/Users/tunited/Projects/fullstack-postgres-app/SyteLine_Compatibility_Matrix.xlsm',
        '/Users/tunited/Downloads/SyteLine_Compatibility_Matrix_1.xlsm'
      ];
      filePath = possiblePaths.find(p => fs.existsSync(p));
    }

    if (!filePath || !fs.existsSync(filePath)) {
      console.warn('⚠️ SyteLine_Compatibility_Matrix.xlsm not found in any standard path.');
      return { success: false, error: 'File SyteLine_Compatibility_Matrix.xlsm not found' };
    }

    // If customFilePath uploaded, copy it over to root project directory for persistence
    const targetRootPath = '/Users/tunited/Projects/fullstack-postgres-app/SyteLine_Compatibility_Matrix.xlsm';
    if (customFilePath && fs.existsSync(customFilePath) && customFilePath !== targetRootPath) {
      try {
        fs.copyFileSync(customFilePath, targetRootPath);
        console.log(`💾 Overwritten project root matrix file with uploaded version.`);
      } catch (cpErr) {
        console.warn('Could not copy uploaded file to root path:', cpErr.message);
      }
    }

    console.log(`📖 Reading Excel file: ${filePath}`);
    const workbook = xlsx.readFile(filePath);
    
    // Check for OCMRawData sheet first
    const ocmSheetName = workbook.SheetNames.find(n => n.toLowerCase() === 'ocmrawdata') || 'OCMRawData';
    const ocmSheet = workbook.Sheets[ocmSheetName];
    
    const records = [];

    if (ocmSheet) {
      console.log(`📊 Processing '${ocmSheetName}' sheet for all CSI versions...`);
      const rows = xlsx.utils.sheet_to_json(ocmSheet, { header: 1 });
      
      for (let i = 1; i < rows.length; i++) {
        const r = rows[i];
        if (!r || r.length < 5) continue;

        // Columns: 0: Component, 1: Category, 2: Application, 3: AppVersion, 4: Supported, 5: Notes, 6: FullName, 7: InforApp, 8: InforAppVersion
        const component = r[0] ? String(r[0]).trim() : null;
        const category = r[1] ? String(r[1]).trim() : null;
        const integratedApp = r[2] ? String(r[2]).trim() : null;
        const appVersion = r[3] !== undefined && r[3] !== null ? String(r[3]).trim() : '';
        const supportedStatus = r[4] ? String(r[4]).trim() : null;
        const notes = r[5] ? String(r[5]).trim() : '';
        const sytelineSubversion = r[6] ? String(r[6]).trim() : '';
        const csiVersion = r[8] ? String(r[8]).trim() : '10.00.00';

        if (!component || !category || !integratedApp || !supportedStatus) continue;
        if (component.toLowerCase() === 'component' && category.toLowerCase() === 'category') continue;

        records.push({
          csi_version: csiVersion,
          component,
          category,
          integrated_app: integratedApp,
          app_version: appVersion,
          supported_status: supportedStatus,
          syteline_subversion: sytelineSubversion,
          notes
        });
      }
    }

    // Fallback to Technical Data sheet if OCMRawData returned no records
    if (records.length === 0) {
      console.log('⚠️ OCMRawData empty or missing. Falling back to Technical Data sheet...');
      const techSheetName = workbook.SheetNames.find(n => n.toLowerCase() === 'technical data') || 'Technical Data';
      const techSheet = workbook.Sheets[techSheetName];
      if (techSheet) {
        const rows = xlsx.utils.sheet_to_json(techSheet, { header: 1 });
        for (let i = 5; i < rows.length; i++) {
          const r = rows[i];
          if (!r || r.length < 6) continue;
          const component = r[1] ? String(r[1]).trim() : null;
          const category = r[2] ? String(r[2]).trim() : null;
          const integratedApp = r[3] ? String(r[3]).trim() : null;
          const appVersion = r[4] !== undefined && r[4] !== null ? String(r[4]).trim() : '';
          const supportedStatus = r[5] ? String(r[5]).trim() : null;
          const sytelineSubversion = r[6] ? String(r[6]).trim() : '';

          if (!component || !category || !integratedApp || !supportedStatus) continue;
          if (component.toLowerCase() === 'component' && category.toLowerCase() === 'category') continue;

          records.push({
            csi_version: '10.00.00',
            component,
            category,
            integrated_app: integratedApp,
            app_version: appVersion,
            supported_status: supportedStatus,
            syteline_subversion: sytelineSubversion,
            notes: ''
          });
        }
      }
    }

    if (records.length === 0) {
      console.warn('⚠️ No valid records found in workbook.');
      return { success: false, error: 'ไม่พบข้อมูลที่ถูกต้องในไฟล์ Excel ที่อัปโหลด (กรุณาตรวจสอบว่ามีชีต OCMRawData หรือ Technical Data)' };
    }

    console.log(`📦 Found ${records.length} records across all CSI versions to import into database.`);

    // 4. Clear table
    await pool.query('TRUNCATE syteline_compatibility_matrix RESTART IDENTITY');

    // 5. Batch Insert
    for (const rec of records) {
      await pool.query(
        `INSERT INTO syteline_compatibility_matrix 
         (csi_version, component, category, integrated_app, app_version, supported_status, syteline_subversion, notes)
         VALUES ($1, $2, $3, $4, $5, $6, $7, $8)`,
        [rec.csi_version, rec.component, rec.category, rec.integrated_app, rec.app_version, rec.supported_status, rec.syteline_subversion, rec.notes]
      );
    }

    console.log(`✅ Successfully imported ${records.length} records into syteline_compatibility_matrix!`);
    return { success: true, count: records.length, imported: true, filename: path.basename(filePath) };

  } catch (error) {
    console.error('❌ Failed to import compatibility matrix:', error);
    return { success: false, error: error.message };
  }
}
