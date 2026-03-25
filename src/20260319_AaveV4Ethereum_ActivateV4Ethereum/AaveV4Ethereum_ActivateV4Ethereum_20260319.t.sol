// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {ProtocolV4TestBase} from 'src/helpers/v4/tests/utils/ProtocolV4TestBase.sol';
import {IAccessManagerEnumerable} from './interfaces/IAccessManagerEnumerable.sol';
import {IHub} from './interfaces/IHub.sol';
import {IHubConfigurator} from './interfaces/IHubConfigurator.sol';
import {ISpoke} from './interfaces/ISpoke.sol';
import {ISpokeConfigurator} from './interfaces/ISpokeConfigurator.sol';
import {IAccessManaged} from './interfaces/IAccessManaged.sol';
import {Roles} from './Roles.sol';
import {AaveV4EthereumAddresses, AaveV4EthereumHubs, AaveV4EthereumSpokes, AaveV4EthereumTokenizationSpokes} from './AaveV4EthereumAddresses.sol';
import {AaveV4Ethereum_ActivateV4Ethereum_20260319} from './AaveV4Ethereum_ActivateV4Ethereum_20260319.sol';

/**
 * @dev Test for AaveV4Ethereum_ActivateV4Ethereum_20260319
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260319_AaveV4Ethereum_ActivateV4Ethereum/AaveV4Ethereum_ActivateV4Ethereum_20260319.t.sol -vv
 */
contract AaveV4Ethereum_ActivateV4Ethereum_20260319_Test is ProtocolV4TestBase {
  AaveV4Ethereum_ActivateV4Ethereum_20260319 internal proposal;

  address internal constant DEPLOYER = 0xB00A89E5C8756bA8629846eEF8a4a9C71Ad1930A;
  address internal constant SECURITY_COUNCIL = 0x187AAE17d4931310B3fc75743e7F16Bdc9eD77e9;
  address internal constant TMP_EXECUTOR = 0x778b07a501a7a8d7625e51C3Ea84D090118f0161;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24729090);
    proposal = new AaveV4Ethereum_ActivateV4Ethereum_20260319();
  }

  /**
   * @dev executes the generic test suite including e2e
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV4Ethereum_ActivateV4Ethereum_20260319',
      AaveV4EthereumSpokes.getUserSpokes(),
      AaveV4EthereumTokenizationSpokes.getTokenizationSpokes(),
      address(proposal)
    );
  }

  function test_allSpokesInactiveBeforeExecution() public view {
    IHub[] memory hubs = AaveV4EthereumHubs.getHubs();

    for (uint256 hubIdx; hubIdx < hubs.length; ++hubIdx) {
      uint256 assetCount = hubs[hubIdx].getAssetCount();
      for (uint256 assetId; assetId < assetCount; ++assetId) {
        uint256 spokeCount = hubs[hubIdx].getSpokeCount(assetId);
        for (uint256 spokeId; spokeId < spokeCount; ++spokeId) {
          address spoke = hubs[hubIdx].getSpokeAddress(assetId, spokeId);
          IHub.SpokeConfig memory config = hubs[hubIdx].getSpokeConfig(assetId, spoke);
          assertFalse(config.active, 'Spoke should be inactive before execution');
        }
      }
    }
  }

  function test_allSpokesActiveOnCoreHub() public {
    executePayload(vm, address(proposal));
    _assertAllSpokesActiveOnHub(AaveV4EthereumHubs.CORE_HUB);
  }

  function test_allSpokesActiveOnPlusHub() public {
    executePayload(vm, address(proposal));
    _assertAllSpokesActiveOnHub(AaveV4EthereumHubs.PLUS_HUB);
  }

  function test_allSpokesActiveOnPrimeHub() public {
    executePayload(vm, address(proposal));
    _assertAllSpokesActiveOnHub(AaveV4EthereumHubs.PRIME_HUB);
  }

  // |--------------------------------------------------------------------------------------------------------------|
  // | Target             | Role                                   | ID  | Holder                                   |
  // |--------------------|----------------------------------------|-----|------------------------------------------|
  // | Access Manager     | ACCESS_MANAGER_ADMIN_ROLE              | 0   | DAO, Security Council                    |
  // | Hub                | HUB_CONFIGURATOR_ROLE                  | 101 | HubConfigurator                          |
  // | Hub                | HUB_FEE_MINTER_ROLE                    | 102 | DAO, Security Council                    |
  // | Hub                | HUB_DEFICIT_ELIMINATOR_ROLE            | 103 | DAO, Security Council                    |
  // | HubConfigurator    | HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE     | 200 | DAO                                      |
  // | Spoke              | SPOKE_CONFIGURATOR_ROLE                | 301 | SpokeConfigurator                        |
  // | Spoke              | SPOKE_USER_POSITION_UPDATER_ROLE       | 302 | DAO, Security Council                    |
  // | SpokeConfigurator  | SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE   | 400 | DAO, Security Council                    |
  // | Hub                | Proxy Admin Owner                      |     | Security Council                         |
  // | Spoke              | Proxy Admin Owner                      |     | Security Council                         |
  // | Tokenization Spoke | Proxy Admin Owner                      |     | Security Council                         |
  // | Position Managers  | Owner                                  |     | Security Council                         |
  // | Treasury Spoke     | Owner                                  |     | Security Council                         |
  // ---------------------------------------------------------------------------------------------------------------|

  /// @dev Access Manager Admin Role - DAO, Security Council
  function test_AccessManagerAdminRole() public view {
    uint64 roleId = Roles.ACCESS_MANAGER_ADMIN_ROLE;

    _assertRoleHolders(roleId);
    _assertTempAddrsDoNotHaveRole(roleId);
  }

  /// @dev Executor can grant roles to another account
  function test_executorCanGrantRoles() public {
    IAccessManagerEnumerable accessManager = IAccessManagerEnumerable(
      AaveV4EthereumAddresses.ACCESS_MANAGER
    );

    // Grant admin role to another account
    address randomAccount = address(0xBEEF);
    vm.prank(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    accessManager.grantRole(Roles.ACCESS_MANAGER_ADMIN_ROLE, randomAccount, 0);
    (bool granted, ) = accessManager.hasRole(Roles.ACCESS_MANAGER_ADMIN_ROLE, randomAccount);
    assertTrue(granted, 'Executor should be able to grant admin role to another account');

    // Grant itself an existing role it does not yet hold
    vm.prank(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    accessManager.grantRole(Roles.HUB_DOMAIN_ADMIN_ROLE, GovernanceV3Ethereum.EXECUTOR_LVL_1, 0);
    (bool selfGranted, ) = accessManager.hasRole(
      Roles.HUB_DOMAIN_ADMIN_ROLE,
      GovernanceV3Ethereum.EXECUTOR_LVL_1
    );
    assertTrue(selfGranted, 'Executor should be able to grant itself another role');
  }

  /// @dev HubConfigurator can change config on a spoke
  function test_HubConfiguratorRole() public {
    uint64 roleId = Roles.HUB_CONFIGURATOR_ROLE;
    _assertTempAddrsDoNotHaveRole(roleId);

    address[] memory expected = new address[](1);
    expected[0] = AaveV4EthereumAddresses.HUB_CONFIGURATOR;
    _assertExactRoleHolders(roleId, expected);

    IHub hub = _getRandomHub();
    uint256 assetId = _getRandomAssetId(hub);
    address spoke = _getRandomSpoke(hub, assetId);

    IHub.SpokeConfig memory configBefore = hub.getSpokeConfig({assetId: assetId, spoke: spoke});
    assertFalse(configBefore.active, 'Spoke should be inactive before');

    vm.prank(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    IHubConfigurator(AaveV4EthereumAddresses.HUB_CONFIGURATOR).updateSpokeActive({
      hub: address(hub),
      assetId: assetId,
      spoke: spoke,
      active: true
    });

    IHub.SpokeConfig memory configAfter = hub.getSpokeConfig({assetId: assetId, spoke: spoke});
    assertTrue(configAfter.active, 'Spoke should be active after');
  }

  /// @dev HubFeeMinterRole - not granted to any account
  function test_FeeMinterRole() public {
    uint64 roleId = Roles.HUB_FEE_MINTER_ROLE;

    _assertTempAddrsDoNotHaveRole(roleId);
    _assertZeroRoleHolders(roleId);

    IHub hub = _getRandomHub();
    uint256 assetId = _getRandomAssetId(hub);

    vm.expectRevert(
      abi.encodeWithSelector(
        IAccessManaged.AccessManagedUnauthorized.selector,
        GovernanceV3Ethereum.EXECUTOR_LVL_1
      )
    );
    vm.prank(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    hub.mintFeeShares({assetId: assetId});
  }

  /// @dev HubDeficitEliminatorRole - not granted to any account
  function test_HubDeficitEliminatorRole() public {
    uint64 roleId = Roles.HUB_DEFICIT_ELIMINATOR_ROLE;

    _assertTempAddrsDoNotHaveRole(roleId);
    _assertZeroRoleHolders(roleId);

    IHub hub = _getRandomHub();
    uint256 assetId = _getRandomAssetId(hub);
    address spoke = makeAddr('newSpoke');

    vm.startPrank(AaveV4EthereumAddresses.HUB_CONFIGURATOR);
    hub.addSpoke({
      assetId: 0,
      spoke: spoke,
      params: IHub.SpokeConfig({
        addCap: type(uint40).max,
        drawCap: 0,
        riskPremiumThreshold: 0,
        active: true,
        halted: false
      })
    });
    vm.expectRevert(
      abi.encodeWithSelector(
        IAccessManaged.AccessManagedUnauthorized.selector,
        AaveV4EthereumAddresses.HUB_CONFIGURATOR
      )
    );
    hub.eliminateDeficit({assetId: assetId, amount: 1, spoke: spoke});
    vm.stopPrank();
  }

  /// @dev HubConfiguratorDomainAdminRole - DAO
  function test_HubConfiguratorDomainAdminRole() public {
    uint64 roleId = Roles.HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE;
    address[] memory expectedHolders = new address[](1);
    expectedHolders[0] = GovernanceV3Ethereum.EXECUTOR_LVL_1;

    _assertTempAddrsDoNotHaveRole(roleId);
    _assertExactRoleHolders(roleId, expectedHolders);

    address spoke = AaveV4EthereumHubs.CORE_HUB.getSpokeAddress({assetId: 0, index: 0});
    IHub.SpokeConfig memory configBefore = AaveV4EthereumHubs.CORE_HUB.getSpokeConfig({
      assetId: 0,
      spoke: spoke
    });
    assertFalse(configBefore.active, 'Spoke should be inactive before');

    vm.prank(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    IHubConfigurator(AaveV4EthereumAddresses.HUB_CONFIGURATOR).updateSpokeActive({
      hub: address(AaveV4EthereumHubs.CORE_HUB),
      assetId: 0,
      spoke: spoke,
      active: true
    });

    IHub.SpokeConfig memory configAfter = AaveV4EthereumHubs.CORE_HUB.getSpokeConfig({
      assetId: 0,
      spoke: spoke
    });
    assertTrue(configAfter.active, 'Spoke should be active after');
  }

  /// @dev SpokeConfiguratorRole - spokeConfigurator contract
  function test_SpokeConfiguratorRole() public {
    uint64 roleId = Roles.SPOKE_CONFIGURATOR_ROLE;

    _assertTempAddrsDoNotHaveRole(roleId);
    address[] memory expected = new address[](1);
    expected[0] = AaveV4EthereumAddresses.SPOKE_CONFIGURATOR;
    _assertExactRoleHolders(roleId, expected);

    vm.expectRevert(
      abi.encodeWithSelector(
        IAccessManaged.AccessManagedUnauthorized.selector,
        GovernanceV3Ethereum.EXECUTOR_LVL_1
      )
    );
    vm.prank(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    ISpokeConfigurator(AaveV4EthereumAddresses.SPOKE_CONFIGURATOR).updatePaused({
      spoke: address(AaveV4EthereumSpokes.MAIN_SPOKE),
      reserveId: 0,
      paused: true
    });
  }

  /// @dev SpokeUserPositionUpdaterRole - role not granted
  function test_SpokeUserPositionUpdaterRole() public {
    uint64 roleId = Roles.SPOKE_USER_POSITION_UPDATER_ROLE;
    _assertTempAddrsDoNotHaveRole(roleId);
    _assertZeroRoleHolders(roleId);

    vm.expectRevert();
    vm.prank(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    AaveV4EthereumSpokes.MAIN_SPOKE.updateUserRiskPremium(address(this));
  }

  /// @dev SpokeConfiguratorDomainAdminRole - role not granted
  function test_SpokeConfiguratorDomainAdminRole() public {
    uint64 roleId = Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE;
    _assertTempAddrsDoNotHaveRole(roleId);
    _assertZeroRoleHolders(roleId);

    vm.expectRevert(
      abi.encodeWithSelector(
        IAccessManaged.AccessManagedUnauthorized.selector,
        GovernanceV3Ethereum.EXECUTOR_LVL_1
      )
    );
    vm.prank(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    ISpokeConfigurator(AaveV4EthereumAddresses.SPOKE_CONFIGURATOR).updatePaused({
      spoke: address(AaveV4EthereumSpokes.MAIN_SPOKE),
      reserveId: 0,
      paused: true
    });
  }

  /// @dev AccessManagerAdminRole - DAO, Security Council
  function test_hasRole_AccessManagerAdminRole() public view {
    _assertHasRole(Roles.ACCESS_MANAGER_ADMIN_ROLE, GovernanceV3Ethereum.EXECUTOR_LVL_1);
    _assertHasRole(Roles.ACCESS_MANAGER_ADMIN_ROLE, SECURITY_COUNCIL);
  }

  /// @dev HubConfigurator Role - hub configurator contract
  function test_hasRole_HubConfiguratorRole() public view {
    _assertHasRole(Roles.HUB_CONFIGURATOR_ROLE, AaveV4EthereumAddresses.HUB_CONFIGURATOR);
  }

  /// @dev HubFeeMinterRole - not granted to any account
  function test_hasRole_HubFeeMinterRole() public view {
    uint64 roleId = Roles.HUB_FEE_MINTER_ROLE;
    _assertTempAddrsDoNotHaveRole(roleId);
    _assertZeroRoleHolders(roleId);
  }

  /// @dev HubDeficitEliminatorRole - not granted to any account
  function test_hasRole_HubDeficitEliminatorRole() public view {
    uint64 roleId = Roles.HUB_DEFICIT_ELIMINATOR_ROLE;

    _assertTempAddrsDoNotHaveRole(roleId);
    _assertZeroRoleHolders(roleId);
  }

  /// @dev HubConfiguratorDomainAdminRole - DAO
  function test_hasRole_HubConfiguratorDomainAdminRole() public view {
    _assertHasRole(Roles.HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE, GovernanceV3Ethereum.EXECUTOR_LVL_1);
  }

  /// @dev SpokeConfiguratorRole - spokeConfigurator contract
  function test_hasRole_SpokeConfiguratorRole() public view {
    _assertHasRole(Roles.SPOKE_CONFIGURATOR_ROLE, AaveV4EthereumAddresses.SPOKE_CONFIGURATOR);
  }

  /// @dev SpokeUserPositionUpdaterRole - role not granted
  function test_hasRole_SpokeUserPositionUpdaterRole() public view {
    uint64 roleId = Roles.SPOKE_USER_POSITION_UPDATER_ROLE;
    _assertTempAddrsDoNotHaveRole(roleId);
    _assertZeroRoleHolders(roleId);
  }

  /// @dev SpokeConfiguratorDomainAdminRole - role not granted
  function test_hasRole_SpokeConfiguratorDomainAdminRole() public view {
    uint64 roleId = Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE;
    _assertTempAddrsDoNotHaveRole(roleId);
    _assertZeroRoleHolders(roleId);
  }

  function test_allRolesAreLabeled() public view {
    IAccessManagerEnumerable accessManager = IAccessManagerEnumerable(
      AaveV4EthereumAddresses.ACCESS_MANAGER
    );
    uint64[] memory roles = new uint64[](9);
    roles[0] = Roles.HUB_DOMAIN_ADMIN_ROLE;
    roles[1] = Roles.HUB_CONFIGURATOR_ROLE;
    roles[2] = Roles.HUB_FEE_MINTER_ROLE;
    roles[3] = Roles.HUB_DEFICIT_ELIMINATOR_ROLE;
    roles[4] = Roles.HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE;
    roles[5] = Roles.SPOKE_DOMAIN_ADMIN_ROLE;
    roles[6] = Roles.SPOKE_CONFIGURATOR_ROLE;
    roles[7] = Roles.SPOKE_USER_POSITION_UPDATER_ROLE;
    roles[8] = Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE;

    for (uint256 i; i < roles.length; ++i) {
      assertTrue(accessManager.isRoleLabeled(roles[i]), 'Role should be labeled');
    }
  }

  function test_hubProxyAdminsOwnedBySecurityCouncil() public view {
    IHub[] memory hubs = AaveV4EthereumHubs.getHubs();
    for (uint256 i; i < hubs.length; ++i) {
      _assertProxyAdminOwner(address(hubs[i]), SECURITY_COUNCIL);
    }
  }

  function test_spokeProxyAdminsOwnedBySecurityCouncil() public view {
    ISpoke[] memory spokes = AaveV4EthereumSpokes.getSpokes();
    for (uint256 i; i < spokes.length; ++i) {
      _assertProxyAdminOwner(address(spokes[i]), SECURITY_COUNCIL);
    }
  }

  function test_tokenizationSpokeProxyAdminsOwnedBySecurityCouncil() public view {
    address[] memory tokenizationSpokes = AaveV4EthereumTokenizationSpokes.getTokenizationSpokes();
    for (uint256 spokeIdx; spokeIdx < tokenizationSpokes.length; ++spokeIdx) {
      _assertProxyAdminOwner(tokenizationSpokes[spokeIdx], SECURITY_COUNCIL);
    }
  }

  /// @dev Asserts DAO + Security Council hold the ACCESS_MANAGER_ADMIN_ROLE.
  function _assertRoleHolders(uint64 roleId) internal view {
    address[] memory expected = new address[](2);
    expected[0] = SECURITY_COUNCIL;
    expected[1] = GovernanceV3Ethereum.EXECUTOR_LVL_1;
    _assertExactRoleHolders(roleId, expected);
  }

  function _assertHasRole(uint64 roleId, address account) internal view {
    IAccessManagerEnumerable accessManager = IAccessManagerEnumerable(
      AaveV4EthereumAddresses.ACCESS_MANAGER
    );
    (bool hasRole, ) = accessManager.hasRole(roleId, account);
    assertTrue(hasRole, 'Expected account to have role');
  }

  function _assertDoesNotHaveRole(uint64 roleId, address account) internal view {
    IAccessManagerEnumerable accessManager = IAccessManagerEnumerable(
      AaveV4EthereumAddresses.ACCESS_MANAGER
    );
    (bool hasRole, ) = accessManager.hasRole(roleId, account);
    assertFalse(hasRole, 'Expected account to not have role');
  }

  function _assertTempAddrsDoNotHaveRole(uint64 roleId) internal view {
    _assertDoesNotHaveRole(roleId, DEPLOYER);
    _assertDoesNotHaveRole(roleId, TMP_EXECUTOR);
  }

  function _assertZeroRoleHolders(uint64 roleId) internal view {
    IAccessManagerEnumerable accessManager = IAccessManagerEnumerable(
      AaveV4EthereumAddresses.ACCESS_MANAGER
    );
    uint256 memberCount = accessManager.getRoleMemberCount(roleId);
    assertEq(memberCount, 0, 'Role should have no members');
  }

  function _assertExactRoleHolders(uint64 roleId, address[] memory expectedHolders) internal view {
    for (uint256 i; i < expectedHolders.length; ++i) {
      for (uint256 j = i + 1; j < expectedHolders.length; ++j) {
        assertTrue(expectedHolders[i] != expectedHolders[j], 'Duplicate in expectedHolders');
      }
    }

    IAccessManagerEnumerable accessManager = IAccessManagerEnumerable(
      AaveV4EthereumAddresses.ACCESS_MANAGER
    );
    uint256 memberCount = accessManager.getRoleMemberCount(roleId);
    assertEq(memberCount, expectedHolders.length, 'Role member count mismatch');

    address[] memory actualMembers = accessManager.getRoleMembers(roleId, 0, memberCount);
    for (uint256 i; i < expectedHolders.length; ++i) {
      bool found;
      for (uint256 j; j < actualMembers.length; ++j) {
        if (actualMembers[j] == expectedHolders[i]) {
          found = true;
          break;
        }
      }
      assertTrue(found, 'Expected role holder not found');
    }
  }

  function _getRandomHub() internal view returns (IHub) {
    return AaveV4EthereumHubs.getHubs()[vm.randomUint(0, AaveV4EthereumHubs.getHubs().length - 1)];
  }

  function _getRandomAssetId(IHub hub) internal view returns (uint256) {
    return vm.randomUint(0, hub.getAssetCount() - 1);
  }

  function _getRandomSpoke(IHub hub, uint256 assetId) internal view returns (address) {
    return
      hub.getSpokeAddress({
        assetId: assetId,
        index: vm.randomUint(0, hub.getSpokeCount(assetId) - 1)
      });
  }

  /// @dev Reads the EIP-1967 admin slot to find the proxy admin, then checks its owner.
  function _assertProxyAdminOwner(address proxy, address expectedOwner) internal view {
    // EIP-1967 admin slot: bytes32(uint256(keccak256('eip1967.proxy.admin')) - 1)
    bytes32 adminSlot = 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103;
    address proxyAdmin = address(uint160(uint256(vm.load(proxy, adminSlot))));
    (bool success, bytes memory data) = proxyAdmin.staticcall(abi.encodeWithSignature('owner()'));
    require(success, 'owner() call failed on proxy admin');
    address owner = abi.decode(data, (address));
    assertEq(owner, expectedOwner, 'Proxy admin owner mismatch');
  }

  function _assertAllSpokesActiveOnHub(IHub hub) internal view {
    for (uint256 assetId; assetId < hub.getAssetCount(); ++assetId) {
      uint256 spokeCount = hub.getSpokeCount(assetId);
      for (uint256 spokeId; spokeId < spokeCount; ++spokeId) {
        address spoke = hub.getSpokeAddress(assetId, spokeId);
        IHub.SpokeConfig memory config = hub.getSpokeConfig(assetId, spoke);
        assertTrue(config.active, 'Spoke should be active after execution');
      }
    }
  }
}
