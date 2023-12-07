// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {GovernanceV3Polygon} from 'aave-address-book/GovernanceV3Polygon.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Polygon_OnboardNativeUSDCToAaveV3Markets_20231205} from './AaveV3Polygon_OnboardNativeUSDCToAaveV3Markets_20231205.sol';

/**
 * @dev Test for AaveV3Polygon_OnboardNativeUSDCToAaveV3Markets_20231205
 * command: make test-contract filter=AaveV3Polygon_OnboardNativeUSDCToAaveV3Markets_20231205
 */
contract AaveV3Polygon_OnboardNativeUSDCToAaveV3Markets_20231205_Test is ProtocolV3TestBase {
  AaveV3Polygon_OnboardNativeUSDCToAaveV3Markets_20231205 internal proposal;
  address internal USDC_WHALE = 0xe7804c37c13166fF0b37F5aE0BB07A3aEbb6e245;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 50786431);
    proposal = new AaveV3Polygon_OnboardNativeUSDCToAaveV3Markets_20231205();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    startHoax(USDC_WHALE);
    IERC20(proposal.USDCn()).transfer(GovernanceV3Polygon.EXECUTOR_LVL_1, 10 ** 6);
    defaultTest(
      'AaveV3Polygon_OnboardNativeUSDCToAaveV3Markets_20231205',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }

  function test_collectorHasnUSDCFunds() public {
    startHoax(USDC_WHALE);
    IERC20(proposal.USDCn()).transfer(GovernanceV3Polygon.EXECUTOR_LVL_1, 10 ** 6);
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Polygon
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.USDCn());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Polygon.COLLECTOR)), 10 ** 6);
  }
}
