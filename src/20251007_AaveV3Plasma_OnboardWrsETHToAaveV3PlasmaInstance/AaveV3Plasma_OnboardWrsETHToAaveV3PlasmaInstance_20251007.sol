// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Plasma, AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';
import {AaveV3PayloadPlasma} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadPlasma.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Onboard wrsETH to Aave v3 Plasma Instance
 * @author Aave-chan Initiative
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-onboard-wrseth-to-aave-v3-plasma-instance/23183
 */
contract AaveV3Plasma_OnboardWrsETHToAaveV3PlasmaInstance_20251007 is AaveV3PayloadPlasma {
  using SafeERC20 for IERC20;

  address public constant wrsETH = 0xe561FE05C39075312Aa9Bc6af79DdaE981461359;
  uint256 public constant wrsETH_SEED_AMOUNT = 4e16;
  address public constant wrsETH_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    IERC20(wrsETH).forceApprove(address(AaveV3Plasma.POOL), wrsETH_SEED_AMOUNT);
    AaveV3Plasma.POOL.supply(wrsETH, wrsETH_SEED_AMOUNT, AaveV3Plasma.DUST_BIN, 0);

    address awrsETH = AaveV3Plasma.POOL.getReserveAToken(wrsETH);
    IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).setEmissionAdmin(wrsETH, wrsETH_LM_ADMIN);
    IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).setEmissionAdmin(awrsETH, wrsETH_LM_ADMIN);
  }

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](1);

    address[] memory collateralAssets_WrsETHWETH = new address[](1);
    address[] memory borrowableAssets_WrsETHWETH = new address[](1);

    collateralAssets_WrsETHWETH[0] = wrsETH;
    borrowableAssets_WrsETHWETH[0] = AaveV3PlasmaAssets.WETH_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'wrsETH/WETH',
      collaterals: collateralAssets_WrsETHWETH,
      borrowables: borrowableAssets_WrsETHWETH
    });

    return eModeCreations;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: wrsETH,
      assetSymbol: 'wrsETH',
      priceFeed: 0x3acFddf27b85B5f773B610c6F7e4420aeB1Df8dD,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 7_00,
      reserveFactor: 45_00,
      supplyCap: 20_000,
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
