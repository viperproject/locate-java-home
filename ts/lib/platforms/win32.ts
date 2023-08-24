import { execFile } from 'child_process';
import { ILocateJavaHomeResult } from '../interfaces';
import commonFindJavaHome from './common';

/**
 * Find Java on Windows by checking registry keys and PATH
 */
export default function windowsFindJavaHome(): Promise<ILocateJavaHomeResult> {
  return Promise.all([commonFindJavaHome(), checkRegistryKeys()])
    .then(res => {
      // combine the results:
      return {
        homes: res[0].concat(res[1].homes),
        executableExtension: res[1].executableExtension
      };
    });
}

function checkRegistryKeys(): Promise<ILocateJavaHomeResult> {
  return new Promise((resolve, reject) => {
    execFile("find-java.bat", (error, stdout) => {
      if (error) {
        reject(error);
      } else {
        const homes = stdout.split('\r\n').filter(it => it != '').map(it => it.trim());
        resolve({ homes: homes, executableExtension: 'exe' });
      }
    });
  });
}
