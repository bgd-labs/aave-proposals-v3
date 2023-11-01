import path from 'path';
import {Command, Option} from 'commander';
import {getDate, isV2Pool, pascalCase} from './common';
import {input, checkbox} from '@inquirer/prompts';
import {
  CodeArtifact,
  ConfigFile,
  FEATURE,
  FeatureModule,
  Options,
  POOLS,
  PoolConfig,
  PoolConfigs,
} from './types';
import {flashBorrower} from './features/flashBorrower';
import {capsUpdates} from './features/capsUpdates';
import {rateUpdatesV2, rateUpdatesV3} from './features/rateUpdates';
import {collateralsUpdates} from './features/collateralsUpdates';
import {borrowsUpdates} from './features/borrowsUpdates';
import {eModeUpdates} from './features/eModesUpdates';
import {eModeAssets} from './features/eModesAssets';
import {priceFeedsUpdates} from './features/priceFeedsUpdates';
import {assetListing, assetListingCustom} from './features/assetListing';
import {generateFiles, writeFiles} from './generator';

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

const PLACEHOLDER_MODULE: FeatureModule = {
  description: 'Something different not supported by configEngine',
  value: FEATURE.OTHERS,
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
const FEATURE_MODULES_V2 = [rateUpdatesV2, PLACEHOLDER_MODULE];
const FEATURE_MODULES_V3 = [
  rateUpdatesV3,
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

if (options.configFile) {
  const cfgFile: ConfigFile = await import(path.join(process.cwd(), options.configFile));
  options = cfgFile.rootOptions;
  poolConfigs = cfgFile.poolOptions as any;
  for (const pool of options.pools) {
    const v2 = isV2Pool(pool);
    poolConfigs[pool]!.artifacts = [];
    for (const feature of poolConfigs[pool]!.features) {
      const module = v2
        ? FEATURE_MODULES_V2.find((m) => m.value === feature)!
        : FEATURE_MODULES_V3.find((m) => m.value === feature)!;
      poolConfigs[pool]!.pool = pool;
      poolConfigs[pool]!.artifacts.push(
        module.build(options, pool, poolConfigs[pool]!.configs[feature])
      );
    }
  }
} else {
  options.pools = await checkbox({
    message: 'Chains this proposal targets',
    choices: POOLS.map((v) => ({name: v, value: v})),
    required: true,
    // validate(input) {
    //   // currently ignored due to a bug
    //   if (input.length == 0) return 'You must target at least one chain in your proposal!';
    //   return true;
    // },
  });

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
  options.date = getDate();

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

  for (const pool of options.pools) {
    poolConfigs[pool] = {configs: {}, artifacts: [], features: [], pool} as PoolConfig;
    const v2 = isV2Pool(pool);
    poolConfigs[pool]!.features = await checkbox({
      message: `What do you want to do on ${pool}?`,
      choices: v2
        ? FEATURE_MODULES_V2.map((m) => ({value: m.value, name: m.description}))
        : FEATURE_MODULES_V3.map((m) => ({value: m.value, name: m.description})),
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
}

try {
  const files = await generateFiles(options, poolConfigs);
  await writeFiles(options, files);
} catch (e) {
  console.log(JSON.stringify({options, poolConfigs}, null, 2));
  throw e;
}
