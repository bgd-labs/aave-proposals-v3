// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';

import {AddressesToMigrate, AaveV2Polygon_TreasuryManagementPolygonV2ToV3Migration_20231208} from './AaveV2Polygon_TreasuryManagementPolygonV2ToV3Migration_20231208.sol';

/**
 * @dev Test for AaveV2Polygon_TreasuryManagementPolygonV2ToV3Migration_20231208
 * command: make test-contract filter=AaveV2Polygon_TreasuryManagementPolygonV2ToV3Migration_20231208
 */
contract AaveV2Polygon_TreasuryManagementPolygonV2ToV3Migration_20231208_Test is
  ProtocolV2TestBase
{
  AaveV2Polygon_TreasuryManagementPolygonV2ToV3Migration_20231208 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 51130199);
    proposal = AaveV2Polygon_TreasuryManagementPolygonV2ToV3Migration_20231208(
      0x31B7F31dcCF8E8127a6f1619e6624A2a5Ef6713B
    );
  }

  function test_execute() public {
    address[8] memory TO_MIGRATE = AddressesToMigrate.getUnderlyingAddresses();
    address[8] memory A_TOKENS = AddressesToMigrate.getV2ATokenAddresses();

    address[8] memory V3_A_TOKENS = [
      AaveV3PolygonAssets.USDC_A_TOKEN,
      AaveV3PolygonAssets.DAI_A_TOKEN,
      AaveV3PolygonAssets.USDT_A_TOKEN,
      AaveV3PolygonAssets.WETH_A_TOKEN,
      AaveV3PolygonAssets.WMATIC_A_TOKEN,
      AaveV3PolygonAssets.WBTC_A_TOKEN,
      AaveV3PolygonAssets.GHST_A_TOKEN,
      AaveV3PolygonAssets.LINK_A_TOKEN
    ];

    uint256[] memory v3AssetsBalances = new uint256[](8);
    uint256[] memory v2Assetsbalances = new uint256[](8);

    for (uint256 i = 0; i < TO_MIGRATE.length; ++i) {
      uint256 balanceV2 = IERC20(A_TOKENS[i]).balanceOf(address(AaveV3Polygon.COLLECTOR));
      uint256 balanceV3 = IERC20(V3_A_TOKENS[i]).balanceOf(address(AaveV3Polygon.COLLECTOR));

      assertGt(IERC20(A_TOKENS[i]).balanceOf(address(AaveV3Polygon.COLLECTOR)), 0);

      v2Assetsbalances[i] = balanceV2;
      v3AssetsBalances[i] = balanceV3;
    }

    uint256 balanceUsdcBefore = IERC20(AaveV2PolygonAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 balanceWMaticBefore = IERC20(AaveV2PolygonAssets.WMATIC_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );

    assertGt(balanceUsdcBefore, 0);
    assertGt(balanceWMaticBefore, 0);

    executePayload(vm, address(proposal));

    assertEq(IERC20(AaveV2PolygonAssets.USDC_UNDERLYING).balanceOf(address(proposal)), 0);
    assertEq(IERC20(AaveV2PolygonAssets.WMATIC_UNDERLYING).balanceOf(address(proposal)), 0);

    for (uint256 i = 0; i < TO_MIGRATE.length; i++) {
      uint256 balanceV2 = IERC20(A_TOKENS[i]).balanceOf(address(AaveV3Polygon.COLLECTOR));
      uint256 balanceV3 = IERC20(V3_A_TOKENS[i]).balanceOf(address(AaveV3Polygon.COLLECTOR));

      assertEq(IERC20(A_TOKENS[i]).balanceOf(address(proposal)), 0);

      assertLt(balanceV2, v2Assetsbalances[i]);

      address underlying = TO_MIGRATE[i];
      if (
        underlying == AaveV2PolygonAssets.USDC_UNDERLYING ||
        underlying == AaveV2PolygonAssets.WMATIC_UNDERLYING
      ) {
        continue;
      }

      assertApproxEqRel(v3AssetsBalances[i] + v2Assetsbalances[i], balanceV3, 0.001e18);
    }

    // USDC is Position 0
    assertApproxEqRel(
      v3AssetsBalances[0] + v2Assetsbalances[0] + balanceUsdcBefore,
      IERC20(AaveV3PolygonAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0.001e18
    );

    // wMATIC is Position 4
    assertApproxEqRel(
      v3AssetsBalances[4] + v2Assetsbalances[4] + balanceWMaticBefore,
      IERC20(AaveV3PolygonAssets.WMATIC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0.001e18
    );
  }
}
