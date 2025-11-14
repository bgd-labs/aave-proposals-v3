// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3InkWhitelabel} from 'aave-address-book/AaveV3InkWhitelabel.sol';
import {AaveV3PayloadInkWhitelabel} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadInkWhitelabel.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Onboard USDC on AaveV3InkWhitelabel
 * @author ACI
 */
contract AaveV3InkWhitelabel_OnboardUSDCOnAaveV3InkWhitelabel_20251113 is
  AaveV3PayloadInkWhitelabel
{
  using SafeERC20 for IERC20;

  address public constant USDC = 0x2D270e6886d130D724215A266106e6832161EAEd;
  uint256 public constant USDC_SEED_AMOUNT = 100e6;
  address public constant USDC_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(USDC, USDC_SEED_AMOUNT, USDC_LM_ADMIN);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: USDC,
      assetSymbol: 'USDC',
      priceFeed: 0xd910061259A256B99654Cff414c3bfD503E7F6ea,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 10_000_000,
      borrowCap: 9_500_000,
      debtCeiling: 0,
      liqProtocolFee: 0,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_50,
        variableRateSlope2: 40_00
      })
    });

    return listings;
  }
  function _supplyAndConfigureLMAdmin(address asset, uint256 seedAmount, address lmAdmin) internal {
    IERC20(asset).forceApprove(address(AaveV3InkWhitelabel.POOL), seedAmount);
    AaveV3InkWhitelabel.POOL.supply(asset, seedAmount, address(AaveV3InkWhitelabel.DUST_BIN), 0);

    if (lmAdmin != address(0)) {
      address aToken = AaveV3InkWhitelabel.POOL.getReserveAToken(asset);
      IEmissionManager(AaveV3InkWhitelabel.EMISSION_MANAGER).setEmissionAdmin(asset, lmAdmin);
      IEmissionManager(AaveV3InkWhitelabel.EMISSION_MANAGER).setEmissionAdmin(aToken, lmAdmin);
    }
  }
}
