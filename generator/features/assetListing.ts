import {CodeArtifact, FeatureModule, PoolIdentifier} from '../types';
import {addressInput, stringInput} from '../prompts';
import {fetchBorrowUpdate} from './borrowsUpdates';
import {fetchRateStrategyParams} from './rateUpdates';
import {fetchCollateralUpdate} from './collateralsUpdates';
import {fetchCapsUpdate} from './capsUpdates';
import {Listing, ListingWithCustomImpl, TokenImplementations} from './types';
import {CHAIN_TO_CHAIN_OBJECT, getPoolChain} from '../common';
import {PublicClient, getContract} from 'viem';
import {confirm} from '@inquirer/prompts';

async function fetchListing(pool: PoolIdentifier): Promise<Listing> {
  const asset = await addressInput({
    message: 'enter the asset you want to list',
    disableKeepCurrent: true,
  });

  const chain = getPoolChain(pool);
  const erc20 = getContract({
    abi: [
      {
        constant: true,
        inputs: [],
        name: 'symbol',
        outputs: [{internalType: 'string', name: '', type: 'string'}],
        payable: false,
        stateMutability: 'view',
        type: 'function',
      },
    ],
    publicClient: CHAIN_TO_CHAIN_OBJECT[chain] as PublicClient,
    address: asset,
  });
  let symbol = '';
  try {
    symbol = await erc20.read.symbol();
  } catch (e) {
    console.log('could not fetch the symbol - this is likely an error');
  }

  return {
    assetSymbol: await stringInput({
      message: 'Enter the asset symbol',
      disableKeepCurrent: true,
      defaultValue: symbol,
    }),
    priceFeed: await addressInput({message: 'PriceFeed address', disableKeepCurrent: true}),
    ...(await fetchCollateralUpdate(pool, true)),
    ...(await fetchBorrowUpdate(true)),
    ...(await fetchCapsUpdate(true)),
    rateStrategyParams: await fetchRateStrategyParams(pool, true),
    asset,
  };
}

async function fetchCustomImpl(): Promise<TokenImplementations> {
  return {
    aToken: await addressInput({message: 'aToken implementation', disableKeepCurrent: true}),
    vToken: await addressInput({message: 'vToken implementation', disableKeepCurrent: true}),
    sToken: await addressInput({message: 'sToken implementation', disableKeepCurrent: true}),
  };
}

export const assetListing: FeatureModule<Listing[]> = {
  value: 'newListings (listing a new asset)',
  async cli(opt, pool) {
    const response: Listing[] = [];
    console.log(`Fetching information for Assets assets on ${pool}`);
    let more: boolean = true;
    while (more) {
      response.push(await fetchListing(pool));
      more = await confirm({message: 'Do you want to list another asset?', default: false});
    }
    return response;
  },
  build(opt, pool, cfg) {
    const response: CodeArtifact = {
      code: {
        constants: cfg.map(
          (cfg) => `address public constant ${cfg.assetSymbol} = address(${cfg.asset});`
        ),
        fn: [
          `function newListings() public pure override returns (IEngine.Listing[] memory) {
          IEngine.Listing[] memory listings = new IEngine.Listing[](${cfg.length});

          ${cfg
            .map(
              (cfg, ix) => `listings[${ix}] = IEngine.Listing({
               asset: ${cfg.assetSymbol},
               assetSymbol: "${cfg.assetSymbol}",
               priceFeed: ${cfg.priceFeed},
               eModeCategory: ${cfg.eModeCategory},
               enabledToBorrow: ${cfg.enabledToBorrow},
               stableRateModeEnabled: ${cfg.stableRateModeEnabled},
               borrowableInIsolation: ${cfg.borrowableInIsolation},
               withSiloedBorrowing: ${cfg.withSiloedBorrowing},
               flashloanable: ${cfg.flashloanable},
               ltv: ${cfg.ltv}
               liqThreshold: ${cfg.liqThreshold},
               liqBonus: ${cfg.liqBonus},
               reserveFactor: ${cfg.reserveFactor},
               supplyCap: ${cfg.supplyCap},
               borrowCap: ${cfg.borrowCap},
               debtCeiling: ${cfg.debtCeiling},
               liqProtocolFee: ${cfg.liqProtocolFee},
               rateStrategyParams: Rates.RateStrategyParams({
                  optimalUsageRatio: ${cfg.rateStrategyParams.optimalUtilizationRate},
                  baseVariableBorrowRate: ${cfg.rateStrategyParams.baseVariableBorrowRate},
                  variableRateSlope1: ${cfg.rateStrategyParams.variableRateSlope1},
                  variableRateSlope2: ${cfg.rateStrategyParams.variableRateSlope2},
                  stableRateSlope1: ${cfg.rateStrategyParams.stableRateSlope1},
                  stableRateSlope2: ${cfg.rateStrategyParams.stableRateSlope2},
                  baseStableRateOffset: ${cfg.rateStrategyParams.baseStableRateOffset},
                  stableRateExcessOffset: ${cfg.rateStrategyParams.stableRateExcessOffset},
                  optimalStableToTotalDebtRatio: ${cfg.rateStrategyParams.optimalStableToTotalDebtRatio}
              })
             });`
            )
            .join('\n')}

          return listings;
        }`,
        ],
      },
    };
    return response;
  },
};

export const assetListingCustom: FeatureModule<ListingWithCustomImpl[]> = {
  value: 'newListingsCustom (listing a new asset, with custom imeplementations)',
  async cli(opt, pool) {
    const response: ListingWithCustomImpl[] = [];
    let more: boolean = true;
    while (more) {
      response.push({base: await fetchListing(pool), implementations: await fetchCustomImpl()});
      more = await confirm({message: 'Do you want to list another asset?', default: false});
    }
    return response;
  },
  build(opt, pool, cfg) {
    const response: CodeArtifact = {
      code: {
        constants: cfg.map(
          (cfg) => `address public constant ${cfg.base.assetSymbol} = address(${cfg.base.asset});`
        ),
        fn: [
          `function newListingsCustom() public pure override returns (IEngine.ListingWithCustomImpl[] memory) {
          IEngine.ListingWithCustomImpl[] memory listings = new IEngine.ListingWithCustomImpl[](${
            cfg.length
          });

          ${cfg
            .map(
              (cfg, ix) => `listings[${ix}] = IEngine.ListingWithCustomImpl(
                IEngine.Listing({
              asset: ${cfg.base.assetSymbol},
              assetSymbol: "${cfg.base.assetSymbol}",
               priceFeed: ${cfg.base.priceFeed},
               eModeCategory: ${cfg.base.eModeCategory},
               enabledToBorrow: ${cfg.base.enabledToBorrow},
               stableRateModeEnabled: ${cfg.base.stableRateModeEnabled},
               borrowableInIsolation: ${cfg.base.borrowableInIsolation},
               withSiloedBorrowing: ${cfg.base.withSiloedBorrowing},
               flashloanable: ${cfg.base.flashloanable},
               ltv: ${cfg.base.ltv}
               liqThreshold: ${cfg.base.liqThreshold},
               liqBonus: ${cfg.base.liqBonus},
               reserveFactor: ${cfg.base.reserveFactor},
               supplyCap: ${cfg.base.supplyCap},
               borrowCap: ${cfg.base.borrowCap},
               debtCeiling: ${cfg.base.debtCeiling},
               liqProtocolFee: ${cfg.base.liqProtocolFee},
               rateStrategyParams: Rates.RateStrategyParams({
                  optimalUsageRatio: ${cfg.base.rateStrategyParams.optimalUtilizationRate},
                  baseVariableBorrowRate: ${cfg.base.rateStrategyParams.baseVariableBorrowRate},
                  variableRateSlope1: ${cfg.base.rateStrategyParams.variableRateSlope1},
                  variableRateSlope2: ${cfg.base.rateStrategyParams.variableRateSlope2},
                  stableRateSlope1: ${cfg.base.rateStrategyParams.stableRateSlope1},
                  stableRateSlope2: ${cfg.base.rateStrategyParams.stableRateSlope2},
                  baseStableRateOffset: ${cfg.base.rateStrategyParams.baseStableRateOffset},
                  stableRateExcessOffset: ${cfg.base.rateStrategyParams.stableRateExcessOffset},
                  optimalStableToTotalDebtRatio: ${cfg.base.rateStrategyParams.optimalStableToTotalDebtRatio}
              })
             }),
             IEngine.TokenImplementations({
              aToken: ${cfg.implementations.aToken},
              vToken: ${cfg.implementations.vToken},
              sToken: ${cfg.implementations.sToken}
            })
             );`
            )
            .join('\n')}

          return listings;
        }`,
        ],
      },
    };
    return response;
  },
};
