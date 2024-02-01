// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3BNB_OnboardFdUSDToAaveV3OnBSC_20240201} from './AaveV3BNB_OnboardFdUSDToAaveV3OnBSC_20240201.sol';

/**
 * @dev Test for AaveV3BNB_OnboardFdUSDToAaveV3OnBSC_20240201
 * command: make test-contract filter=AaveV3BNB_OnboardFdUSDToAaveV3OnBSC_20240201
 */
contract AaveV3BNB_OnboardFdUSDToAaveV3OnBSC_20240201_Test is ProtocolV3TestBase {
  AaveV3BNB_OnboardFdUSDToAaveV3OnBSC_20240201 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('bnb'), 35760458);
    proposal = new AaveV3BNB_OnboardFdUSDToAaveV3OnBSC_20240201();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3BNB_OnboardFdUSDToAaveV3OnBSC_20240201', AaveV3BNB.POOL, address(proposal));
  }

  function test_collectorHasFDUSDFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3BNB.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.FDUSD()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3BNB.COLLECTOR)), 1 ** 18);
  }
}
