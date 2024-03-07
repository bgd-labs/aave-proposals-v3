// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_MeritApprovals_20240306} from './AaveV3Ethereum_MeritApprovals_20240306.sol';

/**
 * @dev Test for AaveV3Ethereum_MeritApprovals_20240306
 * command: make test-contract filter=AaveV3Ethereum_MeritApprovals_20240306
 */
contract AaveV3Ethereum_MeritApprovals_20240306_Test is ProtocolV3TestBase {
  AaveV3Ethereum_MeritApprovals_20240306 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19377425);
    proposal = new AaveV3Ethereum_MeritApprovals_20240306();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.MERIT_WALLET()
      ),
      0
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.MERIT_WALLET()
      ),
      0
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.MERIT_WALLET()
      ),
      proposal.GHO_ALLOWANCE()
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.MERIT_WALLET()
      ),
      proposal.WETH_V3_ALLOWANCE()
    );

    vm.startPrank(proposal.MERIT_WALLET());
    IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.MERIT_WALLET(),
      2_000_000 ether
    );
    IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.MERIT_WALLET(),
      500 ether
    );
  }
}
