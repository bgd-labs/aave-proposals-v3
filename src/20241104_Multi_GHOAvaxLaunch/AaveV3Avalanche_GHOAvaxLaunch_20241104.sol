// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {UpgradeableBurnMintTokenPool} from 'ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol';
import {UpgradeableTokenPool} from 'ccip/pools/GHO/UpgradeableTokenPool.sol';
import {RateLimiter} from 'ccip/libraries/RateLimiter.sol';
import {UpgradeableGhoToken} from 'gho-core/gho/UpgradeableGhoToken.sol';
import {IGhoToken} from 'gho-core/gho/interfaces/IGhoToken.sol';

library Utils {
  address public constant CCIP_RMN_PROXY = 0xcBD48A8eB077381c3c4Eb36b402d7283aB2b11Bc;
  address public constant CCIP_ROUTER = 0xF4c7E640EdA248ef95972845a62bdC74237805dB;
  uint256 public constant CCIP_BUCKET_CAPACITY = 25_000_000e18; // 25M
  uint64 public constant CCIP_ETH_CHAIN_SELECTOR = 5009297550715157269;

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
 * 4. Configure CCIP TokenPool
 * 5. Add CCIP TokenPool as GHO Facilitator
 */
contract AaveV3Avalanche_GHOAvaxLaunch_20241104 is IProposalGenericExecutor {
  function execute() external {
    // 1. Deploy GHO
    address ghoToken = Utils.deployGhoToken();

    // 2. Deploy BurnMintTokenPool
    address tokenPool = Utils.deployCcipTokenPool(ghoToken);

    // 3. Accept TokenPool ownership
    UpgradeableBurnMintTokenPool(tokenPool).acceptOwnership();

    // 4. Configure CCIP TokenPool
    _configureCcipTokenPool(tokenPool);

    // 5. Add CCIP TokenPool as GHO Facilitator
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
  }

  function _configureCcipTokenPool(address tokenPool) internal {
    UpgradeableTokenPool.ChainUpdate[] memory chainUpdates = new UpgradeableTokenPool.ChainUpdate[](
      1
    );
    RateLimiter.Config memory rateConfig = RateLimiter.Config({
      isEnabled: false,
      capacity: 0,
      rate: 0
    });
    chainUpdates[0] = UpgradeableTokenPool.ChainUpdate({
      remoteChainSelector: Utils.CCIP_ETH_CHAIN_SELECTOR,
      allowed: true,
      remotePoolAddress: abi.encode(address(0)), // TODO: Set after deployment?
      remoteTokenAddress: abi.encode(address(0)), // TODO: Set after deployment?
      outboundRateLimiterConfig: rateConfig,
      inboundRateLimiterConfig: rateConfig
    });
    UpgradeableBurnMintTokenPool(tokenPool).applyChainUpdates(chainUpdates);
  }
}
