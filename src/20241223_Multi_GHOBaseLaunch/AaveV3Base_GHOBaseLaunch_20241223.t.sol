// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';

import {IUpgradeableBurnMintTokenPool_1_4, IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {IPool as IPool_CCIP} from 'src/interfaces/ccip/tokenPool/IPool.sol';
import {IClient} from 'src/interfaces/ccip/IClient.sol';
import {IInternal} from 'src/interfaces/ccip/IInternal.sol';
import {IRouter} from 'src/interfaces/ccip/IRouter.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {IEVM2EVMOnRamp} from 'src/interfaces/ccip/IEVM2EVMOnRamp.sol';
import {IEVM2EVMOffRamp_1_5} from 'src/interfaces/ccip/IEVM2EVMOffRamp.sol';
import {ITokenAdminRegistry} from 'src/interfaces/ccip/ITokenAdminRegistry.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGhoCcipSteward} from 'src/interfaces/IGhoCcipSteward.sol';

import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {MiscBase} from 'aave-address-book/MiscBase.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {GovernanceV3Base} from 'aave-address-book/GovernanceV3Base.sol';

import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {UpgradeableBurnMintTokenPool} from 'aave-ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol';
import {UpgradeableGhoToken} from 'gho-core/gho/UpgradeableGhoToken.sol';
import {GhoCcipSteward} from 'gho-core/misc/GhoCcipSteward.sol';

import {CCIPUtils} from './utils/CCIPUtils.sol';

import {AaveV3Base_GHOBaseLaunch_20241223} from './AaveV3Base_GHOBaseLaunch_20241223.sol';

/**
 * @dev Test for AaveV3Base_GHOBaseLaunch_20241223
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20241223_Multi_GHOBaseLaunch/AaveV3Base_GHOBaseLaunch_20241223.t.sol -vv
 */
contract AaveV3Base_GHOBaseLaunch_20241223_Test is ProtocolV3TestBase {
  struct CCIPSendParams {
    address sender;
    uint256 amount;
    uint64 destChainSelector;
  }

  uint64 internal constant ARB_CHAIN_SELECTOR = CCIPUtils.ARB_CHAIN_SELECTOR;
  uint64 internal constant BASE_CHAIN_SELECTOR = CCIPUtils.BASE_CHAIN_SELECTOR;
  uint64 internal constant ETH_CHAIN_SELECTOR = CCIPUtils.ETH_CHAIN_SELECTOR;

  ITokenAdminRegistry internal constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(0x6f6C373d09C07425BaAE72317863d7F6bb731e37);
  IEVM2EVMOnRamp internal constant ARB_ON_RAMP =
    IEVM2EVMOnRamp(0x9D0ffA76C7F82C34Be313b5bFc6d42A72dA8CA69);
  IEVM2EVMOnRamp internal constant ETH_ON_RAMP =
    IEVM2EVMOnRamp(0x56b30A0Dcd8dc87Ec08b80FA09502bAB801fa78e);

  IEVM2EVMOffRamp_1_5 internal constant ARB_OFF_RAMP =
    IEVM2EVMOffRamp_1_5(0x7D38c6363d5E4DFD500a691Bc34878b383F58d93);
  IEVM2EVMOffRamp_1_5 internal constant ETH_OFF_RAMP =
    IEVM2EVMOffRamp_1_5(0xCA04169671A81E4fB8768cfaD46c347ae65371F1);

  IRouter internal constant ROUTER = IRouter(0x881e3A65B4d4a04dD529061dd0071cf975F58bCD);
  address internal constant RMN_PROXY = 0xC842c69d54F83170C42C4d556B4F6B2ca53Dd3E8;

  address public constant GHO_TOKEN_IMPL = 0xb0e1c7830aA781362f79225559Aa068E6bDaF1d1;
  IGhoToken public constant GHO = IGhoToken(0x888053142E093BcB4D8c3c1B79ce92DBa9C2E910); // predicted address, will be deployed in the AIP
  IGhoCcipSteward internal NEW_GHO_CCIP_STEWARD;
  IUpgradeableBurnMintTokenPool_1_5_1 internal NEW_TOKEN_POOL;
  AaveV3Base_GHOBaseLaunch_20241223 internal proposal;

  address internal NEW_REMOTE_POOL_ARB = makeAddr('ARB: BurnMintTokenPool 1.5.1');
  address internal NEW_REMOTE_POOL_ETH = makeAddr('ETH: LockReleaseTokenPool 1.5.1');
  address internal alice = makeAddr('alice');
  address internal bob = makeAddr('bob');
  address internal carol = makeAddr('carol');

  event Burned(address indexed sender, uint256 amount);
  event Minted(address indexed sender, address indexed recipient, uint256 amount);
  event CCIPSendRequested(IInternal.EVM2EVMMessage message);

  error CallerIsNotARampOnRouter(address);
  error InvalidSourcePoolAddress(bytes);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 24139320);

    NEW_TOKEN_POOL = IUpgradeableBurnMintTokenPool_1_5_1(
      _deployNewBurnMintTokenPool(
        address(GHO),
        RMN_PROXY,
        address(ROUTER),
        GovernanceV3Base.EXECUTOR_LVL_1, // owner
        MiscBase.PROXY_ADMIN
      )
    );
    NEW_GHO_CCIP_STEWARD = IGhoCcipSteward(
      _deployNewGhoCcipSteward(
        address(NEW_TOKEN_POOL),
        address(GHO),
        GovernanceV3Base.EXECUTOR_LVL_1, // riskCouncil, using executor for convenience
        false // bridgeLimitEnabled, *not present* in remote (burnMint) pools
      )
    );

    proposal = new AaveV3Base_GHOBaseLaunch_20241223(
      address(NEW_TOKEN_POOL),
      address(NEW_GHO_CCIP_STEWARD),
      NEW_REMOTE_POOL_ETH,
      NEW_REMOTE_POOL_ARB
    );

    _performCcipPreReq();
  }

  function _performCcipPreReq() internal {
    vm.prank(TOKEN_ADMIN_REGISTRY.owner());
    TOKEN_ADMIN_REGISTRY.proposeAdministrator(address(GHO), GovernanceV3Base.EXECUTOR_LVL_1);
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
          address(proxyAdmin),
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

  function _deployNewGhoCcipSteward(
    address newTokenPool,
    address ghoToken,
    address riskCouncil,
    bool bridgeLimitEnabled
  ) internal returns (address) {
    return address(new GhoCcipSteward(ghoToken, newTokenPool, riskCouncil, bridgeLimitEnabled));
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Base_GHOBaseLaunch_20241223', AaveV3Base.POOL, address(proposal));
  }
}
