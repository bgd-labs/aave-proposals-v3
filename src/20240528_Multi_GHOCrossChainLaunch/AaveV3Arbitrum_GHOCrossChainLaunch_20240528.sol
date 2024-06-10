// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumEModes} from 'aave-address-book/AaveV3Arbitrum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {AaveV3PayloadArbitrum} from 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IV3RateStrategyFactory} from 'aave-helpers/v3-config-engine/IV3RateStrategyFactory.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {ICreate3Factory} from 'solidity-utils/contracts/create3/interfaces/ICreate3Factory.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {UpgradeableBurnMintTokenPool} from 'ccip/v0.8/ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol';
import {UpgradeableTokenPool} from 'ccip/v0.8/ccip/pools/GHO/UpgradeableTokenPool.sol';
import {RateLimiter} from 'ccip/v0.8/ccip/libraries/RateLimiter.sol';
import {UpgradeableGhoToken} from 'gho-core/gho/UpgradeableGhoToken.sol';
import {IGhoToken} from 'gho-core/gho/interfaces/IGhoToken.sol';

library Utils {
  bytes32 public constant GHO_IMPL_DEPLOY_SALT = bytes32(uint256(keccak256('gho.token.impl')));
  bytes32 public constant GHO_DEPLOY_SALT = bytes32(uint256(keccak256('gho.token')));
  uint256 public constant GHO_SEED_AMOUNT = 1e18;
  bytes32 public constant CCIP_TOKEN_POOL_IMPL_DEPLOY_SALT =
    bytes32(uint256(keccak256('gho.ccip.impl')));
  bytes32 public constant CCIP_TOKEN_POOL_DEPLOY_SALT = bytes32(uint256(keccak256('gho.ccip')));
  address public constant CCIP_ARM_PROXY = 0xC311a21e6fEf769344EB1515588B9d535662a145;
  address public constant CCIP_ROUTER = 0x141fa059441E0ca23ce184B6A78bafD2A517DdE8;
  uint256 public constant CCIP_BUCKET_CAPACITY = 1_000_000e18; // 1M
  uint64 public constant CCIP_ETH_CHAIN_SELECTOR = 5009297550715157269;

  function deployGhoToken() external returns (address imple, address proxy) {
    // Deploy imple
    imple = ICreate3Factory(MiscArbitrum.CREATE_3_FACTORY).create(
      GHO_IMPL_DEPLOY_SALT,
      type(UpgradeableGhoToken).creationCode
    );

    // proxy deploy and init
    bytes memory ghoTokenInitParams = abi.encodeWithSignature(
      'initialize(address)',
      GovernanceV3Arbitrum.EXECUTOR_LVL_1 // owner
    );
    bytes memory creationCode = abi.encodePacked(
      type(TransparentUpgradeableProxy).creationCode,
      abi.encode(
        imple,
        MiscArbitrum.PROXY_ADMIN, // proxy admin
        ghoTokenInitParams
      )
    );
    proxy = ICreate3Factory(MiscArbitrum.CREATE_3_FACTORY).create(GHO_DEPLOY_SALT, creationCode);
  }

  function deployCcipTokenPool(address ghoToken) external returns (address imple, address proxy) {
    // Deploy imple
    bytes memory implCreationCode = abi.encodePacked(
      type(UpgradeableBurnMintTokenPool).creationCode,
      abi.encode(
        ghoToken, // token
        CCIP_ARM_PROXY, // armProxy
        false // allowlistEnabled
      )
    );
    imple = ICreate3Factory(MiscArbitrum.CREATE_3_FACTORY).create(
      CCIP_TOKEN_POOL_IMPL_DEPLOY_SALT,
      implCreationCode
    );

    // proxy deploy and init
    address[] memory emptyArray = new address[](0);
    bytes memory tokenPoolInitParams = abi.encodeWithSignature(
      'initialize(address,address[],address)',
      GovernanceV3Arbitrum.EXECUTOR_LVL_1, // owner
      emptyArray, // allowList
      CCIP_ROUTER // router
    );
    bytes memory creationCode = abi.encodePacked(
      type(TransparentUpgradeableProxy).creationCode,
      abi.encode(
        imple, // logic
        MiscArbitrum.PROXY_ADMIN, // proxy admin
        tokenPoolInitParams // data
      )
    );
    proxy = ICreate3Factory(MiscArbitrum.CREATE_3_FACTORY).create(
      CCIP_TOKEN_POOL_DEPLOY_SALT,
      creationCode
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
 * 6. List GHO in Aave V3 Pool
 * 7. Seed Aave Pool
 */
contract AaveV3Arbitrum_GHOCrossChainLaunch_20240528 is AaveV3PayloadArbitrum {
  address public immutable GHO;
  address public immutable GHO_IMPL;
  address public immutable CCIP_TOKEN_POOL;
  address public immutable CCIP_TOKEN_POOL_IMPL;

  constructor() {
    // Predict GHO contract address
    GHO_IMPL = ICreate3Factory(MiscArbitrum.CREATE_3_FACTORY).predictAddress(
      GovernanceV3Arbitrum.EXECUTOR_LVL_1,
      Utils.GHO_IMPL_DEPLOY_SALT
    );
    GHO = ICreate3Factory(MiscArbitrum.CREATE_3_FACTORY).predictAddress(
      GovernanceV3Arbitrum.EXECUTOR_LVL_1,
      Utils.GHO_DEPLOY_SALT
    );
    // Predict CCIP TokenPool contract address
    CCIP_TOKEN_POOL_IMPL = ICreate3Factory(MiscArbitrum.CREATE_3_FACTORY).predictAddress(
      GovernanceV3Arbitrum.EXECUTOR_LVL_1,
      Utils.CCIP_TOKEN_POOL_IMPL_DEPLOY_SALT
    );
    CCIP_TOKEN_POOL = ICreate3Factory(MiscArbitrum.CREATE_3_FACTORY).predictAddress(
      GovernanceV3Arbitrum.EXECUTOR_LVL_1,
      Utils.CCIP_TOKEN_POOL_DEPLOY_SALT
    );
  }

  /// @dev 6. List GHO in Aave V3 Pool
  function newListings() public view override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: GHO,
      assetSymbol: 'GHO',
      priceFeed: 0x3c786e934F23375Ca345C9b8D5aD54838796E8e7,
      eModeCategory: AaveV3ArbitrumEModes.NONE,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 1_000_000,
      borrowCap: 900_000,
      debtCeiling: 0,
      liqProtocolFee: 0,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(90_00),
        baseVariableBorrowRate: _bpsToRay(0),
        variableRateSlope1: _bpsToRay(13_00),
        variableRateSlope2: _bpsToRay(65_00),
        stableRateSlope1: _bpsToRay(0),
        stableRateSlope2: _bpsToRay(0),
        baseStableRateOffset: _bpsToRay(0),
        stableRateExcessOffset: _bpsToRay(0),
        optimalStableToTotalDebtRatio: _bpsToRay(0)
      })
    });

    return listings;
  }

  function _preExecute() internal override {
    // 1. Deploy GHO
    (address ghoTokenImpl, address ghoToken) = Utils.deployGhoToken();
    require(ghoTokenImpl == GHO_IMPL, 'UNEXPECTED_GHO_TOKEN_IMPL_ADDRESS');
    require(ghoToken == GHO, 'UNEXPECTED_GHO_TOKEN_ADDRESS');
    // 2. Deploy BurnMintTokenPool
    (address tokenPoolImpl, address tokenPool) = Utils.deployCcipTokenPool(GHO);
    require(tokenPoolImpl == CCIP_TOKEN_POOL_IMPL, 'UNEXPECTED_CCIP_TOKEN_POOL_IMPL_ADDRESS');
    require(tokenPool == CCIP_TOKEN_POOL, 'UNEXPECTED_CCIP_TOKEN_POOL_ADDRESS');
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

  function _postExecute() internal override {
    // 7. Seed Aave Pool
    _defensiveSeed();
  }

  function _defensiveSeed() internal {
    AaveDefensiveSeed defensiveSeed = new AaveDefensiveSeed(GHO, Utils.GHO_SEED_AMOUNT);

    // Add Facilitator and remove just after the mint of seed amount
    uint256 seedAmount = defensiveSeed.DEFENSIVE_SEED_AMOUNT();
    IGhoToken(GHO).addFacilitator(address(defensiveSeed), 'DefensiveSeed', uint128(seedAmount));
    defensiveSeed.mint();
    IGhoToken(GHO).setFacilitatorBucketCapacity(address(defensiveSeed), 0);

    // Give FacilitatorManager role so it can unwind
    IGhoToken(GHO).grantRole(IGhoToken(GHO).FACILITATOR_MANAGER_ROLE(), address(defensiveSeed));
  }
}

/**
 * @dev This contract serves as a temporary holder for the initial seeding of the GHO reserve in the Aave V3 Pool.
 * @dev Designed as an immutable interim GHO Facilitator, removed once the GHO reserve is adequately seeded.
 */
contract AaveDefensiveSeed {
  using SafeERC20 for IERC20;

  address public immutable GHO;
  uint256 public immutable DEFENSIVE_SEED_AMOUNT;
  bool public mintOnce;
  bool public burnOnce;

  /**
   * @dev Constructor
   * @param gho The address of GHO token
   * @param seedAmount The initial seed amount to be supplied to the Aave Pool
   */
  constructor(address gho, uint256 seedAmount) {
    GHO = gho;
    DEFENSIVE_SEED_AMOUNT = seedAmount;
  }

  /**
   * @dev Executes the initial seeding of the GHO reserve in the Aave V3 Pool.
   * @dev It can only be called once.
   */
  function mint() external {
    require(!mintOnce, 'NOT_ACTIVE');

    // mint
    IGhoToken(GHO).mint(address(this), DEFENSIVE_SEED_AMOUNT);

    // supply
    IERC20(GHO).forceApprove(address(AaveV3Arbitrum.POOL), DEFENSIVE_SEED_AMOUNT);
    AaveV3Arbitrum.POOL.supply(GHO, DEFENSIVE_SEED_AMOUNT, address(this), 0);

    mintOnce = true;
  }

  /**
   * @dev Executes the withdrawal of the initial seeding from the GHO reserve in the Aave V3 Pool, effectively removing
   * this contract as GHO Facilitator.
   * @dev It can only be called once, and only if a sufficient amount of aGHO has been burned at the zero address
   */
  function burn() external {
    require(!burnOnce, 'NOT_ACTIVE');

    // Check address(0) is aGHO holder with sufficient amount
    (address aGHO, , ) = AaveV3Arbitrum.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(GHO);
    require(
      IERC20(aGHO).balanceOf(address(0)) >= DEFENSIVE_SEED_AMOUNT,
      'NOT_ENOUGH_DEFENSIVE_SEED'
    );

    // withdraw
    uint256 amount = IERC20(aGHO).balanceOf(address(this));
    AaveV3Arbitrum.POOL.withdraw(GHO, amount, address(this));

    // burn
    IGhoToken(GHO).burn(amount);

    // Remove itself as facilitator
    IGhoToken(GHO).removeFacilitator(address(this));

    // resign FacilitatorManager role
    IGhoToken(GHO).renounceRole(IGhoToken(GHO).FACILITATOR_MANAGER_ROLE(), address(this));

    burnOnce = true;
  }
}
