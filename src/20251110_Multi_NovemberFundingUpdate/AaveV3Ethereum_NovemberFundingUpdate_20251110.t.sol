// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_NovemberFundingUpdate_20251110} from './AaveV3Ethereum_NovemberFundingUpdate_20251110.sol';

/**
 * @dev Test for AaveV3Ethereum_NovemberFundingUpdate_20251110
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251110_Multi_NovemberFundingUpdate/AaveV3Ethereum_NovemberFundingUpdate_20251110.t.sol -vv
 */
contract AaveV3Ethereum_NovemberFundingUpdate_20251110_Test is ProtocolV3TestBase {
  AaveV3Ethereum_NovemberFundingUpdate_20251110 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23770613);
    proposal = new AaveV3Ethereum_NovemberFundingUpdate_20251110();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_NovemberFundingUpdate_20251110',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_runway() public {
    uint256 allowanceSyndBefore = IERC20(proposal.SYND()).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE
    );
    uint256 allowanceSpkBefore = IERC20(proposal.SPK()).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE
    );
    uint256 allowanceSafeBefore = IERC20(proposal.SAFE()).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE
    );
    uint256 allowancePolBefore = IERC20(proposal.POL()).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE
    );
    assertEq(allowanceSyndBefore, 0);
    assertEq(allowanceSpkBefore, 0);
    assertEq(allowanceSafeBefore, 0);
    assertEq(allowancePolBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceSyndAfter = IERC20(proposal.SYND()).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE
    );
    uint256 allowanceSpkAfter = IERC20(proposal.SPK()).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE
    );
    uint256 allowanceSafeAfter = IERC20(proposal.SAFE()).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE
    );
    uint256 allowancePolAfter = IERC20(proposal.POL()).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE
    );

    assertEq(allowanceSyndAfter, allowanceSyndBefore + proposal.SYND_APPROVAL_AMOUNT());
    assertGt(allowanceSpkAfter, allowanceSpkBefore);
    assertGt(allowanceSafeAfter, allowanceSafeBefore);
    assertGt(allowancePolAfter, allowancePolBefore);

    vm.startPrank(MiscEthereum.AFC_SAFE);
    IERC20(proposal.SYND()).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE,
      proposal.SYND_APPROVAL_AMOUNT()
    );

    IERC20(proposal.SPK()).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE,
      IERC20(proposal.SPK()).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );

    IERC20(proposal.SAFE()).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE,
      IERC20(proposal.SAFE()).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );

    IERC20(proposal.POL()).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE,
      IERC20(proposal.POL()).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );
    vm.stopPrank();
  }

  function test_v4Audits() public {
    uint256 allowanceBefore = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AUDITS_SAFE()
    );
    assertEq(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AUDITS_SAFE()
    );

    assertEq(allowanceAfter, allowanceBefore + proposal.AUDITS_GHO_AMOUNT());
  }

  function test_merit() public {
    uint256 allowanceBefore = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.MERIT_AHAB_SAFE
    );
    assertEq(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.MERIT_AHAB_SAFE
    );

    assertEq(allowanceAfter, allowanceBefore + proposal.MERIT_GHO_AMOUNT());
  }

  function test_reimbursements() public {
    uint256 allowanceBefore = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.TOKEN_LOGIC()
    );
    assertEq(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.TOKEN_LOGIC()
    );

    assertEq(allowanceAfter, allowanceBefore + proposal.REIMBURSEMENTS_GHO_AMOUNT());
  }

  function test_ecosystemReserve() public {}

  function test_swapPaths() public {}
}
