// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Polygon_SeptemberFundingUpdatePartA_20241020} from './AaveV3Polygon_SeptemberFundingUpdatePartA_20241020.sol';

/**
 * @dev Test for AaveV3Polygon_SeptemberFundingUpdatePartA_20241020
 * command: FOUNDRY_PROFILE=polygon forge test --match-path=src/20241020_Multi_SeptemberFundingUpdatePartA/AaveV3Polygon_SeptemberFundingUpdatePartA_20241020.t.sol -vv
 */
contract AaveV3Polygon_SeptemberFundingUpdatePartA_20241020_Test is ProtocolV3TestBase {
  AaveV3Polygon_SeptemberFundingUpdatePartA_20241020 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 63357681);
    proposal = new AaveV3Polygon_SeptemberFundingUpdatePartA_20241020();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_SeptemberFundingUpdatePartA_20241020',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }

  function test_migration_usdt() public {
    uint256 aV2Before = IERC20(AaveV2PolygonAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 aV3Before = IERC20(AaveV3PolygonAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 underlyingBefore = IERC20(AaveV2PolygonAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    uint256 v3After = IERC20(AaveV3PolygonAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 underlyingAfter = IERC20(AaveV3PolygonAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    verifyBalances(
      aV2Before,
      aV3Before,
      underlyingBefore,
      v3After,
      underlyingAfter,
      proposal.BALANCE_LEFT_USDT(),
      500000
    );
  }

  function test_migration_dai() public {
    uint256 aV2Before = IERC20(AaveV2PolygonAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 aV3Before = IERC20(AaveV3PolygonAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 underlyingBefore = IERC20(AaveV2PolygonAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    uint256 v3After = IERC20(AaveV3PolygonAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 underlyingAfter = IERC20(AaveV3PolygonAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    verifyBalances(
      aV2Before,
      aV3Before,
      underlyingBefore,
      v3After,
      underlyingAfter,
      proposal.BALANCE_LEFT_DAI(),
      0.05e18
    );
  }

  function test_migration_wPol() public {
    uint256 aV2Before = IERC20(AaveV2PolygonAssets.WPOL_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 aV3Before = IERC20(AaveV3PolygonAssets.WPOL_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 underlyingBefore = IERC20(AaveV2PolygonAssets.WPOL_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    uint256 v3After = IERC20(AaveV3PolygonAssets.WPOL_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 underlyingAfter = IERC20(AaveV3PolygonAssets.WPOL_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    verifyBalances(
      aV2Before,
      aV3Before,
      underlyingBefore,
      v3After,
      underlyingAfter,
      proposal.BALANCE_LEFT_WPOL(),
      0.05e18
    );
  }

  function test_migration_wEth() public {
    uint256 aV2Before = IERC20(AaveV2PolygonAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 aV3Before = IERC20(AaveV3PolygonAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 underlyingBefore = IERC20(AaveV2PolygonAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    uint256 v3After = IERC20(AaveV3PolygonAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 underlyingAfter = IERC20(AaveV3PolygonAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    verifyBalances(
      aV2Before,
      aV3Before,
      underlyingBefore,
      v3After,
      underlyingAfter,
      proposal.BALANCE_LEFT_WETH(),
      0.05e18
    );
  }

  function test_migration_link() public {
    uint256 aV2Before = IERC20(AaveV2PolygonAssets.LINK_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 aV3Before = IERC20(AaveV3PolygonAssets.LINK_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 underlyingBefore = IERC20(AaveV2PolygonAssets.LINK_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    uint256 v3After = IERC20(AaveV3PolygonAssets.LINK_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 underlyingAfter = IERC20(AaveV3PolygonAssets.LINK_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    verifyBalances(
      aV2Before,
      aV3Before,
      underlyingBefore,
      v3After,
      underlyingAfter,
      proposal.BALANCE_LEFT_LINK(),
      0.05e18
    );
  }

  function test_migration_wBtc() public {
    uint256 aV2Before = IERC20(AaveV2PolygonAssets.WBTC_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 aV3Before = IERC20(AaveV3PolygonAssets.WBTC_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 underlyingBefore = IERC20(AaveV2PolygonAssets.WBTC_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    uint256 v3After = IERC20(AaveV3PolygonAssets.WBTC_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 underlyingAfter = IERC20(AaveV3PolygonAssets.WBTC_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    verifyBalances(
      aV2Before,
      aV3Before,
      underlyingBefore,
      v3After,
      underlyingAfter,
      proposal.BALANCE_LEFT_WBTC(),
      500000
    );
  }

  function verifyBalances(
    uint256 v2Before,
    uint256 v3Before,
    uint256 underlyingBefore,
    uint256 v3After,
    uint256 underlyingAfter,
    uint256 leaveBehind,
    uint256 errorMargin
  ) internal pure {
    /// verify underlying
    assertApproxEqRel(underlyingAfter, 0, errorMargin);

    /// verify v3 balance
    assertApproxEqRel(v3After, (v2Before - leaveBehind) + v3Before + underlyingBefore, errorMargin);
  }
}
