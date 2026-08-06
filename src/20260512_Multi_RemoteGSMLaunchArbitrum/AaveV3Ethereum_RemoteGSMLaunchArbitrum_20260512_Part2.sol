// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {CCIPChainSelectors} from '../helpers/gho-launch/constants/CCIPChainSelectors.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IAaveGhoCcipBridge} from 'aave-helpers/src/bridges/ccip/interfaces/IAaveGhoCcipBridge.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGhoDirectFacilitator} from 'src/interfaces/IGhoDirectFacilitator.sol';

import {RemoteGSMLaunchArbitrumSetup} from './setup/RemoteGSMLaunchArbitrumSetup.sol';

/**
 * @title Remote GSM Launch: Arbitrum
 * @author TokenLogic
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0xf24321514fb593af9e5082d26a1358819ec0f648db8fdb5c2b083f53ef785793
 * - Discussion: https://governance.aave.com/t/arfc-launch-remotegsm-on-arbitrum/24986
 */
contract AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part2 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  // GhoDirectFacilitator Constants
  // https://etherscan.io/address/0x436dccc028322afc355f608cf582b7d7f19fdfed
  address public constant DIRECT_FACILITATOR = 0x436dCCC028322AfC355f608CF582B7d7F19FDfEd;
  string public constant DIRECT_FACILITATOR_NAME = 'GhoDirectFacilitator GSM Arbitrum';

  // https://etherscan.io/address/0x7F2f96fcdC3A29Be75938d2aC3D92E7006919fe6
  address public constant CCIP_BRIDGE = address(0x7F2f96fcdC3A29Be75938d2aC3D92E7006919fe6);

  // Deployed AaveGhoCcipBridge on Arbitrum (counterpart that will receive the CCIP
  // message and forward GHO to the Arbitrum Collector).
  // https://arbiscan.io/address/0x812fBcd390A3C6c01C65B767413Dea6f6e24FDD0
  address public constant ARBITRUM_BRIDGE_DESTINATION = 0x812fBcd390A3C6c01C65B767413Dea6f6e24FDD0;

  // Typical bridge-receive gas limits sit in the 200k–500k range; pick a value that
  // covers the receive + Collector forwarding path with comfortable headroom.
  uint32 public constant ARBITRUM_BRIDGE_GAS_LIMIT = 450_000;

  function execute() external {
    IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).addFacilitator(
      DIRECT_FACILITATOR,
      DIRECT_FACILITATOR_NAME,
      RemoteGSMLaunchArbitrumSetup.DIRECT_FACILITATOR_CAPACITY
    );

    IGhoDirectFacilitator(DIRECT_FACILITATOR).mint(
      address(this),
      RemoteGSMLaunchArbitrumSetup.GHO_BRIDGE_AMOUNT
    );

    IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).forceApprove(
      CCIP_BRIDGE,
      RemoteGSMLaunchArbitrumSetup.GHO_BRIDGE_AMOUNT
    );

    // Configure the Arbitrum lane on the AaveGhoCcipBridge: maps the Arbitrum chain
    // selector to the counterpart bridge address on Arbitrum (which forwards the GHO
    // to AaveV3Arbitrum.COLLECTOR on receipt). `extraArgs` is left empty so the bridge
    // uses its default CCIP extraArgs encoding with the gas limit below.
    IAaveGhoCcipBridge(CCIP_BRIDGE).setDestinationChain(
      CCIPChainSelectors.ARBITRUM,
      abi.encode(ARBITRUM_BRIDGE_DESTINATION),
      bytes(''),
      ARBITRUM_BRIDGE_GAS_LIMIT
    );

    // Bridge already has LINK to bridge, no need to send for fee.
    // This step will fail if Part 1 is not executed first to set the augmented bridge limit (RateLimitExceeded error).
    IAaveGhoCcipBridge(CCIP_BRIDGE).send(
      CCIPChainSelectors.ARBITRUM,
      RemoteGSMLaunchArbitrumSetup.GHO_BRIDGE_AMOUNT,
      AaveV3EthereumAssets.LINK_UNDERLYING
    );

    // Restore the Arbitrum lane bridge limit; normalize the other GHO CCIP lanes
    // touched by this proposal so all end up at the canonical default config.
    RemoteGSMLaunchArbitrumSetup.normalizeIORateLimitsForAllNetworks(
      GhoEthereum.GHO_CCIP_TOKEN_POOL,
      CCIPChainSelectors.ETHEREUM
    );
  }
}
