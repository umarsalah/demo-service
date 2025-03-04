import express from 'express';
import logger from '../utils/logger';
import { castToObject } from '../utils/errors';
import { FAILURE, SUCCESS } from '../utils/constants';
import { failure, success } from '../utils/apiResponse';

/**
 * test endpoint
 * @param req
 * @param res
 */
export const testEndpoint = async (req: express.Request, res: express.Response) => {
  try {
    const requestId = req.id || '';
    const metadata = { requestId: requestId };
    logger.info('test endpoint was triggered', metadata);



    return res.status(200).send(success(`${SUCCESS}: Done`, { ...metadata }));
  } catch (e: any) {
    const errorObject = castToObject(e);
    const metadata = { requestId: req.id, errorObject };
    return res.status(500).send(failure(FAILURE, metadata, 500));
  }
};
