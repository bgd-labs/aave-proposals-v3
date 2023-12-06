// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205} from './AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205.sol';

/**
 * @dev Test for AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205
 * command: make test-contract filter=AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205
 */
contract AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205 internal proposal;
  address internal USDC_WHALE = 0xE68Ee8A12c611fd043fB05d65E1548dC1383f2b9;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 157546316);
    proposal = new AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    startHoax(USDC_WHALE);
    IERC20(proposal.nUSDC()).transfer(GovernanceV3Arbitrum.EXECUTOR_LVL_1, 10 ** 6);
    defaultTest(
      'AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_collectorHasnUSDCFunds() public {
    startHoax(USDC_WHALE);
    IERC20(proposal.nUSDC()).transfer(GovernanceV3Arbitrum.EXECUTOR_LVL_1, 10 ** 6);
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Arbitrum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.nUSDC());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Arbitrum.COLLECTOR)), 10 ** 6);
  }
}
