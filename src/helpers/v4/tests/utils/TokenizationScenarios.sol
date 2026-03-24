// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {ITokenizationSpoke} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/ITokenizationSpoke.sol';
import {IHub} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/IHub.sol';
import {IHubConfigurator} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/IHubConfigurator.sol';
import {AaveV4EthereumAddresses} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/AaveV4EthereumAddresses.sol';
import {Types} from './Types.sol';
import {TokenizationActions} from './TokenizationActions.sol';

/// @title TokenizationScenarios
/// @notice Test scenario orchestration for tokenization spoke (ERC4626) e2e tests.
abstract contract TokenizationScenarios is TokenizationActions {
  using SafeERC20 for IERC20;

  /// @notice Build ReserveInfo from a tokenization spoke's identity getters.
  function _getTokenizationReserveInfo(
    ITokenizationSpoke tokenizationSpoke
  ) internal view returns (Types.ReserveInfo memory) {
    address hub = tokenizationSpoke.hub();
    uint16 assetId = uint16(tokenizationSpoke.assetId());
    address underlying = tokenizationSpoke.asset();
    uint8 decimals = tokenizationSpoke.decimals();
    string memory symbol = _safeSymbol(underlying);

    return
      Types.ReserveInfo({
        reserveId: 0,
        underlying: underlying,
        hub: hub,
        assetId: assetId,
        symbol: symbol,
        decimals: decimals,
        paused: false,
        frozen: false,
        borrowable: false,
        collateralEnabled: false,
        collateralFactor: 0,
        maxLiquidationBonus: 0,
        liquidationFee: 0
      });
  }

  /// @notice Set addCap to max for a tokenization spoke's asset.
  function _setTokenizationCapsToMax(ITokenizationSpoke tokenizationSpoke) internal {
    vm.mockCall(
      AaveV4EthereumAddresses.ACCESS_MANAGER,
      abi.encodeWithSelector(bytes4(keccak256('canCall(address,address,bytes4)'))),
      abi.encode(true, uint32(0))
    );
    IHubConfigurator(AaveV4EthereumAddresses.HUB_CONFIGURATOR).updateSpokeCaps({
      hub: tokenizationSpoke.hub(),
      assetId: tokenizationSpoke.assetId(),
      spoke: address(tokenizationSpoke),
      addCap: type(uint40).max,
      drawCap: type(uint40).max
    });
    vm.clearMockedCalls();
  }

  // -------------------------------------------------------------------------
  // Scenarios
  // -------------------------------------------------------------------------

  /// @dev Test deposit + partial withdraw + full redeem cycle.
  function _testTokenizationDepositWithdraw(
    ITokenizationSpoke tokenizationSpoke,
    Types.ReserveInfo memory reserveInfo,
    uint256 maxAddAmount
  ) internal {
    (address user, uint256 userPrivateKey) = makeAddrAndKey('user');
    uint256 depositAmount = vm.randomUint(1, maxAddAmount);

    // Deposit
    _tokenizationDeposit(tokenizationSpoke, reserveInfo, user, depositAmount);

    // Partial withdraw
    uint256 userAssets = tokenizationSpoke.convertToAssets(tokenizationSpoke.balanceOf(user));
    uint256 snapshot = vm.snapshotState();
    {
      uint256 partialWithdraw = vm.randomUint(1, userAssets - 1);
      _tokenizationWithdraw(tokenizationSpoke, reserveInfo, user, partialWithdraw);
      vm.revertToState(snapshot);
    }

    // Full redeem
    _tokenizationRedeem(tokenizationSpoke, reserveInfo, user, tokenizationSpoke.balanceOf(user));
    assertEq(tokenizationSpoke.balanceOf(user), 0, 'DEPOSIT_WITHDRAW: user should have no shares');
    vm.revertToState(snapshot);

    // Full redeem with sig
    _tokenizationRedeemWithSig(
      tokenizationSpoke,
      reserveInfo,
      userPrivateKey,
      tokenizationSpoke.balanceOf(user)
    );
    assertEq(tokenizationSpoke.balanceOf(user), 0, 'DEPOSIT_WITHDRAW: user should have no shares');
    vm.revertToState(snapshot);
  }

  /// @dev Test mint + partial redeem + full redeem cycle, including mintWithSig.
  function _testTokenizationMintRedeem(
    ITokenizationSpoke tokenizationSpoke,
    Types.ReserveInfo memory reserveInfo,
    uint256 maxAddAmount
  ) internal {
    (address user, uint256 userPrivateKey) = makeAddrAndKey('mintUser');
    uint256 mintAssets = vm.randomUint(1, maxAddAmount);
    uint256 mintShares = tokenizationSpoke.convertToShares(mintAssets);

    uint256 snapshot = vm.snapshotState();

    // Mint
    _tokenizationMint(tokenizationSpoke, reserveInfo, user, mintShares);
    uint256 userShares = tokenizationSpoke.balanceOf(user);

    // Partial redeem
    {
      uint256 postMintSnapshot = vm.snapshotState();
      uint256 partialRedeem = vm.randomUint(1, userShares - 1);
      _tokenizationRedeem(tokenizationSpoke, reserveInfo, user, partialRedeem);
      vm.revertToState(postMintSnapshot);
    }

    // Full redeem
    _tokenizationRedeem(tokenizationSpoke, reserveInfo, user, userShares);
    assertEq(tokenizationSpoke.balanceOf(user), 0, 'MINT_REDEEM: user should have no shares');
    vm.revertToState(snapshot);

    // Mint with sig (clean slate — no prior mint consuming addCap)
    _tokenizationMintWithSig({
      tokenizationSpoke: tokenizationSpoke,
      reserveInfo: reserveInfo,
      privateKey: userPrivateKey,
      shares: mintShares
    });
    assertEq(
      tokenizationSpoke.balanceOf(user),
      mintShares,
      'MINT_WITH_SIG: user should have shares'
    );
  }

  /// @dev Test deposit with EIP-2612 permit signature.
  ///      Skips if the underlying token does not support EIP-2612 (WETH).
  function _testTokenizationPermitDeposit(
    ITokenizationSpoke tokenizationSpoke,
    Types.ReserveInfo memory reserveInfo,
    uint256 maxAddAmount
  ) internal {
    // Skip tokens that don't support EIP-2612 permit (WETH has no nonces function)
    (bool success, ) = reserveInfo.underlying.staticcall(
      abi.encodeWithSignature('nonces(address)', address(this))
    );
    if (!success) {
      console.log('TOKENIZATION_PERMIT: skipping %s (no EIP-2612 support)', reserveInfo.symbol);
      return;
    }

    uint256 depositAmount = vm.randomUint(1, maxAddAmount);
    _tokenizationDepositWithPermit(tokenizationSpoke, reserveInfo, depositAmount);
  }

  /// @dev Test addCap enforcement on tokenization spoke deposits.
  function _testTokenizationAddCap(
    ITokenizationSpoke tokenizationSpoke,
    Types.ReserveInfo memory reserveInfo
  ) internal {
    IHub hub = IHub(reserveInfo.hub);
    IHub.SpokeConfig memory spokeConfig = hub.getSpokeConfig(
      reserveInfo.assetId,
      address(tokenizationSpoke)
    );

    if (spokeConfig.addCap == 0 || spokeConfig.addCap == type(uint40).max) {
      return;
    }

    uint256 addCapScaled = uint256(spokeConfig.addCap) * 10 ** reserveInfo.decimals;
    uint256 currentAdded = hub.getSpokeAddedAssets(reserveInfo.assetId, address(tokenizationSpoke));
    if (addCapScaled <= currentAdded) {
      return;
    }

    uint256 room = addCapScaled - currentAdded;
    address depositor = vm.randomAddress();

    // Deposit more than remaining room — should revert with AddCapExceeded
    uint256 overflowAmount = room + 10 ** reserveInfo.decimals;
    vm.startPrank(depositor);
    deal2(reserveInfo.underlying, depositor, overflowAmount);
    IERC20(reserveInfo.underlying).forceApprove(address(tokenizationSpoke), overflowAmount);
    vm.expectRevert(
      abi.encodeWithSelector(IHub.AddCapExceeded.selector, uint256(spokeConfig.addCap))
    );
    tokenizationSpoke.deposit(overflowAmount, depositor);
    vm.stopPrank();
  }

  /// @dev Test that share value does not decrease over time (yield accrual).
  function _testTokenizationTimeSkip(
    ITokenizationSpoke tokenizationSpoke,
    Types.ReserveInfo memory reserveInfo,
    uint256 maxAddAmount
  ) internal {
    address user = vm.randomAddress();
    uint256 depositAmount = vm.randomUint(1, maxAddAmount);

    // Deposit first
    _tokenizationDeposit(tokenizationSpoke, reserveInfo, user, depositAmount);

    Types.TokenizationSnapshot memory snapshotBefore = _getTokenizationSnapshot(
      tokenizationSpoke,
      reserveInfo,
      user
    );

    uint256 skipDays = vm.randomUint(1, 365);
    skip(skipDays * 1 days);

    Types.TokenizationSnapshot memory snapshotAfter = _getTokenizationSnapshot(
      tokenizationSpoke,
      reserveInfo,
      user
    );

    // totalAssets should not decrease
    assertGe(
      snapshotAfter.totalAssets,
      snapshotBefore.totalAssets,
      'TIME_SKIP: totalAssets decreased'
    );

    // User's asset value should not decrease (share value grows with yield)
    assertGe(
      snapshotAfter.userAssets,
      snapshotBefore.userAssets,
      'TIME_SKIP: user asset value decreased'
    );

    // Share count should remain the same (no shares minted/burned)
    assertEq(
      snapshotAfter.userShares,
      snapshotBefore.userShares,
      'TIME_SKIP: user share count changed'
    );

    // Hub spoke collateral should not decrease
    assertGe(
      snapshotAfter.hubSpoke.collateralAssets,
      snapshotBefore.hubSpoke.collateralAssets,
      'TIME_SKIP: hub collateral assets decreased'
    );

    _assertTokenizationNoDebt(snapshotAfter);
  }
}
