// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_TransferAURAToGLCSafe_20231123} from './AaveV3Ethereum_TransferAURAToGLCSafe_20231123.sol';

/**
 * @dev Test for AaveV3Ethereum_TransferAURAToGLCSafe_20231123
 * command: make test-contract filter=AaveV3Ethereum_TransferAURAToGLCSafe_20231123
 */
contract AaveV3Ethereum_TransferAURAToGLCSafe_20231123_Test is ProtocolV3TestBase {
  AaveV3Ethereum_TransferAURAToGLCSafe_20231123 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18636648);
    proposal = new AaveV3Ethereum_TransferAURAToGLCSafe_20231123();
  }

  function test_execute() public {
    uint256 balanceBefore = IERC20(proposal.AURA()).balanceOf(address(AaveV3Ethereum.COLLECTOR));

    assertEq(IERC20(proposal.AURA()).balanceOf(proposal.GLC_SAFE()), 0);

    GovV3Helpers.executePayload(vm, address(proposal));

    assertEq(IERC20(proposal.AURA()).balanceOf(address(AaveV3Ethereum.COLLECTOR)), 0);

    assertEq(IERC20(proposal.AURA()).balanceOf(proposal.GLC_SAFE()), balanceBefore);
  }
}
