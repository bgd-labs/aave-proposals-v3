// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {TenderlyVirtualTestnetBase} from 'src/helpers/gsm-launch/TenderlyVirtualTestnetBase.sol';
import {GovNetworks} from 'src/helpers/gsm-launch/GovNetworks.sol';

import {AaveV3Monad} from 'aave-address-book/AaveV3Monad.sol';
import {GhoMonad} from 'aave-address-book/GhoMonad.sol';

import {AaveV3Ethereum_RemoteGSMLaunchMonad_20260701_Part1} from './AaveV3Ethereum_RemoteGSMLaunchMonad_20260701_Part1.sol';
import {AaveV3Ethereum_RemoteGSMLaunchMonad_20260701_Part2} from './AaveV3Ethereum_RemoteGSMLaunchMonad_20260701_Part2.sol';
import {AaveV3Monad_RemoteGSMLaunchMonad_20260701_Part1} from './AaveV3Monad_RemoteGSMLaunchMonad_20260701_Part1.sol';
import {AaveV3Monad_RemoteGSMLaunchMonad_20260701_Part2} from './AaveV3Monad_RemoteGSMLaunchMonad_20260701_Part2.sol';

import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGsm} from 'src/interfaces/IGsm.sol';
import {IGhoReserve} from 'src/interfaces/IGhoReserve.sol';
import {IGsmRegistry} from 'src/interfaces/IGsmRegistry.sol';
import {RemoteGSMLaunchMonadSetup} from './setup/RemoteGSMLaunchMonadSetup.sol';

contract CCIPBridgeE2EVirtualTestMainnetMonad is TenderlyVirtualTestnetBase {
  string private constant MAINNET = 'mainnet_virtual';
  string private constant MONAD = 'monad_virtual';

  uint256 internal ghoBefore;

  function run() external {
    // Snapshot so Virtual Testnet does not drift
    string[] memory aliases = new string[](2);
    aliases[0] = MAINNET;
    aliases[1] = MONAD;
    _snapshotLifecycle(aliases, './snapshot');

    GovNetworks.GovNetwork memory eth = GovNetworks.mainnet();
    GovNetworks.GovNetwork memory monad = GovNetworks.monad();

    // Deploy payloads on Virtual Testnet
    address ethPart1 = _deployPayloadOn(
      eth,
      type(AaveV3Ethereum_RemoteGSMLaunchMonad_20260701_Part1).creationCode
    );
    address ethPart2 = _deployPayloadOn(
      eth,
      type(AaveV3Ethereum_RemoteGSMLaunchMonad_20260701_Part2).creationCode
    );
    address monadPart1 = _deployPayloadOn(
      monad,
      type(AaveV3Monad_RemoteGSMLaunchMonad_20260701_Part1).creationCode
    );
    address monadPart2 = _deployPayloadOn(
      monad,
      type(AaveV3Monad_RemoteGSMLaunchMonad_20260701_Part2).creationCode
    );

    // Execute Monad Part 1
    // In practice, Eth Part 1 and Eth Part 2 could be executed prior to Monad Part 1; this
    // script executes Monad Part 1 first because the Virtual Testnets do not support
    // execution delays.
    _refork(monad.rpcAlias);
    (uint256 capBefore, ) = IGhoToken(GhoMonad.GHO_TOKEN).getFacilitatorBucket(
      GhoMonad.GHO_CCIP_TOKEN_POOL
    );

    _executePayloadOn(monad, monadPart1);
    _refork(monad.rpcAlias);

    (uint256 capAfter, ) = IGhoToken(GhoMonad.GHO_TOKEN).getFacilitatorBucket(
      GhoMonad.GHO_CCIP_TOKEN_POOL
    );
    require(
      capAfter == capBefore + RemoteGSMLaunchMonadSetup.GHO_BRIDGE_AMOUNT,
      'Monad Part 1: bucket not increased'
    );

    ghoBefore = IGhoToken(GhoMonad.GHO_TOKEN).balanceOf(address(AaveV3Monad.COLLECTOR));

    _executePayloadOn(eth, ethPart1);
    _refork(eth.rpcAlias);
    _increaseTime(5 seconds);
    _executePayloadOn(eth, ethPart2);

    _pollUntilDelivered(monad.rpcAlias, 60, 3000);

    _executePayloadOn(monad, monadPart2);

    // Assert Part 2 landed the bridged GHO in the reserve and configured the USDC GSM.
    _refork(MONAD);
    _assertMonadPart2(AaveV3Monad_RemoteGSMLaunchMonad_20260701_Part2(monadPart2));
  }

  /// @dev End-state checks for Monad Part 2, read from the payload's own constants so the
  /// expected addresses can't drift from what was executed.
  function _assertMonadPart2(AaveV3Monad_RemoteGSMLaunchMonad_20260701_Part2 payload) internal {
    address gsm = payload.GSM_USDC();
    IGhoReserve reserve = payload.GHO_RESERVE();

    // Bridged GHO reached the reserve (Collector -> GhoReserve forward in Part 2).
    require(
      IGhoToken(GhoMonad.GHO_TOKEN).balanceOf(address(reserve)) ==
        RemoteGSMLaunchMonadSetup.GHO_BRIDGE_AMOUNT,
      'Monad Part2: reserve not funded with bridged GHO'
    );
    // GSM enrolled with its reserve draw limit.
    require(
      reserve.getLimit(gsm) == RemoteGSMLaunchMonadSetup.GSM_USDC_RESERVE_LIMIT,
      'Monad Part2: wrong GSM reserve limit'
    );
    // GSM wired to the reserve and configured with cap + fee strategy.
    require(IGsm(gsm).getGhoReserve() == address(reserve), 'Monad Part2: GSM reserve not set');
    require(
      IGsm(gsm).getExposureCap() == RemoteGSMLaunchMonadSetup.GSM_USDC_INITIAL_EXPOSURE_CAP,
      'Monad Part2: wrong GSM exposure cap'
    );
    require(
      IGsm(gsm).getFeeStrategy() == payload.GSM_USDC_FEE_STRATEGY(),
      'Monad Part2: fee strategy not set'
    );
    // GSM registered in the registry.
    IGsmRegistry registry = IGsmRegistry(payload.GSM_REGISTRY());
    require(registry.getGsmListLength() == 1, 'Monad Part2: GSM not registered');
    require(registry.getGsmAtIndex(0) == gsm, 'Monad Part2: wrong GSM registered');
  }

  function _isDelivered() internal view override returns (bool) {
    return
      IGhoToken(GhoMonad.GHO_TOKEN).balanceOf(address(AaveV3Monad.COLLECTOR)) >=
      ghoBefore + RemoteGSMLaunchMonadSetup.GHO_BRIDGE_AMOUNT;
  }
}
