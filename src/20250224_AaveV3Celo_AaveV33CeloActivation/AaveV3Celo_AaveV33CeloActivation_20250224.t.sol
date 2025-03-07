// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Celo} from 'aave-address-book/AaveV3Celo.sol';
import {MiscCelo} from 'aave-address-book/MiscCelo.sol';
import {GovernanceV3Celo} from 'aave-address-book/GovernanceV3Celo.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Celo_AaveV33CeloActivation_20250224, IEmissionManager} from './AaveV3Celo_AaveV33CeloActivation_20250224.sol';

/**
 * @dev Test for AaveV3Celo_AaveV33CeloActivation_20250224
 * command: FOUNDRY_PROFILE=celo forge test --match-path=src/20250224_AaveV3Celo_AaveV33CeloActivation/AaveV3Celo_AaveV33CeloActivation_20250224.t.sol -vv
 */
contract AaveV3Celo_AaveV33CeloActivation_20250224_Test is ProtocolV3TestBase {
  AaveV3Celo_AaveV33CeloActivation_20250224 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('celo'), 30734047);
    proposal = new AaveV3Celo_AaveV33CeloActivation_20250224();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Celo_AaveV33CeloActivation_20250224',
      AaveV3Celo.POOL,
      address(proposal),
      false
    );
  }

  function test_dustbinHasFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    _validateDustbinFundsAndLMAdmin(proposal.USDC(), proposal.USDC_SEED_AMOUNT());
    _validateDustbinFundsAndLMAdmin(proposal.USDT(), proposal.USDT_SEED_AMOUNT());
    _validateDustbinFundsAndLMAdmin(proposal.CELO(), proposal.CELO_SEED_AMOUNT());
    _validateDustbinFundsAndLMAdmin(proposal.cEUR(), proposal.cEUR_SEED_AMOUNT());
    _validateDustbinFundsAndLMAdmin(proposal.cUSD(), proposal.cUSD_SEED_AMOUNT());
  }

  function test_guardianPoolAdmin() public {
    assertFalse(AaveV3Celo.ACL_MANAGER.isPoolAdmin(MiscCelo.PROTOCOL_GUARDIAN));
    executePayload(vm, address(proposal));
    assertTrue(AaveV3Celo.ACL_MANAGER.isPoolAdmin(MiscCelo.PROTOCOL_GUARDIAN));
  }

  function test_riskStewardRiskAdmin() public {
    assertFalse(AaveV3Celo.ACL_MANAGER.isRiskAdmin(AaveV3Celo.RISK_STEWARD));
    executePayload(vm, address(proposal));
    assertTrue(AaveV3Celo.ACL_MANAGER.isRiskAdmin(AaveV3Celo.RISK_STEWARD));
  }

  function _validateDustbinFundsAndLMAdmin(address asset, uint256 seedAmount) internal view {
    (address aToken, , ) = AaveV3Celo.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(asset);
    assertGe(IERC20(aToken).balanceOf(address(AaveV3Celo.DUST_BIN)), seedAmount);

    assertEq(
      IEmissionManager(AaveV3Celo.EMISSION_MANAGER).getEmissionAdmin(asset),
      proposal.LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Celo.EMISSION_MANAGER).getEmissionAdmin(aToken),
      proposal.LM_ADMIN()
    );
  }
}
