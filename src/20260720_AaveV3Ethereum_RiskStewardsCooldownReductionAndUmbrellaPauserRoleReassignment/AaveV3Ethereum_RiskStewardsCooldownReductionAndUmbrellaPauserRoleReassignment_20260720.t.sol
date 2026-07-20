// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {UmbrellaEthereum, UmbrellaEthereumAssets} from 'aave-address-book/UmbrellaEthereum.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IRiskSteward} from '../interfaces/IRiskSteward.sol';
import {AaveV3Ethereum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720} from './AaveV3Ethereum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol';

interface IPausable {
  function paused() external view returns (bool);
}

/**
 * @dev Test for AaveV3Ethereum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260720_AaveV3Ethereum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Ethereum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol -vv
 */
contract AaveV3Ethereum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720
    internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25572588);
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
    IRiskSteward riskSteward = IRiskSteward(AaveV3Ethereum.RISK_STEWARD);
    IRiskSteward.Config memory beforeConfig = riskSteward.getRiskConfig();

    assertEq(beforeConfig.rateConfig.baseVariableBorrowRate.minDelay, 72 hours);
    assertEq(beforeConfig.rateConfig.variableRateSlope1.minDelay, 72 hours);
    assertEq(beforeConfig.rateConfig.variableRateSlope2.minDelay, 72 hours);
    assertEq(beforeConfig.rateConfig.optimalUsageRatio.minDelay, 72 hours);
    assertEq(beforeConfig.capConfig.supplyCap.minDelay, 72 hours);
    assertEq(beforeConfig.capConfig.borrowCap.minDelay, 72 hours);

    executePayload(vm, address(proposal), AaveV3Ethereum.POOL);

    IRiskSteward.Config memory afterConfig = riskSteward.getRiskConfig();
    uint40 newMinDelay = proposal.NEW_MIN_DELAY();

    assertEq(afterConfig.rateConfig.baseVariableBorrowRate.minDelay, newMinDelay);
    assertEq(afterConfig.rateConfig.variableRateSlope1.minDelay, newMinDelay);
    assertEq(afterConfig.rateConfig.variableRateSlope2.minDelay, newMinDelay);
    assertEq(afterConfig.rateConfig.optimalUsageRatio.minDelay, newMinDelay);
    assertEq(afterConfig.capConfig.supplyCap.minDelay, newMinDelay);
    assertEq(afterConfig.capConfig.borrowCap.minDelay, newMinDelay);

    assertEq(
      afterConfig.rateConfig.baseVariableBorrowRate.maxPercentChange,
      beforeConfig.rateConfig.baseVariableBorrowRate.maxPercentChange
    );
    assertEq(
      afterConfig.rateConfig.variableRateSlope1.maxPercentChange,
      beforeConfig.rateConfig.variableRateSlope1.maxPercentChange
    );
    assertEq(
      afterConfig.rateConfig.variableRateSlope2.maxPercentChange,
      beforeConfig.rateConfig.variableRateSlope2.maxPercentChange
    );
    assertEq(
      afterConfig.rateConfig.optimalUsageRatio.maxPercentChange,
      beforeConfig.rateConfig.optimalUsageRatio.maxPercentChange
    );
    assertEq(
      afterConfig.capConfig.supplyCap.maxPercentChange,
      beforeConfig.capConfig.supplyCap.maxPercentChange
    );
    assertEq(
      afterConfig.capConfig.borrowCap.maxPercentChange,
      beforeConfig.capConfig.borrowCap.maxPercentChange
    );

    assertEq(
      keccak256(abi.encode(afterConfig.collateralConfig)),
      keccak256(abi.encode(beforeConfig.collateralConfig))
    );
    assertEq(
      keccak256(abi.encode(afterConfig.eModeConfig)),
      keccak256(abi.encode(beforeConfig.eModeConfig))
    );
    assertEq(
      keccak256(abi.encode(afterConfig.priceCapConfig)),
      keccak256(abi.encode(beforeConfig.priceCapConfig))
    );
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
