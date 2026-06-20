// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {IAaveV4ConfigEngine} from 'aave-v4/config-engine/interfaces/IAaveV4ConfigEngine.sol';
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
import {AaveV4PayloadHub} from '../v4-hub/AaveV4PayloadHub.sol';
import {AaveV4PayloadEthereumHubForkTestBase} from '../v4-hub/AaveV4PayloadEthereumHubForkTestBase.sol';
import {AaveV4PayloadEthereumSpokeTestBase} from './AaveV4PayloadEthereumSpokeTestBase.sol';

/// @dev Extends the hub fork base, mirroring `AaveV4PayloadSpoke is AaveV4PayloadHub`: a combined
///      payload's test inherits only this and implements `_payload()`.
abstract contract AaveV4PayloadEthereumSpokeForkTestBase is
  AaveV4PayloadEthereumHubForkTestBase,
  AaveV4PayloadEthereumSpokeTestBase
{
  using SafeERC20 for IERC20;

  /// @dev A spoke payload is also a hub payload; subclasses implement only `_payload()`.
  function _hubPayload() internal view override returns (AaveV4PayloadHub) {
    return _payload();
  }

  /// @dev Assumed precondition: the SpokeConfigurator already holds SPOKE_CONFIGURATOR_ROLE.
  function test_assumedRole_spokeConfiguratorHoldsConfiguratorRole() public view virtual {
    (bool isMember, ) = AaveV4Ethereum.ACCESS_MANAGER.hasRole(
      Roles.SPOKE_CONFIGURATOR_ROLE,
      address(AaveV4Ethereum.SPOKE_CONFIGURATOR)
    );
    assertTrue(isMember, 'SpokeConfigurator must already hold SPOKE_CONFIGURATOR_ROLE');
  }

  /// @dev Every existing spoke this payload reconfigures must already gate the configurator
  ///      selectors behind SPOKE_CONFIGURATOR_ROLE, else the price-source updates revert.
  function test_assumedRole_reconfiguredSpokesGateConfiguratorSelectors() public view virtual {
    IAaveV4ConfigEngine.ReserveConfigUpdate[] memory updates = _payload()
      .spokeReserveConfigUpdates();
    bytes4[] memory selectors = Roles.getSpokeConfiguratorRoleSelectors();
    for (uint256 i; i < updates.length; ++i) {
      for (uint256 j; j < selectors.length; ++j) {
        assertEq(
          AaveV4Ethereum.ACCESS_MANAGER.getTargetFunctionRole(updates[i].spoke, selectors[j]),
          Roles.SPOKE_CONFIGURATOR_ROLE
        );
      }
    }
  }

  /// @dev One parametrised collateral/borrow flow. The hub is specified per leg, since collateral
  ///      and borrow reserves may live on different hubs (cross-hub credit lines).
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
    // Liquidity to seed into the borrow reserve before borrowing. 0 when the asset already has
    // liquidity (cross-hub credit line); > 0 for a native borrowable with no depositors yet, so
    // borrows revert on HF rather than on liquidity. Only set for spoke-suppliable reserves.
    uint256 borrowLiquiditySeed;
    // Whether the borrow asset implements EIP-2612 `permit`. The SignatureGateway flow needs it;
    // non-permit tokens (e.g. USDT) are skipped there and covered by the other flows.
    bool borrowSupportsPermit;
  }

  /// @dev One tokenization-spoke deposit/redeem flow.
  struct TokenizationTestCase {
    IHub hub;
    address underlying;
    uint256 depositAmount;
    uint256 spokeAssetIdAddCap;
  }

  /// @dev Owner of each PositionManager; used to `registerSpoke` (onlyOwner, out of gov reach).
  address internal constant SECURITY_COUNCIL = 0x187AAE17d4931310B3fc75743e7F16Bdc9eD77e9;

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
      // SignatureGateway needs EIP-2612 permit; non-permit borrow assets are skipped here.
      if (!cases[i].borrowSupportsPermit) continue;
      Types.ReserveInfo memory collateralInfo = _findReserveInfo(
        reserves,
        cases[i].collateralUnderlying
      );
      Types.ReserveInfo memory borrowInfo = _findReserveInfo(reserves, cases[i].borrowUnderlying);
      _seedBorrowLiquidity(cases[i], i);
      _testSignatureGateway({
        gateway: AaveV4EthereumPositionManagers.SIGNATURE_GATEWAY,
        spoke: spokeContract,
        reserveInfo: collateralInfo,
        collateralInfo: collateralInfo
      });
      _testSignatureGatewayBorrowFlow({
        gateway: AaveV4EthereumPositionManagers.SIGNATURE_GATEWAY,
        spoke: spokeContract,
        borrowInfo: borrowInfo,
        collateralInfo: collateralInfo
      });
    }
  }

  /// @dev Supply collateral + borrow + repay via SignatureGateway; assumes borrow liquidity exists.
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

  /// @dev Seeds `borrowLiquiditySeed` of the borrow asset into the spoke; no-op when the seed is 0.
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
