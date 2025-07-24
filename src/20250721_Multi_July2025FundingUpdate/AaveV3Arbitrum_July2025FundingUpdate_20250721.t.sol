// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {ArbSysMock} from 'aave-helpers/tests/bridges/arbitrum/ArbSysMock.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Arbitrum_July2025FundingUpdate_20250721} from './AaveV3Arbitrum_July2025FundingUpdate_20250721.sol';

/**
 * @dev Test for AaveV3Arbitrum_July2025FundingUpdate_20250721
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250721_Multi_July2025FundingUpdate/AaveV3Arbitrum_July2025FundingUpdate_20250721.t.sol -vv
 */
contract AaveV3Arbitrum_July2025FundingUpdate_20250721_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_July2025FundingUpdate_20250721 internal proposal;

  event Bridge(address indexed token, uint256 amount);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 360806785);
    proposal = new AaveV3Arbitrum_July2025FundingUpdate_20250721();

    ArbSysMock arbsys = new ArbSysMock();
    vm.etch(address(0x0000000000000000000000000000000000000064), address(arbsys).code);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_July2025FundingUpdate_20250721',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_bridges() public {
    uint256 daiCollectorBalanceBefore = IERC20(AaveV3ArbitrumAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );

    uint256 usdcCollectorBalanceBefore = IERC20(AaveV3ArbitrumAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );

    assertGt(daiCollectorBalanceBefore, 0);
    assertGt(usdcCollectorBalanceBefore, 0);

    vm.expectEmit(true, true, true, true, MiscArbitrum.AAVE_ARB_ETH_BRIDGE);
    emit Bridge(AaveV3ArbitrumAssets.DAI_UNDERLYING, daiCollectorBalanceBefore);
    vm.expectEmit(true, true, true, true, MiscArbitrum.AAVE_ARB_ETH_BRIDGE);
    emit Bridge(AaveV3ArbitrumAssets.USDC_UNDERLYING, usdcCollectorBalanceBefore);

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3ArbitrumAssets.DAI_UNDERLYING).balanceOf(address(AaveV3Arbitrum.COLLECTOR)),
      0
    );

    assertEq(
      IERC20(AaveV3ArbitrumAssets.USDC_UNDERLYING).balanceOf(address(AaveV3Arbitrum.COLLECTOR)),
      0
    );
  }
}
