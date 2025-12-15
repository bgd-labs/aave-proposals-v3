// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV3PayloadAvalanche} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadAvalanche.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Onboard rsETH to Aave V3 Avalanche Instance
 * @author Aave-chan Initiative
 * - Snapshot: direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-onboard-rseth-to-aave-v3-avalanche-instance/23313
 */
contract AaveV3Avalanche_OnboardRsETHToAaveV3AvalancheInstance_20251117 is AaveV3PayloadAvalanche {
  using SafeERC20 for IERC20;

  address public constant wrsETH = 0x7bFd4CA2a6Cf3A3fDDd645D10B323031afe47FF0;
  uint256 public constant wrsETH_SEED_AMOUNT = 3e16;
  address public constant wrsETH_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(wrsETH, wrsETH_SEED_AMOUNT, wrsETH_LM_ADMIN);
  }

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](1);

    address[] memory collateralAssets_WrsETHETH = new address[](1);
    address[] memory borrowableAssets_WrsETHETH = new address[](1);

    collateralAssets_WrsETHETH[0] = wrsETH;
    borrowableAssets_WrsETHETH[0] = AaveV3AvalancheAssets.WETHe_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'wrsETH/ETH',
      collaterals: collateralAssets_WrsETHETH,
      borrowables: borrowableAssets_WrsETHETH
    });

    return eModeCreations;
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: wrsETH,
      assetSymbol: 'wrsETH',
      priceFeed: 0xe5Af98d1c62c7D9C1378AF187eEFB0BEe112ff64,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 7_00,
      reserveFactor: 45_00,
      supplyCap: 5_000,
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

  function _supplyAndConfigureLMAdmin(address asset, uint256 seedAmount, address lmAdmin) internal {
    IERC20(asset).forceApprove(address(AaveV3Avalanche.POOL), seedAmount);
    AaveV3Avalanche.POOL.supply(asset, seedAmount, address(AaveV3Avalanche.DUST_BIN), 0);

    if (lmAdmin != address(0)) {
      address aToken = AaveV3Avalanche.POOL.getReserveAToken(asset);
      IEmissionManager(AaveV3Avalanche.EMISSION_MANAGER).setEmissionAdmin(asset, lmAdmin);
      IEmissionManager(AaveV3Avalanche.EMISSION_MANAGER).setEmissionAdmin(aToken, lmAdmin);
    }
  }
}
