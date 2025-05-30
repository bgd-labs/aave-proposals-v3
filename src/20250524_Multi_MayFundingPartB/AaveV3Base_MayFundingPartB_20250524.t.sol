// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Base_MayFundingPartB_20250524} from './AaveV3Base_MayFundingPartB_20250524.sol';

/**
 * @dev Test for AaveV3Base_MayFundingPartB_20250524
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250524_Multi_MayFundingPartB/AaveV3Base_MayFundingPartB_20250524.t.sol -vv
 */
contract AaveV3Base_MayFundingPartB_20250524_Test is ProtocolV3TestBase {
  AaveV3Base_MayFundingPartB_20250524 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 30647717);
    proposal = new AaveV3Base_MayFundingPartB_20250524();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Base_MayFundingPartB_20250524', AaveV3Base.POOL, address(proposal));
  }

  function test_approvals() public {
    assertEq(
      IERC20(AaveV3BaseAssets.USDC_A_TOKEN).allowance(
        address(AaveV3Base.COLLECTOR),
        proposal.AFC_SAFE()
      ),
      0
    );

    assertEq(
      IERC20(AaveV3BaseAssets.cbBTC_A_TOKEN).allowance(
        address(AaveV3Base.COLLECTOR),
        proposal.AFC_SAFE()
      ),
      0
    );

    assertEq(
      IERC20(AaveV3BaseAssets.USDbC_A_TOKEN).allowance(
        address(AaveV3Base.COLLECTOR),
        proposal.AFC_SAFE()
      ),
      0
    );

    uint256 balanceUsdcBefore = IERC20(AaveV3BaseAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Base.COLLECTOR)
    );

    uint256 balanceCbBtcBefore = IERC20(AaveV3BaseAssets.cbBTC_A_TOKEN).balanceOf(
      address(AaveV3Base.COLLECTOR)
    );

    uint256 balanceUsdBcBefore = IERC20(AaveV3BaseAssets.USDbC_A_TOKEN).balanceOf(
      address(AaveV3Base.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    uint256 allowanceUsdcAfter = IERC20(AaveV3BaseAssets.USDC_A_TOKEN).allowance(
      address(AaveV3Base.COLLECTOR),
      proposal.AFC_SAFE()
    );

    uint256 allowanceCbBtcAfter = IERC20(AaveV3BaseAssets.cbBTC_A_TOKEN).allowance(
      address(AaveV3Base.COLLECTOR),
      proposal.AFC_SAFE()
    );

    uint256 allowanceUsdBcAfter = IERC20(AaveV3BaseAssets.USDbC_A_TOKEN).allowance(
      address(AaveV3Base.COLLECTOR),
      proposal.AFC_SAFE()
    );

    assertEq(allowanceUsdcAfter, balanceUsdcBefore);
    assertEq(allowanceCbBtcAfter, balanceCbBtcBefore);
    assertEq(allowanceUsdBcAfter, balanceUsdBcBefore);

    vm.startPrank(proposal.AFC_SAFE());
    IERC20(AaveV3BaseAssets.USDC_A_TOKEN).transferFrom(
      address(AaveV3Base.COLLECTOR),
      proposal.AFC_SAFE(),
      allowanceUsdcAfter
    );

    IERC20(AaveV3BaseAssets.cbBTC_A_TOKEN).transferFrom(
      address(AaveV3Base.COLLECTOR),
      proposal.AFC_SAFE(),
      allowanceCbBtcAfter
    );

    IERC20(AaveV3BaseAssets.USDbC_A_TOKEN).transferFrom(
      address(AaveV3Base.COLLECTOR),
      proposal.AFC_SAFE(),
      allowanceUsdBcAfter
    );
    vm.stopPrank();
  }
}
