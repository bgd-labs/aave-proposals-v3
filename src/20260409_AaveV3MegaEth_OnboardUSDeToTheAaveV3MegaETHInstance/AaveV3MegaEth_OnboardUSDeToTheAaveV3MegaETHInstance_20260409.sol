// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3MegaEth, AaveV3MegaEthAssets} from 'aave-address-book/AaveV3MegaEth.sol';
import {AaveV3PayloadMegaEth} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadMegaEth.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {GovernanceV3MegaEth} from 'aave-address-book/GovernanceV3MegaEth.sol';

/**
 * @title Onboard USDe to the Aave V3 MegaETH Instance
 * @author Aave Labs
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-onboard-usde-to-the-aave-v3-megaeth-instance/24389
 */
contract AaveV3MegaEth_OnboardUSDeToTheAaveV3MegaETHInstance_20260409 is AaveV3PayloadMegaEth {
  using SafeERC20 for IERC20;

  address public constant USDe = 0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34;
  uint256 public constant USDe_SEED_AMOUNT = 1e18;

  address public constant LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _preExecute() internal override {
    AaveV3MegaEth.COLLECTOR.transfer(
      IERC20(USDe),
      GovernanceV3MegaEth.EXECUTOR_LVL_1,
      USDe_SEED_AMOUNT
    );
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: USDe,
      assetSymbol: 'USDe',
      priceFeed: 0x6B00ffb3852E87c13b7f56660a7dfF64191180B3,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 25_00,
      supplyCap: 50_000_000,
      borrowCap: 40_000_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 85_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 4_00,
        variableRateSlope2: 12_00
      })
    });

    return listings;
  }

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](1);

    address[] memory collateralAssets_USDeStablecoins = new address[](1);
    address[] memory borrowableAssets_USDeStablecoins = new address[](2);

    collateralAssets_USDeStablecoins[0] = USDe;
    borrowableAssets_USDeStablecoins[0] = AaveV3MegaEthAssets.USDT0_UNDERLYING;
    borrowableAssets_USDeStablecoins[1] = AaveV3MegaEthAssets.USDm_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 90_00,
      liqThreshold: 93_00,
      liqBonus: 2_00,
      label: 'USDe__USDT0_USDm',
      collaterals: collateralAssets_USDeStablecoins,
      borrowables: borrowableAssets_USDeStablecoins
    });

    return eModeCreations;
  }

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(USDe, USDe_SEED_AMOUNT, LM_ADMIN);
  }

  function _supplyAndConfigureLMAdmin(address asset, uint256 seedAmount, address lmAdmin) internal {
    IERC20(asset).forceApprove(address(AaveV3MegaEth.POOL), seedAmount);
    AaveV3MegaEth.POOL.supply(asset, seedAmount, address(AaveV3MegaEth.DUST_BIN), 0);

    if (lmAdmin != address(0)) {
      address aToken = AaveV3MegaEth.POOL.getReserveAToken(asset);
      address vToken = AaveV3MegaEth.POOL.getReserveVariableDebtToken(asset);
      IEmissionManager(AaveV3MegaEth.EMISSION_MANAGER).setEmissionAdmin(asset, lmAdmin);
      IEmissionManager(AaveV3MegaEth.EMISSION_MANAGER).setEmissionAdmin(aToken, lmAdmin);
      IEmissionManager(AaveV3MegaEth.EMISSION_MANAGER).setEmissionAdmin(vToken, lmAdmin);
    }
  }
}
