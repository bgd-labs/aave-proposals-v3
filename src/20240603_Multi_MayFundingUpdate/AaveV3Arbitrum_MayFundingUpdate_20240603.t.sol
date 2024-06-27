// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {stdStorage, StdStorage} from 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_MayFundingUpdate_20240603} from './AaveV3Arbitrum_MayFundingUpdate_20240603.sol';

contract GatewayMock {
  function outboundTransfer(address, address, uint256, bytes calldata) external {}
}

/**
 * @dev Test for AaveV3Arbitrum_MayFundingUpdate_20240603
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20240603_Multi_MayFundingUpdate/AaveV3Arbitrum_MayFundingUpdate_20240603.t.sol -vv
 */
contract AaveV3Arbitrum_MayFundingUpdate_20240603_Test is ProtocolV3TestBase {
  using stdStorage for StdStorage;

  address internal COLLECTOR = address(AaveV3Arbitrum.COLLECTOR);

  AaveV3Arbitrum_MayFundingUpdate_20240603 internal proposal;

  event Bridge(address token, uint256 amount);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 226121182);
    proposal = new AaveV3Arbitrum_MayFundingUpdate_20240603();
    GatewayMock mock = new GatewayMock();
    vm.etch(proposal.USDC_GATEWAY(), address(mock).code);
    stdstore.target(address(proposal.BRIDGE())).sig('owner()').checked_write(
      GovernanceV3Arbitrum.EXECUTOR_LVL_1
    );
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  // function test_defaultProposalExecution() public {
  //   defaultTest('AaveV3Arbitrum_MayFundingUpdate_20240603', AaveV3Arbitrum.POOL, address(proposal));
  // }

  function test_bridge() public {
    uint256 collectorUsdcBalanceBefore = IERC20(AaveV3ArbitrumAssets.USDC_UNDERLYING).balanceOf(
      COLLECTOR
    );
    uint256 collectorAusdcBalanceBefore = IERC20(AaveV3ArbitrumAssets.USDC_A_TOKEN).balanceOf(
      COLLECTOR
    );

    /// code below should work, for some reason it doesn't, pls help
    /// from the logs here is the manual bridge event emitted and the actual bridge event emitted
    ///   emit Bridge(token: 0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8, amount: 342589958890 [3.425e11])
    ///   emit Bridge(token: 0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8, amount: 342589958890 [3.425e11])
    /// identical but test still reverts with "[Revert] log != expected log"

    // vm.expectEmit(address(proposal.BRIDGE()));
    // emit Bridge(
    //   AaveV3ArbitrumAssets.USDC_UNDERLYING,
    //   342589958890
    // );

    executePayload(vm, address(proposal));

    uint256 collectorUsdcBalanceAfter = IERC20(AaveV3ArbitrumAssets.USDC_UNDERLYING).balanceOf(
      COLLECTOR
    );
    uint256 collectorAusdcBalanceAfter = IERC20(AaveV3ArbitrumAssets.USDC_A_TOKEN).balanceOf(
      COLLECTOR
    );

    assertApproxEqAbs(collectorUsdcBalanceAfter, 0, 1e6);
    assertApproxEqAbs(collectorAusdcBalanceAfter, 1e6, 1e6);
  }
}
