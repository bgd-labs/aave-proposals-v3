// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {TokenAdminRegistry} from 'ccip/tokenAdminRegistry/TokenAdminRegistry.sol';
import {UpgradeableBurnMintTokenPool} from 'ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol';
import {UpgradeableGhoToken} from 'gho-core/gho/UpgradeableGhoToken.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_GHOAvaxLaunch_20241106} from './AaveV3Avalanche_GHOAvaxLaunch_20241106.sol';

/**
 * @dev Test for AaveV3Avalanche_GHOAvaxLaunch_20241106
 * command: FOUNDRY_PROFILE=avalanche forge test --match-path=src/20241106_Multi_GHOAvaxLaunch/AaveV3Avalanche_GHOAvaxLaunch_20241106.t.sol -vv
 */
contract AaveV3Avalanche_GHOAvaxLaunch_20241106_Test is ProtocolV3TestBase {
  AaveV3Avalanche_GHOAvaxLaunch_20241106 internal proposal;

  address public constant TOKEN_ADMIN_REGISTRY = 0xc8df5D618c6a59Cc6A311E96a39450381001464F;
  address public constant REGISTRY_ADMIN = 0xA3f32a07CCd8569f49cf350D4e61C016CA484644;
  // TODO: Remove these constants once we have deployed pool address
  address public constant CCIP_RMN_PROXY = 0xcBD48A8eB077381c3c4Eb36b402d7283aB2b11Bc;
  address public constant CCIP_ROUTER = 0xF4c7E640EdA248ef95972845a62bdC74237805dB;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 53559217);

    // TODO: Remove this and put back in proposal after Chainlink sets executor as pending admin
    address ghoToken = _deployGhoToken();

    // TODO: Remove this deployment once we have deployed pool address
    address tokenPool = _deployCcipTokenPool(ghoToken);

    // TODO: Remove this (will be done on chainlink's side)
    // Prank chainlink and set up admin role to be accepted on token registry
    vm.startPrank(REGISTRY_ADMIN);
    TokenAdminRegistry(TOKEN_ADMIN_REGISTRY).proposeAdministrator(
      ghoToken,
      GovernanceV3Avalanche.EXECUTOR_LVL_1
    );
    vm.stopPrank();

    proposal = new AaveV3Avalanche_GHOAvaxLaunch_20241106();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Avalanche_GHOAvaxLaunch_20241106', AaveV3Avalanche.POOL, address(proposal));
  }

  function _deployGhoToken() internal returns (address) {
    address imple = address(new UpgradeableGhoToken());

    bytes memory ghoTokenInitParams = abi.encodeWithSignature(
      'initialize(address)',
      GovernanceV3Avalanche.EXECUTOR_LVL_1 // owner
    );
    return
      address(
        new TransparentUpgradeableProxy(imple, MiscAvalanche.PROXY_ADMIN, ghoTokenInitParams)
      );
  }

  function _deployCcipTokenPool(address ghoToken) internal returns (address) {
    address imple = address(new UpgradeableBurnMintTokenPool(ghoToken, CCIP_RMN_PROXY, false));
    UpgradeableBurnMintTokenPool(imple).transferOwnership(GovernanceV3Avalanche.EXECUTOR_LVL_1);

    bytes memory tokenPoolInitParams = abi.encodeWithSignature(
      'initialize(address,address[],address)',
      GovernanceV3Avalanche.EXECUTOR_LVL_1, // owner
      new address[](0), // allowList
      CCIP_ROUTER // router
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
