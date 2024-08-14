// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_EventsGrant2024_20240718} from './AaveV3Ethereum_EventsGrant2024_20240718.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @dev Test for AaveV3Ethereum_EventsGrant2024_20240718
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240718_AaveV3Ethereum_EventsGrant2024/AaveV3Ethereum_EventsGrant2024_20240718.t.sol -vv
 */
contract AaveV3Ethereum_EventsGrant2024_20240718_Test is ProtocolV3TestBase {
  AaveV3Ethereum_EventsGrant2024_20240718 internal proposal;

  address public constant AAVE_LABS = 0x1c037b3C22240048807cC9d7111be5d455F640bd;
  uint256 public constant GHO_GRANT_AMOUNT = 650_000 ether;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20336106);
    proposal = new AaveV3Ethereum_EventsGrant2024_20240718();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_EventsGrant2024_20240718', AaveV3Ethereum.POOL, address(proposal));
  }

  function testProposalExecution() public {
    uint256 ALGHOBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(AAVE_LABS);
    uint256 CollectorV3GHOBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(AAVE_LABS),
      ALGHOBalanceBefore + GHO_GRANT_AMOUNT
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      CollectorV3GHOBalanceBefore - GHO_GRANT_AMOUNT
    );
  }
}
