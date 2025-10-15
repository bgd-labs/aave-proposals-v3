// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Plasma} from 'aave-address-book/AaveV3Plasma.sol';
import {AaveV3PayloadPlasma} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadPlasma.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Launch GHO on Plasma & Set ACI as Emissions Manager for Rewards
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xeb3572580924976867073ad9c8012cb9e52093c76dafebd7d3aebf318f2576fb
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-plasma-set-aci-as-emissions-manager-for-rewards/22994
 */
contract AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930 is
  AaveV3PayloadPlasma
{
  using SafeERC20 for IERC20;

  address public constant GHO = 0xb77E872A68C62CfC0dFb02C067Ecc3DA23B4bbf3;
  uint256 public constant GHO_SEED_AMOUNT = 1e18;
  address public constant GHO_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _preExecute() internal override {
    // Set up GHO Reserve
    // Set up GSMs
    // Allow GSMs
    // Move GHO to GHO Reserve
  }

  function _postExecute() internal override {
    IERC20(GHO).forceApprove(address(AaveV3Plasma.POOL), GHO_SEED_AMOUNT);
    AaveV3Plasma.POOL.supply(GHO, GHO_SEED_AMOUNT, AaveV3Plasma.DUST_BIN, 0);

    address aGHO = AaveV3Plasma.POOL.getReserveAToken(GHO);
    IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).setEmissionAdmin(GHO, GHO_LM_ADMIN);
    IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).setEmissionAdmin(aGHO, GHO_LM_ADMIN);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: GHO,
      assetSymbol: 'GHO',
      priceFeed: 0xb0e1c7830aA781362f79225559Aa068E6bDaF1d1,
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
        variableRateSlope1: 6_50,
        variableRateSlope2: 50_00
      })
    });

    return listings;
  }
}
