// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {IPayloadsControllerCore} from 'aave-address-book/GovernanceV3.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IHub, ISpoke, IAaveOracle, IHubConfigurator, ISpokeConfigurator, ITreasurySpoke, IAccessManagerEnumerable} from 'aave-address-book/AaveV4.sol';
import {IPriceFeed} from 'aave-v4/spoke/interfaces/IPriceFeed.sol';
import {AaveV4EthereumSentoraCurated, AaveV4EthereumSentoraCuratedHubs, AaveV4EthereumSentoraCuratedSpokes, AaveV4EthereumSentoraCuratedPositionManagers, AaveV4EthereumSentoraCuratedAssets} from 'aave-address-book/AaveV4EthereumSentoraCurated.sol';
import {ProtocolV4TestBaseEthereumSentoraCurated} from 'aave-helpers/src/v4-protocol-test/ProtocolV4TestBaseEthereumSentoraCurated.sol';
import {IOwnable2Step} from 'src/interfaces/IOwnable2Step.sol';
import {IRiskStewardV4} from 'src/interfaces/IRiskStewardV4.sol';
import {AaveV4EthereumSentoraCurated_SentoraMarketActivation_20261009} from './AaveV4EthereumSentoraCurated_SentoraMarketActivation_20261009.sol';
import {IReduceRiskStewardWrapper, IMidasToken} from './SentoraInterfaces.sol';
import {MidasAccessControlMock} from './SentoraTestPayloads.sol';

/**
 * @dev Shared fork setup for the Sentora market activation tests: forks after the on-chain relinquish
 *      (block 26192973) and the Security Council's RiskSteward `acceptOwnership`, the state the
 *      activation payload will find.
 */
abstract contract SentoraTestBase is ProtocolV4TestBaseEthereumSentoraCurated {
  uint256 internal constant FORK_BLOCK = 26193000;

  IHub internal constant HUB = AaveV4EthereumSentoraCuratedHubs.SENTORA_HUB;
  ISpoke internal constant RLUSD_YIELD = AaveV4EthereumSentoraCuratedSpokes.RLUSD_YIELD_SPOKE;
  ISpoke internal constant OUSD_YIELD = AaveV4EthereumSentoraCuratedSpokes.OUSD_YIELD_SPOKE;
  ISpoke internal constant BLUECHIP = AaveV4EthereumSentoraCuratedSpokes.BLUECHIP_SPOKE;
  ITreasurySpoke internal constant TREASURY_SPOKE = AaveV4EthereumSentoraCurated.TREASURY_SPOKE;
  IAccessManagerEnumerable internal constant ACCESS_MANAGER =
    AaveV4EthereumSentoraCurated.ACCESS_MANAGER;
  IHubConfigurator internal constant HUB_CONFIGURATOR =
    AaveV4EthereumSentoraCurated.HUB_CONFIGURATOR;
  ISpokeConfigurator internal constant SPOKE_CONFIGURATOR =
    AaveV4EthereumSentoraCurated.SPOKE_CONFIGURATOR;
  IRiskStewardV4 internal constant RISK_STEWARD =
    IRiskStewardV4(AaveV4EthereumSentoraCurated.RISK_STEWARD);
  IReduceRiskStewardWrapper internal constant WRAPPER =
    IReduceRiskStewardWrapper(AaveV4EthereumSentoraCurated.REDUCE_RISK_STEWARD_WRAPPER);

  address internal constant PPC = AaveV4EthereumSentoraCurated.PERMISSIONED_PAYLOADS_CONTROLLER;
  address internal constant EXECUTOR =
    AaveV4EthereumSentoraCurated.PERMISSIONED_PAYLOADS_CONTROLLER_EXECUTOR;
  address internal constant SECURITY_COUNCIL = MiscEthereum.V4_SECURITY_COUNCIL;
  address internal constant EMERGENCY_ADMIN = AaveV4EthereumSentoraCurated.SENTORA_EMERGENCY_ADMIN;
  address internal constant OPERATOR = AaveV4EthereumSentoraCurated.SENTORA_OPERATOR;
  address internal constant FEE_ADMIN = AaveV4EthereumSentoraCurated.SENTORA_FEE_ADMIN;
  /// @dev Deployed and configured the market (aave-v4 Sentora deploy report); holds nothing after the
  /// relinquish but the pending Ownable2Step transfers.
  address internal constant DEPLOYER = 0x043a48d1Bd61c59f67C09215D5Eae6b743Fe533d;

  uint64 internal constant ADMIN_ROLE = 0;
  uint64 internal constant HUB_CONFIGURATOR_ROLE = 101;
  uint64 internal constant HUB_FEE_MINTER_ROLE = 102;
  uint64 internal constant HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE = 200;
  uint64 internal constant SPOKE_CONFIGURATOR_ROLE = 301;
  uint64 internal constant SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE = 400;
  uint64 internal constant SENTORA_RISK_ROLE = 1000;
  uint64 internal constant SENTORA_EMERGENCY_ROLE = 1001;

  uint40 internal constant PPC_DELAY = 2 days;
  uint40 internal constant PPC_GRACE_PERIOD = 7 days;
  uint40 internal constant PPC_EXPIRATION_DELAY = 35 days;

  bytes32 internal constant M_WIN_MIN_BALANCE_EXEMPT_ROLE =
    keccak256('M_WIN_MIN_BALANCE_EXEMPT_ROLE');

  uint256 internal constant ASSET_COUNT = 8;
  /// @dev 14 reserves plus the TreasurySpoke of each of the 8 assets.
  uint256 internal constant SPOKE_PAIR_COUNT = 22;

  AaveV4EthereumSentoraCurated_SentoraMarketActivation_20261009 internal proposal;

  function setUp() public virtual {
    vm.createSelectFork(vm.rpcUrl('mainnet'), FORK_BLOCK);
    vm.skip(
      address(HUB).code.length == 0 ||
        PPC.code.length == 0 ||
        address(RISK_STEWARD).code.length == 0 ||
        address(WRAPPER).code.length == 0
    );
    proposal = new AaveV4EthereumSentoraCurated_SentoraMarketActivation_20261009();
  }

  modifier activated() {
    _activate();
    _;
  }

  /// @dev The Fee Admin's TreasurySpoke `acceptOwnership` is its own step outside the activation
  /// payload; flows that need the Fee Admin as owner run it first.
  function _acceptTreasurySpokeOwnership() internal {
    vm.prank(FEE_ADMIN);
    IOwnable2Step(address(TREASURY_SPOKE)).acceptOwnership();
  }

  /// @dev Runs the activation payload the way it goes live: created by the Sentora Operator,
  /// executed once the PPC delay has passed.
  function _activate() internal {
    _executeAfterDelay(_createPayload(address(proposal)));
  }

  function _createPayload(address payload) internal returns (uint40) {
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload);
    vm.prank(OPERATOR);
    return IPayloadsControllerCore(PPC).createPayload(actions);
  }

  function _executeAfterDelay(uint40 payloadId) internal {
    IPayloadsControllerCore.Payload memory payload = IPayloadsControllerCore(PPC).getPayloadById(
      payloadId
    );
    vm.warp(payload.queuedAt + payload.delay + 1);
    IPayloadsControllerCore(PPC).executePayload(payloadId);
  }

  function _ownedByExecutor() internal pure returns (address[] memory owned) {
    owned = new address[](5);
    owned[0] = address(AaveV4EthereumSentoraCuratedPositionManagers.GIVER_POSITION_MANAGER);
    owned[1] = address(AaveV4EthereumSentoraCuratedPositionManagers.TAKER_POSITION_MANAGER);
    owned[2] = address(AaveV4EthereumSentoraCuratedPositionManagers.CONFIG_POSITION_MANAGER);
    owned[3] = address(AaveV4EthereumSentoraCuratedPositionManagers.NATIVE_TOKEN_GATEWAY);
    owned[4] = address(AaveV4EthereumSentoraCuratedPositionManagers.SIGNATURE_GATEWAY);
  }

  function _marketProxies() internal pure returns (address[] memory proxies) {
    proxies = new address[](5);
    proxies[0] = address(HUB);
    proxies[1] = address(RLUSD_YIELD);
    proxies[2] = address(OUSD_YIELD);
    proxies[3] = address(BLUECHIP);
    proxies[4] = address(TREASURY_SPOKE);
  }

  function _spokes() internal pure returns (ISpoke[] memory spokes) {
    spokes = new ISpoke[](3);
    spokes[0] = RLUSD_YIELD;
    spokes[1] = OUSD_YIELD;
    spokes[2] = BLUECHIP;
  }

  function _proxyAdmin(address proxy) internal view returns (address) {
    return
      address(
        uint160(
          uint256(
            vm.load(proxy, 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103)
          )
        )
      );
  }

  function _reserveId(ISpoke spoke, address underlying) internal view returns (uint256) {
    return spoke.getReserveId(address(HUB), HUB.getAssetId(underlying));
  }

  function _underlying(ISpoke spoke, uint256 reserveId) internal view returns (address) {
    return spoke.getReserve(reserveId).underlying;
  }

  function _units(ISpoke spoke, uint256 reserveId, uint256 tokens) internal view returns (uint256) {
    return tokens * 10 ** spoke.getReserve(reserveId).decimals;
  }

  function _supplyAs(ISpoke spoke, uint256 reserveId, address user, uint256 amount) internal {
    address underlying = _underlying(spoke, reserveId);
    deal2(underlying, user, amount);
    vm.startPrank(user);
    IERC20(underlying).approve(address(spoke), amount);
    spoke.supply(reserveId, amount, user);
    vm.stopPrank();
  }

  function _supplyCollateralAs(
    ISpoke spoke,
    uint256 reserveId,
    address user,
    uint256 amount
  ) internal {
    _supplyAs(spoke, reserveId, user, amount);
    vm.prank(user);
    spoke.setUsingAsCollateral(reserveId, true, user);
  }

  function _borrowAs(ISpoke spoke, uint256 reserveId, address user, uint256 amount) internal {
    vm.prank(user);
    spoke.borrow(reserveId, amount, user);
  }

  function _mockSourcePrice(ISpoke spoke, uint256 reserveId, int256 price) internal {
    vm.mockCall(
      _source(spoke, reserveId),
      abi.encodeWithSelector(IPriceFeed.latestAnswer.selector),
      abi.encode(price)
    );
  }

  function _source(ISpoke spoke, uint256 reserveId) internal view returns (address) {
    return IAaveOracle(spoke.ORACLE()).getReserveSource(reserveId);
  }

  /// @dev mWIN only moves between holders of its Midas greenlist role, and a holder outside the
  /// min-balance exempt role must keep a minimum balance. At FORK_BLOCK the Hub holds neither role
  /// (see `SentoraMarketOpen.test_mWinTransferRestrictions`). Flows that move mWIN swap the Midas
  /// access control for one granting both roles to every account; code is swapped rather than
  /// calls mocked because the e2e helpers clear mocked calls mid-flow.
  function deal2(address asset, address user, uint256 amount) internal virtual override {
    if (asset == AaveV4EthereumSentoraCuratedAssets.mWIN_UNDERLYING) _grantMWinTransferRoles();
    super.deal2(asset, user, amount);
  }

  function _grantMWinTransferRoles() internal {
    IMidasToken mWin = IMidasToken(AaveV4EthereumSentoraCuratedAssets.mWIN_UNDERLYING);
    MidasAccessControlMock mock = new MidasAccessControlMock(
      mWin.M_WIN_GREENLISTED_ROLE(),
      M_WIN_MIN_BALANCE_EXEMPT_ROLE
    );
    vm.etch(mWin.accessControl(), address(mock).code);
  }

  function _expectUnauthorized(address caller) internal {
    vm.expectRevert(abi.encodeWithSignature('AccessManagedUnauthorized(address)', caller));
  }
}
