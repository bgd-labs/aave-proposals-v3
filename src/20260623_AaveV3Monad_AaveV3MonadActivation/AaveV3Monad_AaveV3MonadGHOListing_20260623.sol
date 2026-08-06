// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Monad} from 'aave-address-book/AaveV3Monad.sol';
import {AaveV3PayloadMonad} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadMonad.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title AaveV3MonadGHOListing
 * @author Aave Labs
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0x24f105bd023c476a9b85fa87ff795bfeec769fa799ce6ada8e2724c9738049f6
 * - Discussion: https://governance.aave.com/t/arfc-deploy-aave-protocol-on-monad/24943
 * @dev Lists GHO on Aave V3 Monad and adds it as a borrowable to the syrupUSDC__Stablecoins and
 *      USDe_sUSDe__Stablecoins eModes. Must be executed after AaveV3MonadActivation_20260623, which
 *      creates those eModes.
 */
contract AaveV3Monad_AaveV3MonadGHOListing_20260623 is AaveV3PayloadMonad {
  using SafeERC20 for IERC20;

  // https://monadscan.com/address/0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73
  address public constant GHO = 0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73;
  uint256 public constant GHO_SEED_AMOUNT = 100e18;
  // https://monadscan.com/address/0x26cBccD96502D2EfDb612737bD6aECe19f65109c
  address public constant GHO_PRICE_FEED = 0x26cBccD96502D2EfDb612737bD6aECe19f65109c;

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: GHO,
      assetSymbol: 'GHO',
      priceFeed: GHO_PRICE_FEED,
      enabledToBorrow: EngineFlags.ENABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 7_50,
      reserveFactor: 10_00,
      supplyCap: 20_000_000,
      borrowCap: 18_000_000,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 4_00,
        variableRateSlope2: 40_00
      })
    });

    return listings;
  }

  function assetsEModeUpdates()
    public
    view
    override
    returns (IAaveV3ConfigEngine.AssetEModeUpdate[] memory)
  {
    IAaveV3ConfigEngine.AssetEModeUpdate[]
      memory updates = new IAaveV3ConfigEngine.AssetEModeUpdate[](2);

    updates[0] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: GHO,
      eModeCategory: _findEModeCategoryId('syrupUSDC__Stablecoins'),
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED,
      ltvzero: EngineFlags.KEEP_CURRENT
    });

    updates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: GHO,
      eModeCategory: _findEModeCategoryId('USDe_sUSDe__Stablecoins'),
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED,
      ltvzero: EngineFlags.KEEP_CURRENT
    });

    return updates;
  }

  function _preExecute() internal view override {
    require(AaveV3Monad.POOL.getReservesCount() > 0, 'ACTIVATION_PAYLOAD_NOT_EXECUTED');
  }

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(GHO, GHO_SEED_AMOUNT, address(0));
  }

  function _supplyAndConfigureLMAdmin(address asset, uint256 seedAmount, address lmAdmin) internal {
    IERC20(asset).forceApprove(address(AaveV3Monad.POOL), seedAmount);
    AaveV3Monad.POOL.supply(asset, seedAmount, address(AaveV3Monad.DUST_BIN), 0);

    if (lmAdmin != address(0)) {
      address aToken = AaveV3Monad.POOL.getReserveAToken(asset);
      address vToken = AaveV3Monad.POOL.getReserveVariableDebtToken(asset);
      IEmissionManager(AaveV3Monad.EMISSION_MANAGER).setEmissionAdmin(asset, lmAdmin);
      IEmissionManager(AaveV3Monad.EMISSION_MANAGER).setEmissionAdmin(aToken, lmAdmin);
      IEmissionManager(AaveV3Monad.EMISSION_MANAGER).setEmissionAdmin(vToken, lmAdmin);
    }
  }

  function _findEModeCategoryId(string memory label) internal view returns (uint8) {
    for (uint8 i = 1; i < 255; i++) {
      if (keccak256(bytes(AaveV3Monad.POOL.getEModeCategoryLabel(i))) == keccak256(bytes(label))) {
        return i;
      }
    }
    revert('eMode category not found');
  }
}
