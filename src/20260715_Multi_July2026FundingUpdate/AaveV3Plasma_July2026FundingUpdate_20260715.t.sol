// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Plasma, AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';
import {MiscPlasma} from 'aave-address-book/MiscPlasma.sol';
import {PercentageMath} from 'aave-v3-origin/contracts/protocol/libraries/math/PercentageMath.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Plasma_July2026FundingUpdate_20260715} from './AaveV3Plasma_July2026FundingUpdate_20260715.sol';

/**
 * @dev Test for AaveV3Plasma_July2026FundingUpdate_20260715
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260715_Multi_July2026FundingUpdate/AaveV3Plasma_July2026FundingUpdate_20260715.t.sol -vv
 */
contract AaveV3Plasma_July2026FundingUpdate_20260715_Test is ProtocolV3TestBase {
  using PercentageMath for uint256;

  AaveV3Plasma_July2026FundingUpdate_20260715 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('plasma'), 27178593);
    proposal = new AaveV3Plasma_July2026FundingUpdate_20260715();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Plasma_July2026FundingUpdate_20260715',
      AaveV3Plasma.POOL,
      address(proposal)
    );
  }

  /**
   * @dev checks whether reserve configurations changed or stayed unchanged as expected
   */
  function test_reserveConfigChanges() public {
    address[] memory updatedAssets = new address[](0);

    reserveConfigChangesTest(AaveV3Plasma.POOL, address(proposal), updatedAssets);
  }

  function test_approvals_ptSusde9Apr2026() public {
    _assertFullBalanceApproval(AaveV3PlasmaAssets.PT_sUSDE_9APR2026_A_TOKEN);
  }

  function test_approvals_ptUsde15Jan2026() public {
    _assertFullBalanceApproval(AaveV3PlasmaAssets.PT_USDe_15JAN2026_A_TOKEN);
  }

  function test_approvals_ptSusde18Jun2026() public {
    _assertFullBalanceApproval(AaveV3PlasmaAssets.PT_sUSDE_18JUN2026_A_TOKEN);
  }

  function test_approvals_ptSusde15Jan2026() public {
    _assertFullBalanceApproval(AaveV3PlasmaAssets.PT_sUSDE_15JAN2026_A_TOKEN);
  }

  function test_approvals_ptUsde9Apr2026() public {
    _assertFullBalanceApproval(AaveV3PlasmaAssets.PT_USDe_9APR2026_A_TOKEN);
  }

  function test_approvals_ptUsde18Jun2026() public {
    _assertFullBalanceApproval(AaveV3PlasmaAssets.PT_USDe_18JUN2026_A_TOKEN);
  }

  function test_approvals_weth() public {
    _assertFullBalanceApproval(AaveV3PlasmaAssets.WETH_A_TOKEN);
  }

  function test_approvals_weEth() public {
    _assertFullBalanceApproval(AaveV3PlasmaAssets.weETH_A_TOKEN);
  }

  function test_approvals_usde() public {
    _assertFullBalanceApproval(AaveV3PlasmaAssets.sUSDe_A_TOKEN);
  }

  function test_approvals_usdt() public {
    uint256 afcAllowanceBefore = IERC20(AaveV3PlasmaAssets.USDT0_A_TOKEN).allowance(
      address(AaveV3Plasma.COLLECTOR),
      MiscPlasma.AFC_SAFE
    );
    assertGt(afcAllowanceBefore, 0);

    uint256 ahabAllowanceBefore = IERC20(AaveV3PlasmaAssets.USDT0_A_TOKEN).allowance(
      address(AaveV3Plasma.COLLECTOR),
      proposal.AHAB_SAFE()
    );
    assertGt(ahabAllowanceBefore, 0);

    executePayload(vm, address(proposal));

    // The AFC safe allowance is cleared out.
    uint256 afcAllowanceAfter = IERC20(AaveV3PlasmaAssets.USDT0_A_TOKEN).allowance(
      address(AaveV3Plasma.COLLECTOR),
      MiscPlasma.AFC_SAFE
    );
    assertEq(afcAllowanceAfter, 0);

    uint256 ahabAllowanceAfter = IERC20(AaveV3PlasmaAssets.USDT0_A_TOKEN).allowance(
      address(AaveV3Plasma.COLLECTOR),
      proposal.AHAB_SAFE()
    );
    assertEq(ahabAllowanceAfter, proposal.USDT_ALLOWANCE());
  }

  /**
   * @dev the collector approves the AFC safe for its full aToken balance plus a buffer covering
   *      interest accrued between execution and transfer, so the resulting allowance must equal
   *      the collector's balance scaled by that buffer (approvals move no tokens).
   */
  function _assertFullBalanceApproval(address aToken) internal {
    uint256 collectorBalance = IERC20(aToken).balanceOf(address(AaveV3Plasma.COLLECTOR));

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(aToken).allowance(
      address(AaveV3Plasma.COLLECTOR),
      MiscPlasma.AFC_SAFE
    );
    assertEq(allowanceAfter, collectorBalance.percentMul(proposal.ALLOWANCE_BUFFER_PERCENT()));
  }
}
