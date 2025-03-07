// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Sonic} from 'aave-address-book/AaveV3Sonic.sol';
import {MiscSonic} from 'aave-address-book/MiscSonic.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Sonic_AaveV33SonicActivation_20250217, IEmissionManager} from './AaveV3Sonic_AaveV33SonicActivation_20250217.sol';

/**
 * @dev Test for AaveV3Sonic_AaveV33SonicActivation_20250217
 * command: FOUNDRY_PROFILE=sonic forge test --match-path=src/20250217_AaveV3Sonic_AaveV33SonicActivation/AaveV3Sonic_AaveV33SonicActivation_20250217.t.sol -vv
 */
contract AaveV3Sonic_AaveV33SonicActivation_20250217_Test is ProtocolV3TestBase {
  AaveV3Sonic_AaveV33SonicActivation_20250217 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('sonic'), 8641675);
    proposal = new AaveV3Sonic_AaveV33SonicActivation_20250217();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Sonic_AaveV33SonicActivation_20250217', AaveV3Sonic.POOL, address(proposal));
  }

  function test_collectorHasFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    _validateCollectorFundsAndLMAdmin(proposal.WETH(), proposal.WETH_SEED_AMOUNT());
    _validateCollectorFundsAndLMAdmin(proposal.USDC(), proposal.USDC_SEED_AMOUNT());
    _validateCollectorFundsAndLMAdmin(proposal.wS(), proposal.wS_SEED_AMOUNT());
  }

  function test_guardianPoolAdmin() public {
    assertFalse(AaveV3Sonic.ACL_MANAGER.isPoolAdmin(MiscSonic.PROTOCOL_GUARDIAN));
    executePayload(vm, address(proposal));
    assertTrue(AaveV3Sonic.ACL_MANAGER.isPoolAdmin(MiscSonic.PROTOCOL_GUARDIAN));
  }

  function test_riskStewardRiskAdmin() public {
    assertFalse(AaveV3Sonic.ACL_MANAGER.isRiskAdmin(AaveV3Sonic.RISK_STEWARD));
    executePayload(vm, address(proposal));
    assertTrue(AaveV3Sonic.ACL_MANAGER.isRiskAdmin(AaveV3Sonic.RISK_STEWARD));
  }

  function _validateCollectorFundsAndLMAdmin(address asset, uint256 seedAmount) internal view {
    (address aToken, , ) = AaveV3Sonic.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(asset);
    assertGe(IERC20(aToken).balanceOf(address(AaveV3Sonic.COLLECTOR)), seedAmount);

    assertEq(
      IEmissionManager(AaveV3Sonic.EMISSION_MANAGER).getEmissionAdmin(asset),
      proposal.LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Sonic.EMISSION_MANAGER).getEmissionAdmin(aToken),
      proposal.LM_ADMIN()
    );
  }
}
