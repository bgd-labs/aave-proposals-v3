// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
// import {AaveV3InkWhitelabel} from "aave-address-book/AaveV3InkWhitelabel.sol";
import {GHOInkLaunchConstants} from './GHOInkLaunchConstants.sol';
import {GhoCCIPChains} from './abstraction/constants/GhoCCIPChains.sol';
import {AaveV3Payload} from 'aave-v3-origin/contracts/extensions/v3-config-engine/AaveV3Payload.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IPool} from 'aave-v3-origin/contracts/interfaces/IPool.sol';
import {IPoolDataProvider} from 'aave-v3-origin/contracts/interfaces/IPoolDataProvider.sol';

/**
 * @title GHO Ink Listing
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-ink-set-aci-as-emissions-manager-for-rewards/22664
 */
contract AaveV3Ink_GHOInkListing_20250814 is
  AaveV3Payload(IAaveV3ConfigEngine(GHOInkLaunchConstants.CONFIG_ENGINE))
{
  using SafeERC20 for IERC20;

  address public constant EMISSION_ADMIN = GHOInkLaunchConstants.EMISSION_ADMIN;
  address public constant GHO_PRICE_FEED = GHOInkLaunchConstants.GHO_PRICE_FEED;
  address public immutable GHO_TOKEN = GhoCCIPChains.INK().ghoToken;
  uint256 public constant GHO_SEED_AMOUNT = 100e18;

  function _preExecute() internal view override {
    // robot should simulate and only execute if seed amount has been bridged, redundant check
    assert(IERC20(GHO_TOKEN).balanceOf(address(this)) >= GHO_SEED_AMOUNT);
  }

  function _postExecute() internal override {
    IERC20(GHO_TOKEN).forceApprove(address(GHOInkLaunchConstants.POOL), GHO_SEED_AMOUNT);
    IPool(GHOInkLaunchConstants.POOL).supply(
      GHO_TOKEN,
      GHO_SEED_AMOUNT,
      GHOInkLaunchConstants.DUST_BIN,
      0
    );

    (address aGhoToken, , ) = IPoolDataProvider(GHOInkLaunchConstants.AAVE_PROTOCOL_DATA_PROVIDER)
      .getReserveTokensAddresses(GHO_TOKEN);
    IEmissionManager(GHOInkLaunchConstants.EMISSION_MANAGER).setEmissionAdmin(
      GHO_TOKEN,
      EMISSION_ADMIN
    );
    IEmissionManager(GHOInkLaunchConstants.EMISSION_MANAGER).setEmissionAdmin(
      aGhoToken,
      EMISSION_ADMIN
    );
  }

  function newListings() public view override returns (IAaveV3ConfigEngine.Listing[] memory) {
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
      supplyCap: 5_000_000,
      borrowCap: 4_500_000,
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

  function getPoolContext()
    public
    view
    virtual
    override
    returns (IAaveV3ConfigEngine.PoolContext memory)
  {
    return IAaveV3ConfigEngine.PoolContext({networkName: 'Ink', networkAbbreviation: 'Ink'});
  }
}
