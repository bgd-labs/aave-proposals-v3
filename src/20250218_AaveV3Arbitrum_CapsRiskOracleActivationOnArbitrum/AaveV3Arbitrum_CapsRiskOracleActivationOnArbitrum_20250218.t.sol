// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AutomationCompatibleInterface} from './interfaces/AutomationCompatibleInterface.sol';
import {IRiskSteward} from './interfaces/IRiskSteward.sol';
import {IRiskOracle} from './interfaces/IRiskOracle.sol';
import {IAaveStewardInjector} from './interfaces/IAaveStewardInjector.sol';
import {ArbSys} from './interfaces/ArbSys.sol';
import {AaveV3Arbitrum_CapsRiskOracleActivationOnArbitrum_20250218} from './AaveV3Arbitrum_CapsRiskOracleActivationOnArbitrum_20250218.sol';

/**
 * @dev Test for AaveV3Arbitrum_CapsRiskOracleActivationOnArbitrum_20250218
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20250218_AaveV3Arbitrum_CapsRiskOracleActivationOnArbitrum/AaveV3Arbitrum_CapsRiskOracleActivationOnArbitrum_20250218.t.sol -vv
 */
contract AaveV3Arbitrum_CapsRiskOracleActivationOnArbitrum_20250218_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_CapsRiskOracleActivationOnArbitrum_20250218 internal proposal;
  event KeeperRegistered(uint256 indexed id, address indexed upkeep, uint96 indexed amount);

  address public constant ARB_SYS = 0x0000000000000000000000000000000000000064;
  address public constant RISK_ORACLE_OWNER = 0x42939e82DF15afc586bb95f7dD69Afb6Dc24A6f9;
  IRiskOracle public RISK_ORACLE;

  function setUp() public {
    uint256 blockNumber = 307265279;
    vm.createSelectFork(vm.rpcUrl('arbitrum'), blockNumber);
    proposal = new AaveV3Arbitrum_CapsRiskOracleActivationOnArbitrum_20250218();
    RISK_ORACLE = IRiskOracle(IAaveStewardInjector(proposal.AAVE_STEWARD_INJECTOR()).RISK_ORACLE());

    // https://github.com/foundry-rs/foundry/issues/5085
    vm.mockCall(
      ARB_SYS,
      abi.encodeWithSelector(ArbSys.arbBlockNumber.selector),
      abi.encode(blockNumber)
    );
    vm.mockCall(
      ARB_SYS,
      abi.encodeWithSelector(ArbSys.arbBlockHash.selector, blockNumber - 1),
      abi.encode(0xbe6f5dfa9ce3324bd677f5195ecd8d1a258cbf3800f24621d0e0d2724224704f)
    );
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_CapsRiskOracleActivationOnArbitrum_20250218',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_permissions() public {
    assertEq(AaveV3Arbitrum.ACL_MANAGER.isRiskAdmin(proposal.EDGE_RISK_STEWARD()), false);
    executePayload(vm, address(proposal));

    assertEq(AaveV3Arbitrum.ACL_MANAGER.isRiskAdmin(proposal.EDGE_RISK_STEWARD()), true);
    assertEq(
      IRiskSteward(proposal.EDGE_RISK_STEWARD()).RISK_COUNCIL(),
      proposal.AAVE_STEWARD_INJECTOR()
    );
  }

  function test_robotRegistered() public {
    vm.expectEmit(false, true, true, true);
    emit KeeperRegistered(
      uint256(0),
      proposal.AAVE_STEWARD_INJECTOR(),
      uint96(proposal.LINK_AMOUNT())
    );
    executePayload(vm, address(proposal));
  }

  function test_injectUpdateToProtocol() public {
    executePayload(vm, address(proposal));
    (, uint256 supplyCap) = AaveV3Arbitrum.AAVE_PROTOCOL_DATA_PROVIDER.getReserveCaps(
      AaveV3ArbitrumAssets.WETH_UNDERLYING
    );
    uint256 supplyCapToSet = (supplyCap * 130) / 100; // increase caps by 30%

    _addUpdateToRiskOracle(supplyCapToSet);

    (bool upkeepNeeded, bytes memory performData) = AutomationCompatibleInterface(
      proposal.AAVE_STEWARD_INJECTOR()
    ).checkUpkeep('');
    assertTrue(upkeepNeeded);

    AutomationCompatibleInterface(proposal.AAVE_STEWARD_INJECTOR()).performUpkeep(performData);

    (, uint256 currentSupplyCap) = AaveV3Arbitrum.AAVE_PROTOCOL_DATA_PROVIDER.getReserveCaps(
      AaveV3ArbitrumAssets.WETH_UNDERLYING
    );
    assertEq(supplyCapToSet, currentSupplyCap);
  }

  function _addUpdateToRiskOracle(uint256 value) internal {
    vm.startPrank(RISK_ORACLE_OWNER);
    RISK_ORACLE.publishRiskParameterUpdate(
      'referenceId',
      abi.encodePacked(value * 1e18),
      'supplyCap',
      address(AaveV3ArbitrumAssets.WETH_A_TOKEN),
      'additionalData'
    );
    vm.stopPrank();
  }
}
