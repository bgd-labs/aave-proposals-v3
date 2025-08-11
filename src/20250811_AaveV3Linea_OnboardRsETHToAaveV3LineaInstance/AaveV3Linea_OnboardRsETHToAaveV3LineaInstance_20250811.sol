// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Linea, AaveV3LineaAssets} from 'aave-address-book/AaveV3Linea.sol';
import {AaveV3PayloadLinea} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadLinea.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Onboard rsETH to Aave V3 Linea Instance
 * @author ACI
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-onboard-rseth-to-aave-v3-linea-instance/22172
 */
contract AaveV3Linea_OnboardRsETHToAaveV3LineaInstance_20250811 is AaveV3PayloadLinea {
  using SafeERC20 for IERC20;

  address public constant wrsETH = 0xD2671165570f41BBB3B0097893300b6EB6101E6C;
  uint256 public constant wrsETH_SEED_AMOUNT = 1e16;
  address public constant wrsETH_LM_ADMIN = 0xdef1FA4CEfe67365ba046a7C630D6B885298E210;

  function _postExecute() internal override {
    IERC20(wrsETH).forceApprove(address(AaveV3Linea.POOL), wrsETH_SEED_AMOUNT);
    AaveV3Linea.POOL.supply(wrsETH, wrsETH_SEED_AMOUNT, AaveV3Linea.DUST_BIN, 0);

    address awrsETH = AaveV3Linea.POOL.getReserveAToken(wrsETH);
    IEmissionManager(AaveV3Linea.EMISSION_MANAGER).setEmissionAdmin(wrsETH, wrsETH_LM_ADMIN);
    IEmissionManager(AaveV3Linea.EMISSION_MANAGER).setEmissionAdmin(awrsETH, wrsETH_LM_ADMIN);
  }

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](1);

    address[] memory collateralAssets_WrsETHWETHIsolatedLiquidEMode = new address[](0);
    address[] memory borrowableAssets_WrsETHWETHIsolatedLiquidEMode = new address[](1);

    borrowableAssets_WrsETHWETHIsolatedLiquidEMode[0] = AaveV3LineaAssets.WETH_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 90_00,
      liqThreshold: 93_00,
      liqBonus: 1_00,
      label: 'wrsETH/WETH Isolated Liquid E-mode',
      collaterals: collateralAssets_WrsETHWETHIsolatedLiquidEMode,
      borrowables: borrowableAssets_WrsETHWETHIsolatedLiquidEMode
    });

    return eModeCreations;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: wrsETH,
      assetSymbol: 'wrsETH',
      priceFeed: 0x444f25c5E73fED92B91F3ECB1bD27003C3CDdeE7,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 70_00,
      liqThreshold: 73_00,
      liqBonus: 10_00,
      reserveFactor: 45_00,
      supplyCap: 400,
      borrowCap: 0,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 20_00,
        variableRateSlope2: 300_00
      })
    });

    return listings;
  }
}
