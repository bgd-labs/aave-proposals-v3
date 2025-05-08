// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {ChainlinkBase} from 'aave-address-book/ChainlinkBase.sol';
import {AaveV3PayloadBase} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadBase.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
/**
 * @title Add AAVE token to Aave V3 Base Instance
 * @author Aave-Chan Initiative
 * - Snapshot: snapshot.box/#/s:aavedao.eth/proposal/0x54efdfaaccf429320071c7e56dd8f14759f2027c8f1c1fb4ef0596374c7558d8
 * - Discussion: https://governance.aave.com/t/arfc-add-aave-token-to-aave-v3-base-instance/21105
 */
contract AaveV3Base_AddAAVETokenToAaveV3BaseInstance_20250507 is AaveV3PayloadBase {
  using SafeERC20 for IERC20;

  address public constant AAVE = 0x63706e401c06ac8513145b7687A14804d17f814b;
  uint256 public constant AAVE_SEED_AMOUNT = 0.65e18;
  address public constant AAVE_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    IERC20(AAVE).forceApprove(address(AaveV3Base.POOL), AAVE_SEED_AMOUNT);
    AaveV3Base.POOL.supply(AAVE, AAVE_SEED_AMOUNT, AaveV3Base.DUST_BIN, 0);

    address aAAVE = AaveV3Base.POOL.getReserveAToken(AAVE);
    IEmissionManager(AaveV3Base.EMISSION_MANAGER).setEmissionAdmin(AAVE, AAVE_LM_ADMIN);
    IEmissionManager(AaveV3Base.EMISSION_MANAGER).setEmissionAdmin(aAAVE, AAVE_LM_ADMIN);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: AAVE,
      assetSymbol: 'AAVE',
      priceFeed: ChainlinkBase.AAVE_USD,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 60_00,
      liqThreshold: 65_00,
      liqBonus: 10_00,
      reserveFactor: 20_00,
      supplyCap: 30_000,
      borrowCap: 1,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 10_00,
        variableRateSlope2: 300_00
      })
    });

    return listings;
  }
}
