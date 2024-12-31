// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';

import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IGhoAaveSteward} from 'gho-core/misc/interfaces/IGhoAaveSteward.sol';
import {IGhoBucketSteward} from 'gho-core/misc/interfaces/IGhoBucketSteward.sol';
import {IGhoCcipSteward} from 'gho-core/misc/interfaces/IGhoCcipSteward.sol';
import {IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {ITokenAdminRegistry} from 'src/interfaces/ccip/ITokenAdminRegistry.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGhoOracle} from 'src/interfaces/IGhoOracle.sol';

import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {MiscBase} from 'aave-address-book/MiscBase.sol';
import {GovernanceV3Base} from 'aave-address-book/GovernanceV3Base.sol';

import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {UpgradeableBurnMintTokenPool} from 'aave-ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol';
import {GhoAaveSteward} from 'gho-core/misc/GhoAaveSteward.sol';
import {GhoBucketSteward} from 'gho-core/misc/GhoBucketSteward.sol';
import {GhoCcipSteward} from 'gho-core/misc/GhoCcipSteward.sol';

import {AaveV3Base_GHOBaseLaunch_20241223} from './AaveV3Base_GHOBaseLaunch_20241223.sol';
import {AaveV3Base_GHOBaseListing_20241223} from './AaveV3Base_GHOBaseListing_20241223.sol';

/**
 * @dev Test for AaveV3Base_Ads_20241231
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20241223_Multi_GHOBaseLaunch/AaveV3Base_GHOBaseListing_20241223.t.sol -vv
 */
contract AaveV3Base_GHOBaseListing_20241223_Base is ProtocolV3TestBase {
  AaveV3Base_GHOBaseListing_20241223 internal proposal;

  ITokenAdminRegistry internal constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(0x6f6C373d09C07425BaAE72317863d7F6bb731e37);
  address internal constant ROUTER = 0x881e3A65B4d4a04dD529061dd0071cf975F58bCD;
  address internal constant RMN_PROXY = 0xC842c69d54F83170C42C4d556B4F6B2ca53Dd3E8;
  address internal constant RISK_COUNCIL = 0x8513e6F37dBc52De87b166980Fa3F50639694B60;
  IGhoToken internal constant GHO_TOKEN = IGhoToken(0x6F2216CB3Ca97b8756C5fD99bE27986f04CBd81D); // predicted address, will be deployed in the AIP

  address internal NEW_REMOTE_POOL_ARB = makeAddr('ARB: BurnMintTokenPool 1.5.1');
  address internal NEW_REMOTE_POOL_ETH = makeAddr('ETH: LockReleaseTokenPool 1.5.1');
  IGhoAaveSteward internal NEW_GHO_AAVE_STEWARD;
  IGhoBucketSteward internal NEW_GHO_BUCKET_STEWARD;
  IGhoCcipSteward internal NEW_GHO_CCIP_STEWARD;
  IUpgradeableBurnMintTokenPool_1_5_1 internal NEW_TOKEN_POOL;

  function setUp() public virtual {
    vm.createSelectFork(vm.rpcUrl('base'), 24430581);
    _executeLaunchAIP(); // deploys gho token, token pool & stewards

    proposal = new AaveV3Base_GHOBaseListing_20241223();
  }

  function _executeLaunchAIP() internal {
    NEW_TOKEN_POOL = IUpgradeableBurnMintTokenPool_1_5_1(
      _deployNewBurnMintTokenPool(
        address(GHO_TOKEN),
        RMN_PROXY,
        ROUTER,
        GovernanceV3Base.EXECUTOR_LVL_1, // owner
        MiscBase.PROXY_ADMIN
      )
    );
    (NEW_GHO_AAVE_STEWARD, NEW_GHO_BUCKET_STEWARD, NEW_GHO_CCIP_STEWARD) = _deployStewards();

    _performCcipPreReq();

    executePayload(
      vm,
      address(
        new AaveV3Base_GHOBaseLaunch_20241223(
          address(NEW_TOKEN_POOL),
          NEW_REMOTE_POOL_ETH,
          NEW_REMOTE_POOL_ARB,
          address(NEW_GHO_AAVE_STEWARD),
          address(NEW_GHO_BUCKET_STEWARD),
          address(NEW_GHO_CCIP_STEWARD)
        )
      )
    );
  }

  function _performCcipPreReq() internal {
    vm.prank(TOKEN_ADMIN_REGISTRY.owner());
    TOKEN_ADMIN_REGISTRY.proposeAdministrator(address(GHO_TOKEN), GovernanceV3Base.EXECUTOR_LVL_1);
  }
  function _deployNewBurnMintTokenPool(
    address ghoToken,
    address rmnProxy,
    address router,
    address owner,
    address proxyAdmin
  ) private returns (address) {
    address newTokenPoolImpl = address(
      new UpgradeableBurnMintTokenPool(
        ghoToken,
        18,
        rmnProxy,
        false // allowListEnabled
      )
    );

    return
      address(
        new TransparentUpgradeableProxy(
          newTokenPoolImpl,
          ProxyAdmin(proxyAdmin),
          abi.encodeCall(
            IUpgradeableBurnMintTokenPool_1_5_1.initialize,
            (
              owner,
              new address[](0), // allowList
              router
            )
          )
        )
      );
  }
  function _deployStewards()
    internal
    returns (IGhoAaveSteward, IGhoBucketSteward, IGhoCcipSteward)
  {
    address aaveSteward = address(
      new GhoAaveSteward({
        owner: GovernanceV3Base.EXECUTOR_LVL_1,
        addressesProvider: address(AaveV3Base.POOL_ADDRESSES_PROVIDER),
        poolDataProvider: address(AaveV3Base.UI_POOL_DATA_PROVIDER),
        ghoToken: address(GHO_TOKEN),
        riskCouncil: RISK_COUNCIL,
        borrowRateConfig: IGhoAaveSteward.BorrowRateConfig({
          optimalUsageRatioMaxChange: 500,
          baseVariableBorrowRateMaxChange: 500,
          variableRateSlope1MaxChange: 500,
          variableRateSlope2MaxChange: 500
        })
      })
    );
    address bucketSteward = address(
      new GhoBucketSteward({
        owner: GovernanceV3Base.EXECUTOR_LVL_1,
        ghoToken: address(GHO_TOKEN),
        riskCouncil: RISK_COUNCIL
      })
    );
    address ccipSteward = address(
      new GhoCcipSteward({
        ghoToken: address(GHO_TOKEN),
        ghoTokenPool: address(NEW_TOKEN_POOL),
        riskCouncil: RISK_COUNCIL,
        bridgeLimitEnabled: false
      })
    );
    return (
      IGhoAaveSteward(aaveSteward),
      IGhoBucketSteward(bucketSteward),
      IGhoCcipSteward(ccipSteward)
    );
  }
}

contract AaveV3Base_GHOBaseListing_20241223_Listing is AaveV3Base_GHOBaseListing_20241223_Base {
  function setUp() public override {
    super.setUp();

    uint256 seedAmount = proposal.GHO_SEED_AMOUNT();
    // mock executor receives seed amount after Launch AIP (ie bridge activation)
    vm.prank(address(NEW_TOKEN_POOL));
    GHO_TOKEN.mint(GovernanceV3Base.EXECUTOR_LVL_1, seedAmount);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Base_GHOBaseListing_20241223', AaveV3Base.POOL, address(proposal));

    (address aGhoToken, , ) = AaveV3Base.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.GHO_TOKEN()
    );
    assertGe(IERC20(aGhoToken).balanceOf(address(0)), proposal.GHO_SEED_AMOUNT());
  }

  function test_ghoPriceFeed() public view {
    IGhoOracle priceOracle = IGhoOracle(proposal.GHO_PRICE_FEED());
    assertEq(priceOracle.latestAnswer(), 1e8);
    assertEq(priceOracle.decimals(), 8);
  }

  function test_GhoAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aGhoToken, , ) = AaveV3Base.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.GHO_TOKEN()
    );
    assertEq(
      IEmissionManager(AaveV3Base.EMISSION_MANAGER).getEmissionAdmin(proposal.GHO_TOKEN()),
      proposal.EMISSION_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Base.EMISSION_MANAGER).getEmissionAdmin(aGhoToken),
      proposal.EMISSION_ADMIN()
    );
  }
}
