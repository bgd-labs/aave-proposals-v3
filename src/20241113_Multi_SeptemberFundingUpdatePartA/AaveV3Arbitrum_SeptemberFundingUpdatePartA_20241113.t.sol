// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';

import 'forge-std/Test.sol';
import {stdStorage, StdStorage} from 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_SeptemberFundingUpdatePartA_20241113} from './AaveV3Arbitrum_SeptemberFundingUpdatePartA_20241113.sol';

contract GatewayMock {
  function outboundTransfer(address, address, uint256, bytes calldata) external {}
}

/**
 * @dev Test for AaveV3Arbitrum_SeptemberFundingUpdatePartA_20241113
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20241113_Multi_SeptemberFundingUpdatePartA/AaveV3Arbitrum_SeptemberFundingUpdatePartA_20241113.t.sol -vv
 */
contract AaveV3Arbitrum_SeptemberFundingUpdatePartA_20241113_Test is ProtocolV3TestBase {
  using stdStorage for StdStorage;

  event Bridge(address indexed token, uint256 amount);

  AaveV3Arbitrum_SeptemberFundingUpdatePartA_20241113 internal proposal;

  address internal COLLECTOR = address(AaveV3Arbitrum.COLLECTOR);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 274046247);
    proposal = new AaveV3Arbitrum_SeptemberFundingUpdatePartA_20241113();

    GatewayMock mock = new GatewayMock();
    vm.etch(proposal.USDC_GATEWAY(), address(mock).code);
    vm.etch(proposal.LUSD_GATEWAY(), address(mock).code);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_SeptemberFundingUpdatePartA_20241113',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_bridgeUSDC() public {
    uint256 collectorAUsdcBalanceBefore = IERC20(AaveV3ArbitrumAssets.USDC_A_TOKEN).balanceOf(
      COLLECTOR
    );

    vm.expectEmit(true, false, false, true, address(proposal.BRIDGE()));
    emit Bridge(AaveV3ArbitrumAssets.USDC_UNDERLYING, collectorAUsdcBalanceBefore - 100e6);
    executePayload(vm, address(proposal));

    uint256 collectorAUsdcBalanceAfter = IERC20(AaveV3ArbitrumAssets.USDC_A_TOKEN).balanceOf(
      COLLECTOR
    );

    assertApproxEqAbs(collectorAUsdcBalanceAfter, 100e6, 5_000e6);
  }

  function test_bridgeLUSD() public {
    uint256 collectorALusdBalanceBefore = IERC20(AaveV3ArbitrumAssets.LUSD_A_TOKEN).balanceOf(
      COLLECTOR
    );

    vm.expectEmit(true, false, false, true, address(proposal.BRIDGE()));
    emit Bridge(AaveV3ArbitrumAssets.LUSD_UNDERLYING, collectorALusdBalanceBefore - 1e18);
    executePayload(vm, address(proposal));

    uint256 collectorALusdBalanceAfter = IERC20(AaveV3ArbitrumAssets.LUSD_A_TOKEN).balanceOf(
      COLLECTOR
    );

    assertApproxEqAbs(collectorALusdBalanceAfter, 1e18, 2_000e18);
  }
}
