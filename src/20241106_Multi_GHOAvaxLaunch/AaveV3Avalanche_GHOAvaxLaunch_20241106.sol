// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {UpgradeableBurnMintTokenPool} from 'ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol';
import {UpgradeableTokenPool} from 'ccip/pools/GHO/UpgradeableTokenPool.sol';
import {RateLimiter} from 'ccip/libraries/RateLimiter.sol';
import {TokenAdminRegistry} from 'ccip/tokenAdminRegistry/TokenAdminRegistry.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3PayloadAvalanche} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadAvalanche.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IGhoToken} from 'gho-core/gho/interfaces/IGhoToken.sol';
import {UpgradeableGhoToken} from 'gho-core/gho/UpgradeableGhoToken.sol';

/**
 * @title GHO Avax Launch
 * @author Aave Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x2aed7eb8b03cb3f961cbf790bf2e2e1e449f841a4ad8bdbcdd223bb6ac69e719
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-avalanche-set-aci-as-emissions-manager-for-rewards/19339
 * @dev This payload consists of the following set of actions:
 * 1. Deploy GHO
 * 2. Accept ownership of CCIP TokenPool
 * 3. Configure CCIP TokenPool for Ethereum
 * 4. Configure CCIP TokenPool for Arbitrum
 * 5. Add CCIP TokenPool as GHO Facilitator (allowing burn and mint)
 * 6. Accept administrator role from Chainlink token admin registry
 * 7. Link token to pool on Chainlink token admin registry
 */
contract AaveV3Avalanche_GHOAvaxLaunch_20241106 is IProposalGenericExecutor {
  address public constant CCIP_RMN_PROXY = 0xcBD48A8eB077381c3c4Eb36b402d7283aB2b11Bc;
  address public constant CCIP_ROUTER = 0xF4c7E640EdA248ef95972845a62bdC74237805dB;
  address public constant CCIP_TOKEN_ADMIN_REGISTRY = 0xc8df5D618c6a59Cc6A311E96a39450381001464F;
  address public constant GHO_TOKEN = 0xb025950B02b9cfe851C6a4C041f9D6c0942f0eB1;
  address public constant CCIP_TOKEN_POOL = 0x2e234DAe75C793f67A35089C9d99245E1C58470b;
  address public constant ETH_TOKEN_POOL = MiscEthereum.GHO_CCIP_TOKEN_POOL;
  address public constant ETH_GHO = MiscEthereum.GHO_TOKEN;
  address public constant ARB_TOKEN_POOL = MiscArbitrum.GHO_CCIP_TOKEN_POOL;
  address public constant ARB_GHO = AaveV3ArbitrumAssets.GHO_UNDERLYING;
  uint256 public constant CCIP_BUCKET_CAPACITY = 25_000_000e18; // 25M
  uint64 public constant CCIP_ETH_CHAIN_SELECTOR = 5009297550715157269;
  uint64 public constant CCIP_ARB_CHAIN_SELECTOR = 4949039107694359620;

  function execute() external {
    // 1. Deploy GHO
    _deployGhoToken();

    // 2. Accept TokenPool ownership
    UpgradeableBurnMintTokenPool(CCIP_TOKEN_POOL).acceptOwnership();

    // 3. Configure CCIP TokenPool for Ethereum
    _configureCcipTokenPool(CCIP_TOKEN_POOL, CCIP_ETH_CHAIN_SELECTOR, ETH_TOKEN_POOL, ETH_GHO);

    // 4. Configure CCIP TokenPool for Arbitrum
    _configureCcipTokenPool(CCIP_TOKEN_POOL, CCIP_ARB_CHAIN_SELECTOR, ARB_TOKEN_POOL, ARB_GHO);

    // 5. Add CCIP TokenPool as GHO Facilitator
    IGhoToken(GHO_TOKEN).grantRole(
      IGhoToken(GHO_TOKEN).FACILITATOR_MANAGER_ROLE(),
      GovernanceV3Avalanche.EXECUTOR_LVL_1
    );
    IGhoToken(GHO_TOKEN).grantRole(
      IGhoToken(GHO_TOKEN).BUCKET_MANAGER_ROLE(),
      GovernanceV3Avalanche.EXECUTOR_LVL_1
    );
    IGhoToken(GHO_TOKEN).addFacilitator(
      CCIP_TOKEN_POOL,
      'CCIP TokenPool',
      uint128(CCIP_BUCKET_CAPACITY)
    );

    // 6. Accept administrator role from Chainlink token manager
    TokenAdminRegistry(CCIP_TOKEN_ADMIN_REGISTRY).acceptAdminRole(GHO_TOKEN);

    // 7. Link token to pool on Chainlink token admin registry
    TokenAdminRegistry(CCIP_TOKEN_ADMIN_REGISTRY).setPool(GHO_TOKEN, CCIP_TOKEN_POOL);
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
    bytes[] memory remotePools = new bytes[](1);
    remotePools[0] = abi.encode(remotePool);
    chainUpdates[0] = UpgradeableTokenPool.ChainUpdate({
      remoteChainSelector: chainSelector,
      remotePoolAddresses: remotePools,
      remoteTokenAddress: abi.encode(remoteToken),
      outboundRateLimiterConfig: rateConfig,
      inboundRateLimiterConfig: rateConfig
    });
    UpgradeableBurnMintTokenPool(tokenPool).applyChainUpdates(new uint64[](0), chainUpdates);
  }
}

// TODO: Determine appropriate procedure to have these 2 as separate payload, same AIP
/*
 * @dev This payload consists of the following set of actions:
 * 1. List GHO on Avax in separate payload - because there is a delay to activate lane
 * 2. Supply GHO to the Aave protocol
 */
contract GhoAvaxListing is AaveV3PayloadAvalanche {
  using SafeERC20 for IERC20;

  uint256 public constant GHO_SEED_AMOUNT = 1_000_000e18;
  address public immutable ghoToken;

  constructor(address gho) {
    ghoToken = gho;
  }

  function newListings() public view override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: ghoToken,
      assetSymbol: 'GHO',
      priceFeed: 0x076DE3812BDbdAe1330064fc01Adf7f4EAa123f3,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 5_000_000,
      borrowCap: 4_500_000,
      debtCeiling: 0,
      liqProtocolFee: 0,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: _bpsToRay(90_00),
        baseVariableBorrowRate: _bpsToRay(0),
        variableRateSlope1: _bpsToRay(12_00),
        variableRateSlope2: _bpsToRay(65_00)
      })
    });

    return listings;
  }

  function _postExecute() internal override {
    IERC20(ghoToken).forceApprove(address(AaveV3Avalanche.POOL), GHO_SEED_AMOUNT);
    AaveV3Avalanche.POOL.supply(ghoToken, GHO_SEED_AMOUNT, address(0), 0);
  }
}
