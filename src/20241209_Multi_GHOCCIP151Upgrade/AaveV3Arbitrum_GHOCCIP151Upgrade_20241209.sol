// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {IUpgradeableBurnMintTokenPool_1_4, IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {ITokenAdminRegistry} from 'src/interfaces/ccip/ITokenAdminRegistry.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';

import {UpgradeableBurnMintTokenPool} from './utils/UpgradeableBurnMintTokenPool_1_4_WithdrawLiq.sol';

/**
 * @title GHO CCIP 1.5.1 Upgrade
 * @author Aave Labs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Arbitrum_GHOCCIP151Upgrade_20241209 is IProposalGenericExecutor {
  uint64 public constant ETH_CHAIN_SELECTOR = 5009297550715157269;

  // https://arbiscan.io/address/0x39AE1032cF4B334a1Ed41cdD0833bdD7c7E7751E
  ITokenAdminRegistry public constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(0x39AE1032cF4B334a1Ed41cdD0833bdD7c7E7751E);

  // https://arbiscan.io/address/0xF168B83598516A532a85995b52504a2Fa058C068
  IUpgradeableBurnMintTokenPool_1_4 public constant EXISTING_TOKEN_POOL =
    IUpgradeableBurnMintTokenPool_1_4(0xF168B83598516A532a85995b52504a2Fa058C068); // MiscArbitrum.GHO_CCIP_TOKEN_POOL; will be updated in address-book after AIP
  IUpgradeableBurnMintTokenPool_1_5_1 public immutable NEW_TOKEN_POOL;

  // https://etherscan.io/address/0x9Ec9F9804733df96D1641666818eFb5198eC50f0
  address public constant EXISTING_REMOTE_POOL_ETH = 0x9Ec9F9804733df96D1641666818eFb5198eC50f0; // ProxyPool on ETH
  address public immutable NEW_REMOTE_POOL_ETH;

  ProxyAdmin public constant PROXY_ADMIN = ProxyAdmin(MiscArbitrum.PROXY_ADMIN);
  IGhoToken public constant GHO = IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING);

  constructor(address newTokenPoolArb, address newTokenPoolEth) {
    NEW_TOKEN_POOL = IUpgradeableBurnMintTokenPool_1_5_1(newTokenPoolArb);
    NEW_REMOTE_POOL_ETH = newTokenPoolEth;
  }

  function execute() external {
    _acceptOwnership();
    _migrateLiquidity();
    _setupAndRegisterNewPool();
  }

  // pre-req - chainlink transfers gho token pool ownership on token admin registry
  function _acceptOwnership() internal {
    NEW_TOKEN_POOL.acceptOwnership();
    TOKEN_ADMIN_REGISTRY.acceptAdminRole(AaveV3ArbitrumAssets.GHO_UNDERLYING);
  }

  function _migrateLiquidity() internal {
    // bucketLevel === bridgedAmount
    (uint256 bucketCapacity, uint256 bucketLevel) = GHO.getFacilitatorBucket(
      address(EXISTING_TOKEN_POOL)
    );

    GHO.addFacilitator(address(NEW_TOKEN_POOL), 'CCIP v1.5.1 TokenPool', uint128(bucketCapacity));
    NEW_TOKEN_POOL.transferLiquidity(address(EXISTING_TOKEN_POOL), bucketLevel); // mintTo

    _upgradeExistingTokenPool();
    UpgradeableBurnMintTokenPool(address(EXISTING_TOKEN_POOL)).withdrawLiquidity(bucketLevel); // burn

    GHO.removeFacilitator(address(EXISTING_TOKEN_POOL));
  }

  function _setupAndRegisterNewPool() internal {
    IRateLimiter.Config memory emptyRateLimiterConfig = IRateLimiter.Config({
      isEnabled: false,
      capacity: 0,
      rate: 0
    });

    IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[]
      memory chains = new IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[](1);

    bytes[] memory remotePoolAddresses = new bytes[](2);
    remotePoolAddresses[0] = abi.encode(EXISTING_REMOTE_POOL_ETH);
    remotePoolAddresses[1] = abi.encode(NEW_REMOTE_POOL_ETH);

    chains[0] = IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate({
      remoteChainSelector: ETH_CHAIN_SELECTOR,
      remotePoolAddresses: remotePoolAddresses,
      remoteTokenAddress: abi.encode(MiscEthereum.GHO_TOKEN),
      outboundRateLimiterConfig: emptyRateLimiterConfig,
      inboundRateLimiterConfig: emptyRateLimiterConfig
    });

    // setup new pool
    NEW_TOKEN_POOL.applyChainUpdates(new uint64[](0), chains);
    NEW_TOKEN_POOL.setRateLimitAdmin(EXISTING_TOKEN_POOL.getRateLimitAdmin()); // GhoCcipSteward

    // register new pool
    TOKEN_ADMIN_REGISTRY.setPool(address(GHO), address(NEW_TOKEN_POOL));
  }

  function _upgradeExistingTokenPool() internal {
    address newImplementation = address(
      new UpgradeableBurnMintTokenPool(
        EXISTING_TOKEN_POOL.getToken(),
        EXISTING_TOKEN_POOL.getArmProxy(),
        EXISTING_TOKEN_POOL.getAllowListEnabled()
      )
    );

    PROXY_ADMIN.upgrade(
      TransparentUpgradeableProxy(payable(address(EXISTING_TOKEN_POOL))),
      newImplementation
    );
  }
}
