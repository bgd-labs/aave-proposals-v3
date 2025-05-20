// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {SafeCast} from 'openzeppelin-contracts/contracts/utils/math/SafeCast.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';

/**
 * @title Onboard USDe July expiry PT tokens and eUSDe August expiry PT tokens on V3 Core
 * @author Aave-Chan Initiative
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-onboard-usde-july-expiry-pt-tokens-on-aave-v3-core-instance/22041
 */
contract AaveV3Ethereum_OnboardUSDeJulyExpiryPTTokensAndEUSDeAugustExpiryPTTokensOnV3Core_20250520 is
  AaveV3PayloadEthereum
{
  using CollectorUtils for ICollector;
  using SafeCast for uint256;
  using SafeERC20 for IERC20;

  address public constant PT_USDe_31JUL2025 = 0x917459337CaAC939D41d7493B3999f571D20D667;
  uint256 public constant PT_USDe_31JUL2025_SEED_AMOUNT = 100e18;
  address public constant PT_USDe_31JUL2025_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  address public constant PT_eUSDe_14AUG2025 = 0x14Bdc3A3AE09f5518b923b69489CBcAfB238e617;
  uint256 public constant PT_eUSDe_14AUG2025_SEED_AMOUNT = 100e18;
  address public constant PT_eUSDe_14AUG2025_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;
  function execute() internal override {
    // we whitelist eModeId 10 to 13 on the injector
    address[] memory marketsToWhitelist = new address[](4);
    marketsToWhitelist[0] = address(uint160(10)); // on the injector we encode eModeId to address
    marketsToWhitelist[1] = address(uint160(11)); // on the injector we encode eModeId to address
    marketsToWhitelist[2] = address(uint160(12)); // on the injector we encode eModeId to address
    marketsToWhitelist[3] = address(uint160(13)); // on the injector we encode eModeId to address
    IAaveStewardInjector(AAVE_STEWARD_INJECTOR).addMarkets(marketsToWhitelist);
  }

  function _postExecute() internal override {
    // we supply the seed amount of PT-USDe-31JUL2025
    IERC20(PT_USDe_31JUL2025).forceApprove(
      address(AaveV3Ethereum.POOL),
      PT_USDe_31JUL2025_SEED_AMOUNT
    );
    AaveV3Ethereum.POOL.supply(
      PT_USDe_31JUL2025,
      PT_USDe_31JUL2025_SEED_AMOUNT,
      AaveV3Ethereum.DUST_BIN,
      0
    );

    // we set ACI as emission admin
    address aPT_USDe_31JUL2025 = AaveV3Ethereum.POOL.getReserveAToken(PT_USDe_31JUL2025);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(
      PT_USDe_31JUL2025,
      PT_USDe_31JUL2025_LM_ADMIN
    );
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(
      aPT_USDe_31JUL2025,
      PT_USDe_31JUL2025_LM_ADMIN
    );

    // we supply the seed amount of PT-eUSDe-14AUG2025
    IERC20(PT_eUSDe_14AUG2025).forceApprove(
      address(AaveV3Ethereum.POOL),
      PT_eUSDe_14AUG2025_SEED_AMOUNT
    );
    AaveV3Ethereum.POOL.supply(
      PT_eUSDe_14AUG2025,
      PT_eUSDe_14AUG2025_SEED_AMOUNT,
      AaveV3Ethereum.DUST_BIN,
      0
    );

    // we set ACI as emission admin
    address aPT_eUSDe_14AUG2025 = AaveV3Ethereum.POOL.getReserveAToken(PT_eUSDe_14AUG2025);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(
      PT_eUSDe_14AUG2025,
      PT_eUSDe_14AUG2025_LM_ADMIN
    );
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(
      aPT_eUSDe_14AUG2025,
      PT_eUSDe_14AUG2025_LM_ADMIN
    );
  }

  function eModeCategoriesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryUpdate[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryUpdate[]
      memory eModeUpdates = new IAaveV3ConfigEngine.EModeCategoryUpdate[](4);

    eModeUpdates[0] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 10,
      ltv: 88_10,
      liqThreshold: 91_10,
      liqBonus: 3_90,
      label: 'PT-USDe Stablecoins July 2025'
    });
    eModeUpdates[1] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 11,
      ltv: 90_10,
      liqThreshold: 92_10,
      liqBonus: 2_80,
      label: 'PT-USDe USDe July 2025'
    });
    eModeUpdates[2] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 12,
      ltv: 87_10,
      liqThreshold: 90_10,
      liqBonus: 4_10,
      label: 'PT-eUSDe Stablecoins August 2025'
    });
    eModeUpdates[3] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 13,
      ltv: 89_00,
      liqThreshold: 91_00,
      liqBonus: 3_10,
      label: 'PT-eUSDe USDe August 2025'
    });

    return eModeUpdates;
  }
  function assetsEModeUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.AssetEModeUpdate[] memory)
  {
    IAaveV3ConfigEngine.AssetEModeUpdate[]
      memory assetEModeUpdates = new IAaveV3ConfigEngine.AssetEModeUpdate[](12);

    assetEModeUpdates[0] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: PT_USDe_31JUL2025,
      eModeCategory: 10,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: PT_USDe_31JUL2025,
      eModeCategory: 11,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[2] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: PT_eUSDe_14AUG2025,
      eModeCategory: 12,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[3] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: PT_eUSDe_14AUG2025,
      eModeCategory: 13,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[4] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDC_UNDERLYING,
      eModeCategory: 10,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[5] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDT_UNDERLYING,
      eModeCategory: 10,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[6] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDe_UNDERLYING,
      eModeCategory: 11,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[7] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDS_UNDERLYING,
      eModeCategory: 10,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[8] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDC_UNDERLYING,
      eModeCategory: 12,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[9] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDT_UNDERLYING,
      eModeCategory: 12,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[10] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDe_UNDERLYING,
      eModeCategory: 13,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[11] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDS_UNDERLYING,
      eModeCategory: 12,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    return assetEModeUpdates;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](2);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: PT_USDe_31JUL2025,
      assetSymbol: 'PT_USDe_31JUL2025',
      priceFeed: 0xC26D4a1c46d884cfF6dE9800B6aE7A8Cf48B4Ff8,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 7_50,
      reserveFactor: 45_00,
      supplyCap: 40_000_000,
      borrowCap: 1,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 10_00,
        variableRateSlope2: 300_00
      })
    });
    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: PT_eUSDe_14AUG2025,
      assetSymbol: 'PT_eUSDe_14AUG2025',
      priceFeed: 0x5292AB3292D076271f853Ed8e05e61cc02F0A2C6,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 7_50,
      reserveFactor: 45_00,
      supplyCap: 100_000_000,
      borrowCap: 1,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 10_00,
        variableRateSlope2: 300_00
      })
    });

    return listings;
  }
}
