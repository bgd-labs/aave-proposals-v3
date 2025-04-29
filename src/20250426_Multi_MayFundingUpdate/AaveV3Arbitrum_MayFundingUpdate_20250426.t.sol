// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {ArbSysMock} from 'aave-helpers/tests/bridges/arbitrum/ArbSysMock.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_MayFundingUpdate_20250426} from './AaveV3Arbitrum_MayFundingUpdate_20250426.sol';

/**
 * @dev Test for AaveV3Arbitrum_MayFundingUpdate_20250426
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20250426_Multi_MayFundingUpdate/AaveV3Arbitrum_MayFundingUpdate_20250426.t.sol -vv
 */
contract AaveV3Arbitrum_MayFundingUpdate_20250426_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_MayFundingUpdate_20250426 internal proposal;

  event Bridge(address indexed token, uint256 amount);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 331207896);
    proposal = new AaveV3Arbitrum_MayFundingUpdate_20250426();

    ArbSysMock arbsys = new ArbSysMock();
    vm.etch(address(0x0000000000000000000000000000000000000064), address(arbsys).code);
  }

  function test_Bridges() public {
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

    uint256 daiCollectorBalanceAfter = IERC20(AaveV3ArbitrumAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );

    uint256 usdcCollectorBalanceAfter = IERC20(AaveV3ArbitrumAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );

    assertEq(daiCollectorBalanceAfter, 0);
    assertEq(usdcCollectorBalanceAfter, 0);
  }
}
