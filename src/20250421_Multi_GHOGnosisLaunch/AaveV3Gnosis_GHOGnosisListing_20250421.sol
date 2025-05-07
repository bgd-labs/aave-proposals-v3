// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {AaveV3PayloadGnosis} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadGnosis.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';

/**
 * @title GHO Gnosis Listing
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-gnosis-chain/21379
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x62996204d8466d603fe8c953176599db02a23f440a682ff15ba2d0ca63dda386
 */
contract AaveV3Gnosis_GHOGnosisListing_20250421 is AaveV3PayloadGnosis {
  using SafeERC20 for IERC20;

  // https://gnosisscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd
  address public constant EMISSION_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;
  // https://gnosisscan.io/address/0x360d8aa8F6b09B7BC57aF34db2Eb84dD87bf4d12
  address public constant GHO_PRICE_FEED = 0x360d8aa8F6b09B7BC57aF34db2Eb84dD87bf4d12;
  // https://gnosisscan.io/address/0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73
  address public constant GHO_TOKEN = 0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73;
  uint256 public constant GHO_SEED_AMOUNT = 1e18;

  function _preExecute() internal view override {
    // robot should simulate and only execute if seed amount has been bridged, redundant check
    assert(IERC20(GHO_TOKEN).balanceOf(address(this)) >= GHO_SEED_AMOUNT);
  }

  function _postExecute() internal override {
    IERC20(GHO_TOKEN).forceApprove(address(AaveV3Gnosis.POOL), GHO_SEED_AMOUNT);
    AaveV3Gnosis.POOL.supply(GHO_TOKEN, GHO_SEED_AMOUNT, address(0), 0);

    (address aGhoToken, , ) = AaveV3Gnosis.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      GHO_TOKEN
    );
    IEmissionManager(AaveV3Gnosis.EMISSION_MANAGER).setEmissionAdmin(GHO_TOKEN, EMISSION_ADMIN);
    IEmissionManager(AaveV3Gnosis.EMISSION_MANAGER).setEmissionAdmin(aGhoToken, EMISSION_ADMIN);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: GHO_TOKEN,
      assetSymbol: 'GHO',
      priceFeed: GHO_PRICE_FEED,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 1,
      supplyCap: 2_500_000,
      borrowCap: 2_250_000,
      debtCeiling: 0,
      liqProtocolFee: 0,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 6_50,
        variableRateSlope2: 50_00
      })
    });

    return listings;
  }
}
