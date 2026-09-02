import pool from '../config/db.js';
import fs from 'fs';
import path from 'path';
import { initAndImportCompatibilityMatrix } from '../services/compatibilityImporter.js';

/**
 * Get filtered compatibility matrix records
 */
export async function getCompatibilityMatrix(req, res) {
  try {
    const { csi_version, component, category, integrated_app, status, search } = req.query;

    let query = `SELECT * FROM syteline_compatibility_matrix WHERE 1=1`;
    const values = [];
    let paramIndex = 1;

    if (csi_version && csi_version !== 'all') {
      query += ` AND csi_version = $${paramIndex++}`;
      values.push(csi_version);
    }

    if (component && component !== 'all') {
      query += ` AND component = $${paramIndex++}`;
      values.push(component);
    }

    if (category && category !== 'all') {
      query += ` AND category = $${paramIndex++}`;
      values.push(category);
    }

    if (integrated_app && integrated_app !== 'all') {
      query += ` AND integrated_app = $${paramIndex++}`;
      values.push(integrated_app);
    }

    if (status && status !== 'all') {
      query += ` AND supported_status = $${paramIndex++}`;
      values.push(status);
    }

    if (search && search.trim() !== '') {
      query += ` AND (
        csi_version ILIKE $${paramIndex} OR 
        component ILIKE $${paramIndex} OR 
        category ILIKE $${paramIndex} OR 
        integrated_app ILIKE $${paramIndex} OR 
        app_version ILIKE $${paramIndex} OR 
        syteline_subversion ILIKE $${paramIndex}
      )`;
      values.push(`%${search.trim()}%`);
      paramIndex++;
    }

    query += ` ORDER BY 
      CASE WHEN supported_status = 'Supported' THEN 1 ELSE 2 END ASC,
      NULLIF(SPLIT_PART(regexp_replace(csi_version, '[^0-9.]', '', 'g'), '.', 1), '')::int DESC NULLS LAST,
      NULLIF(SPLIT_PART(regexp_replace(csi_version, '[^0-9.]', '', 'g'), '.', 2), '')::int DESC NULLS LAST,
      NULLIF(SPLIT_PART(regexp_replace(csi_version, '[^0-9.]', '', 'g'), '.', 3), '')::int DESC NULLS LAST,
      component ASC, category ASC, integrated_app ASC, app_version DESC`;

    const result = await pool.query(query, values);

    // Fetch summary statistics
    const statsResult = await pool.query(`
      SELECT 
        COUNT(*)::int AS total,
        COUNT(CASE WHEN supported_status = 'Supported' THEN 1 END)::int AS supported,
        COUNT(CASE WHEN supported_status = 'Deprecated' THEN 1 END)::int AS deprecated,
        COUNT(DISTINCT csi_version)::int AS total_csi_versions,
        COUNT(DISTINCT component)::int AS total_components,
        COUNT(DISTINCT category)::int AS total_categories
      FROM syteline_compatibility_matrix
    `);

    res.json({
      success: true,
      stats: statsResult.rows[0],
      total: result.rows.length,
      data: result.rows
    });
  } catch (error) {
    console.error('Error fetching compatibility matrix:', error);
    res.status(500).json({ error: 'Failed to fetch compatibility matrix', details: error.message });
  }
}

/**
 * Get distinct options for filter dropdowns
 */
export async function getFilterOptions(req, res) {
  try {
    const versionsRes = await pool.query(
      `SELECT DISTINCT csi_version FROM syteline_compatibility_matrix`
    );
    const componentsRes = await pool.query(
      `SELECT DISTINCT component FROM syteline_compatibility_matrix ORDER BY component ASC`
    );
    const categoriesRes = await pool.query(
      `SELECT DISTINCT category FROM syteline_compatibility_matrix ORDER BY category ASC`
    );
    const appsRes = await pool.query(
      `SELECT DISTINCT integrated_app FROM syteline_compatibility_matrix ORDER BY integrated_app ASC`
    );
    const statusesRes = await pool.query(
      `SELECT DISTINCT supported_status FROM syteline_compatibility_matrix ORDER BY supported_status ASC`
    );

    const sortedVersions = versionsRes.rows
      .map(r => r.csi_version)
      .sort((a, b) => {
        const cleanA = a.replace(/^csi\s*/i, '');
        const cleanB = b.replace(/^csi\s*/i, '');
        return cleanB.localeCompare(cleanA, undefined, { numeric: true, sensitivity: 'base' });
      });

    res.json({
      success: true,
      csi_versions: sortedVersions,
      components: componentsRes.rows.map(r => r.component),
      categories: categoriesRes.rows.map(r => r.category),
      integrated_apps: appsRes.rows.map(r => r.integrated_app),
      statuses: statusesRes.rows.map(r => r.supported_status)
    });
  } catch (error) {
    console.error('Error fetching filter options:', error);
    res.status(500).json({ error: 'Failed to fetch filter options', details: error.message });
  }
}

/**
 * Re-import matrix from xlsm file
 */
export async function reimportMatrix(req, res) {
  try {
    const result = await initAndImportCompatibilityMatrix(true);
    res.json(result);
  } catch (error) {
    console.error('Error re-importing matrix:', error);
    res.status(500).json({ error: 'Failed to re-import matrix', details: error.message });
  }
}

/**
 * Upload and import Excel Matrix file (.xlsm / .xlsx)
 */
export async function uploadMatrixFile(req, res) {
  try {
    if (!req.file) {
      return res.status(400).json({ success: false, error: 'กรุณาเลือกไฟล์ Excel (.xlsm หรือ .xlsx)' });
    }

    const uploadedFilePath = req.file.path;
    console.log(`📤 Admin uploaded matrix file: ${uploadedFilePath}`);

    const result = await initAndImportCompatibilityMatrix(true, uploadedFilePath);

    // Clean up temp file
    const rootMatrixPath = path.resolve(process.cwd(), 'SyteLine_Compatibility_Matrix.xlsm');
    if (fs.existsSync(uploadedFilePath) && uploadedFilePath !== rootMatrixPath) {
      try {
        fs.unlinkSync(uploadedFilePath);
      } catch (e) {
        console.warn('Temp upload file cleanup error:', e.message);
      }
    }

    res.json(result);
  } catch (error) {
    console.error('Error handling upload matrix file:', error);
    res.status(500).json({ success: false, error: 'เกิดข้อผิดพลาดในการอัปโหลดไฟล์', details: error.message });
  }
}
