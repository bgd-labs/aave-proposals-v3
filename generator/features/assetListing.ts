import {CodeArtifact, FEATURE, FeatureModule, PoolIdentifier} from '../types';
import {fetchBorrowUpdate} from './borrowsUpdates';
import {fetchRateStrategyParamsV3} from './rateUpdates';
import {fetchCollateralUpdate} from './collateralsUpdates';
import {fetchCapsUpdate} from './capsUpdates';
import {Listing, ListingWithCustomImpl, TokenImplementations} from './types';
import {CHAIN_TO_CHAIN_ID, getPoolChain, getExplorerLink} from '../common';
import {getContract, isAddress} from 'viem';
import {confirm} from '@inquirer/prompts';
import {TEST_EXECUTE_PROPOSAL} from '../utils/constants';
import {addressPrompt, translateJsAddressToSol} from '../prompts/addressPrompt';
import {stringPrompt} from '../prompts/stringPrompt';
import {translateJsBoolToSol} from '../prompts/boolPrompt';
import {transformNumberToPercent, translateJsPercentToSol} from '../prompts/percentPrompt';
import {transformNumberToHumanReadable, translateJsNumberToSol} from '../prompts/numberPrompt';
import {CHAIN_ID_CLIENT_MAP} from '@bgd-labs/js-utils';
import {IERC20Detailed_ABI} from '@bgd-labs/aave-address-book/abis';

async function fetchListing(pool: PoolIdentifier): Promise<Listing> {
  const asset = await addressPrompt({
    message: 'Enter the address of the asset you want to list',
    required: true,
  });

  const chain = getPoolChain(pool);
  const erc20 = getContract({
    abi: IERC20Detailed_ABI,
    client: CHAIN_ID_CLIENT_MAP[CHAIN_TO_CHAIN_ID[chain]],
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
    asset,
    admin: await addressPrompt({message: 'Emission admin address (optional)', required: false}),
  };
}

async function fetchCustomImpl(): Promise<TokenImplementations> {
  return {
    aToken: await addressPrompt({message: 'aToken implementation', required: true}),
    vToken: await addressPrompt({message: 'vToken implementation', required: true}),
    sToken: await addressPrompt({message: 'sToken implementation', required: true}),
  };
}

function generateAssetListingSol(cfg: Listing) {
  return `asset: ${cfg.assetSymbol},
  assetSymbol: "${cfg.assetSymbol}",
  priceFeed: ${translateJsAddressToSol(cfg.priceFeed)},
  enabledToBorrow: ${translateJsBoolToSol(cfg.enabledToBorrow)},
  borrowableInIsolation: ${translateJsBoolToSol(cfg.borrowableInIsolation)},
  withSiloedBorrowing: ${translateJsBoolToSol(cfg.withSiloedBorrowing)},
  flashloanable: ${translateJsBoolToSol(cfg.flashloanable)},
  ltv: ${translateJsPercentToSol(cfg.ltv)},
  liqThreshold: ${translateJsPercentToSol(cfg.liqThreshold)},
  liqBonus: ${translateJsPercentToSol(cfg.liqBonus)},
  reserveFactor: ${translateJsPercentToSol(cfg.reserveFactor)},
  supplyCap: ${translateJsNumberToSol(cfg.supplyCap)},
  borrowCap: ${translateJsNumberToSol(cfg.borrowCap)},
  debtCeiling: ${translateJsNumberToSol(cfg.debtCeiling)},
  liqProtocolFee: ${translateJsPercentToSol(cfg.liqProtocolFee)},
  rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
     optimalUsageRatio: ${translateJsPercentToSol(cfg.rateStrategyParams.optimalUtilizationRate)},
     baseVariableBorrowRate: ${translateJsPercentToSol(
       cfg.rateStrategyParams.baseVariableBorrowRate,
     )},
     variableRateSlope1: ${translateJsPercentToSol(cfg.rateStrategyParams.variableRateSlope1)},
     variableRateSlope2: ${translateJsPercentToSol(cfg.rateStrategyParams.variableRateSlope2)}
  })`;
}

export const assetListing: FeatureModule<Listing[]> = {
  value: FEATURE.ASSET_LISTING,
  description: 'newListings (listing a new asset)',
  async cli({pool}) {
    const response: Listing[] = [];
    console.log(`Fetching information for Assets assets on ${pool}`);
    let more: boolean = true;
    while (more) {
      response.push(await fetchListing(pool));
      more = await confirm({message: 'Do you want to list another asset?', default: false});
    }
    return response;
  },
  build({pool, cfg}) {
    const response: CodeArtifact = {
      code: {
        constants: cfg.map((cfg) => {
          let listingConstant = `address public constant ${cfg.assetSymbol} = ${translateJsAddressToSol(cfg.asset)};\n`;
          listingConstant += `uint256 public constant ${cfg.assetSymbol}_SEED_AMOUNT = 1e${cfg.decimals};\n`;
          if (isAddress(cfg.admin)) {
            listingConstant += `address public constant ${cfg.assetSymbol}_LM_ADMIN = ${translateJsAddressToSol(cfg.admin)};\n`;
          }
          return listingConstant;
        }),
        execute: cfg.map((cfg) => {
          let listingExe = `IERC20(${cfg.assetSymbol}).forceApprove(address(${pool}.POOL), ${cfg.assetSymbol}_SEED_AMOUNT);\n`;
          listingExe += `${pool}.POOL.supply(${cfg.assetSymbol}, ${cfg.assetSymbol}_SEED_AMOUNT, address(${pool}.COLLECTOR), 0);\n`;
          if (isAddress(cfg.admin)) {
            listingExe += `\n(address a${cfg.assetSymbol}, , ) = ${pool}.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(${cfg.assetSymbol});\n`;
            listingExe += `IEmissionManager(${pool}.EMISSION_MANAGER).setEmissionAdmin(${cfg.assetSymbol}, ${cfg.assetSymbol}_ADMIN);\n`;
            listingExe += `IEmissionManager(${pool}.EMISSION_MANAGER).setEmissionAdmin(a${cfg.assetSymbol}, ${cfg.assetSymbol}_ADMIN);\n`;
          }
          return listingExe;
        }),
        fn: [
          `function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
          IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](${
            cfg.length
          });

          ${cfg
            .map(
              (cfg, ix) => `listings[${ix}] = IAaveV3ConfigEngine.Listing({
               ${generateAssetListingSol(cfg)}
             });`,
            )
            .join('\n')}

          return listings;
        }`,
        ],
      },
      test: {
        fn: cfg.map((cfg) => {
          let listingTest = `function test_collectorHas${cfg.assetSymbol}Funds() public {
            ${TEST_EXECUTE_PROPOSAL}
            (address aTokenAddress, , ) = ${pool}.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(proposal.${cfg.assetSymbol}());
            assertGe(IERC20(aTokenAddress).balanceOf(address(${pool}.COLLECTOR)), 10 ** ${cfg.decimals});
          }\n`;
          if (isAddress(cfg.admin)) {
            listingTest += `\nfunction test_${cfg.assetSymbol}Admin() public {
	      ${TEST_EXECUTE_PROPOSAL}
              (address a${cfg.assetSymbol}, , ) = ${pool}.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(proposal.${cfg.assetSymbol}());
	      assertEq(IEmissionManager(${pool}.EMISSION_MANAGER).getEmissionAdmin(proposal.${cfg.assetSymbol}()), proposal.${cfg.assetSymbol}_ADMIN());
	      assertEq(IEmissionManager(${pool}.EMISSION_MANAGER).getEmissionAdmin(a${cfg.assetSymbol}), proposal.${cfg.assetSymbol}_ADMIN());
	    }\n`;
          }
          return listingTest;
        }),
      },
      aip: {
        specification: cfg.map((cfg) => {
          let listingTemplate = `The table below illustrates the configured risk parameters for **${cfg.assetSymbol}**\n\n`;
          listingTemplate += `| Parameter | Value |\n`;
          listingTemplate += `| --- | --: |\n`;
          listingTemplate += `| Isolation Mode | ${cfg.debtCeiling !== '0'} |\n`;
          listingTemplate += `| Borrowable | ${cfg.enabledToBorrow} |\n`;
          listingTemplate += `| Collateral Enabled | ${!!cfg.liqThreshold} |\n`;
          listingTemplate += `| Supply Cap (${cfg.assetSymbol}) | ${transformNumberToHumanReadable(
            cfg.supplyCap,
          )} |\n`;
          listingTemplate += `| Borrow Cap (${cfg.assetSymbol}) | ${transformNumberToHumanReadable(
            cfg.borrowCap,
          )} |\n`;
          listingTemplate += `| Debt Ceiling | USD ${transformNumberToHumanReadable(
            cfg.debtCeiling,
          )} |\n`;
          listingTemplate += `| LTV | ${transformNumberToPercent(cfg.ltv)} |\n`;
          listingTemplate += `| LT | ${transformNumberToPercent(cfg.liqThreshold)} |\n`;
          listingTemplate += `| Liquidation Bonus	| ${transformNumberToPercent(cfg.liqBonus)} |\n`;
          listingTemplate += `| Liquidation Protocol Fee | ${transformNumberToPercent(
            cfg.liqProtocolFee,
          )} |\n`;
          listingTemplate += `| Reserve Factor | ${transformNumberToPercent(
            cfg.reserveFactor,
          )} |\n`;
          listingTemplate += `| Base Variable Borrow Rate	| ${transformNumberToPercent(
            cfg.rateStrategyParams.baseVariableBorrowRate,
          )} |\n`;
          listingTemplate += `| Variable Slope 1 | ${transformNumberToPercent(
            cfg.rateStrategyParams.variableRateSlope1,
          )} |\n`;
          listingTemplate += `| Variable Slope 2 | ${transformNumberToPercent(
            cfg.rateStrategyParams.variableRateSlope2,
          )} |\n`;
          listingTemplate += `| Uoptimal | ${transformNumberToPercent(
            cfg.rateStrategyParams.optimalUtilizationRate,
          )} |\n`;
          listingTemplate += `| Flashloanable	| ${cfg.flashloanable} |\n`;
          listingTemplate += `| Siloed Borrowing	| ${cfg.withSiloedBorrowing} |\n`;
          listingTemplate += `| Borrowable in Isolation | ${cfg.borrowableInIsolation} |\n`;
          listingTemplate += `| Oracle | ${cfg.priceFeed} |\n`;
          if (isAddress(cfg.admin)) {
            listingTemplate += `\nAdditionaly [${cfg.admin}](${getExplorerLink(CHAIN_TO_CHAIN_ID[getPoolChain(pool)], cfg.admin)}) has been set as the emission admin for ${cfg.assetSymbol} and the corresponding aToken.\n`;
          }
          return listingTemplate;
        }),
      },
    };
    return response;
  },
};

export const assetListingCustom: FeatureModule<ListingWithCustomImpl[]> = {
  value: FEATURE.ASSET_LISTING_CUSTOM,
  description: 'newListingsCustom (listing a new asset, with custom implementations)',
  async cli({pool}) {
    const response: ListingWithCustomImpl[] = [];
    let more: boolean = true;
    while (more) {
      response.push({base: await fetchListing(pool), implementations: await fetchCustomImpl()});
      more = await confirm({message: 'Do you want to list another asset?', default: false});
    }
    return response;
  },
  build({pool, cfg}) {
    const response: CodeArtifact = {
      code: {
        constants: cfg.map(
          (cfg) =>
            `address public constant ${cfg.base.assetSymbol} = ${translateJsAddressToSol(
              cfg.base.asset,
            )};`,
        ),
        execute: cfg.map(
          (cfg) =>
            `IERC20(${cfg.base.assetSymbol}).forceApprove(address(${pool}.POOL), 10 ** ${cfg.base.decimals});
            ${pool}.POOL.supply(${cfg.base.assetSymbol}, 10 ** ${cfg.base.decimals}, ${pool}.COLLECTOR, 0);`,
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
                  ${generateAssetListingSol(cfg.base)},
                  IAaveV3ConfigEngine.TokenImplementations({
                    aToken: ${translateJsAddressToSol(cfg.implementations.aToken)},
                    vToken: ${translateJsAddressToSol(cfg.implementations.vToken)},
                    sToken: ${translateJsAddressToSol(cfg.implementations.sToken)}
                  })
                })
             );`,
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
          }`,
        ),
      },
    };
    return response;
  },
};
