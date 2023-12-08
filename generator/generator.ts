import fs from 'fs';
import path from 'path';
import {generateContractName, generateFolderName} from './common';
import {proposalTemplate} from './templates/proposal.template';
import {testTemplate} from './templates/test.template';
import {confirm} from '@inquirer/prompts';
import {ConfigFile, Options, PoolConfigs, PoolIdentifier} from './types';
import prettier from 'prettier';
import {generateScript} from './templates/script.template';
import {generateAIP} from './templates/aip.template';

const prettierSolCfg = await prettier.resolveConfig('foo.sol');
const prettierMDCfg = await prettier.resolveConfig('foo.md');

type Files = {
  jsonConfig: string;
  script: string;
  aip: string;
  payloads: {payload: string; test: string; contractName: string}[];
};

/**
 * Generates all the file contents for aip/tests/payloads & script
 * @param options
 * @param poolConfigs
 * @returns
 */
export async function generateFiles(options: Options, poolConfigs: PoolConfigs): Promise<Files> {
  const jsonConfig = JSON.stringify(
    {
      rootOptions: options,
      poolOptions: (Object.keys(poolConfigs) as PoolIdentifier[]).reduce((acc, pool) => {
        acc[pool] = {configs: poolConfigs[pool]!.configs, cache: poolConfigs[pool]!.cache};
        return acc;
      }, {}),
    } as ConfigFile,
    null,
    2
  );

  function createPayloadAndTest(options: Options, pool: PoolIdentifier) {
    const contractName = generateContractName(options, pool);
    const testCode = testTemplate(options, poolConfigs[pool]!, pool);
    return {
      payload: prettier.format(proposalTemplate(options, poolConfigs[pool]!, pool), {
        ...prettierSolCfg,
        filepath: 'foo.sol',
      }),
      test: prettier.format(testCode, {
        ...prettierSolCfg,
        filepath: 'foo.sol',
      }),
      contractName: contractName,
    };
  }

  console.log('generating script');
  const script = prettier.format(generateScript(options), {
    ...prettierSolCfg,
    filepath: 'foo.sol',
  });
  console.log('generating aip');
  const aip = prettier.format(generateAIP(options, poolConfigs), {
    ...prettierMDCfg,
    filepath: 'foo.md',
  });

  return {
    jsonConfig,
    script,
    aip,
    payloads: options.pools.map((pool) => createPayloadAndTest(options, pool)),
  };
}

async function askBeforeWrite(options: Options, path: string, content: string) {
  if (!options.force && fs.existsSync(path)) {
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
export async function writeFiles(options: Options, {jsonConfig, script, aip, payloads}: Files) {
  const baseName = generateFolderName(options);
  const baseFolder = path.join(process.cwd(), 'src', baseName);
  if (fs.existsSync(baseFolder)) {
    if (!options.force && fs.existsSync(baseFolder)) {
      const force = await confirm({
        message: 'A proposal already exists at that location, do you want to continue?',
        default: false,
      });
      if (!force) return;
    }
  } else {
    fs.mkdirSync(baseFolder, {recursive: true});
  }

  // write config
  await askBeforeWrite(options, path.join(baseFolder, 'config.json'), jsonConfig);
  // write aip
  await askBeforeWrite(options, path.join(baseFolder, `${options.shortName}.md`), aip);
  // write scripts
  await askBeforeWrite(
    options,
    path.join(baseFolder, `${generateContractName(options)}.s.sol`),
    script
  );

  for (const {payload, test, contractName} of payloads) {
    await askBeforeWrite(options, path.join(baseFolder, `${contractName}.sol`), payload);
    await askBeforeWrite(options, path.join(baseFolder, `${contractName}.t.sol`), test);
  }
}
