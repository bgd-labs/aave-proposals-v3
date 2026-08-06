// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {TenderlyVirtualTestnetBase} from 'src/helpers/gsm-launch/TenderlyVirtualTestnetBase.sol';
import {GovNetworks} from 'src/helpers/gsm-launch/GovNetworks.sol';

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {GhoArbitrum} from 'aave-address-book/GhoArbitrum.sol';

import {AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part1} from './AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part1.sol';
import {AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part2} from './AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part2.sol';
import {AaveV3Arbitrum_RemoteGSMLaunchArbitrum_20260512_Part1} from './AaveV3Arbitrum_RemoteGSMLaunchArbitrum_20260512_Part1.sol';
import {AaveV3Arbitrum_RemoteGSMLaunchArbitrum_20260512_Part2} from './AaveV3Arbitrum_RemoteGSMLaunchArbitrum_20260512_Part2.sol';

import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGsm} from 'src/interfaces/IGsm.sol';
import {IGhoReserve} from 'src/interfaces/IGhoReserve.sol';
import {IGsmRegistry} from 'src/interfaces/IGsmRegistry.sol';
import {RemoteGSMLaunchArbitrumSetup} from './setup/RemoteGSMLaunchArbitrumSetup.sol';

contract CCIPBridgeE2EVirtualTest is TenderlyVirtualTestnetBase {
  string private constant MAINNET = 'mainnet_virtual';
  string private constant ARBITRUM = 'arbitrum_virtual';

  uint256 internal ghoBefore;

  function run() external {
    // Snapshot so Virtual Testnet does not drift
    string[] memory aliases = new string[](2);
    aliases[0] = MAINNET;
    aliases[1] = ARBITRUM;
    _snapshotLifecycle(aliases, './snapshot');

    GovNetworks.GovNetwork memory eth = GovNetworks.mainnet();
    GovNetworks.GovNetwork memory arb = GovNetworks.arbitrum();

    // Deploy payloads on Virtual Testnet
    address ethPart1 = _deployPayloadOn(
      eth,
      type(AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part1).creationCode
    );
    address ethPart2 = _deployPayloadOn(
      eth,
      type(AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part2).creationCode
    );
    address arbPart1 = _deployPayloadOn(
      arb,
      type(AaveV3Arbitrum_RemoteGSMLaunchArbitrum_20260512_Part1).creationCode
    );
    address arbPart2 = _deployPayloadOn(
      arb,
      type(AaveV3Arbitrum_RemoteGSMLaunchArbitrum_20260512_Part2).creationCode
    );

    // Execute Arb Part 1
    // In practice, Eth Part 1 could and Eth Part 2 could be executed prior to Arb Part 1
    // Since there are no delays in this script, executing Arb Part 1 because of limitations
    // on the Virual Testnets
    _refork(arb.rpcAlias);
    (uint256 capBefore, ) = IGhoToken(GhoArbitrum.GHO_TOKEN).getFacilitatorBucket(
      GhoArbitrum.GHO_CCIP_TOKEN_POOL
    );

    _executePayloadOn(arb, arbPart1);
    _refork(arb.rpcAlias);

    (uint256 capAfter, ) = IGhoToken(GhoArbitrum.GHO_TOKEN).getFacilitatorBucket(
      GhoArbitrum.GHO_CCIP_TOKEN_POOL
    );
    require(
      capAfter == capBefore + RemoteGSMLaunchArbitrumSetup.GHO_BRIDGE_AMOUNT,
      'ArbPart1: bucket not increased'
    );

    ghoBefore = IGhoToken(GhoArbitrum.GHO_TOKEN).balanceOf(address(AaveV3Arbitrum.COLLECTOR));

    _executePayloadOn(eth, ethPart1);
    _refork(eth.rpcAlias);
    _increaseTime(5 seconds);
    _executePayloadOn(eth, ethPart2);

    _pollUntilDelivered(arb.rpcAlias, 60, 3000);

    _executePayloadOn(arb, arbPart2);

    // Assert Part 2 landed the bridged GHO in the reserve and configured the USDC GSM.
    _refork(ARBITRUM);
    _assertArbPart2(AaveV3Arbitrum_RemoteGSMLaunchArbitrum_20260512_Part2(arbPart2));
  }

  /// @dev End-state checks for Arbitrum Part 2, read from the payload's own constants so the
  /// expected addresses can't drift from what was executed.
  function _assertArbPart2(AaveV3Arbitrum_RemoteGSMLaunchArbitrum_20260512_Part2 payload) internal {
    address gsm = payload.GSM_USDC();
    IGhoReserve reserve = payload.GHO_RESERVE();

    // Bridged GHO reached the reserve (Collector -> GhoReserve forward in Part 2).
    require(
      IGhoToken(GhoArbitrum.GHO_TOKEN).balanceOf(address(reserve)) ==
        RemoteGSMLaunchArbitrumSetup.GHO_BRIDGE_AMOUNT,
      'ArbPart2: reserve not funded with bridged GHO'
    );
    // GSM enrolled with its reserve draw limit.
    require(
      reserve.getLimit(gsm) == RemoteGSMLaunchArbitrumSetup.GSM_USDC_RESERVE_LIMIT,
      'ArbPart2: wrong GSM reserve limit'
    );
    // GSM wired to the reserve and configured with cap + fee strategy.
    require(IGsm(gsm).getGhoReserve() == address(reserve), 'ArbPart2: GSM reserve not set');
    require(
      IGsm(gsm).getExposureCap() == RemoteGSMLaunchArbitrumSetup.GSM_USDC_INITIAL_EXPOSURE_CAP,
      'ArbPart2: wrong GSM exposure cap'
    );
    require(
      IGsm(gsm).getFeeStrategy() == payload.GSM_USDC_FEE_STRATEGY(),
      'ArbPart2: fee strategy not set'
    );
    // GSM registered in the registry.
    IGsmRegistry registry = IGsmRegistry(payload.GSM_REGISTRY());
    require(registry.getGsmListLength() == 1, 'ArbPart2: GSM not registered');
    require(registry.getGsmAtIndex(0) == gsm, 'ArbPart2: wrong GSM registered');
  }

  function _isDelivered() internal view override returns (bool) {
    return
      IGhoToken(GhoArbitrum.GHO_TOKEN).balanceOf(address(AaveV3Arbitrum.COLLECTOR)) >=
      ghoBefore + RemoteGSMLaunchArbitrumSetup.GHO_BRIDGE_AMOUNT;
  }
}
