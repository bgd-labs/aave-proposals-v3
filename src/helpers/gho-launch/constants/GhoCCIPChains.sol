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
  /**
   * @notice Struct containing information about a chain supporting GHO through CCIP
   * @param chainSelector The selector identifying the chain on CCIP
   * @param ghoToken The address of the GHO ERC-20 token on the chain
   * @param ghoCCIPTokenPool The address of the GHO CCIP token pool on the chain
   * @param ghoBucketSteward The address of the GHO bucket steward on the chain
   * @param ghoAaveCoreSteward The address of the GHO Aave core steward on the chain
   * @param ghoCCIPSteward The address of the GHO CCIP steward on the chain
   * @param aclManager The address of the ACL manager on the chain
   * @param tokenAdminRegistry The address of the token admin registry on the chain
   * @param owner The address of the owner (a.k.a. executor level 1) on the chain
   * @param ccipRouter The address of the CCIP router on the chain
   */
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

  /**
   * @notice Returns all supported ChainInfo constants
   * @return An array with all the ChainInfo constants supported
   */
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

  /**
   * @notice Returns all supported ChainInfo constants except the one specified
   * @param selectorChainToExclude The selector of the chain to exclude
   * @return An array with all the ChainInfo constants supported except the one specified
   */
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

  /**
   * @notice Returns all supported ChainInfo constants except the one specified
   * @param chainToExclude The chain to exclude
   * @return An array with all the ChainInfo constants supported except the one specified
   */
  function getAllChainsExcept(
    ChainInfo memory chainToExclude
  ) public pure returns (ChainInfo[] memory) {
    return getAllChainsExcept(chainToExclude.chainSelector);
  }

  /**
   * @notice Returns the ChainInfo constant for the given chain selector
   * @param chainSelector The selector of the chain to get the ChainInfo constant for
   * @return The ChainInfo constant for the given chain selector
   */
  function getChainInfoBySelector(uint64 chainSelector) public pure returns (ChainInfo memory) {
    ChainInfo[] memory allChains = getAllChains();
    for (uint256 i = 0; i < allChains.length; i++) {
      if (allChains[i].chainSelector == chainSelector) {
        return allChains[i];
      }
    }
    revert('ChainInfo not found for given chain selector');
  }

  /**
   * @notice Returns a ChainInfo with all nullified values.
   * @return A ChainInfo with all nullified values.
   */
  function emptyChainInfo() public pure returns (ChainInfo memory) {
    // Returns a ChainInfo with all nullified values.
  }

  ///////////////////////////////////////////////////////////////

  /**
   * @notice Returns the ChainInfo constant for Ethereum
   * @return The ChainInfo constant for Ethereum
   */
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

  /**
   * @notice Returns the ChainInfo constant for Arbitrum
   * @return The ChainInfo constant for Arbitrum
   */
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

  /**
   * @notice Returns the ChainInfo constant for Base
   * @return The ChainInfo constant for Base
   */
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

  /**
   * @notice Returns the ChainInfo constant for Avalanche
   * @return The ChainInfo constant for Avalanche
   */
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

  /**
   * @notice Returns the ChainInfo constant for Gnosis
   * @return The ChainInfo constant for Gnosis
   */
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

  /**
   * @notice Returns the ChainInfo constant for Ink
   * @return The ChainInfo constant for Ink
   */
  function INK() public pure returns (ChainInfo memory) {
    return
      ChainInfo({
        chainSelector: CCIPChainSelectors.INK,
        ghoToken: 0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73,
        ghoCCIPTokenPool: 0xDe6539018B095353A40753Dc54C91C68c9487D4E,
        ghoBucketSteward: 0xA5Ba213867E175A182a5dd6A9193C6158738105A,
        ghoAaveCoreSteward: address(0), // Aave Core Steward not available and won't be configured in the Ink GHO Launch proposal
        ghoCCIPSteward: 0x2Ce400703dAcc37b7edFA99D228b8E70a4d3831B,
        aclManager: address(AaveV3InkWhitelabel.ACL_MANAGER),
        tokenAdminRegistry: CCIPChainTokenAdminRegistries.INK,
        owner: GovernanceV3Ink.EXECUTOR_LVL_1,
        ccipRouter: CCIPChainRouters.INK
      });
  }
}
