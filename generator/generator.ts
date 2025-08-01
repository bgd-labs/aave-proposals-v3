import fs from 'fs';
import path from 'path';
import {generateContractName, generateFolderName, isWhitelabelPool} from './common';
import {proposalTemplate} from './templates/proposal.template';
import {testTemplate} from './templates/test.template';
import {confirm} from '@inquirer/prompts';
import {ConfigFile, Options, PoolConfigs, PoolIdentifier, Scripts, Files} from './types';
import prettier from 'prettier';
import {generateScript} from './templates/script.template';
import {generateZkSyncScript} from './templates/zksync.script.template';
import {generateAIP} from './templates/aip.template';

const prettierSolCfg = await prettier.resolveConfig('foo.sol');
const prettierMDCfg = await prettier.resolveConfig('foo.md');
const prettierTsCfg = await prettier.resolveConfig('foo.ts');

/**
 * Generates all the file contents for aip/tests/payloads & script
 * @param options
 * @param poolConfigs
 * @returns
 */
export async function generateFiles(options: Options, poolConfigs: PoolConfigs): Promise<Files> {
  const jsonConfig = await prettier.format(
    `import {ConfigFile} from '../../generator/types';
    export const config: ConfigFile = ${JSON.stringify({
      rootOptions: options,
      poolOptions: (Object.keys(poolConfigs) as PoolIdentifier[]).reduce((acc, pool) => {
        acc[pool] = {configs: poolConfigs[pool]!.configs, cache: poolConfigs[pool]!.cache};
        return acc;
      }, {}),
    } as ConfigFile)}`,
    {...prettierTsCfg, filepath: 'foo.ts'},
  );

  async function createPayloadAndTest(options: Options, pool: PoolIdentifier) {
    const contractName = generateContractName(options, pool);
    const testCode = testTemplate(options, poolConfigs[pool]!, pool);

    return {
      pool,
      payload: await prettier.format(proposalTemplate(options, poolConfigs[pool]!, pool), {
        ...prettierSolCfg,
        filepath: 'foo.sol',
      }),
      test: await prettier.format(testCode, {
        ...prettierSolCfg,
        filepath: 'foo.sol',
      }),
      contractName: contractName,
    };
  }

  console.log('generating script');
  let scripts: Scripts = {
    defaultScript: await prettier.format(generateScript(options), {
      ...prettierSolCfg,
      filepath: 'foo.sol',
    }),
  };
  if (Object.keys(poolConfigs).includes('AaveV3ZkSync')) {
    scripts.zkSyncScript = await prettier.format(generateZkSyncScript(options), {
      ...prettierSolCfg,
      filepath: 'foo.sol',
    });
  }

  console.log('generating aip');
  const aip = await prettier.format(generateAIP(options, poolConfigs), {
    ...prettierMDCfg,
    filepath: 'foo.md',
  });

  return {
    jsonConfig,
    scripts,
    aip,
    payloads: await Promise.all(options.pools.map((pool) => createPayloadAndTest(options, pool))),
  };
}

async function askBeforeWrite(options: Options, path: string, content: string) {
  if (!options.force && fs.existsSync(path)) {
    const currentContent = fs.readFileSync(path, {encoding: 'utf8'});
    // skip if content did not change
    if (currentContent === content) return;
    const force = await confirm({
      message: `A file already exists at ${path} do you want to overwrite`,
      default: false,
    });
    if (!force) return;
  }
  fs.writeFileSync(path, content);
}

/**
 * Writes the files according to defined folder/file format
 * @param options
 * @param param1
 */
export async function writeFiles(options: Options, {jsonConfig, scripts, aip, payloads}: Files) {
  const baseName = generateFolderName(options);
  const baseFolder = path.join(process.cwd(), 'src', baseName);
  const zkSyncBaseFolder = path.join(process.cwd(), 'zksync/src', baseName);

  if (fs.existsSync(baseFolder) || (scripts.zkSyncScript && fs.existsSync(zkSyncBaseFolder))) {
    if (!options.force && fs.existsSync(baseFolder)) {
      const force = await confirm({
        message: 'A proposal already exists at that location, do you want to continue?',
        default: false,
      });
      if (!force) return;
    }
  } else {
    fs.mkdirSync(baseFolder, {recursive: true});
    if (scripts.zkSyncScript) fs.mkdirSync(zkSyncBaseFolder, {recursive: true});
  }

  // write config
  await askBeforeWrite(options, path.join(baseFolder, 'config.ts'), jsonConfig);
  // write aip
  if (!options.pools.some((pool) => isWhitelabelPool(pool))) {
    await askBeforeWrite(options, path.join(baseFolder, `${options.shortName}.md`), aip);
  }
  // write scripts
  await askBeforeWrite(
    options,
    path.join(baseFolder, `${generateContractName(options)}.s.sol`),
    scripts.defaultScript,
  );
  if (scripts.zkSyncScript) {
    await askBeforeWrite(
      options,
      path.join(zkSyncBaseFolder, `${generateContractName(options)}.s.sol`),
      scripts.zkSyncScript,
    );
  }

  for (const {pool, payload, test, contractName} of payloads) {
    await askBeforeWrite(
      options,
      path.join(pool === 'AaveV3ZkSync' ? zkSyncBaseFolder : baseFolder, `${contractName}.sol`),
      payload,
    );
    await askBeforeWrite(
      options,
      path.join(pool === 'AaveV3ZkSync' ? zkSyncBaseFolder : baseFolder, `${contractName}.t.sol`),
      test,
    );
  }
}
