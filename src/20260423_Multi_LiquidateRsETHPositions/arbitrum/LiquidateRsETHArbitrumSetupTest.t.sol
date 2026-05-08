// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IPool} from 'aave-address-book/AaveV3.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {GovV3Helpers, IPayloadsControllerCore} from 'aave-helpers/src/GovV3Helpers.sol';
import {LiquidateRsETHArbitrumSetup} from './LiquidateRsETHArbitrumSetup.sol';
import {LiquidateRsETHPositionsSetupTest} from '../setup/LiquidateRsETHPositionsSetupTest.t.sol';
import {LiquidateRsETHConstants} from '../setup/LiquidateRsETHConstants.sol';

abstract contract LiquidateRsETHArbitrumSetupTest is LiquidateRsETHPositionsSetupTest {
  using SafeERC20 for IERC20;

  function _setupFork() internal override {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 457933433);
  }

  function _executor() internal pure override returns (address) {
    return GovernanceV3Arbitrum.EXECUTOR_LVL_1;
  }

  function test_pool_matchesAddressBook() public view {
    assertEq(address(proposal.POOL()), address(AaveV3Arbitrum.POOL));
  }

  function test_oracle_matchesAddressBook() public view {
    assertEq(address(proposal.ORACLE()), address(AaveV3Arbitrum.ORACLE));
  }

  function test_poolConfigurator_matchesAddressBook() public view {
    assertEq(address(proposal.POOL_CONFIGURATOR()), address(AaveV3Arbitrum.POOL_CONFIGURATOR));
  }

  function test_collector_matchesAddressBook() public view {
    assertEq(address(proposal.COLLECTOR()), address(AaveV3Arbitrum.COLLECTOR));
  }

  function test_rsEth_matchesAddressBook() public view {
    assertEq(proposal.RSETH(), AaveV3ArbitrumAssets.rsETH_UNDERLYING);
  }

  function test_weth_matchesAddressBook() public view {
    assertEq(proposal.WETH(), AaveV3ArbitrumAssets.WETH_UNDERLYING);
  }

  function test_wsteth_matchesAddressBook() public view {
    assertEq(proposal.WSTETH(), AaveV3ArbitrumAssets.wstETH_UNDERLYING);
  }

  function test_recoveryGuardian_matches() public view {
    assertEq(proposal.RECOVERY_GUARDIAN(), LiquidateRsETHConstants.ARB_RECOVERY_GUARDIAN);
  }

  function test_fixedPriceFeed_matches() public view {
    assertEq(proposal.FIXED_PRICE_FEED(), LiquidateRsETHConstants.ARB_FIXED_PRICE_FEED);
  }

  function test_guardianEnabledFlag_matches() public view {
    assertEq(proposal.GUARDIAN_ENABLED_FLAG(), LiquidateRsETHConstants.ARB_GUARDIAN_ENABLED_FLAG);
  }

  function test_umbrellaAddressSetToGuardianPostAip() public {
    address recoveryGuardian = _recoveryGuardian();
    executePayload(vm, address(proposal));
    assertEq(
      _pool().ADDRESSES_PROVIDER().getAddress(bytes32('UMBRELLA')),
      recoveryGuardian,
      'UMBRELLA addresses-provider slot != recovery guardian post-AIP'
    );
  }

  function test_umbrellaAddressSetIsNoopWhenAlreadySet() public {
    address recoveryGuardian = _recoveryGuardian();
    vm.startPrank(_executor());
    _pool().ADDRESSES_PROVIDER().setAddress(bytes32('UMBRELLA'), recoveryGuardian);
    vm.stopPrank();

    assertEq(_pool().ADDRESSES_PROVIDER().getAddress(bytes32('UMBRELLA')), recoveryGuardian);

    executePayload(vm, address(proposal));

    assertEq(
      _pool().ADDRESSES_PROVIDER().getAddress(bytes32('UMBRELLA')),
      recoveryGuardian,
      'UMBRELLA slot not preserved when already set'
    );
  }

  function test_umbrellaAddressSetWhenAlreadySetToNonGuardian() public {
    address recoveryGuardian = _recoveryGuardian();
    address nonGuardian = makeAddr('non-guardian');
    vm.startPrank(_executor());
    _pool().ADDRESSES_PROVIDER().setAddress(bytes32('UMBRELLA'), nonGuardian);
    vm.stopPrank();

    assertEq(_pool().ADDRESSES_PROVIDER().getAddress(bytes32('UMBRELLA')), nonGuardian);

    executePayload(vm, address(proposal));

    assertEq(
      _pool().ADDRESSES_PROVIDER().getAddress(bytes32('UMBRELLA')),
      recoveryGuardian,
      'UMBRELLA slot not overwritten with recovery guardian'
    );
  }

  function test_eliminateWethDeficitAfterProposal() public {
    IPool pool = _pool();
    address weth = _weth();
    address recoveryGuardian = _recoveryGuardian();
    uint256 deficitBefore = pool.getReserveDeficit(weth);

    executePayload(vm, address(proposal));

    uint256 deficitNew = pool.getReserveDeficit(weth) - deficitBefore;
    if (deficitNew == 0) {
      return;
    }

    assertEq(
      pool.ADDRESSES_PROVIDER().getAddress(bytes32('UMBRELLA')),
      recoveryGuardian,
      'AIP did not result in UMBRELLA = recovery guardian'
    );

    _fundGuardianWithAToken(weth, deficitNew);

    vm.prank(recoveryGuardian);
    pool.eliminateReserveDeficit(weth, deficitNew);

    assertEq(pool.getReserveDeficit(weth), deficitBefore, 'pool deficit not back to pre-AIP level');

    e2eTest(pool);
  }
}
