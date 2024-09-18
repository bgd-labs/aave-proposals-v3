// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumEModes} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-periphery/contracts/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-periphery/contracts/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
/**
 * @title Onboard Tbtc
 * @author ACI
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x9e2e3bd26866212d0cbd8e7cefcfa21eec9522202fd25b02456b8ff59371db08
 * - Discussion: https://governance.aave.com/t/arfc-onboard-tbtc-to-aave-v3-on-ethereum-arbitrum-and-optimism/17686
 */
contract AaveV3Ethereum_OnboardTbtc_20240917 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  address public constant tBTC = 0x18084fbA666a33d37592fA2633fD49a74DD93a88;
  uint256 public constant tBTC_SEED_AMOUNT = 2e5;

  function _postExecute() internal override {
    IERC20(tBTC).forceApprove(address(AaveV3Ethereum.POOL), tBTC_SEED_AMOUNT);
    AaveV3Ethereum.POOL.supply(tBTC, tBTC_SEED_AMOUNT, address(AaveV3Ethereum.COLLECTOR), 0);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: tBTC,
      assetSymbol: 'tBTC',
      priceFeed: 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c,
      eModeCategory: AaveV3EthereumEModes.NONE,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 73_00,
      liqThreshold: 78_00,
      liqBonus: 7_50,
      reserveFactor: 20_00,
      supplyCap: 550,
      borrowCap: 275,
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
