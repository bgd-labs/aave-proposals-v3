// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {UpgradeableBurnMintTokenPool} from 'ccip/v0.8/ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol';
import {UpgradeableTokenPool} from 'ccip/v0.8/ccip/pools/GHO/UpgradeableTokenPool.sol';
import {RateLimiter} from 'ccip/v0.8/ccip/libraries/RateLimiter.sol';
import {UpgradeableGhoToken} from 'gho-core/gho/UpgradeableGhoToken.sol';
import {IGhoToken} from 'gho-core/gho/interfaces/IGhoToken.sol';

library Utils {
  address public constant CCIP_ARM_PROXY = 0xC311a21e6fEf769344EB1515588B9d535662a145;
  address public constant CCIP_ROUTER = 0x141fa059441E0ca23ce184B6A78bafD2A517DdE8;
  uint256 public constant CCIP_BUCKET_CAPACITY = 1_000_000e18; // 1M
  uint64 public constant CCIP_ETH_CHAIN_SELECTOR = 5009297550715157269;

  function deployGhoToken() internal returns (address) {
    address imple = address(new UpgradeableGhoToken());

    bytes memory ghoTokenInitParams = abi.encodeWithSignature(
      'initialize(address)',
      GovernanceV3Arbitrum.EXECUTOR_LVL_1 // owner
    );
    return
      address(new TransparentUpgradeableProxy(imple, MiscArbitrum.PROXY_ADMIN, ghoTokenInitParams));
  }

  function deployCcipTokenPool(address ghoToken) external returns (address) {
    address imple = address(new UpgradeableBurnMintTokenPool(ghoToken, CCIP_ARM_PROXY, false));

    bytes memory tokenPoolInitParams = abi.encodeWithSignature(
      'initialize(address,address[],address)',
      GovernanceV3Arbitrum.EXECUTOR_LVL_1, // owner
      new address[](0), // allowList
      CCIP_ROUTER // router
    );
    return
      address(
        new TransparentUpgradeableProxy(
          imple, // logic
          MiscArbitrum.PROXY_ADMIN, // proxy admin
          tokenPoolInitParams // data
        )
      );
  }
}

/**
 * @title GHO Cross-Chain Launch
 * @author Aave Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x2a6ffbcff41a5ef98b7542f99b207af9c1e79e61f859d0a62f3bf52d3280877a
 * - Discussion: https://governance.aave.com/t/arfc-gho-cross-chain-launch/17616
 * @dev This payload consists of the following set of actions:
 * 1. Deploy GHO
 * 2. Deploy BurnMintTokenPool
 * 3. Accept ownership of CCIP TokenPool
 * 4. Configure CCIP TokenPool
 * 5. Add CCIP TokenPool as GHO Facilitator
 */
contract AaveV3Arbitrum_GHOCrossChainLaunch_20240528 is IProposalGenericExecutor {
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
      GovernanceV3Arbitrum.EXECUTOR_LVL_1
    );
    IGhoToken(ghoToken).grantRole(
      IGhoToken(ghoToken).BUCKET_MANAGER_ROLE(),
      GovernanceV3Arbitrum.EXECUTOR_LVL_1
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
      outboundRateLimiterConfig: rateConfig,
      inboundRateLimiterConfig: rateConfig
    });
    UpgradeableBurnMintTokenPool(tokenPool).applyChainUpdates(chainUpdates);
  }
}
