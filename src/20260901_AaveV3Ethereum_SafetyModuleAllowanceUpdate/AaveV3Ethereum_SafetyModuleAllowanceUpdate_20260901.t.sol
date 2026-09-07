// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_SafetyModuleAllowanceUpdate_20260901} from './AaveV3Ethereum_SafetyModuleAllowanceUpdate_20260901.sol';

/**
 * @dev Test for AaveV3Ethereum_SafetyModuleAllowanceUpdate_20260901
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260901_AaveV3Ethereum_SafetyModuleAllowanceUpdate/AaveV3Ethereum_SafetyModuleAllowanceUpdate_20260901.t.sol -vv
 */
contract AaveV3Ethereum_SafetyModuleAllowanceUpdate_20260901_Test is ProtocolV3TestBase {
  AaveV3Ethereum_SafetyModuleAllowanceUpdate_20260901 internal proposal;

  // stkAAVE stakers with pending rewards at the fork block, jointly exceeding the current allowance
  address[8] internal stkAaveClaimers = [
    0xc1ae9Aa84fDaa2511139a6Bc65FDD2c6Dc5Ccbd3,
    0xdC0990910F47aD479020eD77B0d62BF738C2791a,
    0x3E312eDdAaEd13db65178a8036a8b715f645A746,
    0x54a1Bec1DF929dCE9ce385856493e76D986359B2,
    0xE26a0B67F05A7DC632aaAfc625CaBB24a2029A03,
    0x6A4DB4B375592a1Fa59aF7579D8Aba8A46513402,
    0x144F2822bcA1D5E51D4C00e5B9cB7bBab0717512,
    0x507B3F6d4f85c451f7914006C647391a1Afb96D6
  ];

  // holders with pending rewards on each sunset module at the fork block
  address internal constant STK_ABPT_CLAIMER = 0xcf27ec0AE6F3C4AFf868b2A19F8dad58CdC8730c;
  address internal constant STK_GHO_CLAIMER = 0xa02A67966Ef2BFf32A225374EC71fDF7B2a6f9Ae;
  address internal constant STK_AAVE_WSTETH_BPTV2_CLAIMER =
    0xa19ed0aE46e89461e56063f1eD268a0dc225745f;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25880238);
    proposal = new AaveV3Ethereum_SafetyModuleAllowanceUpdate_20260901();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_SafetyModuleAllowanceUpdate_20260901',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_emissionPerSecondUnchanged() public {
    uint256 emissionPerDay = 150 ether;
    (uint128 emissionBefore, , ) = IStakeToken(AaveSafetyModule.STK_AAVE).assets(
      AaveSafetyModule.STK_AAVE
    );
    assertEq(
      uint256(emissionBefore),
      emissionPerDay / 1 days,
      'stkAAVE emission should be 150 AAVE per day before execution'
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    (uint128 emissionAfter, , ) = IStakeToken(AaveSafetyModule.STK_AAVE).assets(
      AaveSafetyModule.STK_AAVE
    );
    assertEq(
      uint256(emissionAfter),
      emissionPerDay / 1 days,
      'stkAAVE emission should remain 150 AAVE per day after execution'
    );
  }

  function test_stkAaveAllowanceUpdated() public {
    (uint128 emissionPerSecond, , ) = IStakeToken(AaveSafetyModule.STK_AAVE).assets(
      AaveSafetyModule.STK_AAVE
    );
    uint256 allowanceBefore = _allowanceOf(AaveSafetyModule.STK_AAVE);

    GovV3Helpers.executePayload(vm, address(proposal));

    uint256 expected = allowanceBefore +
      proposal.STK_AAVE_BACKLOG_GAP() +
      uint256(emissionPerSecond) *
      (block.timestamp - proposal.SNAPSHOT_TIMESTAMP() + proposal.FORWARD_EMISSIONS_PERIOD());
    uint256 allowanceAfter = _allowanceOf(AaveSafetyModule.STK_AAVE);
    assertEq(
      allowanceAfter,
      expected,
      'stkAAVE allowance should cover the backlog plus 90 days of emissions'
    );
    assertApproxEqAbs(
      allowanceAfter,
      68_487.44 ether,
      1 ether,
      'stkAAVE allowance should match the forum-projected total at the fork block'
    );
    assertGe(
      allowanceAfter,
      55_042.63 ether,
      'stkAAVE allowance should cover the forum-stated claimable backlog'
    );
  }

  function test_sunsetModuleAllowancesUpdated() public {
    assertApproxEqAbs(
      _allowanceOf(AaveSafetyModule.STK_ABPT),
      923.54 ether,
      0.01 ether,
      'stkABPT v1 allowance should match the forum snapshot before execution'
    );
    assertApproxEqAbs(
      _allowanceOf(AaveSafetyModule.STK_GHO),
      1_190.87 ether,
      0.01 ether,
      'stkGHO allowance should match the forum snapshot before execution'
    );
    assertApproxEqAbs(
      _allowanceOf(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2),
      16_878.48 ether,
      2 ether,
      'stkAAVEwstETHBPTv2 allowance should match the forum snapshot before execution'
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    assertEq(
      _allowanceOf(AaveSafetyModule.STK_ABPT),
      proposal.STK_ABPT_V1_ABSOLUTE_ALLOWANCE(),
      'stkABPT v1 allowance should be 1250 AAVE'
    );
    assertEq(
      _allowanceOf(AaveSafetyModule.STK_GHO),
      proposal.STK_GHO_ABSOLUTE_ALLOWANCE(),
      'stkGHO allowance should be 1200 AAVE'
    );
    assertEq(
      _allowanceOf(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2),
      proposal.STK_AAVE_WSTETH_BPTV2_ABSOLUTE_ALLOWANCE(),
      'stkAAVEwstETHBPTv2 allowance should be 2500 AAVE'
    );
  }

  function test_stkAaveLargeClaimsRevertBeforeSucceedAfter() public {
    uint256 snap = vm.snapshotState();

    bool reverted;
    for (uint256 i = 0; i < stkAaveClaimers.length; i++) {
      vm.prank(stkAaveClaimers[i]);
      try
        IStakeToken(AaveSafetyModule.STK_AAVE).claimRewards(stkAaveClaimers[i], type(uint256).max)
      {} catch {
        reverted = true;
        break;
      }
    }
    assertTrue(reverted, 'claims should exhaust the current allowance and revert');

    vm.revertToState(snap);
    GovV3Helpers.executePayload(vm, address(proposal));

    for (uint256 i = 0; i < stkAaveClaimers.length; i++) {
      _assertClaimSucceeds(AaveSafetyModule.STK_AAVE, stkAaveClaimers[i]);
    }
  }

  function test_sunsetModuleClaimsSucceedAfterUpdate() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    _assertClaimSucceeds(AaveSafetyModule.STK_ABPT, STK_ABPT_CLAIMER);
    _assertClaimSucceeds(AaveSafetyModule.STK_GHO, STK_GHO_CLAIMER);
    _assertClaimSucceeds(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2, STK_AAVE_WSTETH_BPTV2_CLAIMER);
  }

  function _assertClaimSucceeds(address module, address claimer) internal {
    uint256 balanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(claimer);
    vm.prank(claimer);
    IStakeToken(module).claimRewards(claimer, type(uint256).max);
    assertGt(
      IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(claimer),
      balanceBefore,
      'claimer should receive AAVE rewards after the allowance update'
    );
  }

  function _allowanceOf(address module) internal view returns (uint256) {
    return
      IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
        MiscEthereum.ECOSYSTEM_RESERVE,
        module
      );
  }
}
