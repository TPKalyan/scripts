import fs from 'fs'
import * as childProcess from 'child_process';
import util from 'util';
const exec = util.promisify(childProcess.exec);

const execute = async (command) => {
    const { stdout, stderr } = await exec(command);
    return {stdout, stderr};
};

const listAllTeamDirectories = async (projectName) => {
    const res = await execute(`ls`);
    return res.stdout.trim().split('\n').filter(entry => entry.startsWith(projectName));
};

const pullNewChanges = (directoryName) => {
    exec(`cd ${directoryName} && git pull --rebase`)
      .then((res) => console.log("\x1b[32m%s\x1b[0m", `Sucessfully pulled ${directoryName} \n ${res.stdout}`))
      .catch((err) => console.error("\x1b[31m%s\x1b[0m", `Failed to pull ${directoryName} \n ${err.stderr}`));
};

const main = async () => {
    listAllTeamDirectories(process.argv[2])
      .then(directories => {
        directories.forEach((directory) => {
          pullNewChanges(directory);
        });

      });
};

main().then();
