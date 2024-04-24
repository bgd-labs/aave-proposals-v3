// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';

import {AaveV2Polygon_AprilFinanceUpdate_20240421} from './AaveV2Polygon_AprilFinanceUpdate_20240421.sol';

interface IAavePolEthPlasmaBridge {
  function bridge(uint256 amount) external;
  function transferOwnership(address newOwner) external;
  function owner() external view returns (address);
}

/**
 * @dev Test for AaveV2Polygon_AprilFinanceUpdate_20240421
 * command: make test-contract filter=AaveV2Polygon_AprilFinanceUpdate_20240421
 */
contract AaveV2Polygon_AprilFinanceUpdate_20240421_Test is ProtocolV2TestBase {
  event Bridge(address token, uint256 amount);

  struct TokenToSwap {
    address underlying;
    address aToken;
    uint256 balance;
  }

  AaveV2Polygon_AprilFinanceUpdate_20240421 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 56178996);
    proposal = new AaveV2Polygon_AprilFinanceUpdate_20240421();
    setupBridge();
  }

  // Assign bridge ownership to the Polygon Executor
  function setupBridge() public {
    IAavePolEthPlasmaBridge plasmaBridge = IAavePolEthPlasmaBridge(
      0xc980508cC8866f726040Da1C0C61f682e74aBc39
    );
    vm.prank(plasmaBridge.owner());
    plasmaBridge.transferOwnership(0xDf7d0e6454DB638881302729F5ba99936EaAB233);
  }

  function test_bgdReimbursements() public {
    uint256 recipientAWmaticBalanceBefore = IERC20(AaveV2PolygonAssets.WMATIC_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );

    executePayload(vm, address(proposal));

    uint256 recipientAWmaticBalanceAfter = IERC20(AaveV2PolygonAssets.WMATIC_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );

    assertApproxEqAbs(
      recipientAWmaticBalanceAfter,
      recipientAWmaticBalanceBefore + proposal.A_WMATIC_AMOUNT_REIMBURSEMENT(),
      1
    );
  }

  function test_migrate() public {
    uint256 balanceAUSDTBefore = IERC20(AaveV2PolygonAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 balanceEthAUSDTBefore = IERC20(AaveV3PolygonAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    assertLt(
      IERC20(AaveV2PolygonAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      balanceAUSDTBefore
    );

    assertGt(
      IERC20(AaveV3PolygonAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      balanceEthAUSDTBefore
    );
  }

  function test_withdrawV2() public {
    TokenToSwap[] memory tokens = new TokenToSwap[](2);
    tokens[0] = TokenToSwap(
      AaveV2PolygonAssets.DAI_UNDERLYING,
      AaveV2PolygonAssets.DAI_A_TOKEN,
      IERC20(AaveV2PolygonAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 1 ether
    );
    tokens[1] = TokenToSwap(
      AaveV2PolygonAssets.USDC_UNDERLYING,
      AaveV2PolygonAssets.USDC_A_TOKEN,
      IERC20(AaveV2PolygonAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 1e6
    );

    for (uint256 i = 0; i < tokens.length; i++) {
      assertGt(IERC20(tokens[i].aToken).balanceOf(address(AaveV3Polygon.COLLECTOR)), 0);
    }

    _expectEmits();

    executePayload(vm, address(proposal));

    for (uint256 i = 0; i < tokens.length; i++) {
      assertApproxEqAbs(
        IERC20(tokens[i].aToken).balanceOf(address(AaveV3Polygon.COLLECTOR)),
        1 ether,
        1000 ether
      );
    } // V2 Withdrawals leave a lot behind
  }

  function test_withdrawV3() public {
    TokenToSwap[] memory tokens = new TokenToSwap[](2);
    tokens[0] = TokenToSwap(
      AaveV3PolygonAssets.USDC_UNDERLYING,
      AaveV3PolygonAssets.USDC_A_TOKEN,
      IERC20(AaveV3PolygonAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 1e6
    );
    tokens[1] = TokenToSwap(
      AaveV3PolygonAssets.DAI_UNDERLYING,
      AaveV3PolygonAssets.DAI_A_TOKEN,
      IERC20(AaveV3PolygonAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 1 ether
    );

    for (uint256 i = 0; i < tokens.length; i++) {
      assertGt(IERC20(tokens[i].aToken).balanceOf(address(AaveV3Polygon.COLLECTOR)), 0);
    }

    _expectEmits();

    executePayload(vm, address(proposal));

    assertApproxEqAbs(
      IERC20(AaveV3PolygonAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      1e6,
      1,
      'aEthUSDC not within 1 ether'
    );
    assertApproxEqAbs(
      IERC20(AaveV3PolygonAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      1 ether,
      1,
      'aEthDAI not within 1 ether'
    );
  }

  function _expectEmits() internal {
    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.USDC_UNDERLYING, 833867244365); // ~268 units

    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.DAI_UNDERLYING, 198944360880437552419394); // ~559,109 units

    vm.expectEmit(true, true, true, true, address(proposal.plasmaBridge()));
    emit Bridge(proposal.NATIVE_MATIC(), 627139693358400415831543);
  }
}
