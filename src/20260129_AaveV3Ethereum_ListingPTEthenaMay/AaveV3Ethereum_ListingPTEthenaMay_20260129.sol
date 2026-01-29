// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Listing PT Ethena May
 * @author Aavechan Initiative @aci
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-onboard-usde-susde-may-expiry-pt-tokens-on-aave-v3-core-instance/23882
 */
contract AaveV3Ethereum_ListingPTEthenaMay_20260129 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  address public constant PT_USDe_7MAY2026 = 0xAeBf0Bb9f57E89260d57f31AF34eB58657d96Ce0;
  uint256 public constant PT_USDe_7MAY2026_SEED_AMOUNT = 100e18;
  address public constant PT_USDe_7MAY2026_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  address public constant PT_sUSDe_7MAY2026 = 0x3de0ff76E8b528C092d47b9DaC775931cef80F49;
  uint256 public constant PT_sUSDe_7MAY2026_SEED_AMOUNT = 100e18;
  address public constant PT_sUSDe_7MAY2026_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _preExecute() internal override {
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(PT_USDe_7MAY2026),
      GovernanceV3Ethereum.EXECUTOR_LVL_1,
      PT_USDe_7MAY2026_SEED_AMOUNT
    );
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(PT_sUSDe_7MAY2026),
      GovernanceV3Ethereum.EXECUTOR_LVL_1,
      PT_sUSDe_7MAY2026_SEED_AMOUNT
    );
  }

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(
      PT_USDe_7MAY2026,
      PT_USDe_7MAY2026_SEED_AMOUNT,
      PT_USDe_7MAY2026_LM_ADMIN
    );

    _supplyAndConfigureLMAdmin(
      PT_sUSDe_7MAY2026,
      PT_sUSDe_7MAY2026_SEED_AMOUNT,
      PT_sUSDe_7MAY2026_LM_ADMIN
    );
  }

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](4);

    address[] memory collateralAssets_PT_USDe_7MAY2026__Stablecoins = new address[](3);
    address[] memory borrowableAssets_PT_USDe_7MAY2026__Stablecoins = new address[](4);

    collateralAssets_PT_USDe_7MAY2026__Stablecoins[0] = PT_USDe_7MAY2026;
    collateralAssets_PT_USDe_7MAY2026__Stablecoins[1] = AaveV3EthereumAssets.USDe_UNDERLYING;
    collateralAssets_PT_USDe_7MAY2026__Stablecoins[2] = AaveV3EthereumAssets
      .PT_USDe_5FEB2026_UNDERLYING;
    borrowableAssets_PT_USDe_7MAY2026__Stablecoins[0] = AaveV3EthereumAssets.USDC_UNDERLYING;
    borrowableAssets_PT_USDe_7MAY2026__Stablecoins[1] = AaveV3EthereumAssets.USDT_UNDERLYING;
    borrowableAssets_PT_USDe_7MAY2026__Stablecoins[2] = AaveV3EthereumAssets.USDe_UNDERLYING;
    borrowableAssets_PT_USDe_7MAY2026__Stablecoins[3] = AaveV3EthereumAssets.USDtb_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 87_20,
      liqThreshold: 89_20,
      liqBonus: 4_40,
      label: 'PT_USDe_7MAY2026__Stablecoins',
      collaterals: collateralAssets_PT_USDe_7MAY2026__Stablecoins,
      borrowables: borrowableAssets_PT_USDe_7MAY2026__Stablecoins
    });

    address[] memory collateralAssets_PT_USDe_7MAY2026__USDe = new address[](3);
    address[] memory borrowableAssets_PT_USDe_7MAY2026__USDe = new address[](1);

    collateralAssets_PT_USDe_7MAY2026__USDe[0] = PT_USDe_7MAY2026;
    collateralAssets_PT_USDe_7MAY2026__USDe[1] = AaveV3EthereumAssets.USDe_UNDERLYING;
    collateralAssets_PT_USDe_7MAY2026__USDe[2] = AaveV3EthereumAssets.PT_USDe_5FEB2026_UNDERLYING;
    borrowableAssets_PT_USDe_7MAY2026__USDe[0] = AaveV3EthereumAssets.USDe_UNDERLYING;

    eModeCreations[1] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 88_10,
      liqThreshold: 90_10,
      liqBonus: 3_40,
      label: 'PT_USDe_7MAY2026__USDe',
      collaterals: collateralAssets_PT_USDe_7MAY2026__USDe,
      borrowables: borrowableAssets_PT_USDe_7MAY2026__USDe
    });

    address[] memory collateralAssets_PT_sUSDe_7MAY2026__Stablecoins = new address[](3);
    address[] memory borrowableAssets_PT_sUSDe_7MAY2026__Stablecoins = new address[](4);

    collateralAssets_PT_sUSDe_7MAY2026__Stablecoins[0] = PT_sUSDe_7MAY2026;
    collateralAssets_PT_sUSDe_7MAY2026__Stablecoins[1] = AaveV3EthereumAssets.sUSDe_UNDERLYING;
    collateralAssets_PT_sUSDe_7MAY2026__Stablecoins[2] = AaveV3EthereumAssets
      .PT_sUSDE_5FEB2026_UNDERLYING;
    borrowableAssets_PT_sUSDe_7MAY2026__Stablecoins[0] = AaveV3EthereumAssets.USDC_UNDERLYING;
    borrowableAssets_PT_sUSDe_7MAY2026__Stablecoins[1] = AaveV3EthereumAssets.USDT_UNDERLYING;
    borrowableAssets_PT_sUSDe_7MAY2026__Stablecoins[2] = AaveV3EthereumAssets.USDe_UNDERLYING;
    borrowableAssets_PT_sUSDe_7MAY2026__Stablecoins[3] = AaveV3EthereumAssets.USDtb_UNDERLYING;

    eModeCreations[2] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 86_40,
      liqThreshold: 88_40,
      liqBonus: 5_50,
      label: 'PT_sUSDe_7MAY2026__Stablecoins',
      collaterals: collateralAssets_PT_sUSDe_7MAY2026__Stablecoins,
      borrowables: borrowableAssets_PT_sUSDe_7MAY2026__Stablecoins
    });

    address[] memory collateralAssets_PT_sUSDe_7MAY2026__USDe = new address[](3);
    address[] memory borrowableAssets_PT_sUSDe_7MAY2026__USDe = new address[](1);

    collateralAssets_PT_sUSDe_7MAY2026__USDe[0] = PT_sUSDe_7MAY2026;
    collateralAssets_PT_sUSDe_7MAY2026__USDe[1] = AaveV3EthereumAssets.sUSDe_UNDERLYING;
    collateralAssets_PT_sUSDe_7MAY2026__USDe[2] = AaveV3EthereumAssets.PT_sUSDE_5FEB2026_UNDERLYING;
    borrowableAssets_PT_sUSDe_7MAY2026__USDe[0] = AaveV3EthereumAssets.USDe_UNDERLYING;

    eModeCreations[3] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 87_20,
      liqThreshold: 89_20,
      liqBonus: 4_50,
      label: 'PT_sUSDe_7MAY2026__USDe',
      collaterals: collateralAssets_PT_sUSDe_7MAY2026__USDe,
      borrowables: borrowableAssets_PT_sUSDe_7MAY2026__USDe
    });

    return eModeCreations;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](2);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: PT_USDe_7MAY2026,
      assetSymbol: 'PT_USDe_7MAY2026',
      priceFeed: 0x0a72df02CE3E4185b6CEDf561f0AE651E9BeE235,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 45_00,
      supplyCap: 30_000_000,
      borrowCap: 1,
      debtCeiling: 1,
      liqProtocolFee: 10,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 10_00,
        variableRateSlope2: 300_00
      })
    });
    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: PT_sUSDe_7MAY2026,
      assetSymbol: 'PT_sUSDe_7MAY2026',
      priceFeed: 0xa0dc0249c32fa79e8B9b17c735908a60b1141B40,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 45_00,
      supplyCap: 70_000_000,
      borrowCap: 1,
      debtCeiling: 1,
      liqProtocolFee: 10,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 10_00,
        variableRateSlope2: 300_00
      })
    });

    return listings;
  }
  function _supplyAndConfigureLMAdmin(address asset, uint256 seedAmount, address lmAdmin) internal {
    IERC20(asset).forceApprove(address(AaveV3Ethereum.POOL), seedAmount);
    AaveV3Ethereum.POOL.supply(asset, seedAmount, address(AaveV3Ethereum.DUST_BIN), 0);

    if (lmAdmin != address(0)) {
      address aToken = AaveV3Ethereum.POOL.getReserveAToken(asset);
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(asset, lmAdmin);
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(aToken, lmAdmin);
    }
  }
}
