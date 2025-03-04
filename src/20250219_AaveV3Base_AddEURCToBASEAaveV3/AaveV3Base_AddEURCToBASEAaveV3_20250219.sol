// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {AaveV3PayloadBase} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadBase.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
/**
 * @title Add EURC to BASE Aave V3
 * @author Aave-Chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0xa2d0c8f06e8fae4ba961407f77732c0b6f870e00a349f826a032d20e291e48f6
 * - Discussion: https://governance.aave.com/t/arfc-add-eurc-to-base-aave-v3/20680
 */
contract AaveV3Base_AddEURCToBASEAaveV3_20250219 is AaveV3PayloadBase {
  using SafeERC20 for IERC20;

  address public constant EURC = 0x60a3E35Cc302bFA44Cb288Bc5a4F316Fdb1adb42;
  uint256 public constant EURC_SEED_AMOUNT = 100e6;
  address public constant EURC_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    IERC20(EURC).forceApprove(address(AaveV3Base.POOL), EURC_SEED_AMOUNT);
    AaveV3Base.POOL.supply(EURC, EURC_SEED_AMOUNT, address(AaveV3Base.COLLECTOR), 0);

    (address aEURC, , ) = AaveV3Base.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(EURC);
    IEmissionManager(AaveV3Base.EMISSION_MANAGER).setEmissionAdmin(EURC, EURC_LM_ADMIN);
    IEmissionManager(AaveV3Base.EMISSION_MANAGER).setEmissionAdmin(aEURC, EURC_LM_ADMIN);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: EURC,
      assetSymbol: 'EURC',
      priceFeed: 0x215f25556f91b30AFCF0a12dA51C9d4374B22570,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 5_00,
      reserveFactor: 10_00,
      supplyCap: 4_200_000,
      borrowCap: 3_800_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 8_50,
        variableRateSlope2: 40_00
      })
    });

    return listings;
  }
}
