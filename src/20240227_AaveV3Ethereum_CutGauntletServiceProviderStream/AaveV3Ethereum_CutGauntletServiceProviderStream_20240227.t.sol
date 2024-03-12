// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_CutGauntletServiceProviderStream_20240227} from './AaveV3Ethereum_CutGauntletServiceProviderStream_20240227.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @dev Test for AaveV3Ethereum_CutGauntletServiceProviderStream_20240227
 * command: make test-contract filter=AaveV3Ethereum_CutGauntletServiceProviderStream_20240227
 */
contract AaveV3Ethereum_CutGauntletServiceProviderStream_20240227_Test is ProtocolV3TestBase {
  AaveV3Ethereum_CutGauntletServiceProviderStream_20240227 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19319345);
    proposal = new AaveV3Ethereum_CutGauntletServiceProviderStream_20240227();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    address GAUNTLET_RECIPIENT = proposal.GAUNTLET_RECIPIENT();
    uint256 COLLECTOR_aUSDT_STREAM = proposal.COLLECTOR_aUSDT_STREAM();
    uint256 COLLECTOR_GHO_STREAM = proposal.COLLECTOR_GHO_STREAM();

    (, address recipient, , address tokenAddress, , , , ) = AaveV2Ethereum.COLLECTOR.getStream(
      COLLECTOR_aUSDT_STREAM
    );

    assertEq(recipient, GAUNTLET_RECIPIENT);
    assertEq(tokenAddress, AaveV2EthereumAssets.USDT_A_TOKEN);

    (, recipient, , tokenAddress, , , , ) = AaveV2Ethereum.COLLECTOR.getStream(
      COLLECTOR_GHO_STREAM
    );

    assertEq(recipient, GAUNTLET_RECIPIENT);
    assertEq(tokenAddress, AaveV3EthereumAssets.GHO_UNDERLYING);

    uint256 claimableAusdt = AaveV2Ethereum.COLLECTOR.balanceOf(
      COLLECTOR_aUSDT_STREAM,
      GAUNTLET_RECIPIENT
    );

    uint256 claimableGho = AaveV2Ethereum.COLLECTOR.balanceOf(
      COLLECTOR_GHO_STREAM,
      GAUNTLET_RECIPIENT
    );

    uint256 ausdtBalanceBefore = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      GAUNTLET_RECIPIENT
    );
    uint256 ghoBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      GAUNTLET_RECIPIENT
    );

    defaultTest(
      'AaveV3Ethereum_CutGauntletServiceProviderStream_20240227',
      AaveV3Ethereum.POOL,
      address(proposal),
      false
    );

    vm.expectRevert('stream does not exist');
    AaveV2Ethereum.COLLECTOR.getStream(COLLECTOR_aUSDT_STREAM);

    vm.expectRevert('stream does not exist');
    AaveV2Ethereum.COLLECTOR.getStream(COLLECTOR_GHO_STREAM);

    uint256 ausdtBalanceAfter = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      GAUNTLET_RECIPIENT
    );
    uint256 ghoBalanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      GAUNTLET_RECIPIENT
    );

    assertEq(ausdtBalanceAfter, ausdtBalanceBefore + claimableAusdt);
    assertEq(ghoBalanceAfter, ghoBalanceBefore + claimableGho);
  }
}
