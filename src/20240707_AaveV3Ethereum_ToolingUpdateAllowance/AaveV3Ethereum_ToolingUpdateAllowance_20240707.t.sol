// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_ToolingUpdateAllowance_20240707} from './AaveV3Ethereum_ToolingUpdateAllowance_20240707.sol';

/**
 * @dev Test for AaveV3Ethereum_ToolingUpdateAllowance_20240707
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240707_AaveV3Ethereum_ToolingUpdateAllowance/AaveV3Ethereum_ToolingUpdateAllowance_20240707.t.sol -vv
 */
contract AaveV3Ethereum_ToolingUpdateAllowance_20240707_Test is ProtocolV3TestBase {
  AaveV3Ethereum_ToolingUpdateAllowance_20240707 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20257930);
    proposal = new AaveV3Ethereum_ToolingUpdateAllowance_20240707();
  }

  function test_defaultProposalExecution() public {
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.TOKEN_LOGIC()
      ),
      0
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.TOKEN_LOGIC()
      ),
      proposal.ALLOWANCE()
    );
  }
}
