// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Mantle} from 'aave-address-book/AaveV3Mantle.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Mantle_AaveV36MantleActivation_20260117} from './AaveV3Mantle_AaveV36MantleActivation_20260117.sol';

/**
 * @dev Test for AaveV3Mantle_AaveV36MantleActivation_20260117
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260117_AaveV3Mantle_AaveV36MantleActivation/AaveV3Mantle_AaveV36MantleActivation_20260117.t.sol -vv
 */
contract AaveV3Mantle_AaveV36MantleActivation_20260117_Test is ProtocolV3TestBase {
  AaveV3Mantle_AaveV36MantleActivation_20260117 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mantle'), 90260247);
    proposal = new AaveV3Mantle_AaveV36MantleActivation_20260117();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Mantle_AaveV36MantleActivation_20260117',
      AaveV3Mantle.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasWETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Mantle.POOL.getReserveAToken(proposal.WETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Mantle.DUST_BIN)), 10 ** 18);
  }

  function test_dustBinHasWMNTFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Mantle.POOL.getReserveAToken(proposal.WMNT());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Mantle.DUST_BIN)), 10 ** 18);
  }

  function test_dustBinHasUSDT0Funds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Mantle.POOL.getReserveAToken(proposal.USDT0());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Mantle.DUST_BIN)), 10 ** 6);
  }

  function test_dustBinHasUSDCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Mantle.POOL.getReserveAToken(proposal.USDC());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Mantle.DUST_BIN)), 10 ** 6);
  }

  function test_dustBinHasUSDeFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Mantle.POOL.getReserveAToken(proposal.USDe());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Mantle.DUST_BIN)), 10 ** 18);
  }

  function test_dustBinHassUSDeFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Mantle.POOL.getReserveAToken(proposal.sUSDe());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Mantle.DUST_BIN)), 10 ** 18);
  }

  function test_dustBinHasFBTCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Mantle.POOL.getReserveAToken(proposal.FBTC());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Mantle.DUST_BIN)), 10 ** 8);
  }

  function test_dustBinHassyrupUSDTFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Mantle.POOL.getReserveAToken(proposal.syrupUSDT());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Mantle.DUST_BIN)), 10 ** 6);
  }

  function test_dustBinHaswrsETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Mantle.POOL.getReserveAToken(proposal.wrsETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Mantle.DUST_BIN)), 10 ** 18);
  }
}
