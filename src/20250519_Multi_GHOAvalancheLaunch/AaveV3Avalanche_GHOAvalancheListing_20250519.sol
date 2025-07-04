// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {AaveV3PayloadAvalanche} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadAvalanche.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {GHOAvalancheLaunch} from './utils/GHOAvalancheLaunch.sol';

/**
 * @title GHO Avalanche Listing
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-avalanche-set-aci-as-emissions-manager-for-rewards
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x2aed7eb8b03cb3f961cbf790bf2e2e1e449f841a4ad8bdbcdd223bb6ac69e719
 */
contract AaveV3Avalanche_GHOAvalancheListing_20250519 is AaveV3PayloadAvalanche {
  using SafeERC20 for IERC20;

  // https://avascan.info/blockchain/all/address/0xac140648435d03f784879cd789130F22Ef588Fcd
  address public constant EMISSION_ADMIN = GHOAvalancheLaunch.EMISSION_ADMIN;
  address public constant GHO_PRICE_FEED = GHOAvalancheLaunch.GHO_PRICE_FEED;
  address public constant GHO_TOKEN = GHOAvalancheLaunch.GHO_TOKEN;
  uint256 public constant GHO_SEED_AMOUNT = 100e18;

  function _preExecute() internal view override {
    // robot should simulate and only execute if seed amount has been bridged, redundant check
    assert(IERC20(GHO_TOKEN).balanceOf(address(this)) >= GHO_SEED_AMOUNT);
  }

  function _postExecute() internal override {
    IERC20(GHO_TOKEN).forceApprove(address(AaveV3Avalanche.POOL), GHO_SEED_AMOUNT);
    AaveV3Avalanche.POOL.supply(GHO_TOKEN, GHO_SEED_AMOUNT, AaveV3Avalanche.DUST_BIN, 0);

    (address aGhoToken, , ) = AaveV3Avalanche.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      GHO_TOKEN
    );
    IEmissionManager(AaveV3Avalanche.EMISSION_MANAGER).setEmissionAdmin(GHO_TOKEN, EMISSION_ADMIN);
    IEmissionManager(AaveV3Avalanche.EMISSION_MANAGER).setEmissionAdmin(aGhoToken, EMISSION_ADMIN);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    // below values to match /config.ts
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
      supplyCap: 10_000_000,
      borrowCap: 9_000_000,
      debtCeiling: 0,
      liqProtocolFee: 0,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_50,
        variableRateSlope2: 50_00
      })
    });

    return listings;
  }
}
