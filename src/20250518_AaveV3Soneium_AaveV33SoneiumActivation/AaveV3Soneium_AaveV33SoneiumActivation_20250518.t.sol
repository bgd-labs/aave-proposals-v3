// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Soneium} from 'aave-address-book/AaveV3Soneium.sol';
import {MiscSoneium} from 'aave-address-book/MiscSoneium.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Soneium_AaveV33SoneiumActivation_20250518} from './AaveV3Soneium_AaveV33SoneiumActivation_20250518.sol';

/**
 * @dev Test for AaveV3Soneium_AaveV33SoneiumActivation_20250518
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250518_AaveV3Soneium_AaveV33SoneiumActivation/AaveV3Soneium_AaveV33SoneiumActivation_20250518.t.sol -vv
 */
contract AaveV3Soneium_AaveV33SoneiumActivation_20250518_Test is ProtocolV3TestBase {
  AaveV3Soneium_AaveV33SoneiumActivation_20250518 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('soneium'), 7218882);
    proposal = new AaveV3Soneium_AaveV33SoneiumActivation_20250518();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Soneium_AaveV33SoneiumActivation_20250518',
      AaveV3Soneium.POOL,
      address(proposal)
    );
  }

  function test_collectorHasFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    _validateCollectorFundsAndLMAdmin(proposal.USDCe(), proposal.USDCe_SEED_AMOUNT());
    _validateCollectorFundsAndLMAdmin(proposal.USDT(), proposal.USDT_SEED_AMOUNT());
    _validateCollectorFundsAndLMAdmin(proposal.WETH(), proposal.WETH_SEED_AMOUNT());
  }

  function test_guardianPoolAdmin() public {
    assertFalse(AaveV3Soneium.ACL_MANAGER.isPoolAdmin(MiscSoneium.PROTOCOL_GUARDIAN));
    executePayload(vm, address(proposal));
    assertTrue(AaveV3Soneium.ACL_MANAGER.isPoolAdmin(MiscSoneium.PROTOCOL_GUARDIAN));
  }

  function test_riskStewardRiskAdmin() public {
    assertFalse(AaveV3Soneium.ACL_MANAGER.isRiskAdmin(AaveV3Soneium.RISK_STEWARD));
    executePayload(vm, address(proposal));
    assertTrue(AaveV3Soneium.ACL_MANAGER.isRiskAdmin(AaveV3Soneium.RISK_STEWARD));
  }

  function _validateCollectorFundsAndLMAdmin(address asset, uint256 seedAmount) internal view {
    (address aToken, , ) = AaveV3Soneium.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      asset
    );
    assertGe(IERC20(aToken).balanceOf(address(AaveV3Soneium.DUST_BIN)), seedAmount);

    assertEq(
      IEmissionManager(AaveV3Soneium.EMISSION_MANAGER).getEmissionAdmin(asset),
      proposal.LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Soneium.EMISSION_MANAGER).getEmissionAdmin(aToken),
      proposal.LM_ADMIN()
    );
  }
}
