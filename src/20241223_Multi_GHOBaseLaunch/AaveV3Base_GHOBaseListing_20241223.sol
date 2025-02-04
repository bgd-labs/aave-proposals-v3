// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {AaveV3PayloadBase} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadBase.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';

/**
 * @title GHO Base Listing
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-base-set-aci-as-emissions-manager-for-rewards/19338
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x03dc21e0423c60082dc23317af6ebaf997610cbc2cbb0f5a385653bd99a524fe
 */
contract AaveV3Base_GHOBaseListing_20241223 is AaveV3PayloadBase {
  using SafeERC20 for IERC20;

  // https://basescan.org/address/0xac140648435d03f784879cd789130F22Ef588Fcd
  address public constant EMISSION_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;
  // https://basescan.org/address/0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73
  address public constant GHO_PRICE_FEED = 0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73;
  // https://basescan.org/address/0x6Bb7a212910682DCFdbd5BCBb3e28FB4E8da10Ee
  address public constant GHO_TOKEN = 0x6Bb7a212910682DCFdbd5BCBb3e28FB4E8da10Ee;
  uint256 public constant GHO_SEED_AMOUNT = 1e18;

  function _preExecute() internal view override {
    // robot should simulate and only execute if seed amount has been bridged, redundant check
    assert(IERC20(GHO_TOKEN).balanceOf(address(this)) >= GHO_SEED_AMOUNT);
  }

  function _postExecute() internal override {
    IERC20(GHO_TOKEN).forceApprove(address(AaveV3Base.POOL), GHO_SEED_AMOUNT);
    AaveV3Base.POOL.supply(GHO_TOKEN, GHO_SEED_AMOUNT, address(0), 0);

    (address aGhoToken, , ) = AaveV3Base.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      GHO_TOKEN
    );
    IEmissionManager(AaveV3Base.EMISSION_MANAGER).setEmissionAdmin(GHO_TOKEN, EMISSION_ADMIN);
    IEmissionManager(AaveV3Base.EMISSION_MANAGER).setEmissionAdmin(aGhoToken, EMISSION_ADMIN);
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
      reserveFactor: 10_00,
      supplyCap: 2_500_000,
      borrowCap: 2_250_000,
      debtCeiling: 0,
      liqProtocolFee: 0,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 9_50,
        variableRateSlope2: 50_00
      })
    });

    return listings;
  }
}
