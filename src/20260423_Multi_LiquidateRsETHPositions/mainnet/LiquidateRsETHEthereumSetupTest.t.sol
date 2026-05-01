// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {ReserveConfiguration} from 'aave-v3-origin/contracts/protocol/libraries/configuration/ReserveConfiguration.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';
import {WadRayMath} from 'aave-v3-origin/contracts/protocol/libraries/math/WadRayMath.sol';
import {IScaledBalanceToken} from 'aave-v3-origin/contracts/interfaces/IScaledBalanceToken.sol';

import {IPool, IPoolConfigurator} from 'aave-address-book/AaveV3.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {UmbrellaEthereum} from 'aave-address-book/UmbrellaEthereum.sol';
import {GovV3Helpers, IPayloadsControllerCore} from 'aave-helpers/src/GovV3Helpers.sol';

import {IPausable} from '../../interfaces/IPausable.sol';

import {LiquidateRsETHPositionsSetupTest} from '../setup/LiquidateRsETHPositionsSetupTest.t.sol';
import {LiquidateRsETHConstants} from '../setup/LiquidateRsETHConstants.sol';

abstract contract LiquidateRsETHEthereumSetupTest is LiquidateRsETHPositionsSetupTest {
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;
  using SafeERC20 for IERC20;
  using WadRayMath for uint256;

  bytes32 internal constant DEFAULT_ADMIN_ROLE = 0x00;
  bytes32 internal constant COVERAGE_MANAGER_ROLE = keccak256('COVERAGE_MANAGER_ROLE');
  bytes32 internal constant PAUSE_GUARDIAN_ROLE = keccak256('PAUSE_GUARDIAN_ROLE');

  function _setupFork() internal override {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24993134);
  }

  function _executor() internal pure override returns (address) {
    return GovernanceV3Ethereum.EXECUTOR_LVL_1;
  }

  function test_staticWethDebt() public {
    address vWeth = _vDebtTokenOf(_weth());
    assertEq(
      proposal.wethScaledDebt(),
      IScaledBalanceToken(vWeth).scaledBalanceOf(user),
      'wethScaledDebt != user scaled debt'
    );
    assertEq(_wethStaticDebt(), IERC20(vWeth).balanceOf(user), 'staticWethDebt != vWeth.balanceOf');
  }

  /// @dev WETH deficit offset grows by `staticWethDebt = scaledHardcoded × index`.
  function test_wethOffsetIncreasedByStaticWethDebt() public {
    address weth = _weth();
    uint256 staticDebt = _wethStaticDebt();
    uint256 offsetBefore = UmbrellaEthereum.UMBRELLA.getDeficitOffset(weth);

    executePayload(vm, address(proposal));

    uint256 offsetIncrease = UmbrellaEthereum.UMBRELLA.getDeficitOffset(weth) - offsetBefore;
    assertEq(offsetIncrease, staticDebt, 'WETH offset increase != static');
  }

  /// @dev WETH should remain non-slashable before and after execution.
  function test_wethNotSlashableBeforeAndAfter() public {
    (bool slashableBefore, ) = UmbrellaEthereum.UMBRELLA.isReserveSlashable(_weth());
    assertFalse(slashableBefore, 'WETH is slashable before proposal');

    executePayload(vm, address(proposal));

    (bool slashableAfter, ) = UmbrellaEthereum.UMBRELLA.isReserveSlashable(_weth());
    assertFalse(slashableAfter, 'WETH became slashable after proposal');
  }

  /// @dev Preemptive WETH offset increase can only grow headroom; never shrinks it.
  function test_wethDistanceFromSlashingDoesNotShrink() public {
    uint256 distanceBefore = _wethSlashingHeadroom();
    executePayload(vm, address(proposal));
    uint256 distanceAfter = _wethSlashingHeadroom();
    assertGe(distanceAfter, distanceBefore, 'slashing headroom shrank');
  }

  function test_nonWethUmbrellaOffsetUnchangedPostAip() public {
    address[] memory reserves = _pool().getReservesList();
    uint256 n = reserves.length;
    uint256[] memory offsetsBefore = new uint256[](n);
    for (uint256 i; i < n; ++i) {
      offsetsBefore[i] = UmbrellaEthereum.UMBRELLA.getDeficitOffset(reserves[i]);
    }

    executePayload(vm, address(proposal));

    address weth = _weth();
    for (uint256 i; i < n; ++i) {
      if (reserves[i] == weth) {
        continue;
      }
      uint256 offsetAfter = UmbrellaEthereum.UMBRELLA.getDeficitOffset(reserves[i]);
      assertEq(offsetAfter, offsetsBefore[i], 'non-WETH umbrella offset moved');
    }
  }

  function test_pool_matchesAddressBook() public view {
    assertEq(address(proposal.POOL()), address(AaveV3Ethereum.POOL));
  }

  function test_oracle_matchesAddressBook() public view {
    assertEq(address(proposal.ORACLE()), address(AaveV3Ethereum.ORACLE));
  }

  function test_poolConfigurator_matchesAddressBook() public view {
    assertEq(address(proposal.POOL_CONFIGURATOR()), address(AaveV3Ethereum.POOL_CONFIGURATOR));
  }

  function test_collector_matchesAddressBook() public view {
    assertEq(address(proposal.COLLECTOR()), address(AaveV3Ethereum.COLLECTOR));
  }

  function test_rsEth_matchesAddressBook() public view {
    assertEq(proposal.RSETH(), AaveV3EthereumAssets.rsETH_UNDERLYING);
  }

  function test_weth_matchesAddressBook() public view {
    assertEq(proposal.WETH(), AaveV3EthereumAssets.WETH_UNDERLYING);
  }

  function test_recoveryGuardian_matches() public view {
    assertEq(proposal.RECOVERY_GUARDIAN(), LiquidateRsETHConstants.ETH_RECOVERY_GUARDIAN);
  }

  function test_fixedPriceFeed_matches() public view {
    assertEq(proposal.FIXED_PRICE_FEED(), LiquidateRsETHConstants.ETH_FIXED_PRICE_FEED);
  }

  function test_guardianEnabledFlag_matches() public view {
    assertEq(proposal.GUARDIAN_ENABLED_FLAG(), LiquidateRsETHConstants.ETH_GUARDIAN_ENABLED_FLAG);
  }

  function test_wsteth() public view {
    assertEq(proposal.WSTETH(), AaveV3EthereumAssets.wstETH_UNDERLYING);
  }

  function test_guardianHasDefaultAdminRolePostAip() public {
    executePayload(vm, address(proposal));
    assertTrue(
      IAccessControl(address(UmbrellaEthereum.UMBRELLA)).hasRole(
        DEFAULT_ADMIN_ROLE,
        _recoveryGuardian()
      ),
      'guardian missing DEFAULT_ADMIN_ROLE'
    );
  }

  function test_grantingDefaultAdminRoleIsNoopWhenAlreadyHeld() public {
    address guardian = _recoveryGuardian();
    address admin = AaveV3Ethereum.ACL_ADMIN;
    vm.prank(admin);
    IAccessControl(address(UmbrellaEthereum.UMBRELLA)).grantRole(DEFAULT_ADMIN_ROLE, guardian);
    assertTrue(
      IAccessControl(address(UmbrellaEthereum.UMBRELLA)).hasRole(DEFAULT_ADMIN_ROLE, guardian),
      'precondition: guardian must already hold role'
    );

    executePayload(vm, address(proposal));

    assertTrue(
      IAccessControl(address(UmbrellaEthereum.UMBRELLA)).hasRole(DEFAULT_ADMIN_ROLE, guardian),
      'guardian role lost when already held'
    );
  }

  /// @dev Guardian increases the deficit offset of every reserve
  /// backed by an Umbrella stk token, both before and after pausing the stk.
  /// Pause must not lock the offset path.
  function test_guardianCanIncreaseDeficitOffsetPostAip() public {
    executePayload(vm, address(proposal));

    address[] memory stks = UmbrellaEthereum.UMBRELLA.getStkTokens();
    assertGt(stks.length, 0, 'no stk tokens to test');

    vm.startPrank(_recoveryGuardian());
    IAccessControl(address(UmbrellaEthereum.UMBRELLA)).grantRole(
      PAUSE_GUARDIAN_ROLE,
      _recoveryGuardian()
    );

    for (uint256 i; i < stks.length; ++i) {
      address reserve = UmbrellaEthereum.UMBRELLA.getStakeTokenData(stks[i]).reserve;

      uint256 offsetBefore = UmbrellaEthereum.UMBRELLA.getDeficitOffset(reserve);
      UmbrellaEthereum.UMBRELLA.setDeficitOffset(reserve, offsetBefore + 1 ether);
      assertEq(
        UmbrellaEthereum.UMBRELLA.getDeficitOffset(reserve),
        offsetBefore + 1 ether,
        'offset not increased pre-pause'
      );

      UmbrellaEthereum.UMBRELLA.pauseStk(stks[i]);

      // offset deficit can be increased post-pause
      uint256 offsetAfterPause = UmbrellaEthereum.UMBRELLA.getDeficitOffset(reserve);
      UmbrellaEthereum.UMBRELLA.setDeficitOffset(reserve, offsetAfterPause + 1 ether);
      assertEq(
        UmbrellaEthereum.UMBRELLA.getDeficitOffset(reserve),
        offsetAfterPause + 1 ether,
        'offset not increased post-pause'
      );
    }
    vm.stopPrank();
  }

  /// @dev Guardian self-grants `COVERAGE_MANAGER_ROLE`, supplies aWETH, and
  /// calls `coverDeficitOffset` to absorb AIP deficit.
  function test_guardianCanSelfGrantAndCoverDeficitOffset() public {
    executePayload(vm, address(proposal));
    address weth = _weth();
    uint256 aipDeficit = _pool().getReserveDeficit(weth);

    vm.startPrank(_recoveryGuardian());
    IAccessControl(address(UmbrellaEthereum.UMBRELLA)).grantRole(
      COVERAGE_MANAGER_ROLE,
      _recoveryGuardian()
    );
    vm.stopPrank();

    _fundGuardianWithAToken(weth, aipDeficit);

    vm.startPrank(_recoveryGuardian());
    IERC20(_aTokenOf(weth)).approve(address(UmbrellaEthereum.UMBRELLA), aipDeficit);
    uint256 covered = UmbrellaEthereum.UMBRELLA.coverDeficitOffset(weth, aipDeficit);
    vm.stopPrank();

    assertEq(covered, aipDeficit, 'not all deficit covered');
  }

  /// @dev Guardian self-grants `PAUSE_GUARDIAN_ROLE`, then pauses + unpauses
  /// every Umbrella stk token.
  function test_guardianCanPauseAndUnpauseAllStkTokens() public {
    executePayload(vm, address(proposal));

    vm.startPrank(_recoveryGuardian());
    IAccessControl(address(UmbrellaEthereum.UMBRELLA)).grantRole(
      PAUSE_GUARDIAN_ROLE,
      _recoveryGuardian()
    );

    address[] memory stks = UmbrellaEthereum.UMBRELLA.getStkTokens();
    assertGt(stks.length, 0, 'no stk tokens to test');

    for (uint256 i; i < stks.length; ++i) {
      bool wasPaused = IPausable(stks[i]).paused();
      if (wasPaused) {
        UmbrellaEthereum.UMBRELLA.unpauseStk(stks[i]);
        assertFalse(IPausable(stks[i]).paused(), 'stk not unpaused');
        UmbrellaEthereum.UMBRELLA.pauseStk(stks[i]);
        assertTrue(IPausable(stks[i]).paused(), 'stk not re-paused');
      } else {
        UmbrellaEthereum.UMBRELLA.pauseStk(stks[i]);
        assertTrue(IPausable(stks[i]).paused(), 'stk not paused');
        UmbrellaEthereum.UMBRELLA.unpauseStk(stks[i]);
        assertFalse(IPausable(stks[i]).paused(), 'stk not unpaused');
      }
    }
    vm.stopPrank();
  }

  function _wethSlashingHeadroom() internal view returns (uint256) {
    address weth = _weth();
    uint256 poolDeficit = _pool().getReserveDeficit(weth);
    uint256 offset = UmbrellaEthereum.UMBRELLA.getDeficitOffset(weth);
    uint256 pending = UmbrellaEthereum.UMBRELLA.getPendingDeficit(weth);
    uint256 notSlashable = offset + pending;
    return notSlashable > poolDeficit ? notSlashable - poolDeficit : 0;
  }

  /// @dev Static WETH debt as it would be computed inside the AIP at this very
  /// block: `wethScaledDebt × normalizedVariableDebt`, ceil-rounded to match
  /// `vDebt.balanceOf`.
  function _wethStaticDebt() internal view returns (uint256) {
    return proposal.wethScaledDebt().rayMulCeil(_pool().getReserveNormalizedVariableDebt(_weth()));
  }
}
