import {CodeArtifact, FEATURE, FeatureModule, PoolIdentifier} from '../types';
import {eModeSelect} from '../prompts';
import {fetchBorrowUpdate} from './borrowsUpdates';
import {fetchRateStrategyParamsV3} from './rateUpdates';
import {fetchCollateralUpdate} from './collateralsUpdates';
import {fetchCapsUpdate} from './capsUpdates';
import {Listing, ListingWithCustomImpl, TokenImplementations} from './types';
import {CHAIN_TO_CHAIN_OBJECT, getPoolChain} from '../common';
import {createPublicClient, getContract, http} from 'viem';
import {confirm} from '@inquirer/prompts';
import {TEST_EXECUTE_PROPOSAL} from '../utils/constants';
import {addressPrompt, translateJsAddressToSol} from '../prompts/addressPrompt';
import {stringPrompt} from '../prompts/stringPrompt';

async function fetchListing(pool: PoolIdentifier): Promise<Listing> {
  const asset = await addressPrompt({
    message: 'Enter the address of the asset you want to list',
    required: true,
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
      {
        constant: true,
        inputs: [],
        name: 'decimals',
        outputs: [
          {
            name: '',
            type: 'uint8',
          },
        ],
        payable: false,
        stateMutability: 'view',
        type: 'function',
      },
    ],
    publicClient: createPublicClient({chain: CHAIN_TO_CHAIN_OBJECT[chain], transport: http()}),
    address: asset,
  });
  let symbol = '';
  try {
    symbol = await erc20.read.symbol();
  } catch (e) {
    console.log('could not fetch the symbol - this is likely an error');
    console.log(e);
  }
  const decimals = await erc20.read.decimals();

  return {
    assetSymbol: await stringPrompt({
      message: 'Enter the asset symbol',
      required: true,
      defaultValue: symbol,
    }),
    decimals,
    priceFeed: await addressPrompt({message: 'PriceFeed address', required: true}),
    ...(await fetchCollateralUpdate(pool, true)),
    ...(await fetchBorrowUpdate(true)),
    ...(await fetchCapsUpdate(true)),
    rateStrategyParams: await fetchRateStrategyParamsV3(true),
    eModeCategory: await eModeSelect({
      message: `Select the eMode you want to assign to ${asset}`,
      disableKeepCurrent: true,
      pool,
    }),
    asset,
  };
}

async function fetchCustomImpl(): Promise<TokenImplementations> {
  return {
    aToken: await addressPrompt({message: 'aToken implementation', required: true}),
    vToken: await addressPrompt({message: 'vToken implementation', required: true}),
    sToken: await addressPrompt({message: 'sToken implementation', required: true}),
  };
}

export const assetListing: FeatureModule<Listing[]> = {
  value: FEATURE.ASSET_LISTING,
  description: 'newListings (listing a new asset)',
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
        constants: cfg
          .map((cfg) => [
            `address public constant ${cfg.assetSymbol} = ${translateJsAddressToSol(cfg.asset)};`,
            `uint256 internal constant ${cfg.assetSymbol}_SEED_AMOUNT = 10 ** ${cfg.decimals};`,
          ])
          .flat(),
        execute: cfg.map(
          (cfg) =>
            `IERC20(${cfg.assetSymbol}).forceApprove(address(${pool}.POOL), ${cfg.assetSymbol}_SEED_AMOUNT);
            ${pool}.POOL.supply(${cfg.assetSymbol}, ${cfg.assetSymbol}_SEED_AMOUNT, address(${pool}.COLLECTOR), 0);`
        ),
        fn: [
          `function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
          IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](${
            cfg.length
          });

          ${cfg
            .map(
              (cfg, ix) => `listings[${ix}] = IAaveV3ConfigEngine.Listing({
               asset: ${cfg.assetSymbol},
               assetSymbol: "${cfg.assetSymbol}",
               priceFeed: ${translateJsAddressToSol(cfg.priceFeed)},
               eModeCategory: ${cfg.eModeCategory},
               enabledToBorrow: ${cfg.enabledToBorrow},
               stableRateModeEnabled: ${cfg.stableRateModeEnabled},
               borrowableInIsolation: ${cfg.borrowableInIsolation},
               withSiloedBorrowing: ${cfg.withSiloedBorrowing},
               flashloanable: ${cfg.flashloanable},
               ltv: ${cfg.ltv},
               liqThreshold: ${cfg.liqThreshold},
               liqBonus: ${cfg.liqBonus},
               reserveFactor: ${cfg.reserveFactor},
               supplyCap: ${cfg.supplyCap},
               borrowCap: ${cfg.borrowCap},
               debtCeiling: ${cfg.debtCeiling},
               liqProtocolFee: ${cfg.liqProtocolFee},
               rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
                  optimalUsageRatio: ${cfg.rateStrategyParams.optimalUtilizationRate},
                  baseVariableBorrowRate: ${cfg.rateStrategyParams.baseVariableBorrowRate},
                  variableRateSlope1: ${cfg.rateStrategyParams.variableRateSlope1},
                  variableRateSlope2: ${cfg.rateStrategyParams.variableRateSlope2},
                  stableRateSlope1: ${cfg.rateStrategyParams.stableRateSlope1},
                  stableRateSlope2: ${cfg.rateStrategyParams.stableRateSlope2},
                  baseStableRateOffset: ${cfg.rateStrategyParams.baseStableRateOffset},
                  stableRateExcessOffset: ${cfg.rateStrategyParams.stableRateExcessOffset},
                  optimalStableToTotalDebtRatio: ${
                    cfg.rateStrategyParams.optimalStableToTotalDebtRatio
                  }
              })
             });`
            )
            .join('\n')}

          return listings;
        }`,
        ],
      },
      test: {
        fn: cfg.map(
          (cfg) => `function test_collectorHas${cfg.assetSymbol}Funds() public {
            ${TEST_EXECUTE_PROPOSAL}
            (address aTokenAddress, , ) = ${pool}.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(proposal.${cfg.assetSymbol}());
            assertGe(IERC20(aTokenAddress).balanceOf(address(${pool}.COLLECTOR)), 10 ** ${cfg.decimals});
          }`
        ),
      },
      // aip: {
      //   specification: cfg.map((cfg) => {
      //     let listingTemplate = `The table below illustrates the configured risk parameters for **${cfg.assetSymbol}**\n\n`;
      //     listingTemplate += `| Parameter | Value |\n`;
      //     listingTemplate += `| --- | --: |\n`;
      //     listingTemplate += `| Isolation Mode | ${!!cfg.debtCeiling} |\n`;
      //     listingTemplate += `| Borrowable | ${cfg.enabledToBorrow} |\n`;
      //     listingTemplate += `| Collateral Enabled | ${!!cfg.liqThreshold} |\n`;
      //     listingTemplate += `| Supply Cap (${cfg.assetSymbol}) | ${cfg.supplyCap} |\n`;
      //     listingTemplate += `| Borrow Cap (${cfg.assetSymbol}) | ${cfg.borrowCap} |\n`;
      //     listingTemplate += `| Debt Ceiling | ${cfg.debtCeiling} |\n`;
      //     listingTemplate += `| LTV | ${cfg.ltv} |\n`;
      //     listingTemplate += `| LT | ${cfg.liqThreshold} |\n`;
      //     listingTemplate += `| Liquidation Bonus	| ${cfg.liqBonus} |\n`;
      //     listingTemplate += `| Liquidation Protocol Fee | ${cfg.liqProtocolFee} |\n`;
      //     listingTemplate += `| Reserve Factor | ${cfg.reserveFactor} |\n`;
      //     listingTemplate += `| Base Variable Borrow Rate	| ${cfg.rateStrategyParams.baseVariableBorrowRate} |\n`;
      //     listingTemplate += `| Variable Slope 1 | ${cfg.rateStrategyParams.variableRateSlope1} |\n`;
      //     listingTemplate += `| Variable Slope 2 | ${cfg.rateStrategyParams.variableRateSlope2} |\n`;
      //     listingTemplate += `| Uoptimal | ${cfg.rateStrategyParams.optimalUtilizationRate} |\n`;
      //     listingTemplate += `| Stable Borrowing | ${cfg.stableRateModeEnabled} |\n`;
      //     listingTemplate += `| Stable Slope1	| ${cfg.rateStrategyParams.stableRateSlope1} |\n`;
      //     listingTemplate += `| Stable Slope2	| ${cfg.rateStrategyParams.stableRateSlope2} |\n`;
      //     listingTemplate += `| Base Stable Rate Offset | ${cfg.rateStrategyParams.baseStableRateOffset} |\n`;
      //     listingTemplate += `| Stable Rate Excess Offset	| ${cfg.rateStrategyParams.stableRateExcessOffset} |\n`;
      //     listingTemplate += `| Optimal Stable To Total Debt Ratio | ${cfg.rateStrategyParams.optimalStableToTotalDebtRatio} |\n`;
      //     listingTemplate += `| Flahloanable	| ${cfg.flashloanable} |\n`;
      //     listingTemplate += `| Siloed Borrowing	| ${cfg.withSiloedBorrowing} |\n`;
      //     listingTemplate += `| Borrowable in Isolation | ${cfg.borrowableInIsolation} |\n`;
      //     listingTemplate += `| Oracle | ${cfg.priceFeed} |\n`;
      //     return listingTemplate;
      //   }),
      // },
    };
    return response;
  },
};

export const assetListingCustom: FeatureModule<ListingWithCustomImpl[]> = {
  value: FEATURE.ASSET_LISTING_CUSTOM,
  description: 'newListingsCustom (listing a new asset, with custom implementations)',
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
          (cfg) =>
            `address public constant ${cfg.base.assetSymbol} = ${translateJsAddressToSol(
              cfg.base.asset
            )};`
        ),
        execute: cfg.map(
          (cfg) =>
            `IERC20(${cfg.base.assetSymbol}).forceApprove(address(${pool}.POOL), 10 ** ${cfg.base.decimals});
            ${pool}.POOL.supply(${cfg.base.assetSymbol}, 10 ** ${cfg.base.decimals}, ${pool}.COLLECTOR, 0);`
        ),
        fn: [
          `function newListingsCustom() public pure override returns (IAaveV3ConfigEngine.ListingWithCustomImpl[] memory) {
          IAaveV3ConfigEngine.ListingWithCustomImpl[] memory listings = new IAaveV3ConfigEngine.ListingWithCustomImpl[](${
            cfg.length
          });

          ${cfg
            .map(
              (cfg, ix) => `listings[${ix}] = IAaveV3ConfigEngine.ListingWithCustomImpl(
                IAaveV3ConfigEngine.Listing({
               asset: ${cfg.base.assetSymbol},
               assetSymbol: "${cfg.base.assetSymbol}",
               priceFeed: ${translateJsAddressToSol(cfg.base.priceFeed)},
               eModeCategory: ${cfg.base.eModeCategory},
               enabledToBorrow: ${cfg.base.enabledToBorrow},
               stableRateModeEnabled: ${cfg.base.stableRateModeEnabled},
               borrowableInIsolation: ${cfg.base.borrowableInIsolation},
               withSiloedBorrowing: ${cfg.base.withSiloedBorrowing},
               flashloanable: ${cfg.base.flashloanable},
               ltv: ${cfg.base.ltv},
               liqThreshold: ${cfg.base.liqThreshold},
               liqBonus: ${cfg.base.liqBonus},
               reserveFactor: ${cfg.base.reserveFactor},
               supplyCap: ${cfg.base.supplyCap},
               borrowCap: ${cfg.base.borrowCap},
               debtCeiling: ${cfg.base.debtCeiling},
               liqProtocolFee: ${cfg.base.liqProtocolFee},
               rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
                  optimalUsageRatio: ${cfg.base.rateStrategyParams.optimalUtilizationRate},
                  baseVariableBorrowRate: ${cfg.base.rateStrategyParams.baseVariableBorrowRate},
                  variableRateSlope1: ${cfg.base.rateStrategyParams.variableRateSlope1},
                  variableRateSlope2: ${cfg.base.rateStrategyParams.variableRateSlope2},
                  stableRateSlope1: ${cfg.base.rateStrategyParams.stableRateSlope1},
                  stableRateSlope2: ${cfg.base.rateStrategyParams.stableRateSlope2},
                  baseStableRateOffset: ${cfg.base.rateStrategyParams.baseStableRateOffset},
                  stableRateExcessOffset: ${cfg.base.rateStrategyParams.stableRateExcessOffset},
                  optimalStableToTotalDebtRatio: ${
                    cfg.base.rateStrategyParams.optimalStableToTotalDebtRatio
                  }
              })
             }),
             IAaveV3ConfigEngine.TokenImplementations({
              aToken: ${translateJsAddressToSol(cfg.implementations.aToken)},
              vToken: ${translateJsAddressToSol(cfg.implementations.vToken)},
              sToken: ${translateJsAddressToSol(cfg.implementations.sToken)}
            })
             );`
            )
            .join('\n')}

          return listings;
        }`,
        ],
      },
      test: {
        fn: cfg.map(
          (cfg) => `function test_collectorHas${cfg.base.assetSymbol}Funds() public {
            ${TEST_EXECUTE_PROPOSAL}
            (address aTokenAddress, , ) = ${pool}.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(proposal.${cfg.base.assetSymbol}());
            assertGte(IERC20(aTokenAddress).balanceOf(${pool}.COLLECTOR), 10 ** ${cfg.base.decimals});
          }`
        ),
      },
    };
    return response;
  },
};
