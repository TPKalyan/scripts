const util = require('node:util');
const exec = util.promisify(require('node:child_process').exec);

const execute = async (command, options = {}) => {
  return { stdout, stderr } = await exec(command, options);
};

let PWD = process.cwd();
let teamName = process.argv[2];

const listAllProjectRepos = async (teamName) => {
  return await execute(`ls | grep "^${teamName}"`).then(res => res.stdout);
}

const main = async (teamName) => {
  let reposString = await listAllProjectRepos(teamName);
  reposString.trim().split("\n").forEach(async (repo) => {
    let repoPath = `${PWD}/${repo}`;
    execute(`git pull --rebase`, {cwd:repoPath})
    .then(val => {
      console.log("\x1b[32m", `Sucessfully pulled ${repo}`);
      console.log(val.stdout)
    })
    .catch(err => {
      console.log("\x1b[31m", `Failed to pull ${repo}`);
      console.error(err.stderr);
    });
  });

}

main(teamName).then();
