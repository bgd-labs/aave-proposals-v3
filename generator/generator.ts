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
      poolOptions: Object.keys(poolConfigs).reduce((acc, pool) => {
        acc[pool] = {configs: poolConfigs[pool].configs, features: poolConfigs[pool].features};
        return acc;
      }, {} as PoolConfigs),
    } as ConfigFile,
    null,
    2
  );

  const baseName = generateFolderName(options);
  const baseFolder = path.join(process.cwd(), 'src', baseName);

  if (!options.force && fs.existsSync(baseFolder)) {
    options.force = await confirm({
      message: 'A proposal already exists at that location, do you want to override?',
      default: false,
    });
  }

  async function createPayloadAndTest(options: Options, pool: PoolIdentifier) {
    const contractName = generateContractName(options, pool);
    const testCode = await testTemplate(options, poolConfigs[pool]!);
    return {
      payload: prettier.format(proposalTemplate(options, poolConfigs[pool]!), {
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
    payloads: await Promise.all(options.pools.map((pool) => createPayloadAndTest(options, pool))),
  };
}

/**
 * Writes the files according to defined folder/file format
 * @param options
 * @param param1
 */
export async function writeFiles(options: Options, {jsonConfig, script, aip, payloads}: Files) {
  console.log(options);
  const baseName = generateFolderName(options);
  const baseFolder = path.join(process.cwd(), 'src', baseName);
  if (!options.force && fs.existsSync(baseFolder)) {
    options.force = await confirm({
      message: 'A proposal already exists at that location, do you want to override?',
      default: false,
    });
  }
  if (fs.existsSync(baseFolder) && !options.force) {
    console.log('Creation skipped as folder already exists.');
    console.log('If you want to overwrite, supply --force');
  } else {
    fs.mkdirSync(baseFolder, {recursive: true});
    // write config
    fs.writeFileSync(path.join(baseFolder, 'config.json'), jsonConfig);
    // write aip
    fs.writeFileSync(path.join(baseFolder, `${options.shortName}.md`), aip);
    // write scripts
    fs.writeFileSync(path.join(baseFolder, `${generateContractName(options)}.s.sol`), script);

    payloads.map(({payload, test, contractName}) => {
      fs.writeFileSync(path.join(baseFolder, `${contractName}.sol`), payload);
      fs.writeFileSync(path.join(baseFolder, `${contractName}.t.sol`), test);
    });
  }
}
