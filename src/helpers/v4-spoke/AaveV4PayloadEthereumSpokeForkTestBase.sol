// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {ProtocolV4TestBase} from 'aave-helpers/src/ProtocolV4TestBase.sol';
import {Types} from 'aave-helpers/src/dependencies/v4/Types.sol';
import {ERC1967Utils} from 'aave-v4/dependencies/openzeppelin/ERC1967Utils.sol';
import {IAccessManaged} from 'aave-v4/dependencies/openzeppelin/IAccessManaged.sol';
import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';
import {ISpoke} from 'aave-v4/spoke/interfaces/ISpoke.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {IAaveOracle, ISignatureGateway, ITokenizationSpoke} from 'aave-address-book/AaveV4.sol';
import {AaveV4Ethereum, AaveV4EthereumPositionManagers} from 'aave-address-book/AaveV4Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

import {TokenizationSpokeLib} from '../v4-hub/TokenizationSpokeLib.sol';
import {AaveV4PayloadEthereumSpokeTestBase} from './AaveV4PayloadEthereumSpokeTestBase.sol';

abstract contract AaveV4PayloadEthereumSpokeForkTestBase is
  AaveV4PayloadEthereumSpokeTestBase,
  ProtocolV4TestBase
{
  using SafeERC20 for IERC20;

  /// @dev One parametrised collateral/borrow flow on the spoke being onboarded.
  ///      Collateral and borrow reserves may live on different hubs (cross-hub credit lines on
  ///      correlated spokes), so the hub is specified per leg.
  struct ReserveTestCase {
    IHub collateralHub;
    address collateralUnderlying;
    address collateralPriceFeed;
    IHub borrowHub;
    address borrowUnderlying;
    uint256 supplyAmount;
    uint256 borrowAmount;
    uint256 borrowAmountOverCF;
    int256 unhealthyCollateralPrice;
    uint256 partialLiquidationDebtAmount;
    uint256 healthyLiquidationDebtAmount;
    // Liquidity to seed into the borrow reserve before the test borrows. Leave 0 when the borrow
    // asset already has liquidity (e.g. a cross-hub credit line draws from another hub's pool);
    // set > 0 for a natively-listed borrowable that nobody has supplied to yet, so the borrow
    // legs revert for the intended reason (HF) and not for lack of liquidity. Must only be set for
    // reserves that are suppliable to the spoke (receiveSharesEnabled).
    uint256 borrowLiquiditySeed;
    // Whether the borrow asset implements EIP-2612 `permit`. The SignatureGateway flow signs a
    // permit to pull the repay amount, so it can only run against permit-capable borrowables
    // (e.g. USDT has no permit). Other flows (direct approvals, Giver/Taker/Config PMs) ignore it.
    bool borrowSupportsPermit;
  }

  /// @dev One tokenization-spoke deposit/redeem flow.
  struct TokenizationTestCase {
    IHub hub;
    address underlying;
    uint256 depositAmount;
    uint256 spokeAssetIdAddCap;
  }

  /// @dev Address of the SECURITY_COUNCIL that owns each PositionManager. Used to register a new
  ///      spoke on each PM since `registerSpoke` is `onlyOwner` and out of governance reach.
  address internal constant SECURITY_COUNCIL = 0x187AAE17d4931310B3fc75743e7F16Bdc9eD77e9;

  function test_spokeDeployment_isCanonicalSpokeImplementation() public virtual {
    _assertSpokeImplIsCanonical(_payload().spoke());
  }

  function test_targetFunctionRolesSetOnNewSpoke() public virtual {
    GovV3Helpers.executePayload(vm, address(_payload()));

    address spokeAddress = _payload().spoke();
    bytes4[] memory configuratorSelectors = Roles.getSpokeConfiguratorRoleSelectors();
    for (uint256 i; i < configuratorSelectors.length; ++i) {
      assertEq(
        AaveV4Ethereum.ACCESS_MANAGER.getTargetFunctionRole(spokeAddress, configuratorSelectors[i]),
        Roles.SPOKE_CONFIGURATOR_ROLE
      );
    }
    bytes4[] memory updaterSelectors = Roles.getSpokePositionUpdaterRoleSelectors();
    for (uint256 i; i < updaterSelectors.length; ++i) {
      assertEq(
        AaveV4Ethereum.ACCESS_MANAGER.getTargetFunctionRole(spokeAddress, updaterSelectors[i]),
        Roles.SPOKE_USER_POSITION_UPDATER_ROLE
      );
    }
  }

  function test_positionManagersActiveOnSpoke() public virtual {
    GovV3Helpers.executePayload(vm, address(_payload()));

    ISpoke spokeContract = ISpoke(_payload().spoke());
    assertTrue(
      spokeContract.isPositionManagerActive(
        address(AaveV4EthereumPositionManagers.GIVER_POSITION_MANAGER)
      )
    );
    assertTrue(
      spokeContract.isPositionManagerActive(
        address(AaveV4EthereumPositionManagers.TAKER_POSITION_MANAGER)
      )
    );
    assertTrue(
      spokeContract.isPositionManagerActive(
        address(AaveV4EthereumPositionManagers.CONFIG_POSITION_MANAGER)
      )
    );
    assertTrue(
      spokeContract.isPositionManagerActive(
        address(AaveV4EthereumPositionManagers.SIGNATURE_GATEWAY)
      )
    );
  }

  function test_spokeConfigurator_canCallGatedSelectors() public virtual {
    GovV3Helpers.executePayload(vm, address(_payload()));

    address spokeAddress = _payload().spoke();
    address holder = address(AaveV4Ethereum.SPOKE_CONFIGURATOR);
    bytes4[] memory gated = Roles.getSpokeConfiguratorRoleSelectors();
    for (uint256 i; i < gated.length; ++i) {
      (bool allowed, uint32 delay) = AaveV4Ethereum.ACCESS_MANAGER.canCall(
        holder,
        spokeAddress,
        gated[i]
      );
      assertTrue(allowed, 'SpokeConfigurator should be allowed to call selector');
      assertEq(delay, 0, 'No execution delay expected');
    }
  }

  function test_e2eNewSpokeStandalone() public virtual {
    GovV3Helpers.executePayload(vm, address(_payload()));
    e2eTestSpoke(ISpoke(_payload().spoke()));
  }

  function test_e2eAllPositionManagersForNewSpoke() public virtual {
    GovV3Helpers.executePayload(vm, address(_payload()));
    _registerSpokeOnPositionManagers();
    e2eTestPositionManagers(ISpoke(_payload().spoke()));
  }

  function test_supplyAndBorrow_closeToMaxCF() public virtual {
    GovV3Helpers.executePayload(vm, address(_payload()));
    ReserveTestCase[] memory cases = _reserveTestCases();
    for (uint256 i; i < cases.length; ++i) _runSupplyAndBorrow(cases[i], i);
  }

  function test_borrow_overCF_reverts() public virtual {
    GovV3Helpers.executePayload(vm, address(_payload()));
    ReserveTestCase[] memory cases = _reserveTestCases();
    for (uint256 i; i < cases.length; ++i) _runBorrowOverCFReverts(cases[i], i);
  }

  function test_liquidation_partial() public virtual {
    GovV3Helpers.executePayload(vm, address(_payload()));
    ReserveTestCase[] memory cases = _reserveTestCases();
    for (uint256 i; i < cases.length; ++i) _runLiquidationPartial(cases[i], i);
  }

  function test_liquidation_revertsIfHealthy() public virtual {
    GovV3Helpers.executePayload(vm, address(_payload()));
    ReserveTestCase[] memory cases = _reserveTestCases();
    for (uint256 i; i < cases.length; ++i) _runLiquidationRevertsIfHealthy(cases[i], i);
  }

  function test_giverPositionManager_supplyOnBehalfOf() public virtual {
    GovV3Helpers.executePayload(vm, address(_payload()));
    _registerSpokeOnPositionManagers();
    ReserveTestCase[] memory cases = _reserveTestCases();
    for (uint256 i; i < cases.length; ++i) _runGiverPositionManagerSupply(cases[i], i);
  }

  function test_takerPositionManager_borrowOnBehalfOf() public virtual {
    GovV3Helpers.executePayload(vm, address(_payload()));
    _registerSpokeOnPositionManagers();
    ReserveTestCase[] memory cases = _reserveTestCases();
    for (uint256 i; i < cases.length; ++i) _runTakerPositionManagerBorrow(cases[i], i);
  }

  function test_configPositionManager_setUsingAsCollateralOnBehalfOf() public virtual {
    GovV3Helpers.executePayload(vm, address(_payload()));
    _registerSpokeOnPositionManagers();
    ReserveTestCase[] memory cases = _reserveTestCases();
    for (uint256 i; i < cases.length; ++i) _runConfigPositionManagerSetCollateral(cases[i], i);
  }

  function test_signatureGateway_onBehalfOfNewSpoke() public virtual {
    GovV3Helpers.executePayload(vm, address(_payload()));
    _registerSpokeOnPositionManagers();
    ReserveTestCase[] memory cases = _reserveTestCases();
    ISpoke spokeContract = ISpoke(_payload().spoke());
    Types.ReserveInfo[] memory reserves = _getReserveInfo(spokeContract);
    for (uint256 i; i < cases.length; ++i) {
      // The SignatureGateway pulls funds via an EIP-2612 permit signature, so it can only be
      // exercised against permit-capable borrow assets. Non-permit tokens (e.g. USDT) are covered
      // by the direct-approval and Giver/Taker/Config PM flows instead.
      if (!cases[i].borrowSupportsPermit) continue;
      Types.ReserveInfo memory collateralInfo = _findReserveInfo(
        reserves,
        cases[i].collateralUnderlying
      );
      Types.ReserveInfo memory borrowInfo = _findReserveInfo(reserves, cases[i].borrowUnderlying);
      _seedBorrowLiquidity(cases[i], i);
      // Supply/withdraw on the collateral leg (non-borrowable; borrow branch skipped inside).
      _testSignatureGateway({
        gateway: AaveV4EthereumPositionManagers.SIGNATURE_GATEWAY,
        spoke: spokeContract,
        reserveInfo: collateralInfo,
        collateralInfo: collateralInfo
      });
      // Borrow/repay against the collateral leg — works for cross-hub credit lines where the
      // borrow asset isn't suppliable to the spoke directly (the spoke draws via the credit
      // line at borrow time).
      _testSignatureGatewayBorrowFlow({
        gateway: AaveV4EthereumPositionManagers.SIGNATURE_GATEWAY,
        spoke: spokeContract,
        borrowInfo: borrowInfo,
        collateralInfo: collateralInfo
      });
    }
  }

  /// @dev Supply collateral + borrow + repay via SignatureGateway. Assumes the borrow asset
  ///      already has liquidity (e.g. via a cross-hub credit line or pre-existing local supply).
  function _testSignatureGatewayBorrowFlow(
    ISignatureGateway gateway,
    ISpoke spoke,
    Types.ReserveInfo memory borrowInfo,
    Types.ReserveInfo memory collateralInfo
  ) internal {
    uint256 privateKey = vm.randomUint(1, type(uint248).max);
    address user = vm.addr(privateKey);

    vm.prank(user);
    spoke.setUserPositionManager(address(gateway), true);

    address oracleAddr = spoke.ORACLE();
    uint256 borrowDollars = vm.randomUint(1_000, 10_000);
    uint256 borrowAmount = _getTokenAmountByDollarValue(oracleAddr, borrowInfo, borrowDollars);
    uint256 collateralAmount = _getTokenAmountByDollarValue(
      oracleAddr,
      collateralInfo,
      borrowDollars * 3
    );

    _sigSupply({
      gateway: gateway,
      spoke: spoke,
      reserveInfo: collateralInfo,
      privateKey: privateKey,
      user: user,
      amount: collateralAmount
    });
    _sigSetUsingAsCollateral({
      gateway: gateway,
      spoke: spoke,
      reserveInfo: collateralInfo,
      privateKey: privateKey,
      user: user
    });
    _sigBorrow({
      gateway: gateway,
      spoke: spoke,
      reserveInfo: borrowInfo,
      privateKey: privateKey,
      user: user,
      amount: borrowAmount
    });
    _sigRepay({
      gateway: gateway,
      spoke: spoke,
      reserveInfo: borrowInfo,
      privateKey: privateKey,
      user: user,
      amount: vm.randomUint(1, borrowAmount)
    });
    _sigRepay({
      gateway: gateway,
      spoke: spoke,
      reserveInfo: borrowInfo,
      privateKey: privateKey,
      user: user,
      amount: type(uint256).max
    });
  }

  function test_tokenizationSpoke_depositRevertsWhileAddCapZero() public virtual {
    GovV3Helpers.executePayload(vm, address(_payload()));
    TokenizationTestCase[] memory cases = _tokenizationTestCases();
    for (uint256 i; i < cases.length; ++i)
      _runTokenizationDepositRevertsWhileAddCapZero(cases[i], i);
  }

  function test_tokenizationSpoke_depositAndRedeem() public virtual {
    GovV3Helpers.executePayload(vm, address(_payload()));
    TokenizationTestCase[] memory cases = _tokenizationTestCases();
    for (uint256 i; i < cases.length; ++i) _runTokenizationDepositAndRedeem(cases[i], i);
  }

  function test_spokeDeployment_codeExists() public view virtual {
    assertGt(_payload().spoke().code.length, 0);
  }

  function test_spokeDeployment_authority() public view virtual {
    assertEq(
      IAccessManaged(_payload().spoke()).authority(),
      address(AaveV4Ethereum.ACCESS_MANAGER)
    );
  }

  function test_spokeDeployment_oracleWired() public view virtual {
    address spokeAddress = _payload().spoke();
    address oracle = ISpoke(spokeAddress).ORACLE();
    assertGt(oracle.code.length, 0, 'oracle has no code');
    assertEq(IAaveOracle(oracle).spoke(), spokeAddress);
    assertEq(uint256(IAaveOracle(oracle).decimals()), 8);
  }

  function _runSupplyAndBorrow(ReserveTestCase memory testCase, uint256 index) internal {
    address user = makeAddr(string.concat('supplyBorrowUser_', vm.toString(index)));
    ISpoke spokeContract = ISpoke(_payload().spoke());
    (uint256 collateralReserveId, uint256 borrowReserveId) = _reserveIdsFor(testCase);
    _seedBorrowLiquidity(testCase, index);

    deal2(testCase.collateralUnderlying, user, testCase.supplyAmount);
    vm.startPrank(user);
    IERC20(testCase.collateralUnderlying).forceApprove(
      address(spokeContract),
      testCase.supplyAmount
    );
    spokeContract.supply(collateralReserveId, testCase.supplyAmount, user);
    spokeContract.setUsingAsCollateral(collateralReserveId, true, user);
    spokeContract.borrow(borrowReserveId, testCase.borrowAmount, user);
    vm.stopPrank();

    assertEq(IERC20(testCase.borrowUnderlying).balanceOf(user), testCase.borrowAmount);
    ISpoke.UserAccountData memory acct = spokeContract.getUserAccountData(user);
    assertGt(acct.healthFactor, 1e18);
    assertEq(acct.borrowCount, 1);
    assertEq(acct.activeCollateralCount, 1);
  }

  function _runBorrowOverCFReverts(ReserveTestCase memory testCase, uint256 index) internal {
    address user = makeAddr(string.concat('borrowOverCFUser_', vm.toString(index)));
    ISpoke spokeContract = ISpoke(_payload().spoke());
    (uint256 collateralReserveId, uint256 borrowReserveId) = _reserveIdsFor(testCase);
    _seedBorrowLiquidity(testCase, index);

    deal2(testCase.collateralUnderlying, user, testCase.supplyAmount);
    vm.startPrank(user);
    IERC20(testCase.collateralUnderlying).forceApprove(
      address(spokeContract),
      testCase.supplyAmount
    );
    spokeContract.supply(collateralReserveId, testCase.supplyAmount, user);
    spokeContract.setUsingAsCollateral(collateralReserveId, true, user);
    vm.expectRevert(ISpoke.HealthFactorBelowThreshold.selector);
    spokeContract.borrow(borrowReserveId, testCase.borrowAmountOverCF, user);
    vm.stopPrank();
  }

  function _runLiquidationPartial(ReserveTestCase memory testCase, uint256 index) internal {
    address user = makeAddr(string.concat('liquidationUser_', vm.toString(index)));
    address liquidator = makeAddr(string.concat('liquidator_', vm.toString(index)));
    ISpoke spokeContract = ISpoke(_payload().spoke());
    (uint256 collateralReserveId, uint256 borrowReserveId) = _reserveIdsFor(testCase);
    _seedBorrowLiquidity(testCase, index);

    deal2(testCase.collateralUnderlying, user, testCase.supplyAmount);
    vm.startPrank(user);
    IERC20(testCase.collateralUnderlying).forceApprove(
      address(spokeContract),
      testCase.supplyAmount
    );
    spokeContract.supply(collateralReserveId, testCase.supplyAmount, user);
    spokeContract.setUsingAsCollateral(collateralReserveId, true, user);
    spokeContract.borrow(borrowReserveId, testCase.borrowAmount, user);
    vm.stopPrank();

    vm.mockCall(
      testCase.collateralPriceFeed,
      abi.encodeWithSignature('latestAnswer()'),
      abi.encode(testCase.unhealthyCollateralPrice)
    );

    ISpoke.UserAccountData memory preLiq = spokeContract.getUserAccountData(user);
    assertLt(preLiq.healthFactor, 1e18, 'expected unhealthy position after price drop');

    deal2(testCase.borrowUnderlying, liquidator, testCase.partialLiquidationDebtAmount);
    uint256 liquidatorCollateralBefore = IERC20(testCase.collateralUnderlying).balanceOf(
      liquidator
    );

    vm.startPrank(liquidator);
    IERC20(testCase.borrowUnderlying).forceApprove(
      address(spokeContract),
      testCase.partialLiquidationDebtAmount
    );
    spokeContract.liquidationCall(
      collateralReserveId,
      borrowReserveId,
      user,
      testCase.partialLiquidationDebtAmount,
      false
    );
    vm.stopPrank();
    vm.clearMockedCalls();

    uint256 liquidatorCollateralAfter = IERC20(testCase.collateralUnderlying).balanceOf(liquidator);
    assertGt(
      liquidatorCollateralAfter,
      liquidatorCollateralBefore,
      'liquidator did not receive collateral'
    );
    ISpoke.UserAccountData memory postLiq = spokeContract.getUserAccountData(user);
    assertGt(postLiq.healthFactor, preLiq.healthFactor, 'HF should improve post-liquidation');
    assertLt(postLiq.totalDebtValueRay, preLiq.totalDebtValueRay, 'debt should decrease');
  }

  function _runLiquidationRevertsIfHealthy(
    ReserveTestCase memory testCase,
    uint256 index
  ) internal {
    address user = makeAddr(string.concat('healthyLiqUser_', vm.toString(index)));
    address liquidator = makeAddr(string.concat('healthyLiquidator_', vm.toString(index)));
    ISpoke spokeContract = ISpoke(_payload().spoke());
    (uint256 collateralReserveId, uint256 borrowReserveId) = _reserveIdsFor(testCase);
    _seedBorrowLiquidity(testCase, index);

    deal2(testCase.collateralUnderlying, user, testCase.supplyAmount);
    vm.startPrank(user);
    IERC20(testCase.collateralUnderlying).forceApprove(
      address(spokeContract),
      testCase.supplyAmount
    );
    spokeContract.supply(collateralReserveId, testCase.supplyAmount, user);
    spokeContract.setUsingAsCollateral(collateralReserveId, true, user);
    spokeContract.borrow(borrowReserveId, testCase.borrowAmount, user);
    vm.stopPrank();

    deal2(testCase.borrowUnderlying, liquidator, testCase.healthyLiquidationDebtAmount);
    vm.startPrank(liquidator);
    IERC20(testCase.borrowUnderlying).forceApprove(
      address(spokeContract),
      testCase.healthyLiquidationDebtAmount
    );
    vm.expectRevert(ISpoke.HealthFactorNotBelowThreshold.selector);
    spokeContract.liquidationCall(
      collateralReserveId,
      borrowReserveId,
      user,
      testCase.healthyLiquidationDebtAmount,
      false
    );
    vm.stopPrank();
  }

  function _runGiverPositionManagerSupply(ReserveTestCase memory testCase, uint256 index) internal {
    address owner = makeAddr(string.concat('giverOwner_', vm.toString(index)));
    address supplier = makeAddr(string.concat('giverSupplier_', vm.toString(index)));
    ISpoke spokeContract = ISpoke(_payload().spoke());
    (uint256 collateralReserveId, ) = _reserveIdsFor(testCase);

    vm.prank(owner);
    spokeContract.setUserPositionManager(
      address(AaveV4EthereumPositionManagers.GIVER_POSITION_MANAGER),
      true
    );

    deal2(testCase.collateralUnderlying, supplier, testCase.supplyAmount);
    vm.startPrank(supplier);
    IERC20(testCase.collateralUnderlying).forceApprove(
      address(AaveV4EthereumPositionManagers.GIVER_POSITION_MANAGER),
      testCase.supplyAmount
    );
    AaveV4EthereumPositionManagers.GIVER_POSITION_MANAGER.supplyOnBehalfOf({
      spoke: address(spokeContract),
      reserveId: collateralReserveId,
      amount: testCase.supplyAmount,
      onBehalfOf: owner
    });
    vm.stopPrank();

    assertEq(
      spokeContract.getUserSuppliedAssets(collateralReserveId, owner),
      testCase.supplyAmount
    );
    assertEq(IERC20(testCase.collateralUnderlying).balanceOf(supplier), 0);
  }

  function _runTakerPositionManagerBorrow(ReserveTestCase memory testCase, uint256 index) internal {
    address owner = makeAddr(string.concat('takerOwner_', vm.toString(index)));
    address taker = makeAddr(string.concat('takerDelegatee_', vm.toString(index)));
    ISpoke spokeContract = ISpoke(_payload().spoke());
    (uint256 collateralReserveId, uint256 borrowReserveId) = _reserveIdsFor(testCase);
    _seedBorrowLiquidity(testCase, index);

    deal2(testCase.collateralUnderlying, owner, testCase.supplyAmount);
    vm.startPrank(owner);
    IERC20(testCase.collateralUnderlying).forceApprove(
      address(spokeContract),
      testCase.supplyAmount
    );
    spokeContract.supply(collateralReserveId, testCase.supplyAmount, owner);
    spokeContract.setUsingAsCollateral(collateralReserveId, true, owner);
    spokeContract.setUserPositionManager(
      address(AaveV4EthereumPositionManagers.TAKER_POSITION_MANAGER),
      true
    );
    AaveV4EthereumPositionManagers.TAKER_POSITION_MANAGER.approveBorrow({
      spoke: address(spokeContract),
      reserveId: borrowReserveId,
      spender: taker,
      amount: testCase.borrowAmount
    });
    vm.stopPrank();

    vm.prank(taker);
    AaveV4EthereumPositionManagers.TAKER_POSITION_MANAGER.borrowOnBehalfOf({
      spoke: address(spokeContract),
      reserveId: borrowReserveId,
      amount: testCase.borrowAmount,
      onBehalfOf: owner
    });

    assertEq(IERC20(testCase.borrowUnderlying).balanceOf(taker), testCase.borrowAmount);
    assertApproxEqAbs(
      spokeContract.getUserTotalDebt(borrowReserveId, owner),
      testCase.borrowAmount,
      2
    );
  }

  function _runConfigPositionManagerSetCollateral(
    ReserveTestCase memory testCase,
    uint256 index
  ) internal {
    address owner = makeAddr(string.concat('configOwner_', vm.toString(index)));
    address delegatee = makeAddr(string.concat('configDelegatee_', vm.toString(index)));
    ISpoke spokeContract = ISpoke(_payload().spoke());
    (uint256 collateralReserveId, ) = _reserveIdsFor(testCase);

    deal2(testCase.collateralUnderlying, owner, testCase.supplyAmount);
    vm.startPrank(owner);
    IERC20(testCase.collateralUnderlying).forceApprove(
      address(spokeContract),
      testCase.supplyAmount
    );
    spokeContract.supply(collateralReserveId, testCase.supplyAmount, owner);
    spokeContract.setUserPositionManager(
      address(AaveV4EthereumPositionManagers.CONFIG_POSITION_MANAGER),
      true
    );
    AaveV4EthereumPositionManagers.CONFIG_POSITION_MANAGER.setGlobalPermission({
      spoke: address(spokeContract),
      delegatee: delegatee,
      status: true
    });
    vm.stopPrank();

    (bool enabledBefore, ) = spokeContract.getUserReserveStatus(collateralReserveId, owner);
    assertFalse(enabledBefore, 'collateral should start disabled');

    vm.prank(delegatee);
    AaveV4EthereumPositionManagers.CONFIG_POSITION_MANAGER.setUsingAsCollateralOnBehalfOf({
      spoke: address(spokeContract),
      reserveId: collateralReserveId,
      usingAsCollateral: true,
      onBehalfOf: owner
    });

    (bool enabledAfter, ) = spokeContract.getUserReserveStatus(collateralReserveId, owner);
    assertTrue(enabledAfter, 'delegatee should have enabled collateral');
  }

  function _runTokenizationDepositRevertsWhileAddCapZero(
    TokenizationTestCase memory testCase,
    uint256 index
  ) internal {
    address tokenizationSpoke = TokenizationSpokeLib.find(testCase.hub, testCase.underlying);
    require(tokenizationSpoke != address(0), 'tokenization spoke missing');

    address user = makeAddr(string.concat('tokenizationCapZeroUser_', vm.toString(index)));
    deal2(testCase.underlying, user, testCase.depositAmount);

    vm.startPrank(user);
    IERC20(testCase.underlying).forceApprove(tokenizationSpoke, testCase.depositAmount);
    vm.expectRevert(abi.encodeWithSignature('AddCapExceeded(uint256)', 0));
    ITokenizationSpoke(tokenizationSpoke).deposit(testCase.depositAmount, user);
    vm.stopPrank();
  }

  function _runTokenizationDepositAndRedeem(
    TokenizationTestCase memory testCase,
    uint256 index
  ) internal {
    address tokenizationSpoke = TokenizationSpokeLib.find(testCase.hub, testCase.underlying);
    require(tokenizationSpoke != address(0), 'tokenization spoke missing');

    uint256 assetId = testCase.hub.getAssetId(testCase.underlying);
    vm.prank(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    AaveV4Ethereum.HUB_CONFIGURATOR.updateSpokeAddCap(
      address(testCase.hub),
      assetId,
      tokenizationSpoke,
      testCase.spokeAssetIdAddCap
    );

    address user = makeAddr(string.concat('tokenizationUser_', vm.toString(index)));
    deal2(testCase.underlying, user, testCase.depositAmount);

    vm.startPrank(user);
    IERC20(testCase.underlying).forceApprove(tokenizationSpoke, testCase.depositAmount);
    uint256 shares = ITokenizationSpoke(tokenizationSpoke).deposit(testCase.depositAmount, user);
    vm.stopPrank();

    assertGt(shares, 0, 'no shares minted');
    assertEq(IERC20(tokenizationSpoke).balanceOf(user), shares);
    assertEq(ITokenizationSpoke(tokenizationSpoke).totalAssets(), testCase.depositAmount);
    assertEq(IERC20(testCase.underlying).balanceOf(user), 0);

    uint256 redeemTarget = shares / 2;
    vm.prank(user);
    uint256 redeemedAssets = ITokenizationSpoke(tokenizationSpoke).redeem(redeemTarget, user, user);

    assertGt(redeemedAssets, 0, 'no assets redeemed');
    assertEq(IERC20(tokenizationSpoke).balanceOf(user), shares - redeemTarget);
    assertEq(IERC20(testCase.underlying).balanceOf(user), redeemedAssets);
  }

  function _registerSpokeOnPositionManagers() internal {
    address spokeAddress = _payload().spoke();
    address[4] memory pms = [
      address(AaveV4EthereumPositionManagers.GIVER_POSITION_MANAGER),
      address(AaveV4EthereumPositionManagers.TAKER_POSITION_MANAGER),
      address(AaveV4EthereumPositionManagers.CONFIG_POSITION_MANAGER),
      address(AaveV4EthereumPositionManagers.SIGNATURE_GATEWAY)
    ];
    vm.startPrank(SECURITY_COUNCIL);
    for (uint256 i; i < pms.length; ++i) {
      (bool ok, ) = pms[i].call(
        abi.encodeWithSignature('registerSpoke(address,bool)', spokeAddress, true)
      );
      assertTrue(ok, 'registerSpoke failed');
    }
    vm.stopPrank();
  }

  function _reserveTestCases() internal view virtual returns (ReserveTestCase[] memory);

  function _tokenizationTestCases() internal view virtual returns (TokenizationTestCase[] memory);

  /// @dev Subclasses must pin the trusted canonical SpokeInstance impl address.
  function _canonicalSpokeImplementation() internal view virtual returns (address);

  function _assertSpokeImplIsCanonical(address spokeProxy) internal view {
    bytes32 implementationSlot = vm.load(spokeProxy, ERC1967Utils.IMPLEMENTATION_SLOT);
    address implementation = address(uint160(uint256(implementationSlot)));
    require(implementation != address(0), 'spoke impl slot is zero');
    require(implementation.code.length > 0, 'spoke impl has no code');
    require(
      implementation == _canonicalSpokeImplementation(),
      string.concat('spoke impl is not canonical: ', vm.toString(implementation))
    );
  }

  function _reserveIdsFor(
    ReserveTestCase memory testCase
  ) internal view returns (uint256 collateralReserveId, uint256 borrowReserveId) {
    ISpoke spokeContract = ISpoke(_payload().spoke());
    uint256 collateralAssetId = testCase.collateralHub.getAssetId(testCase.collateralUnderlying);
    uint256 borrowAssetId = testCase.borrowHub.getAssetId(testCase.borrowUnderlying);
    collateralReserveId = spokeContract.getReserveId(
      address(testCase.collateralHub),
      collateralAssetId
    );
    borrowReserveId = spokeContract.getReserveId(address(testCase.borrowHub), borrowAssetId);
  }

  /// @dev Seeds `borrowLiquiditySeed` of the borrow asset into the spoke so natively-listed
  ///      borrowables (no pre-existing depositors) have liquidity to borrow against. No-op when
  ///      the seed is zero (cross-hub credit lines draw from the source hub's existing pool).
  function _seedBorrowLiquidity(ReserveTestCase memory testCase, uint256 index) internal {
    if (testCase.borrowLiquiditySeed == 0) return;
    address seeder = makeAddr(string.concat('borrowSeeder_', vm.toString(index)));
    ISpoke spokeContract = ISpoke(_payload().spoke());
    (, uint256 borrowReserveId) = _reserveIdsFor(testCase);
    deal2(testCase.borrowUnderlying, seeder, testCase.borrowLiquiditySeed);
    vm.startPrank(seeder);
    IERC20(testCase.borrowUnderlying).forceApprove(
      address(spokeContract),
      testCase.borrowLiquiditySeed
    );
    spokeContract.supply(borrowReserveId, testCase.borrowLiquiditySeed, seeder);
    vm.stopPrank();
  }

  function _findReserveInfo(
    Types.ReserveInfo[] memory reserves,
    address underlying
  ) internal pure returns (Types.ReserveInfo memory) {
    for (uint256 i; i < reserves.length; ++i) {
      if (reserves[i].underlying == underlying) return reserves[i];
    }
    revert('reserve not found');
  }
}
