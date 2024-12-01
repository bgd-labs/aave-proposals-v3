// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {TokenAdminRegistry} from 'ccip/tokenAdminRegistry/TokenAdminRegistry.sol';
import {UpgradeableBurnMintTokenPool} from 'ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol';
import {AaveV3Arbitrum_GHOAvaxLaunch_20241106} from './AaveV3Arbitrum_GHOAvaxLaunch_20241106.sol';
import {AaveV3Avalanche_GHOAvaxLaunch_20241106} from './AaveV3Avalanche_GHOAvaxLaunch_20241106.sol';

/**
 * @dev Test for AaveV3Arbitrum_GHOAvaxLaunch_20241106
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20241106_Multi_GHOAvaxLaunch/AaveV3Arbitrum_GHOAvaxLaunch_20241106.t.sol -vv
 */
contract AaveV3Arbitrum_GHOAvaxLaunch_20241106_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_GHOAvaxLaunch_20241106 internal proposal;

  address public constant GHO_TOKEN = AaveV3ArbitrumAssets.GHO_UNDERLYING;
  address public constant TOKEN_POOL = MiscArbitrum.GHO_CCIP_TOKEN_POOL;
  address public constant TOKEN_ADMIN_REGISTRY = 0x39AE1032cF4B334a1Ed41cdD0833bdD7c7E7751E;
  address public constant REGISTRY_ADMIN = 0x8a89770722c84B60cE02989Aedb22Ac4791F8C7f;
  address public constant AVAX_GHO_TOKEN = 0xb025950B02b9cfe851C6a4C041f9D6c0942f0eB1;
  address public constant AVAX_REGISTRY_ADMIN = 0xA3f32a07CCd8569f49cf350D4e61C016CA484644;
  address public constant AVAX_TOKEN_ADMIN_REGISTRY = 0xc8df5D618c6a59Cc6A311E96a39450381001464F;
  address public constant AVAX_RMN_PROXY = 0xcBD48A8eB077381c3c4Eb36b402d7283aB2b11Bc;
  address public constant AVAX_ROUTER = 0xF4c7E640EdA248ef95972845a62bdC74237805dB;

  function setUp() public {
    // Execute Avax proposal to deploy Avax token pool
    vm.createSelectFork(vm.rpcUrl('avalanche'), 53559217);
    // TODO: Remove this deployment once we have deployed pool address
    _deployCcipTokenPool();

    // TODO: Remove this (will be done on chainlink's side)
    // Prank chainlink and set up admin role to be accepted on token registry
    vm.startPrank(AVAX_REGISTRY_ADMIN);
    TokenAdminRegistry(AVAX_TOKEN_ADMIN_REGISTRY).proposeAdministrator(
      AVAX_GHO_TOKEN,
      GovernanceV3Avalanche.EXECUTOR_LVL_1
    );
    vm.stopPrank();

    AaveV3Avalanche_GHOAvaxLaunch_20241106 avaxProposal = new AaveV3Avalanche_GHOAvaxLaunch_20241106();
    GovV3Helpers.executePayload(vm, address(avaxProposal));

    // Switch to Arbitrum and create proposal
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 279521658);
    proposal = new AaveV3Arbitrum_GHOAvaxLaunch_20241106();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Arbitrum_GHOAvaxLaunch_20241106', AaveV3Arbitrum.POOL, address(proposal));
  }

  function _deployCcipTokenPool() internal returns (address) {
    address imple = address(
      new UpgradeableBurnMintTokenPool(AVAX_GHO_TOKEN, AVAX_RMN_PROXY, false)
    );

    bytes memory tokenPoolInitParams = abi.encodeWithSignature(
      'initialize(address,address[],address)',
      GovernanceV3Avalanche.EXECUTOR_LVL_1, // owner
      new address[](0), // allowList
      AVAX_ROUTER // router
    );
    return
      address(
        new TransparentUpgradeableProxy(
          imple, // logic
          MiscAvalanche.PROXY_ADMIN, // proxy admin
          tokenPoolInitParams // data
        )
      );
  }
}
