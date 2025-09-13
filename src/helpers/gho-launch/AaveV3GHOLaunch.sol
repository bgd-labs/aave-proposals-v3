// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IACLManager} from 'aave-address-book/AaveV3.sol';
import {ITokenAdminRegistry} from 'src/interfaces/ccip/ITokenAdminRegistry.sol';
import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {AaveV3GHOLane} from './AaveV3GHOLane.sol';
import {GhoCCIPChains} from './constants/GhoCCIPChains.sol';
import {IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';

/**
 * @title GHO Launch
 * @author Aave Labs
 * @notice Proposal Executor for Aave V3 GHO Launch
 */
abstract contract AaveV3GHOLaunch is AaveV3GHOLane {
  uint64 public immutable LOCAL_CHAIN_SELECTOR;
  IGhoToken public immutable GHO_TOKEN;
  ITokenAdminRegistry public immutable TOKEN_ADMIN_REGISTRY;
  IACLManager public immutable ACL_MANAGER;
  address public immutable GHO_BUCKET_STEWARD;
  address public immutable GHO_AAVE_STEWARD;
  address public immutable GHO_CCIP_STEWARD;
  address public immutable OWNER;

  /**
   * @notice Default CCIP bucket capacity to configure for the CCIP GHO Token Pool. Override `getCCIPBucketCapacity` in
   * order to change this value.
   */
  uint128 internal constant DEFAULT_CCIP_BUCKET_CAPACITY = 40_000_000e18;

  /**
   * @notice Constructor
   * @param localChainInfo The relevant information of the local chain where GHO is being launched.
   */
  constructor(GhoCCIPChains.ChainInfo memory localChainInfo) AaveV3GHOLane(localChainInfo) {
    LOCAL_CHAIN_SELECTOR = localChainInfo.chainSelector;
    GHO_TOKEN = IGhoToken(localChainInfo.ghoToken);
    GHO_BUCKET_STEWARD = localChainInfo.ghoBucketSteward;
    GHO_AAVE_STEWARD = localChainInfo.ghoAaveCoreSteward;
    GHO_CCIP_STEWARD = localChainInfo.ghoCCIPSteward;
    ACL_MANAGER = IACLManager(localChainInfo.aclManager);
    TOKEN_ADMIN_REGISTRY = ITokenAdminRegistry(localChainInfo.tokenAdminRegistry);
    OWNER = localChainInfo.owner;
  }

  /**
   * @notice Executes the GHO Launch proposal
   */
  function execute() external override {
    _acceptTokenAdminRegistryAdminRole();
    _acceptTokenPoolOwnership();
    _setupStewardsAndTokenPoolOnGho();
    _applyChainUpdatesInTokenPool();
    _setPoolInTokenAdminRegistry();
  }

  function lanesToAdd()
    public
    view
    virtual
    override
    returns (IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[] memory)
  {
    GhoCCIPChains.ChainInfo[] memory chainsToSupport = GhoCCIPChains.getAllChainsExcept(
      LOCAL_CHAIN_SELECTOR
    );
    IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[]
      memory chainsToAdd = new IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[](
        chainsToSupport.length
      );
    for (uint256 i = 0; i < chainsToSupport.length; i++) {
      chainsToAdd[i] = _asChainUpdateWithDefaultRateLimiterConfig(chainsToSupport[i]);
    }
    return chainsToAdd;
  }

  /**
   * @notice Returns the CCIP bucket capacity to configure for the CCIP GHO Token Pool
   * @return The CCIP bucket capacity to configure for the CCIP GHO Token Pool
   */
  function getCCIPBucketCapacity() public pure virtual returns (uint128) {
    return DEFAULT_CCIP_BUCKET_CAPACITY;
  }

  function _acceptTokenAdminRegistryAdminRole() internal virtual {
    TOKEN_ADMIN_REGISTRY.acceptAdminRole(address(GHO_TOKEN));
  }

  function _acceptTokenPoolOwnership() internal virtual {
    TOKEN_POOL.acceptOwnership();
  }

  function _setupStewardsAndTokenPoolOnGho() internal virtual {
    _setupFacilitatorManagerRoleInGhoToken();
    _setupBucketManagerRoleInGhoToken();
    _setupTokenPoolAsFacilitatorInGhoToken();
    _setupGhoAaveSteward();
    _setupGhoBucketSteward();
    _setupGhoCCIPSteward();
  }

  function _setupFacilitatorManagerRoleInGhoToken() internal virtual {
    GHO_TOKEN.grantRole(GHO_TOKEN.FACILITATOR_MANAGER_ROLE(), OWNER);
  }

  function _setupBucketManagerRoleInGhoToken() internal virtual {
    GHO_TOKEN.grantRole(GHO_TOKEN.BUCKET_MANAGER_ROLE(), OWNER);
  }

  function _setupTokenPoolAsFacilitatorInGhoToken() internal virtual {
    GHO_TOKEN.addFacilitator(address(TOKEN_POOL), 'CCIP TokenPool v1.5.1', getCCIPBucketCapacity());
  }

  function _setupGhoAaveSteward() internal virtual {
    ACL_MANAGER.grantRole(ACL_MANAGER.RISK_ADMIN_ROLE(), GHO_AAVE_STEWARD);
  }

  function _setupGhoBucketSteward() internal virtual {
    _setupGhoBucketStewardAsBucketManagerInGhoToken();
    _setupGhoBucketStewardAsControlledFacilitatorInGhoBucketSteward();
  }

  function _setupGhoBucketStewardAsBucketManagerInGhoToken() internal virtual {
    GHO_TOKEN.grantRole(GHO_TOKEN.BUCKET_MANAGER_ROLE(), GHO_BUCKET_STEWARD);
  }

  function _setupGhoBucketStewardAsControlledFacilitatorInGhoBucketSteward() internal virtual {
    address[] memory facilitatorList = new address[](1);
    facilitatorList[0] = address(TOKEN_POOL);
    IGhoBucketSteward(GHO_BUCKET_STEWARD).setControlledFacilitator({
      facilitatorList: facilitatorList,
      approve: true
    });
  }

  function _setupGhoCCIPSteward() internal virtual {
    TOKEN_POOL.setRateLimitAdmin(GHO_CCIP_STEWARD);
  }

  function _applyChainUpdatesInTokenPool() internal virtual {
    AaveV3GHOLane._execute();
  }

  function _setPoolInTokenAdminRegistry() internal virtual {
    TOKEN_ADMIN_REGISTRY.setPool(address(GHO_TOKEN), address(TOKEN_POOL));
  }
}
