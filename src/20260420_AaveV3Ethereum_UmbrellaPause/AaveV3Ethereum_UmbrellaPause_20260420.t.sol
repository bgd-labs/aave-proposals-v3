// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_UmbrellaPause_20260420} from './AaveV3Ethereum_UmbrellaPause_20260420.sol';
import {UmbrellaEthereum, UmbrellaEthereumAssets} from 'aave-address-book/UmbrellaEthereum.sol';
import {IUmbrellaStakeToken} from 'aave-umbrella/stakeToken/interfaces/IUmbrellaStakeToken.sol';
import {IERC4626StakeToken} from 'aave-umbrella/stakeToken/interfaces/IERC4626StakeToken.sol';
import {PausableUpgradeable} from 'openzeppelin-contracts-upgradeable/contracts/utils/PausableUpgradeable.sol';
import {ERC4626Upgradeable} from 'openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/ERC4626Upgradeable.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

/**
 * @dev Test for AaveV3Ethereum_UmbrellaPause_20260420
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260420_AaveV3Ethereum_UmbrellaPause/AaveV3Ethereum_UmbrellaPause_20260420.t.sol -vv
 */
contract AaveV3Ethereum_UmbrellaPause_20260420_Test is ProtocolV3TestBase {
  // private constant in StakeToken
  bytes32 internal constant COOLDOWN_WITH_PERMIT_TYPEHASH =
    keccak256(
      'CooldownWithPermit(address user,address caller,uint256 cooldownNonce,uint256 deadline)'
    );

  AaveV3Ethereum_UmbrellaPause_20260420 internal proposal;
  address internal user;
  uint256 internal userPrivateKey;
  address internal user2;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24927750);
    proposal = new AaveV3Ethereum_UmbrellaPause_20260420();
    (user, userPrivateKey) = makeAddrAndKey('user');
    user2 = makeAddr('user2');
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_UmbrellaPause_20260420', AaveV3Ethereum.POOL, address(proposal));
  }

  function test_stkTokensPaused() public {
    assertFalse(PausableUpgradeable(UmbrellaEthereumAssets.STK_WA_WETH_V1).paused());

    GovV3Helpers.executePayload(vm, address(proposal));

    assertTrue(PausableUpgradeable(UmbrellaEthereumAssets.STK_WA_WETH_V1).paused());
  }

  function test_stkWaWETH() public {
    _testStkTokenActions(UmbrellaEthereumAssets.STK_WA_WETH_V1);
  }

  /// @dev user stakes + starts cooldown, then pause lands, then the full cooldown elapses.
  /// Even though the user would otherwise be in the withdrawal window, redeem/withdraw are blocked.
  function test_CooldownedUserCannotWithdrawWhilePaused() public {
    IUmbrellaStakeToken stk = IUmbrellaStakeToken(UmbrellaEthereumAssets.STK_WA_WETH_V1);
    address underlying = stk.asset();
    uint256 amount = 1e18;

    // user stakes and starts cooldown, pre-pause
    deal(underlying, user, amount);
    vm.startPrank(user);
    IERC20(underlying).approve(address(stk), amount);
    uint256 shares = stk.deposit({assets: amount, receiver: user});
    stk.cooldown();
    vm.stopPrank();

    IERC4626StakeToken.CooldownSnapshot memory snapshot = stk.getStakerCooldown(user);
    assertGt(snapshot.amount, 0);
    assertGt(snapshot.endOfCooldown, block.timestamp);

    // pause while the user is in cooldown
    GovV3Helpers.executePayload(vm, address(proposal));

    // warp past endOfCooldown — without the pause, user would now be able to redeem
    vm.warp(snapshot.endOfCooldown + 1);
    assertLt(block.timestamp, uint256(snapshot.endOfCooldown) + uint256(snapshot.withdrawalWindow));

    // paused -> max* views return 0 and redeem/withdraw revert
    assertEq(stk.maxRedeem(user), 0);
    assertEq(stk.maxWithdraw(user), 0);

    vm.startPrank(user);
    vm.expectRevert(
      abi.encodeWithSelector(ERC4626Upgradeable.ERC4626ExceededMaxRedeem.selector, user, shares, 0)
    );
    stk.redeem({shares: shares, receiver: user, owner: user});

    vm.expectRevert(
      abi.encodeWithSelector(ERC4626Upgradeable.ERC4626ExceededMaxWithdraw.selector, user, 1, 0)
    );
    stk.withdraw({assets: 1, receiver: user, owner: user});
    vm.stopPrank();
  }

  function _testStkTokenActions(address stkToken) internal {
    GovV3Helpers.executePayload(vm, address(proposal));
    IUmbrellaStakeToken stk = IUmbrellaStakeToken(stkToken);

    assertEq(stk.maxDeposit(user), 0);
    assertEq(stk.maxMint(user), 0);
    assertEq(stk.maxWithdraw(user), 0);
    assertEq(stk.maxRedeem(user), 0);
    assertEq(stk.getMaxSlashableAssets(), 0);

    // slash: only Umbrella can call; pause guard fires after onlyOwner
    vm.expectRevert(PausableUpgradeable.EnforcedPause.selector);
    vm.prank(address(UmbrellaEthereum.UMBRELLA));
    stk.slash({destination: user, amount: 1});

    vm.startPrank(user);
    // approve + setCooldownOperator remain callable while paused
    stk.approve({spender: user2, value: type(uint256).max});
    stk.setCooldownOperator({operator: user2, flag: true});

    // EnforcedPause errs
    vm.expectRevert(PausableUpgradeable.EnforcedPause.selector);
    stk.transfer({to: user2, value: 1});

    vm.expectRevert(PausableUpgradeable.EnforcedPause.selector);
    stk.cooldown();

    // ERC4626ExceededMax* errs (max* views return 0 while paused, short-circuiting before _update)
    vm.expectRevert(
      abi.encodeWithSelector(ERC4626Upgradeable.ERC4626ExceededMaxDeposit.selector, user, 1, 0)
    );
    stk.deposit({assets: 1, receiver: user});

    vm.expectRevert(
      abi.encodeWithSelector(ERC4626Upgradeable.ERC4626ExceededMaxMint.selector, user, 1, 0)
    );
    stk.mint({shares: 1, receiver: user});

    vm.expectRevert(
      abi.encodeWithSelector(ERC4626Upgradeable.ERC4626ExceededMaxWithdraw.selector, user, 1, 0)
    );
    stk.withdraw({assets: 1, receiver: user, owner: user});

    vm.expectRevert(
      abi.encodeWithSelector(ERC4626Upgradeable.ERC4626ExceededMaxRedeem.selector, user, 1, 0)
    );
    stk.redeem({shares: 1, receiver: user, owner: user});

    vm.stopPrank();

    // transferFrom + cooldownOnBehalfOf: called by user2 (approved above)
    vm.startPrank(user2);

    vm.expectRevert(PausableUpgradeable.EnforcedPause.selector);
    stk.transferFrom({from: user, to: user2, value: 1});

    vm.expectRevert(PausableUpgradeable.EnforcedPause.selector);
    stk.cooldownOnBehalfOf({from: user});

    vm.stopPrank();

    // cooldownWithPermit: user signs, user2 submits
    uint256 deadline = block.timestamp + 1 hours;
    bytes32 digest = keccak256(
      abi.encodePacked(
        '\x19\x01',
        stk.DOMAIN_SEPARATOR(),
        keccak256(
          abi.encode(COOLDOWN_WITH_PERMIT_TYPEHASH, user, user2, stk.cooldownNonces(user), deadline)
        )
      )
    );
    (uint8 v, bytes32 r, bytes32 s) = vm.sign(userPrivateKey, digest);

    vm.prank(user2);
    vm.expectRevert(PausableUpgradeable.EnforcedPause.selector);
    stk.cooldownWithPermit({
      user: user,
      deadline: deadline,
      sig: IERC4626StakeToken.SignatureParams({v: v, r: r, s: s})
    });
  }
}
