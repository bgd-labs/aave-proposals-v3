// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
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

  function deployGhoToken() internal returns (address imple, address proxy) {
    imple = GovV3Helpers.deployDeterministic(getUpgradeableGhoImpleCreationCode());
    proxy = GovV3Helpers.deployDeterministic(getUpgradeableGhoProxyCreationCode(imple));
  }

  function deployCcipTokenPool(address ghoToken) external returns (address imple, address proxy) {
    imple = GovV3Helpers.deployDeterministic(getCcipTokenPoolImpleCreationCode(ghoToken));
    proxy = GovV3Helpers.deployDeterministic(getCcipTokenPoolProxyCreationCode(imple));
  }

  function getCcipTokenPoolImpleCreationCode(
    address ghoToken
  ) internal pure returns (bytes memory) {
    return
      abi.encodePacked(
        type(UpgradeableBurnMintTokenPool).creationCode,
        abi.encode(
          ghoToken, // token
          CCIP_ARM_PROXY, // armProxy
          false // allowlistEnabled
        )
      );
  }

  function getCcipTokenPoolProxyCreationCode(address imple) internal pure returns (bytes memory) {
    bytes memory tokenPoolInitParams = abi.encodeWithSignature(
      'initialize(address,address[],address)',
      GovernanceV3Arbitrum.EXECUTOR_LVL_1, // owner
      new address[](0), // allowList
      CCIP_ROUTER // router
    );
    return
      abi.encodePacked(
        type(TransparentUpgradeableProxy).creationCode,
        abi.encode(
          imple, // logic
          MiscArbitrum.PROXY_ADMIN, // proxy admin
          tokenPoolInitParams // data
        )
      );
  }

  function getUpgradeableGhoImpleCreationCode() internal pure returns (bytes memory) {
    return type(UpgradeableGhoToken).creationCode;
  }

  function getUpgradeableGhoProxyCreationCode(address imple) internal pure returns (bytes memory) {
    bytes memory ghoTokenInitParams = abi.encodeWithSignature(
      'initialize(address)',
      GovernanceV3Arbitrum.EXECUTOR_LVL_1 // owner
    );
    return
      abi.encodePacked(
        type(TransparentUpgradeableProxy).creationCode,
        abi.encode(
          imple,
          MiscArbitrum.PROXY_ADMIN, // proxy admin
          ghoTokenInitParams
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
  address public immutable GHO;
  address public immutable GHO_IMPLE;
  address public immutable CCIP_TOKEN_POOL;
  address public immutable CCIP_TOKEN_POOL_IMPLE;

  constructor() {
    // Predict GHO contract address
    GHO_IMPLE = GovV3Helpers.predictDeterministicAddress(
      Utils.getUpgradeableGhoImpleCreationCode()
    );
    GHO = GovV3Helpers.predictDeterministicAddress(
      Utils.getUpgradeableGhoProxyCreationCode(GHO_IMPLE)
    );
    // Predict CCIP TokenPool contract address
    CCIP_TOKEN_POOL_IMPLE = GovV3Helpers.predictDeterministicAddress(
      Utils.getCcipTokenPoolImpleCreationCode(GHO)
    );
    CCIP_TOKEN_POOL = GovV3Helpers.predictDeterministicAddress(
      Utils.getCcipTokenPoolProxyCreationCode(CCIP_TOKEN_POOL_IMPLE)
    );
  }

  function execute() external {
    // 1. Deploy GHO
    (address ghoTokenImple, address ghoToken) = Utils.deployGhoToken();
    require(GHO_IMPLE == ghoTokenImple, 'UNEXPECTED_GHO_TOKEN_IMPL_ADDRESS');
    require(GHO == ghoToken, 'UNEXPECTED_GHO_TOKEN_ADDRESS');

    // 2. Deploy BurnMintTokenPool
    (address tokenPoolImple, address tokenPool) = Utils.deployCcipTokenPool(GHO);
    require(CCIP_TOKEN_POOL_IMPLE == tokenPoolImple, 'UNEXPECTED_CCIP_TOKEN_POOL_IMPL_ADDRESS');
    require(CCIP_TOKEN_POOL == tokenPool, 'UNEXPECTED_CCIP_TOKEN_POOL_ADDRESS');

    // 3. Accept TokenPool ownership
    UpgradeableBurnMintTokenPool(CCIP_TOKEN_POOL).acceptOwnership();

    // 4. Configure CCIP TokenPool
    _configureCcipTokenPool();

    // 5. Add CCIP TokenPool as GHO Facilitator
    IGhoToken(GHO).grantRole(
      IGhoToken(GHO).FACILITATOR_MANAGER_ROLE(),
      GovernanceV3Arbitrum.EXECUTOR_LVL_1
    );
    IGhoToken(GHO).grantRole(
      IGhoToken(GHO).BUCKET_MANAGER_ROLE(),
      GovernanceV3Arbitrum.EXECUTOR_LVL_1
    );
    IGhoToken(GHO).addFacilitator(
      CCIP_TOKEN_POOL,
      'CCIP TokenPool',
      uint128(Utils.CCIP_BUCKET_CAPACITY)
    );
  }

  function _configureCcipTokenPool() internal {
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
    UpgradeableBurnMintTokenPool(CCIP_TOKEN_POOL).applyChainUpdates(chainUpdates);
  }
}
