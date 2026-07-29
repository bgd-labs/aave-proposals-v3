// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {CCIPChainSelectors} from 'src/helpers/gho-launch/constants/CCIPChainSelectors.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IAaveGhoCcipBridge} from 'aave-helpers/src/bridges/ccip/interfaces/IAaveGhoCcipBridge.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGhoDirectFacilitator} from 'src/interfaces/IGhoDirectFacilitator.sol';

import {RemoteGSMLaunchMonadSetup} from './setup/RemoteGSMLaunchMonadSetup.sol';

/**
 * @title Remote GSM Launch: Monad
 * @author TokenLogic
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0x24f105bd023c476a9b85fa87ff795bfeec769fa799ce6ada8e2724c9738049f6
 * - Discussion: https://governance.aave.com/t/arfc-deploy-aave-protocol-v3-7-on-monad/24943
 */
contract AaveV3Ethereum_RemoteGSMLaunchMonad_20260701_Part2 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  // GhoDirectFacilitator Constants
  // https://etherscan.io/address/0x0cB7C2A2Ab38Aed3e6096631D7Dba3DaBf237134
  address public constant DIRECT_FACILITATOR = 0x0cB7C2A2Ab38Aed3e6096631D7Dba3DaBf237134;
  string public constant DIRECT_FACILITATOR_NAME = 'GhoDirectFacilitator GSM Monad';

  // Ethereum-side AaveGhoCcipBridge (target-agnostic; the destination lane is configured below).
  // Its ROUTER is the same one GhoEthereum.GHO_CCIP_TOKEN_POOL is registered under, so `send`
  // below provably drives the GHO token pool this proposal configures. See
  // `test_ccipBridgeIdentity`.
  // https://etherscan.io/address/0x7F2f96fcdC3A29Be75938d2aC3D92E7006919fe6
  address public constant CCIP_BRIDGE = 0x7F2f96fcdC3A29Be75938d2aC3D92E7006919fe6;

  // AaveGhoCcipBridge on Monad (counterpart that will receive the CCIP message and forward GHO
  // to the Monad Collector).
  // https://monadscan.com/address/0x16A6D0fD02D4DAB40Fee3014faa05b39d083F4ee
  address public constant MONAD_BRIDGE_DESTINATION = 0x16A6D0fD02D4DAB40Fee3014faa05b39d083F4ee;

  // Typical bridge-receive gas limits sit in the 200k–500k range; pick a value that
  // covers the receive + Collector forwarding path with comfortable headroom.
  uint32 public constant MONAD_BRIDGE_GAS_LIMIT = 450_000;

  function execute() external {
    IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).addFacilitator(
      DIRECT_FACILITATOR,
      DIRECT_FACILITATOR_NAME,
      RemoteGSMLaunchMonadSetup.DIRECT_FACILITATOR_CAPACITY
    );

    IGhoDirectFacilitator(DIRECT_FACILITATOR).mint(
      address(this),
      RemoteGSMLaunchMonadSetup.GHO_BRIDGE_AMOUNT
    );

    IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).forceApprove(
      CCIP_BRIDGE,
      RemoteGSMLaunchMonadSetup.GHO_BRIDGE_AMOUNT
    );

    // Configure the Monad lane on the AaveGhoCcipBridge: maps the Monad chain selector to the
    // counterpart bridge address on Monad (which forwards the GHO to AaveV3Monad.COLLECTOR on
    // receipt). `extraArgs` is left empty so the bridge uses its default CCIP extraArgs encoding
    // with the gas limit below.
    IAaveGhoCcipBridge(CCIP_BRIDGE).setDestinationChain(
      CCIPChainSelectors.MONAD,
      abi.encode(MONAD_BRIDGE_DESTINATION),
      bytes(''),
      MONAD_BRIDGE_GAS_LIMIT
    );

    // Bridge already has LINK to bridge, no need to send for fee.
    // This step will fail if Part 1 is not executed first to set the augmented bridge limit (RateLimitExceeded error).
    IAaveGhoCcipBridge(CCIP_BRIDGE).send(
      CCIPChainSelectors.MONAD,
      RemoteGSMLaunchMonadSetup.GHO_BRIDGE_AMOUNT,
      AaveV3EthereumAssets.LINK_UNDERLYING
    );

    // Restore ONLY the Ethereum <> Monad lane rate-limit config to its standard values, undoing
    // the temporary bump from Part 1. Every other lane is intentionally left untouched so this
    // proposal does not change GHO lane capacities across the rest of the network.
    // NOTE: the global bridge limit raised in Part 1 is intentionally NOT reduced here: the 50M
    // just bridged out is now part of the locked supply, so the elevated limit reflects reality.
    RemoteGSMLaunchMonadSetup.restoreLaneRateLimitConfig(
      GhoEthereum.GHO_CCIP_TOKEN_POOL,
      CCIPChainSelectors.MONAD
    );
  }
}
