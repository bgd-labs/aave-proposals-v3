import 'dotenv/config';
import path from 'path';
import {Command, Option} from 'commander';
import {CHAIN_TO_CHAIN_ID, getDate, getPoolChain, isV2Pool, pascalCase} from './common';
import {input, checkbox, select} from '@inquirer/prompts';
import {
  CodeArtifact,
  ConfigFile,
  FEATURE,
  FeatureModule,
  Options,
  POOLS,
  PoolCache,
  PoolConfigs,
  PoolIdentifier,
  VOTING_NETWORK,
} from './types';
import {flashBorrower} from './features/flashBorrower';
import {capsUpdates} from './features/capsUpdates';
import {rateUpdatesV2, rateUpdatesV3} from './features/rateUpdates';
import {collateralsUpdates} from './features/collateralsUpdates';
import {borrowsUpdates} from './features/borrowsUpdates';
import {eModeUpdates} from './features/eModesUpdates';
import {eModeCreations} from './features/eModesCreation';
import {eModeAssets} from './features/eModesAssets';
import {priceFeedsUpdates} from './features/priceFeedsUpdates';
import {freezeUpdates} from './features/freeze';
import {emissionUpdates} from './features/emission';
import {assetListing, assetListingCustom} from './features/assetListing';
import {generateFiles, writeFiles} from './generator';
import {getClient} from '@bgd-labs/toolbox';
import {getBlockNumber} from 'viem/actions';

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
  .addOption(
    new Option(
      '-v, --votingNetwork <votingNetwork...>',
      'network where voting should take place for the proposal',
    ).choices(Object.values(VOTING_NETWORK)),
  )
  .addOption(new Option('-c, --configFile <string>', 'path to config file'))
  .addOption(new Option('-u, --update', 'when used with -c update block height'))
  .allowExcessArguments(false)
  .parse(process.argv);

let options = program.opts<Options>();
let poolConfigs: PoolConfigs = {};

const PLACEHOLDER_MODULE: FeatureModule<{}> = {
  description: 'Something different not supported by configEngine',
  value: FEATURE.OTHERS,
  cli: async ({}) => {
    return {};
  },
  build: ({}) => {
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
  eModeCreations,
  eModeUpdates,
  eModeAssets,
  assetListing,
  assetListingCustom,
  freezeUpdates,
  emissionUpdates,
  PLACEHOLDER_MODULE,
];

async function generateDeterministicPoolCache(pool: PoolIdentifier): Promise<PoolCache> {
  const chain = getPoolChain(pool);
  const client = getClient(CHAIN_TO_CHAIN_ID[chain], {
    providerConfig: {alchemyKey: process.env.ALCHEMY_API_KEY},
  });
  return {blockNumber: Number(await getBlockNumber(client))};
}

async function fetchPoolOptions(pool: PoolIdentifier) {
  poolConfigs[pool] = {
    configs: {},
    artifacts: [],
    cache: await generateDeterministicPoolCache(pool),
  };

  const v2 = isV2Pool(pool);
  const features = await checkbox({
    message: `What do you want to do on ${pool}?`,
    choices: v2
      ? FEATURE_MODULES_V2.map((m) => ({value: m.value, name: m.description}))
      : FEATURE_MODULES_V3.map((m) => ({value: m.value, name: m.description})),
  });
  for (const feature of features) {
    const module = v2
      ? FEATURE_MODULES_V2.find((m) => m.value === feature)!
      : FEATURE_MODULES_V3.find((m) => m.value === feature)!;
    poolConfigs[pool]!.configs[feature] = await module.cli({
      options,
      pool,
      cache: poolConfigs[pool]!.cache,
    });
    poolConfigs[pool]!.artifacts.push(
      module.build({
        options,
        pool,
        cfg: poolConfigs[pool]!.configs[feature],
        cache: poolConfigs[pool]!.cache,
      }),
    );
  }
}

if (options.configFile) {
  const {config: cfgFile}: {config: ConfigFile} = await import(
    path.join(process.cwd(), options.configFile)
  );
  options = {...options, ...cfgFile.rootOptions};
  poolConfigs = cfgFile.poolOptions as any;
  for (const pool of options.pools) {
    const v2 = isV2Pool(pool);
    if (poolConfigs[pool]) {
      poolConfigs[pool]!.artifacts = [];
      for (const feature of Object.keys(poolConfigs[pool]!.configs)) {
        const module = v2
          ? FEATURE_MODULES_V2.find((m) => m.value === feature)!
          : FEATURE_MODULES_V3.find((m) => m.value === feature)!;
        if (options.update) {
          poolConfigs[pool]!.cache = await generateDeterministicPoolCache(pool);
        }
        poolConfigs[pool]!.artifacts.push(
          module.build({
            options,
            pool,
            cfg: poolConfigs[pool]!.configs[feature],
            cache: poolConfigs[pool]!.cache,
          }),
        );
      }
    } else {
      await fetchPoolOptions(pool);
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
      message:
        'Short title of your proposal that will be used as contract name(please refrain from including author or date)',
      validate(input) {
        if (input.length == 0) return "Your title can't be empty";
        // this is no exact math
        // fully qualified identifiers are not allowed to be longer then 300 chars on etherscan api
        // the path is roughly src(3)/date(8)_title/title_date(8):title_date(8), so 3 + 3*8 + 3 title.length
        // so 80 sounds like a reasonable upper bound to stay below 300 character limit
        if (input.trim().length > 80) return 'Your title is to long';
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

  if (!options.votingNetwork) {
    options.votingNetwork = await select({
      message: 'Select network where voting should takes place for the proposal',
      choices: Object.values(VOTING_NETWORK).map((v) => ({
        name: v != VOTING_NETWORK.POLYGON ? v : VOTING_NETWORK.POLYGON + ' (DEFAULT)',
        value: v,
      })),
      default: VOTING_NETWORK.POLYGON,
    });
  }

  for (const pool of options.pools) {
    await fetchPoolOptions(pool);
  }
}

try {
  const files = await generateFiles(options, poolConfigs);
  await writeFiles(options, files);
} catch (e) {
  console.log(JSON.stringify({options, poolConfigs}, null, 2));
  throw e;
}
