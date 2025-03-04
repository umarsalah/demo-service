import r from 'express';
import { testEndpoint } from '../controllers/demo';
const router = r.Router();

router.post('/test', testEndpoint);

export default router;
