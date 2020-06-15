import './utils/env';
import logger from './utils/logger';
import './utils/env';

import { createServer } from 'http';
import { app } from './app';

const port = process.env.PORT || 5000;

(async () => {
  createServer(app).listen(port, () =>
    logger.info(`Server running on port ${port}`),
  );
})();
