// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {ITokenizationSpoke} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/ITokenizationSpoke.sol';
import {ISpoke} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/ISpoke.sol';
import {IHubBase} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/IHubBase.sol';
import {Types} from './Types.sol';
import {Scenarios} from './Scenarios.sol';

/// @title TokenizationActions
/// @notice Low-level tokenization spoke (ERC4626) actions with hub accounting assertions.
abstract contract TokenizationActions is Scenarios {
  using SafeERC20 for IERC20;

  // -------------------------------------------------------------------------
  // Snapshot getter
  // -------------------------------------------------------------------------
  function _getTokenizationSnapshot(
    ITokenizationSpoke tokenizationSpoke,
    Types.ReserveInfo memory reserveInfo,
    address user
  ) internal view returns (Types.TokenizationSnapshot memory) {
    uint256 userShares = tokenizationSpoke.balanceOf(user);
    return
      Types.TokenizationSnapshot({
        userShares: userShares,
        userAssets: userShares > 0 ? tokenizationSpoke.convertToAssets(userShares) : 0,
        totalShares: tokenizationSpoke.totalSupply(),
        totalAssets: tokenizationSpoke.totalAssets(),
        hubSpoke: _getHubSpokeAccounting(ISpoke(address(tokenizationSpoke)), reserveInfo)
      });
  }

  // -------------------------------------------------------------------------
  // Hub invariant: tokenization spoke never borrows
  // -------------------------------------------------------------------------
  function _assertTokenizationNoDebt(Types.TokenizationSnapshot memory snapshot) internal pure {
    assertEq(snapshot.hubSpoke.drawnDebt, 0, 'TOKENIZATION: hub drawn debt should be zero');
    assertEq(snapshot.hubSpoke.drawnShares, 0, 'TOKENIZATION: hub drawn shares should be zero');
    assertEq(snapshot.hubSpoke.totalDebt, 0, 'TOKENIZATION: hub total debt should be zero');
  }

  // -------------------------------------------------------------------------
  // Actions
  // -------------------------------------------------------------------------
  function _tokenizationDeposit(
    ITokenizationSpoke tokenizationSpoke,
    Types.ReserveInfo memory reserveInfo,
    address user,
    uint256 assets
  ) internal {
    Types.TokenizationSnapshot memory snapshotBefore = _getTokenizationSnapshot(
      tokenizationSpoke,
      reserveInfo,
      user
    );

    uint256 expectedShares = tokenizationSpoke.previewDeposit(assets);

    vm.startPrank(user);
    deal2(reserveInfo.underlying, user, assets);
    IERC20(reserveInfo.underlying).forceApprove(address(tokenizationSpoke), assets);
    _logAction('TOKENIZATION_DEPOSIT', reserveInfo.symbol, assets);
    uint256 sharesReturned = tokenizationSpoke.deposit(assets, user);
    vm.stopPrank();

    Types.TokenizationSnapshot memory snapshotAfter = _getTokenizationSnapshot(
      tokenizationSpoke,
      reserveInfo,
      user
    );

    // Returned shares should match preview
    assertEq(
      sharesReturned,
      expectedShares,
      'TOKENIZATION_DEPOSIT: returned shares mismatch with preview'
    );
    // User shares increased
    assertEq(
      snapshotAfter.userShares,
      snapshotBefore.userShares + sharesReturned,
      'TOKENIZATION_DEPOSIT: user shares mismatch'
    );
    // Vault totalAssets increased
    assertEq(
      snapshotAfter.totalAssets,
      snapshotBefore.totalAssets + assets,
      'TOKENIZATION_DEPOSIT: totalAssets mismatch'
    );
    // Hub spoke collateral increased
    assertEq(
      snapshotAfter.hubSpoke.collateralAssets,
      snapshotBefore.hubSpoke.collateralAssets + assets,
      'TOKENIZATION_DEPOSIT: hub collateral assets mismatch'
    );
    {
      uint256 expectedAddedShares = IHubBase(reserveInfo.hub).previewAddByAssets(
        reserveInfo.assetId,
        assets
      );
      assertEq(
        snapshotAfter.hubSpoke.collateralShares,
        snapshotBefore.hubSpoke.collateralShares + expectedAddedShares,
        'TOKENIZATION_DEPOSIT: hub collateral shares mismatch'
      );
    }
    _assertTokenizationNoDebt(snapshotAfter);
  }

  function _tokenizationMint(
    ITokenizationSpoke tokenizationSpoke,
    Types.ReserveInfo memory reserveInfo,
    address user,
    uint256 shares
  ) internal {
    Types.TokenizationSnapshot memory snapshotBefore = _getTokenizationSnapshot(
      tokenizationSpoke,
      reserveInfo,
      user
    );

    uint256 expectedAssets = tokenizationSpoke.previewMint(shares);

    vm.startPrank(user);
    // Add some extra assets to avoid rounding errors
    deal2(reserveInfo.underlying, user, expectedAssets * 2);
    IERC20(reserveInfo.underlying).forceApprove(address(tokenizationSpoke), expectedAssets * 2);
    _logAction('TOKENIZATION_MINT', reserveInfo.symbol, shares);
    uint256 assetsDeposited = tokenizationSpoke.mint(shares, user);
    vm.stopPrank();

    Types.TokenizationSnapshot memory snapshotAfter = _getTokenizationSnapshot(
      tokenizationSpoke,
      reserveInfo,
      user
    );

    // Assets deposited should match preview
    assertEq(
      assetsDeposited,
      expectedAssets,
      'TOKENIZATION_MINT: deposited assets mismatch with preview'
    );
    // User shares increased by exact amount
    assertEq(
      snapshotAfter.userShares,
      snapshotBefore.userShares + shares,
      'TOKENIZATION_MINT: user shares mismatch'
    );
    // Vault totalAssets increased
    assertEq(
      snapshotAfter.totalAssets,
      snapshotBefore.totalAssets + assetsDeposited,
      'TOKENIZATION_MINT: totalAssets mismatch'
    );
    // Hub spoke collateral increased
    assertEq(
      snapshotAfter.hubSpoke.collateralAssets,
      snapshotBefore.hubSpoke.collateralAssets + assetsDeposited,
      'TOKENIZATION_MINT: hub collateral assets mismatch'
    );
    _assertTokenizationNoDebt(snapshotAfter);
  }

  function _tokenizationWithdraw(
    ITokenizationSpoke tokenizationSpoke,
    Types.ReserveInfo memory reserveInfo,
    address user,
    uint256 assets
  ) internal {
    Types.TokenizationSnapshot memory snapshotBefore = _getTokenizationSnapshot(
      tokenizationSpoke,
      reserveInfo,
      user
    );

    uint256 expectedSharesBurned = tokenizationSpoke.previewWithdraw(assets);

    vm.prank(user);
    _logAction('TOKENIZATION_WITHDRAW', reserveInfo.symbol, assets);
    uint256 sharesBurned = tokenizationSpoke.withdraw(assets, user, user);

    Types.TokenizationSnapshot memory snapshotAfter = _getTokenizationSnapshot(
      tokenizationSpoke,
      reserveInfo,
      user
    );

    // Shares burned should match preview
    assertEq(
      sharesBurned,
      expectedSharesBurned,
      'TOKENIZATION_WITHDRAW: shares burned mismatch with preview'
    );
    // User shares decreased
    assertEq(
      snapshotAfter.userShares,
      snapshotBefore.userShares - sharesBurned,
      'TOKENIZATION_WITHDRAW: user shares mismatch'
    );
    // Vault totalAssets decreased
    assertEq(
      snapshotBefore.totalAssets - snapshotAfter.totalAssets,
      assets,
      'TOKENIZATION_WITHDRAW: totalAssets mismatch'
    );
    // Hub spoke collateral decreased
    assertEq(
      snapshotBefore.hubSpoke.collateralAssets - snapshotAfter.hubSpoke.collateralAssets,
      assets,
      'TOKENIZATION_WITHDRAW: hub collateral assets mismatch'
    );
    _assertTokenizationNoDebt(snapshotAfter);
  }

  function _tokenizationRedeem(
    ITokenizationSpoke tokenizationSpoke,
    Types.ReserveInfo memory reserveInfo,
    address user,
    uint256 shares
  ) internal {
    Types.TokenizationSnapshot memory snapshotBefore = _getTokenizationSnapshot(
      tokenizationSpoke,
      reserveInfo,
      user
    );

    uint256 expectedAssets = tokenizationSpoke.previewRedeem(shares);

    vm.prank(user);
    _logAction('TOKENIZATION_REDEEM', reserveInfo.symbol, shares);
    uint256 assetsReceived = tokenizationSpoke.redeem(shares, user, user);

    Types.TokenizationSnapshot memory snapshotAfter = _getTokenizationSnapshot(
      tokenizationSpoke,
      reserveInfo,
      user
    );

    // Assets received should match preview
    assertEq(
      assetsReceived,
      expectedAssets,
      'TOKENIZATION_REDEEM: assets received mismatch with preview'
    );
    // User shares decreased by exact amount
    assertEq(
      snapshotAfter.userShares,
      snapshotBefore.userShares - shares,
      'TOKENIZATION_REDEEM: user shares mismatch'
    );
    // If full redeem, shares should be zero
    if (shares == snapshotBefore.userShares) {
      assertEq(snapshotAfter.userShares, 0, 'TOKENIZATION_REDEEM: user shares should be zero');
    }
    // Vault totalAssets decreased
    assertEq(
      snapshotBefore.totalAssets - snapshotAfter.totalAssets,
      assetsReceived,
      'TOKENIZATION_REDEEM: totalAssets mismatch'
    );
    // Hub spoke collateral decreased
    assertEq(
      snapshotBefore.hubSpoke.collateralAssets - snapshotAfter.hubSpoke.collateralAssets,
      assetsReceived,
      'TOKENIZATION_REDEEM: hub collateral assets mismatch'
    );
    _assertTokenizationNoDebt(snapshotAfter);
  }

  function _tokenizationMintWithSig(
    ITokenizationSpoke tokenizationSpoke,
    Types.ReserveInfo memory reserveInfo,
    uint256 privateKey,
    uint256 shares
  ) internal {
    address user = vm.addr(privateKey);
    uint256 userSharesBefore = tokenizationSpoke.balanceOf(user);
    uint256 totalAssetsBefore = tokenizationSpoke.totalAssets();
    uint256 hubCollateralBefore = IHubBase(reserveInfo.hub).getSpokeAddedAssets(
      reserveInfo.assetId,
      address(tokenizationSpoke)
    );

    uint256 assetsDeposited = _executeTokenizationMintWithSig({
      tokenizationSpoke: tokenizationSpoke,
      reserveInfo: reserveInfo,
      privateKey: privateKey,
      user: user,
      shares: shares
    });

    assertEq(
      tokenizationSpoke.balanceOf(user) - userSharesBefore,
      shares,
      'TOKENIZATION_MINT_WITH_SIG: user shares mismatch'
    );
    assertEq(
      tokenizationSpoke.totalAssets() - totalAssetsBefore,
      assetsDeposited,
      'TOKENIZATION_MINT_WITH_SIG: totalAssets mismatch'
    );
    assertEq(
      IHubBase(reserveInfo.hub).getSpokeAddedAssets(
        reserveInfo.assetId,
        address(tokenizationSpoke)
      ) - hubCollateralBefore,
      assetsDeposited,
      'TOKENIZATION_MINT_WITH_SIG: hub collateral assets mismatch'
    );
  }

  function _executeTokenizationMintWithSig(
    ITokenizationSpoke tokenizationSpoke,
    Types.ReserveInfo memory reserveInfo,
    uint256 privateKey,
    address user,
    uint256 shares
  ) internal returns (uint256 assetsDeposited) {
    uint256 expectedAssets = tokenizationSpoke.previewMint(shares);
    _logAction('TOKENIZATION_MINT_WITH_SIG', reserveInfo.symbol, shares);

    deal2(reserveInfo.underlying, user, expectedAssets * 2);
    vm.prank(user);
    IERC20(reserveInfo.underlying).forceApprove(address(tokenizationSpoke), expectedAssets * 2);

    uint192 nonceKey = tokenizationSpoke.PERMIT_NONCE_NAMESPACE();
    uint256 nonce = tokenizationSpoke.nonces(user, nonceKey);

    {
      uint256 deadline = vm.getBlockTimestamp() + 1 hours;
      ITokenizationSpoke.TokenizedMint memory params = ITokenizationSpoke.TokenizedMint({
        depositor: user,
        shares: shares,
        receiver: user,
        nonce: nonce,
        deadline: deadline
      });
      bytes32 structHash = keccak256(
        abi.encode(
          tokenizationSpoke.MINT_TYPEHASH(),
          params.depositor,
          params.shares,
          params.receiver,
          params.nonce,
          params.deadline
        )
      );
      bytes32 digest = keccak256(
        abi.encodePacked('\x19\x01', tokenizationSpoke.DOMAIN_SEPARATOR(), structHash)
      );
      (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, digest);
      assetsDeposited = tokenizationSpoke.mintWithSig(params, abi.encodePacked(r, s, v));
    }

    assertEq(
      assetsDeposited,
      expectedAssets,
      'TOKENIZATION_MINT_WITH_SIG: assets mismatch with preview'
    );
    assertEq(
      tokenizationSpoke.nonces(user, nonceKey),
      nonce + 1,
      'TOKENIZATION_MINT_WITH_SIG: nonce not incremented'
    );
  }

  function _tokenizationRedeemWithSig(
    ITokenizationSpoke tokenizationSpoke,
    Types.ReserveInfo memory reserveInfo,
    uint256 userPrivateKey,
    uint256 shares
  ) internal {
    address user = vm.addr(userPrivateKey);
    uint256 userSharesBefore = tokenizationSpoke.balanceOf(user);
    uint256 totalAssetsBefore = tokenizationSpoke.totalAssets();
    uint256 hubCollateralBefore = IHubBase(reserveInfo.hub).getSpokeAddedAssets(
      reserveInfo.assetId,
      address(tokenizationSpoke)
    );

    uint256 assetsReceived = _executeTokenizationRedeemWithSig({
      tokenizationSpoke: tokenizationSpoke,
      reserveInfo: reserveInfo,
      privateKey: userPrivateKey,
      user: user,
      shares: shares
    });

    assertEq(
      userSharesBefore - tokenizationSpoke.balanceOf(user),
      shares,
      'TOKENIZATION_REDEEM_WITH_SIG: user shares mismatch'
    );
    if (shares == userSharesBefore) {
      assertEq(
        tokenizationSpoke.balanceOf(user),
        0,
        'TOKENIZATION_REDEEM_WITH_SIG: user shares should be zero'
      );
    }
    assertEq(
      totalAssetsBefore - tokenizationSpoke.totalAssets(),
      assetsReceived,
      'TOKENIZATION_REDEEM_WITH_SIG: totalAssets mismatch'
    );
    assertEq(
      hubCollateralBefore -
        IHubBase(reserveInfo.hub).getSpokeAddedAssets(
          reserveInfo.assetId,
          address(tokenizationSpoke)
        ),
      assetsReceived,
      'TOKENIZATION_REDEEM_WITH_SIG: hub collateral assets mismatch'
    );
  }

  function _executeTokenizationRedeemWithSig(
    ITokenizationSpoke tokenizationSpoke,
    Types.ReserveInfo memory reserveInfo,
    uint256 privateKey,
    address user,
    uint256 shares
  ) internal returns (uint256 assetsReceived) {
    uint256 expectedAssets = tokenizationSpoke.previewRedeem(shares);
    _logAction('TOKENIZATION_REDEEM_WITH_SIG', reserveInfo.symbol, shares);

    uint192 nonceKey = tokenizationSpoke.PERMIT_NONCE_NAMESPACE();
    uint256 nonce = tokenizationSpoke.nonces(user, nonceKey);

    {
      uint256 deadline = vm.getBlockTimestamp() + 1 hours;
      ITokenizationSpoke.TokenizedRedeem memory params = ITokenizationSpoke.TokenizedRedeem({
        owner: user,
        shares: shares,
        receiver: user,
        nonce: nonce,
        deadline: deadline
      });
      bytes32 structHash = keccak256(
        abi.encode(
          tokenizationSpoke.REDEEM_TYPEHASH(),
          params.owner,
          params.shares,
          params.receiver,
          params.nonce,
          params.deadline
        )
      );
      bytes32 digest = keccak256(
        abi.encodePacked('\x19\x01', tokenizationSpoke.DOMAIN_SEPARATOR(), structHash)
      );
      (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, digest);
      assetsReceived = tokenizationSpoke.redeemWithSig(params, abi.encodePacked(r, s, v));
    }

    assertEq(
      assetsReceived,
      expectedAssets,
      'TOKENIZATION_REDEEM_WITH_SIG: assets mismatch with preview'
    );
    assertEq(
      tokenizationSpoke.nonces(user, nonceKey),
      nonce + 1,
      'TOKENIZATION_REDEEM_WITH_SIG: nonce not incremented'
    );
  }

  /// @dev Build the EIP-2612 permit digest for the underlying token.
  ///      `depositWithPermit` permits the underlying, not the vault share token.
  function _buildUnderlyingPermitDigest(
    address underlying,
    address owner,
    address spender,
    uint256 value,
    uint256 deadline
  ) internal view returns (bytes32) {
    // Query nonces and DOMAIN_SEPARATOR from the underlying ERC20Permit token
    (, bytes memory nonceData) = underlying.staticcall(
      abi.encodeWithSignature('nonces(address)', owner)
    );
    uint256 nonce = abi.decode(nonceData, (uint256));

    (, bytes memory dsData) = underlying.staticcall(abi.encodeWithSignature('DOMAIN_SEPARATOR()'));
    bytes32 domainSeparator = abi.decode(dsData, (bytes32));

    bytes32 permitTypehash = keccak256(
      'Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)'
    );
    bytes32 structHash = keccak256(
      abi.encode(permitTypehash, owner, spender, value, nonce, deadline)
    );
    return keccak256(abi.encodePacked('\x19\x01', domainSeparator, structHash));
  }

  function _tokenizationDepositWithPermit(
    ITokenizationSpoke tokenizationSpoke,
    Types.ReserveInfo memory reserveInfo,
    uint256 assets
  ) internal {
    (address user, uint256 userPrivateKey) = makeAddrAndKey('user');

    Types.TokenizationSnapshot memory snapshotBefore = _getTokenizationSnapshot(
      tokenizationSpoke,
      reserveInfo,
      user
    );

    deal2(reserveInfo.underlying, user, assets);

    uint256 deadline = vm.getBlockTimestamp() + 1 hours;
    bytes32 digest = _buildUnderlyingPermitDigest(
      reserveInfo.underlying,
      user,
      address(tokenizationSpoke),
      assets,
      deadline
    );
    (uint8 v, bytes32 r, bytes32 s) = vm.sign(userPrivateKey, digest);

    vm.prank(user);
    _logAction('TOKENIZATION_DEPOSIT_WITH_PERMIT', reserveInfo.symbol, assets);
    uint256 sharesReturned = tokenizationSpoke.depositWithPermit(assets, user, deadline, v, r, s);

    Types.TokenizationSnapshot memory snapshotAfter = _getTokenizationSnapshot(
      tokenizationSpoke,
      reserveInfo,
      user
    );

    // User shares increased
    assertEq(
      snapshotAfter.userShares,
      snapshotBefore.userShares + sharesReturned,
      'TOKENIZATION_DEPOSIT_WITH_PERMIT: user shares mismatch'
    );
    // Vault totalAssets increased
    assertEq(
      snapshotAfter.totalAssets,
      snapshotBefore.totalAssets + assets,
      'TOKENIZATION_DEPOSIT_WITH_PERMIT: totalAssets mismatch'
    );
    // Hub spoke collateral increased
    assertEq(
      snapshotAfter.hubSpoke.collateralAssets,
      snapshotBefore.hubSpoke.collateralAssets + assets,
      'TOKENIZATION_DEPOSIT_WITH_PERMIT: hub collateral assets mismatch'
    );
    _assertTokenizationNoDebt(snapshotAfter);
  }
}
