// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Mantle} from 'aave-address-book/AaveV3Mantle.sol';
import {GovernanceV3Mantle} from 'aave-address-book/GovernanceV3Mantle.sol';
import {MiscMantle} from 'aave-address-book/MiscMantle.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Mantle_AaveV36MantleActivation_20260117} from './AaveV3Mantle_AaveV36MantleActivation_20260117.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @dev Test for AaveV3Mantle_AaveV36MantleActivation_20260117
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260117_AaveV3Mantle_AaveV36MantleActivation/AaveV3Mantle_AaveV36MantleActivation_20260117.t.sol -vv
 */
contract AaveV3Mantle_AaveV36MantleActivation_20260117_Test is ProtocolV3TestBase {
  AaveV3Mantle_AaveV36MantleActivation_20260117 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mantle'), 91075558);
    proposal = new AaveV3Mantle_AaveV36MantleActivation_20260117();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Mantle_AaveV36MantleActivation_20260117',
      AaveV3Mantle.POOL,
      address(proposal),
      false, // e2e
      false
    );
  }

  function test_dustBinHasFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    _validateDustbinFundsAndLMAdmin(proposal.WETH(), 0.0025e18);
    _validateDustbinFundsAndLMAdmin(proposal.WMNT(), 10e18);
    _validateDustbinFundsAndLMAdmin(proposal.USDT0(), 10e6);
    _validateDustbinFundsAndLMAdmin(proposal.USDC(), 10e6);
    _validateDustbinFundsAndLMAdmin(proposal.USDe(), 10e18);
    _validateDustbinFundsAndLMAdmin(proposal.sUSDe(), 10e18);
    _validateDustbinFundsAndLMAdmin(proposal.FBTC(), 0.0005e8);
    _validateDustbinFundsAndLMAdmin(proposal.syrupUSDT(), 10e6);
    _validateDustbinFundsAndLMAdmin(proposal.wrsETH(), 0.0025e18);
    _validateDustbinFundsAndLMAdmin(proposal.GHO(), 10e18);
  }

  function test_guardianPoolAdmin() public {
    assertFalse(AaveV3Mantle.ACL_MANAGER.isPoolAdmin(MiscMantle.PROTOCOL_GUARDIAN));
    executePayload(vm, address(proposal));
    assertTrue(AaveV3Mantle.ACL_MANAGER.isPoolAdmin(MiscMantle.PROTOCOL_GUARDIAN));
  }

  function test_riskStewardRiskAdmin() public {
    assertFalse(AaveV3Mantle.ACL_MANAGER.isRiskAdmin(AaveV3Mantle.RISK_STEWARD));
    executePayload(vm, address(proposal));
    assertTrue(AaveV3Mantle.ACL_MANAGER.isRiskAdmin(AaveV3Mantle.RISK_STEWARD));
  }

  function test_eMode_sanity() public {
    executePayload(vm, address(proposal));

    address user = address(505);
    deal(proposal.sUSDe(), user, 10e18);
    vm.startPrank(user);

    // e2e pool operations
    AaveV3Mantle.POOL.setUserEMode(1); // enter sUSDe Stablecoins
    IERC20(proposal.sUSDe()).approve(address(AaveV3Mantle.POOL), 10e18);
    AaveV3Mantle.POOL.supply(proposal.sUSDe(), 10e18, user, 0);
    AaveV3Mantle.POOL.borrow(proposal.USDT0(), 9e6, 2, 0, user);

    IERC20(proposal.USDT0()).approve(address(AaveV3Mantle.POOL), 4e6);
    AaveV3Mantle.POOL.repay(proposal.USDT0(), 4e6, 2, user);
    AaveV3Mantle.POOL.withdraw(proposal.sUSDe(), 5e18, user);
  }

  function _validateDustbinFundsAndLMAdmin(address asset, uint256 seedAmount) internal view {
    (address aToken, , ) = AaveV3Mantle.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      asset
    );
    assertGe(IERC20(aToken).balanceOf(address(AaveV3Mantle.DUST_BIN)), seedAmount);

    assertEq(
      IEmissionManager(AaveV3Mantle.EMISSION_MANAGER).getEmissionAdmin(asset),
      proposal.LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Mantle.EMISSION_MANAGER).getEmissionAdmin(aToken),
      proposal.LM_ADMIN()
    );
  }
}
