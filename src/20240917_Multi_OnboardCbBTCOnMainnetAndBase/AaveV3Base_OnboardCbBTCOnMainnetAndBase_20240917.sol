// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base, AaveV3BaseEModes} from 'aave-address-book/AaveV3Base.sol';
import {AaveV3PayloadBase} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadBase.sol';
import {EngineFlags} from 'aave-v3-periphery/contracts/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-periphery/contracts/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
/**
 * @title Onboard CbBTC on Mainnet and Base
 * @author ACI
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x7dd65a983a069e9e4def961e116b78acef6965ecb63aebfb26e34a1dcd97b060
 * - Discussion: https://governance.aave.com/t/arfc-onboard-cbbtc-to-aave-v3-on-base-and-mainnet/18988
 */
contract AaveV3Base_OnboardCbBTCOnMainnetAndBase_20240917 is AaveV3PayloadBase {
  using SafeERC20 for IERC20;

  address public constant cbBTC = 0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf;
  uint256 public constant cbBTC_SEED_AMOUNT = 2e5;

  function _postExecute() internal override {
    IERC20(cbBTC).forceApprove(address(AaveV3Base.POOL), cbBTC_SEED_AMOUNT);
    AaveV3Base.POOL.supply(cbBTC, cbBTC_SEED_AMOUNT, address(AaveV3Base.COLLECTOR), 0);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: cbBTC,
      assetSymbol: 'cbBTC',
      priceFeed: 0x64c911996D3c6aC71f9b455B1E8E7266BcbD848F,
      eModeCategory: AaveV3BaseEModes.NONE,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 73_00,
      liqThreshold: 78_00,
      liqBonus: 7_50,
      reserveFactor: 20_00,
      supplyCap: 200,
      borrowCap: 20,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 4_00,
        variableRateSlope2: 300_00
      })
    });

    return listings;
  }
}
