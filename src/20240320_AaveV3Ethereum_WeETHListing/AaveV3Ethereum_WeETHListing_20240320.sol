// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumEModes} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IV3RateStrategyFactory} from 'aave-helpers/v3-config-engine/IV3RateStrategyFactory.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @title weETH Onboarding
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xd5807ee6ec3d33e7d86805a4287540b0a9801430ee0900ff6babb698e4f2a273
 * - Discussion: https://governance.aave.com/t/arfc-onboard-weeth-to-aave-v3-on-ethereum/16758
 */
contract AaveV3Ethereum_WeETHListing_20240320 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  address public constant weETH = 0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee;
  uint256 public constant weETH_SEED_AMOUNT = 1e16;

  function _postExecute() internal override {
    IERC20(weETH).forceApprove(address(AaveV3Ethereum.POOL), weETH_SEED_AMOUNT);
    AaveV3Ethereum.POOL.supply(weETH, weETH_SEED_AMOUNT, address(AaveV3Ethereum.COLLECTOR), 0);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: weETH,
      assetSymbol: 'weETH',
      priceFeed: 0xf112aF6F0A332B815fbEf3Ff932c057E570b62d3,
      eModeCategory: AaveV3EthereumEModes.ETH_CORRELATED,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 72_50,
      liqThreshold: 75_00,
      liqBonus: 7_50,
      reserveFactor: 15_00,
      supplyCap: 8_000,
      borrowCap: 800,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(45_00),
        baseVariableBorrowRate: _bpsToRay(0),
        variableRateSlope1: _bpsToRay(7_00),
        variableRateSlope2: _bpsToRay(300_00),
        stableRateSlope1: _bpsToRay(0),
        stableRateSlope2: _bpsToRay(0),
        baseStableRateOffset: _bpsToRay(0),
        stableRateExcessOffset: _bpsToRay(0),
        optimalStableToTotalDebtRatio: _bpsToRay(0)
      })
    });

    return listings;
  }
}
