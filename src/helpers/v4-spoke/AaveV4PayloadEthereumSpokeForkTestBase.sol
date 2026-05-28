// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {ProtocolV4TestBase} from 'aave-helpers/src/ProtocolV4TestBase.sol';
import {Types} from 'aave-helpers/src/dependencies/v4/Types.sol';
import {IAccessManaged} from 'aave-v4/dependencies/openzeppelin/IAccessManaged.sol';
import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';
import {ISpoke} from 'aave-v4/spoke/interfaces/ISpoke.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {IAaveOracle, ITokenizationSpoke} from 'aave-address-book/AaveV4.sol';
import {AaveV4Ethereum, AaveV4EthereumPositionManagers} from 'aave-address-book/AaveV4Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

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
    bytes4[] memory configuratorSelectors = _payload().spokeConfiguratorSelectors();
    for (uint256 i; i < configuratorSelectors.length; ++i) {
      assertEq(
        AaveV4Ethereum.ACCESS_MANAGER.getTargetFunctionRole(spokeAddress, configuratorSelectors[i]),
        Roles.SPOKE_CONFIGURATOR_ROLE
      );
    }
    bytes4[] memory updaterSelectors = _payload().spokeUserPositionUpdaterSelectors();
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
    bytes4[] memory gated = _payload().spokeConfiguratorSelectors();
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

  function test_signatureGateway_supplyOnBehalfOfNewSpoke() public virtual {
    GovV3Helpers.executePayload(vm, address(_payload()));
    _registerSpokeOnPositionManagers();
    ReserveTestCase[] memory cases = _reserveTestCases();
    Types.ReserveInfo[] memory reserves = _getReserveInfo(ISpoke(_payload().spoke()));
    for (uint256 i; i < cases.length; ++i) {
      Types.ReserveInfo memory collateralInfo = _findReserveInfo(
        reserves,
        cases[i].collateralUnderlying
      );
      _testSignatureGateway({
        gateway: AaveV4EthereumPositionManagers.SIGNATURE_GATEWAY,
        spoke: ISpoke(_payload().spoke()),
        reserveInfo: collateralInfo,
        collateralInfo: collateralInfo
      });
    }
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
    address tokenizationSpoke = _findTokenizationSpoke(testCase.hub, testCase.underlying);
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
    address tokenizationSpoke = _findTokenizationSpoke(testCase.hub, testCase.underlying);
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

  /// @dev Probes each candidate spoke (skipping the payload spoke and treasury) with `name()` —
  ///      tokenization spokes expose it, regular spokes don't. Reverts if more than one matches.
  function _findTokenizationSpoke(IHub hub, address underlying) internal view returns (address) {
    uint256 assetId = hub.getAssetId(underlying);
    uint256 spokeCount = hub.getSpokeCount(assetId);
    address payloadSpoke = _payload().spoke();
    address treasurySpoke = address(AaveV4Ethereum.TREASURY_SPOKE);
    address found;
    for (uint256 i; i < spokeCount; ++i) {
      address candidate = hub.getSpokeAddress(assetId, i);
      if (candidate == payloadSpoke || candidate == treasurySpoke) continue;
      (bool ok, ) = candidate.staticcall(abi.encodeWithSignature('name()'));
      if (!ok) continue;
      require(found == address(0), 'multiple tokenization spokes match');
      found = candidate;
    }
    return found;
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
