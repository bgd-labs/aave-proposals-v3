// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';

import {AaveV3Gnosis_AprilFinanceUpdate_20240421} from './AaveV3Gnosis_AprilFinanceUpdate_20240421.sol';

/**
 * @dev Test for AaveV3Gnosis_AprilFinanceUpdate_20240421
 * command: make test-contract filter=AaveV3Gnosis_AprilFinanceUpdate_20240421
 */
contract AaveV3Gnosis_AprilFinanceUpdate_20240421_Test is ProtocolV3TestBase {
  AaveV3Gnosis_AprilFinanceUpdate_20240421 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 33562797);
    proposal = new AaveV3Gnosis_AprilFinanceUpdate_20240421();
  }

  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Gnosis_AprilFinanceUpdate_20240421', AaveV3Gnosis.POOL, address(proposal));
  }

  function test_transfer() public {
    uint256 balanceCollectorBefore = IERC20(proposal.armmv3WXDAI()).balanceOf(
      address(AaveV3Gnosis.COLLECTOR)
    );
    uint256 balanceRealTBefore = IERC20(proposal.armmv3WXDAI()).balanceOf(proposal.REAL_T());

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(proposal.armmv3WXDAI()).balanceOf(address(AaveV3Gnosis.COLLECTOR)),
      balanceCollectorBefore - proposal.TO_TRANSFER()
    );
    assertEq(
      IERC20(proposal.armmv3WXDAI()).balanceOf(proposal.REAL_T()),
      balanceRealTBefore + proposal.TO_TRANSFER()
    );
  }
}
