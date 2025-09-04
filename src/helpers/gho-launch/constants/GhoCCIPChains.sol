// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {CCIPChainSelectors} from './CCIPChainSelectors.sol';
import {CCIPChainTokenAdminRegistries} from './CCIPChainTokenAdminRegistries.sol';
import {CCIPChainRouters} from './CCIPChainRouters.sol';

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {GhoArbitrum} from 'aave-address-book/GhoArbitrum.sol';

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {GovernanceV3Base} from 'aave-address-book/GovernanceV3Base.sol';
import {GhoBase} from 'aave-address-book/GhoBase.sol';

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {GhoAvalanche} from 'aave-address-book/GhoAvalanche.sol';

import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';
import {GovernanceV3Gnosis} from 'aave-address-book/GovernanceV3Gnosis.sol';
import {GhoGnosis} from 'aave-address-book/GhoGnosis.sol';

import {AaveV3InkWhitelabel} from 'aave-address-book/AaveV3InkWhitelabel.sol';
import {GovernanceV3Ink} from 'aave-address-book/GovernanceV3Ink.sol';

/**
 * @title GhoCCIPChains
 * @author Aave Labs
 * @notice Constants with relevant information of each chain supporting GHO through CCIP
 */
library GhoCCIPChains {
  struct ChainInfo {
    uint64 chainSelector;
    address ghoToken;
    address ghoCCIPTokenPool;
    address ghoBucketSteward;
    address ghoAaveCoreSteward;
    address ghoCCIPSteward;
    address aclManager;
    address tokenAdminRegistry;
    address owner;
    address ccipRouter;
  }

  function getAllChains() public pure returns (ChainInfo[] memory) {
    ChainInfo[] memory allChains = new ChainInfo[](6);
    allChains[0] = ETHEREUM();
    allChains[1] = ARBITRUM();
    allChains[2] = BASE();
    allChains[3] = AVALANCHE();
    allChains[4] = GNOSIS();
    allChains[5] = INK();
    return allChains;
  }

  function getAllChainsExcept(
    uint64 selectorChainToExclude
  ) public pure returns (ChainInfo[] memory) {
    ChainInfo[] memory allChains = getAllChains();
    ChainInfo[] memory chainsToReturn = new ChainInfo[](allChains.length - 1);
    uint256 j = 0;
    for (uint256 i = 0; i < allChains.length; i++) {
      if (allChains[i].chainSelector != selectorChainToExclude) {
        chainsToReturn[j] = allChains[i];
        j++;
      }
    }
    return chainsToReturn;
  }

  function getAllChainsExcept(
    ChainInfo memory chainToExclude
  ) public pure returns (ChainInfo[] memory) {
    return getAllChainsExcept(chainToExclude.chainSelector);
  }

  ///////////////////////////////////////////////////////////////

  function ETHEREUM() public pure returns (ChainInfo memory) {
    return
      ChainInfo({
        chainSelector: CCIPChainSelectors.ETHEREUM,
        ghoToken: GhoEthereum.GHO_TOKEN,
        ghoCCIPTokenPool: GhoEthereum.GHO_CCIP_TOKEN_POOL,
        ghoBucketSteward: GhoEthereum.GHO_BUCKET_STEWARD,
        ghoAaveCoreSteward: GhoEthereum.GHO_AAVE_CORE_STEWARD,
        ghoCCIPSteward: GhoEthereum.GHO_CCIP_STEWARD,
        aclManager: address(AaveV3Ethereum.ACL_MANAGER),
        tokenAdminRegistry: CCIPChainTokenAdminRegistries.ETHEREUM,
        owner: GovernanceV3Ethereum.EXECUTOR_LVL_1,
        ccipRouter: CCIPChainRouters.ETHEREUM
      });
  }

  function ARBITRUM() public pure returns (ChainInfo memory) {
    return
      ChainInfo({
        chainSelector: CCIPChainSelectors.ARBITRUM,
        ghoToken: GhoArbitrum.GHO_TOKEN,
        ghoCCIPTokenPool: GhoArbitrum.GHO_CCIP_TOKEN_POOL,
        ghoBucketSteward: GhoArbitrum.GHO_BUCKET_STEWARD,
        ghoAaveCoreSteward: GhoArbitrum.GHO_AAVE_CORE_STEWARD,
        ghoCCIPSteward: GhoArbitrum.GHO_CCIP_STEWARD,
        aclManager: address(AaveV3Arbitrum.ACL_MANAGER),
        tokenAdminRegistry: CCIPChainTokenAdminRegistries.ARBITRUM,
        owner: GovernanceV3Arbitrum.EXECUTOR_LVL_1,
        ccipRouter: CCIPChainRouters.ARBITRUM
      });
  }

  function BASE() public pure returns (ChainInfo memory) {
    return
      ChainInfo({
        chainSelector: CCIPChainSelectors.BASE,
        ghoToken: GhoBase.GHO_TOKEN,
        ghoCCIPTokenPool: GhoBase.GHO_CCIP_TOKEN_POOL,
        ghoBucketSteward: GhoBase.GHO_BUCKET_STEWARD,
        ghoAaveCoreSteward: GhoBase.GHO_AAVE_CORE_STEWARD,
        ghoCCIPSteward: GhoBase.GHO_CCIP_STEWARD,
        aclManager: address(AaveV3Base.ACL_MANAGER),
        tokenAdminRegistry: CCIPChainTokenAdminRegistries.BASE,
        owner: GovernanceV3Base.EXECUTOR_LVL_1,
        ccipRouter: CCIPChainRouters.BASE
      });
  }

  function AVALANCHE() public pure returns (ChainInfo memory) {
    return
      ChainInfo({
        chainSelector: CCIPChainSelectors.AVALANCHE,
        ghoToken: GhoAvalanche.GHO_TOKEN,
        ghoCCIPTokenPool: GhoAvalanche.GHO_CCIP_TOKEN_POOL,
        ghoBucketSteward: GhoAvalanche.GHO_BUCKET_STEWARD,
        ghoAaveCoreSteward: GhoAvalanche.GHO_AAVE_CORE_STEWARD,
        ghoCCIPSteward: GhoAvalanche.GHO_CCIP_STEWARD,
        aclManager: address(AaveV3Avalanche.ACL_MANAGER),
        tokenAdminRegistry: CCIPChainTokenAdminRegistries.AVALANCHE,
        owner: GovernanceV3Avalanche.EXECUTOR_LVL_1,
        ccipRouter: CCIPChainRouters.AVALANCHE
      });
  }

  function GNOSIS() public pure returns (ChainInfo memory) {
    return
      ChainInfo({
        chainSelector: CCIPChainSelectors.GNOSIS,
        ghoToken: GhoGnosis.GHO_TOKEN,
        ghoCCIPTokenPool: GhoGnosis.GHO_CCIP_TOKEN_POOL,
        ghoBucketSteward: GhoGnosis.GHO_BUCKET_STEWARD,
        ghoAaveCoreSteward: GhoGnosis.GHO_AAVE_CORE_STEWARD,
        ghoCCIPSteward: GhoGnosis.GHO_CCIP_STEWARD,
        aclManager: address(AaveV3Gnosis.ACL_MANAGER),
        tokenAdminRegistry: CCIPChainTokenAdminRegistries.GNOSIS,
        owner: GovernanceV3Gnosis.EXECUTOR_LVL_1,
        ccipRouter: CCIPChainRouters.GNOSIS
      });
  }

  function INK() public pure returns (ChainInfo memory) {
    return
      ChainInfo({
        chainSelector: CCIPChainSelectors.INK,
        ghoToken: 0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73,
        ghoCCIPTokenPool: 0xDe6539018B095353A40753Dc54C91C68c9487D4E,
        ghoBucketSteward: 0xA5Ba213867E175A182a5dd6A9193C6158738105A,
        ghoAaveCoreSteward: address(0),
        ghoCCIPSteward: 0x2Ce400703dAcc37b7edFA99D228b8E70a4d3831B,
        aclManager: address(AaveV3InkWhitelabel.ACL_MANAGER),
        tokenAdminRegistry: CCIPChainTokenAdminRegistries.INK,
        owner: GovernanceV3Ink.EXECUTOR_LVL_1,
        ccipRouter: CCIPChainRouters.INK
      });
  }
}
