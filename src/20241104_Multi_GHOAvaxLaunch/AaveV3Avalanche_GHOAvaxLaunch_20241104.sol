// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {UpgradeableBurnMintTokenPool} from 'ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol';
import {UpgradeableTokenPool} from 'ccip/pools/GHO/UpgradeableTokenPool.sol';
import {RateLimiter} from 'ccip/libraries/RateLimiter.sol';
import {TokenAdminRegistry} from 'ccip/tokenAdminRegistry/TokenAdminRegistry.sol';
import {UpgradeableGhoToken} from 'gho-core/gho/UpgradeableGhoToken.sol';
import {IGhoToken} from 'gho-core/gho/interfaces/IGhoToken.sol';

library Utils {
  address public constant CCIP_RMN_PROXY = 0xcBD48A8eB077381c3c4Eb36b402d7283aB2b11Bc;
  address public constant CCIP_ROUTER = 0xF4c7E640EdA248ef95972845a62bdC74237805dB;
  // TODO: Wait for token admin registry to be deployed, and get proper address
  address public constant CCIP_TOKEN_ADMIN_REGISTRY = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
  uint256 public constant CCIP_BUCKET_CAPACITY = 25_000_000e18; // 25M
  uint64 public constant CCIP_ETH_CHAIN_SELECTOR = 5009297550715157269;
  uint64 public constant CCIP_ARB_CHAIN_SELECTOR = 4949039107694359620;

  function deployGhoToken() internal returns (address) {
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

  function deployCcipTokenPool(address ghoToken) external returns (address) {
    address imple = address(new UpgradeableBurnMintTokenPool(ghoToken, CCIP_RMN_PROXY, false));

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

/**
 * @title GHO Avax Launch
 * @author Aave Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x2aed7eb8b03cb3f961cbf790bf2e2e1e449f841a4ad8bdbcdd223bb6ac69e719
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-avalanche-set-aci-as-emissions-manager-for-rewards/19339
 * @dev This payload consists of the following set of actions:
 * 1. Deploy GHO
 * 2. Deploy BurnMintTokenPool
 * 3. Accept ownership of CCIP TokenPool
 * 4. Configure CCIP TokenPool for Ethereum
 * 5. Configure CCIP TokenPool for Arbitrum
 * 6. Add CCIP TokenPool as GHO Facilitator (allowing burn and mint)
 * 7. Accept administrator role from Chainlink token admin registry
 * 8. Link token to pool on Chainlink token admin registry
 * 9. List GHO on Avax in separate payload - because there is a delay to activate lane
 * 10. Supply GHO to the Aave protocol
 */
contract AaveV3Avalanche_GHOAvaxLaunch_20241104 is IProposalGenericExecutor {
  function execute() external {
    // 1. Deploy GHO
    address ghoToken = Utils.deployGhoToken();

    // 2. Deploy BurnMintTokenPool
    address tokenPool = Utils.deployCcipTokenPool(ghoToken);

    // 3. Accept TokenPool ownership
    UpgradeableBurnMintTokenPool(tokenPool).acceptOwnership();

    // 4. Configure CCIP TokenPool for Ethereum
    // TODO: Set remote pool and token addresses after deployment?
    _configureCcipTokenPool(tokenPool, Utils.CCIP_ETH_CHAIN_SELECTOR, address(0), address(0));

    // 5. Configure CCIP TokenPool for Arbitrum
    // TODO: Set remote pool and token addresses after deployment?
    _configureCcipTokenPool(tokenPool, Utils.CCIP_ARB_CHAIN_SELECTOR, address(0), address(0));

    // 6. Add CCIP TokenPool as GHO Facilitator
    IGhoToken(ghoToken).grantRole(
      IGhoToken(ghoToken).FACILITATOR_MANAGER_ROLE(),
      GovernanceV3Avalanche.EXECUTOR_LVL_1
    );
    IGhoToken(ghoToken).grantRole(
      IGhoToken(ghoToken).BUCKET_MANAGER_ROLE(),
      GovernanceV3Avalanche.EXECUTOR_LVL_1
    );
    IGhoToken(ghoToken).addFacilitator(
      tokenPool,
      'CCIP TokenPool',
      uint128(Utils.CCIP_BUCKET_CAPACITY)
    );

    // 7. Accept administrator role from Chainlink token manager
    TokenAdminRegistry(Utils.CCIP_TOKEN_ADMIN_REGISTRY).acceptAdminRole(ghoToken);

    // 8. Link token to pool on Chainlink token admin registry
    // TODO

    // 9. List GHO on Avax in separate payload
    // TODO

    // 10. Supply GHO to the Aave protocol
    // TODO
  }

  function _configureCcipTokenPool(
    address tokenPool,
    uint64 chainSelector,
    address remotePool,
    address remoteToken
  ) internal {
    UpgradeableTokenPool.ChainUpdate[] memory chainUpdates = new UpgradeableTokenPool.ChainUpdate[](
      1
    );
    RateLimiter.Config memory rateConfig = RateLimiter.Config({
      isEnabled: false,
      capacity: 0,
      rate: 0
    });
    chainUpdates[0] = UpgradeableTokenPool.ChainUpdate({
      remoteChainSelector: chainSelector,
      allowed: true,
      remotePoolAddress: abi.encode(remotePool),
      remoteTokenAddress: abi.encode(remoteToken),
      outboundRateLimiterConfig: rateConfig,
      inboundRateLimiterConfig: rateConfig
    });
    UpgradeableBurnMintTokenPool(tokenPool).applyChainUpdates(chainUpdates);
  }
}
