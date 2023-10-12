import fs from 'fs';
import path from 'path';
import {Command, Option} from 'commander';
import {generateContractName, generateFolderName, isV2Pool, pascalCase} from './common';
import {proposalTemplate} from './templates/proposal.template';
import {testTemplate} from './templates/test.template';
import {input, checkbox, confirm} from '@inquirer/prompts';
import {
  CodeArtifact,
  ConfigFile,
  FeatureModule,
  Options,
  POOLS,
  PoolConfig,
  PoolConfigs,
  PoolIdentifier,
} from './types';
import {flashBorrower} from './features/flashBorrower';
import {capsUpdates} from './features/capsUpdates';
import {rateUpdates} from './features/rateUpdates';
import prettier from 'prettier';
import {generateScript} from './templates/script.template';
import {generateAIP} from './templates/aip.template';
import {collateralsUpdates} from './features/collateralsUpdates';
import {borrowsUpdates} from './features/borrowsUpdates';
import {eModeUpdates} from './features/eModesUpdates';
import {eModeAssets} from './features/eModesAssets';
import {priceFeedsUpdates} from './features/priceFeedsUpdates';
import {assetListing, assetListingCustom} from './features/assetListing';

const prettierSolCfg = await prettier.resolveConfig('foo.sol');
const prettierMDCfg = await prettier.resolveConfig('foo.md');

const program = new Command();

program
  .name('proposal-generator')
  .description('CLI to generate aave proposals')
  .version('1.0.0')
  .addOption(new Option('-f, --force', 'force creation (might overwrite existing files)'))
  .addOption(new Option('-p, --pools <pools...>').choices(POOLS))
  .addOption(new Option('-t, --title <string>', 'aip title'))
  .addOption(new Option('-a, --author <string>', 'author'))
  .addOption(new Option('-d, --discussion <string>', 'forum link'))
  .addOption(new Option('-s, --snapshot <string>', 'snapshot link'))
  .addOption(new Option('-c, --configFile <string>', 'path to config file'))
  .allowExcessArguments(false)
  .parse(process.argv);

let options = program.opts<Options>();
let poolConfigs: PoolConfigs = {};

let configFileLoaded = false;
if (options.configFile) {
  const cfgFile: ConfigFile = await import(path.join(process.cwd(), options.configFile));
  options = cfgFile.rootOptions;
  poolConfigs = cfgFile.poolOptions as any;
  configFileLoaded = true;
}

// workaround as there's validate is not currently supported on checkbox
// https://github.com/SBoudrias/Inquirer.js/issues/1257
while (!options.pools?.length === true) {
  options.pools = await checkbox({
    message: 'Chains this proposal targets',
    choices: POOLS.map((v) => ({name: v, value: v})),
    // validate(input) {
    //   // currently ignored due to a bug
    //   if (input.length == 0) return 'You must target at least one chain in your proposal!';
    //   return true;
    // },
  });
}

if (!options.title) {
  options.title = await input({
    message: 'Title of your proposal',
    validate(input) {
      if (input.length == 0) return "Your title can't be empty";
      return true;
    },
  });
}
options.shortName = pascalCase(options.title);

if (!options.author) {
  options.author = await input({
    message: 'Author of your proposal',
    validate(input) {
      if (input.length == 0) return "Your author can't be empty";
      return true;
    },
  });
}

if (!options.discussion) {
  options.discussion = await input({
    message: 'Link to forum discussion',
  });
}

if (!options.snapshot) {
  options.snapshot = await input({
    message: 'Link to snapshot',
  });
}
const PLACEHOLDER_MODULE = {
  value: 'Something different not supported by configEngine',
  cli: async (opt, pool) => {
    return {};
  },
  build: (opt, pool, cfg) => {
    const response: CodeArtifact = {
      code: {execute: ['// custom code goes here']},
    };
    return response;
  },
};
const FEATURE_MODULES_V2 = [rateUpdates, PLACEHOLDER_MODULE];
const FEATURE_MODULES_V3 = [
  rateUpdates,
  capsUpdates,
  collateralsUpdates,
  borrowsUpdates,
  flashBorrower,
  priceFeedsUpdates,
  eModeUpdates,
  eModeAssets,
  assetListing,
  assetListingCustom,
  PLACEHOLDER_MODULE,
];

if (!configFileLoaded) {
  for (const pool of options.pools) {
    poolConfigs[pool] = {configs: {}, artifacts: [], features: []} as PoolConfig;
    const v2 = isV2Pool(pool);
    poolConfigs[pool]!.features = await checkbox({
      message: `What do you want to do on ${pool}?`,
      choices: v2 ? FEATURE_MODULES_V2 : FEATURE_MODULES_V3,
    });
    for (const feature of poolConfigs[pool]!.features) {
      const module = v2
        ? FEATURE_MODULES_V2.find((m) => m.value === feature)!
        : FEATURE_MODULES_V3.find((m) => m.value === feature)!;
      poolConfigs[pool]!.configs[feature] = await module.cli(options, pool);
      poolConfigs[pool]!.artifacts.push(
        module.build(options, pool, poolConfigs[pool]!.configs[feature])
      );
    }
  }
} else {
  for (const pool of options.pools) {
    const v2 = isV2Pool(pool);
    poolConfigs[pool]!.artifacts = [];
    for (const feature of poolConfigs[pool]!.features) {
      const module = v2
        ? FEATURE_MODULES_V2.find((m) => m.value === feature)!
        : FEATURE_MODULES_V3.find((m) => m.value === feature)!;
      poolConfigs[pool]!.artifacts.push(
        module.build(options, pool, poolConfigs[pool]!.configs[feature])
      );
    }
  }
}

console.log('### JSON config emitted to be stored for reuse ###');
const logOptions = {
  rootOptions: options,
  poolOptions: Object.keys(poolConfigs).reduce((acc, pool) => {
    acc[pool] = {configs: poolConfigs[pool].configs, features: poolConfigs[pool].features};
    return acc;
  }, {} as PoolConfigs),
} as ConfigFile;
console.log(JSON.stringify(logOptions, null, 2));
console.log('### ###');

const baseName = generateFolderName(options);
const baseFolder = path.join(process.cwd(), 'src', baseName);

if (!options.force && fs.existsSync(baseFolder)) {
  options.force = await confirm({
    message: 'A proposal already exists at that location, do you want to override?',
    default: false,
  });
}
// create files
if (fs.existsSync(baseFolder) && !options.force) {
  console.log('Creation skipped as folder already exists.');
  console.log('If you want to overwrite, supply --force');
} else {
  fs.mkdirSync(baseFolder, {recursive: true});

  async function createFiles(options: Options, pool: PoolIdentifier) {
    const contractName = generateContractName(options, pool);
    fs.writeFileSync(
      path.join(baseFolder, `${contractName}.sol`),
      prettier.format(proposalTemplate(options, pool, poolConfigs[pool]?.artifacts), {
        ...prettierSolCfg,
        filepath: 'foo.sol',
      })
    );
    const testCode = await testTemplate(options, pool, poolConfigs[pool]?.artifacts);
    fs.writeFileSync(
      path.join(baseFolder, `${contractName}.t.sol`),
      prettier.format(testCode, {
        ...prettierSolCfg,
        filepath: 'foo.sol',
      })
    );
  }

  await Promise.all(options.pools.map((pool) => createFiles(options, pool)));

  console.log(generateScript(options));
  fs.writeFileSync(
    path.join(baseFolder, `${generateContractName(options)}.s.sol`),
    prettier.format(generateScript(options), {
      ...prettierSolCfg,
      filepath: 'foo.sol',
    })
  );
  fs.writeFileSync(
    path.join(baseFolder, `${options.shortName}.md`),
    prettier.format(generateAIP(options), {
      ...prettierMDCfg,
      filepath: 'foo.md',
    })
  );
}
