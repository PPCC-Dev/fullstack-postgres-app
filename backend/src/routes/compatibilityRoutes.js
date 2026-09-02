import express from 'express';
import multer from 'multer';
import path from 'path';
import fs from 'fs';
import { 
  getCompatibilityMatrix, 
  getFilterOptions, 
  reimportMatrix,
  uploadMatrixFile
} from '../controllers/compatibilityController.js';

const router = express.Router();

// Multer storage for excel matrix upload
const uploadDir = path.resolve(process.cwd(), 'uploads');
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
}

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, uploadDir);
  },
  filename: (req, file, cb) => {
    const ext = path.extname(file.originalname);
    cb(null, `matrix_upload_${Date.now()}${ext}`);
  }
});

const upload = multer({ 
  storage,
  limits: { fileSize: 50 * 1024 * 1024 } // 50MB max file size
});

// GET /api/compatibility - Fetch matrix with optional filters
router.get('/', getCompatibilityMatrix);

// GET /api/compatibility/filters - Fetch unique dropdown options
router.get('/filters', getFilterOptions);

// POST /api/compatibility/reimport - Force re-import from xlsm
router.post('/reimport', reimportMatrix);

// POST /api/compatibility/upload - Upload new .xlsm / .xlsx file and re-import
router.post('/upload', upload.single('file'), uploadMatrixFile);

export default router;
