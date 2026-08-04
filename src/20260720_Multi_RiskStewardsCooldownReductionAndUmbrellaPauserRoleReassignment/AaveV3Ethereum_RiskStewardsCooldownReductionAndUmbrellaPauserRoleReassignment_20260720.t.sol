// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {UmbrellaEthereum, UmbrellaEthereumAssets} from 'aave-address-book/UmbrellaEthereum.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';

import 'forge-std/Test.sol';
import {RiskStewardCooldownReductionBaseTest} from './RiskStewardCooldownReductionBaseTest.sol';
import {AaveV3Ethereum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720} from './AaveV3Ethereum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol';

interface IPausable {
  function paused() external view returns (bool);
}

/**
 * @dev Test for AaveV3Ethereum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Ethereum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol -vv
 */
contract AaveV3Ethereum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720_Test is
  RiskStewardCooldownReductionBaseTest
{
  AaveV3Ethereum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720
    internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25680707);
    proposal = new AaveV3Ethereum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_riskStewardConfig() public {
    _testRiskStewardConfig(address(proposal), AaveV3Ethereum.POOL, AaveV3Ethereum.RISK_STEWARD);
  }

  function test_umbrellaPauseGuardianRole() public {
    IAccessControl umbrellaAccessControl = IAccessControl(address(UmbrellaEthereum.UMBRELLA));
    bytes32 pauseGuardianRole = proposal.PAUSE_GUARDIAN_ROLE();

    assertFalse(umbrellaAccessControl.hasRole(pauseGuardianRole, MiscEthereum.PROTOCOL_GUARDIAN));
    assertTrue(
      umbrellaAccessControl.hasRole(pauseGuardianRole, GovernanceV3Ethereum.EXECUTOR_LVL_1)
    );

    executePayload(vm, address(proposal), AaveV3Ethereum.POOL);

    assertTrue(umbrellaAccessControl.hasRole(pauseGuardianRole, MiscEthereum.PROTOCOL_GUARDIAN));
    assertTrue(
      umbrellaAccessControl.hasRole(pauseGuardianRole, GovernanceV3Ethereum.EXECUTOR_LVL_1)
    );

    address[] memory stakeTokens = UmbrellaEthereum.UMBRELLA.getStkTokens();
    assertEq(stakeTokens.length, 4);
    assertEq(stakeTokens[0], UmbrellaEthereumAssets.STK_WA_USDC_V1);
    assertEq(stakeTokens[1], UmbrellaEthereumAssets.STK_WA_USDT_V1);
    assertEq(stakeTokens[2], UmbrellaEthereumAssets.STK_WA_WETH_V1);
    assertEq(stakeTokens[3], UmbrellaEthereumAssets.STK_GHO_V1);

    vm.startPrank(MiscEthereum.PROTOCOL_GUARDIAN);
    for (uint256 i; i < stakeTokens.length; ++i) {
      assertFalse(IPausable(stakeTokens[i]).paused());
      UmbrellaEthereum.UMBRELLA.pauseStk(stakeTokens[i]);
      assertTrue(IPausable(stakeTokens[i]).paused());
      UmbrellaEthereum.UMBRELLA.unpauseStk(stakeTokens[i]);
      assertFalse(IPausable(stakeTokens[i]).paused());
    }
    vm.stopPrank();
  }
}
