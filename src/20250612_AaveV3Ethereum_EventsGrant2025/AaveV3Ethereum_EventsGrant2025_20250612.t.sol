// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_EventsGrant2025_20250612} from './AaveV3Ethereum_EventsGrant2025_20250612.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

/**
 * @dev Test for AaveV3Ethereum_EventsGrant2025_20250612
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250612_AaveV3Ethereum_EventsGrant2025/AaveV3Ethereum_EventsGrant2025_20250612.t.sol -vv
 */
contract AaveV3Ethereum_EventsGrant2025_20250612_Test is ProtocolV3TestBase {
  AaveV3Ethereum_EventsGrant2025_20250612 internal proposal;

  address public constant AAVE_LABS = 0x1c037b3C22240048807cC9d7111be5d455F640bd;
  uint256 public constant GHO_GRANT_AMOUNT = 750_000 ether;
  IERC20 public constant GHO_TOKEN = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22689071);
    proposal = new AaveV3Ethereum_EventsGrant2025_20250612();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_EventsGrant2025_20250612', AaveV3Ethereum.POOL, address(proposal));
  }

  function testProposalExecution() public {
    uint256 ALGHOBalanceBefore = GHO_TOKEN.balanceOf(AAVE_LABS);
    uint256 CollectorV3GHOBalanceBefore = GHO_TOKEN.balanceOf(address(AaveV3Ethereum.COLLECTOR));

    executePayload(vm, address(proposal));

    assertEq(GHO_TOKEN.balanceOf(AAVE_LABS), ALGHOBalanceBefore + GHO_GRANT_AMOUNT);
    assertEq(
      GHO_TOKEN.balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      CollectorV3GHOBalanceBefore - GHO_GRANT_AMOUNT
    );
  }
}
