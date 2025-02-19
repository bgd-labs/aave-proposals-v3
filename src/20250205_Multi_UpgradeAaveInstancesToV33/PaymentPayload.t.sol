// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {PaymentPayload} from './PaymentPayload.sol';

/**
 * @dev Test for AaveV3Ethereum_UpdateUSDSGHOBorrowRate_20250203
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250205_Multi_UpgradeAaveInstancesToV33/PaymentPayload.t.sol -vv
 */
contract AaveV3Ethereum_PaymentPayload_Test is ProtocolV3TestBase {
  PaymentPayload internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21767442);
    proposal = new PaymentPayload();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    uint256 balanceAUSDCBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      proposal.BGD()
    );
    defaultTest('AaveV3Ethereum_PaymentPayload', AaveV3Ethereum.POOL, address(proposal));
    uint256 balanceAUSDCAfter = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(proposal.BGD());
    assertApproxEqAbs(balanceAUSDCAfter - balanceAUSDCBefore, proposal.AMOUNT(), 1);
  }
}
