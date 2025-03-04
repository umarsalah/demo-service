import * as fs from 'fs';
import { GoogleAuth } from 'google-auth-library';



/**
 * @remarks
 * This function detects the google environment and  returns the current project_id
 *
 * @returns {string}
 */
export const getCurrentProjectId = async (): Promise<string> => {
    // Detect Google environment
    try {
        const auth = new GoogleAuth({
            scopes: 'https://www.googleapis.com/auth/cloud-platform',
        });
        return await auth.getProjectId();
    } catch (e: unknown) {
        throw new Error(`Error while detecting GCP environment: ${(e as Error).message}`);
    }
};


/**
 * @remarks
 * Delete a file from the file system
 * @param filePath
 *
 */
export const deleteFile = (filePath: string): void => {
    if (fs.existsSync(filePath)) {
        fs.unlinkSync(filePath);
    }
};
