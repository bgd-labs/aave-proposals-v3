// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

library AddressesToMigrate {
  function getUnderlyingAddresses() internal view returns (address[8] memory) {
    return [
      AaveV2PolygonAssets.USDC_UNDERLYING,
      AaveV2PolygonAssets.DAI_UNDERLYING,
      AaveV2PolygonAssets.USDT_UNDERLYING,
      AaveV2PolygonAssets.WETH_UNDERLYING,
      AaveV2PolygonAssets.WMATIC_UNDERLYING,
      AaveV2PolygonAssets.WBTC_UNDERLYING,
      AaveV2PolygonAssets.GHST_UNDERLYING,
      AaveV2PolygonAssets.LINK_UNDERLYING
    ];
  }

  function getV2ATokenAddresses() internal view returns (address[8] memory) {
    return [
      AaveV2PolygonAssets.USDC_A_TOKEN,
      AaveV2PolygonAssets.DAI_A_TOKEN,
      AaveV2PolygonAssets.USDT_A_TOKEN,
      AaveV2PolygonAssets.WETH_A_TOKEN,
      AaveV2PolygonAssets.WMATIC_A_TOKEN,
      AaveV2PolygonAssets.WBTC_A_TOKEN,
      AaveV2PolygonAssets.GHST_A_TOKEN,
      AaveV2PolygonAssets.LINK_A_TOKEN
    ];
  }
}

/**
 * @title Treasury Management - Polygon v2 to v3 Migration
 * @author efecarranza.eth
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x1b816c12b6f547a1982198ffd0e36412390b05828b560c9edee4e8a6903c4882
 * - Discussion: https://governance.aave.com/t/arfc-migrate-consolidate-polygon-treasury/12248/4
 */
contract AaveV2Polygon_TreasuryManagementPolygonV2ToV3Migration_20231208 is
  IProposalGenericExecutor
{
  using SafeERC20 for IERC20;

  function execute() external {
    address[8] memory TO_MIGRATE = AddressesToMigrate.getUnderlyingAddresses();
    address[8] memory A_TOKENS = AddressesToMigrate.getV2ATokenAddresses();

    AaveV3Polygon.COLLECTOR.transfer(
      AaveV2PolygonAssets.USDC_UNDERLYING,
      address(this),
      IERC20(AaveV2PolygonAssets.USDC_UNDERLYING).balanceOf(address(AaveV3Polygon.COLLECTOR))
    );

    AaveV3Polygon.COLLECTOR.transfer(
      AaveV2PolygonAssets.WMATIC_UNDERLYING,
      address(this),
      IERC20(AaveV2PolygonAssets.WMATIC_UNDERLYING).balanceOf(address(AaveV3Polygon.COLLECTOR))
    );

    for (uint256 i = 0; i < 8; ++i) {
      address underlying = TO_MIGRATE[i];
      address aToken = A_TOKENS[i];

      AaveV3Polygon.COLLECTOR.transfer(
        aToken,
        address(this),
        IERC20(aToken).balanceOf(address(AaveV3Polygon.COLLECTOR))
      );

      AaveV2Polygon.POOL.withdraw(underlying, type(uint256).max, address(this));

      uint256 amount = IERC20(underlying).balanceOf(address(this));
      IERC20(underlying).forceApprove(address(AaveV3Polygon.POOL), amount);

      AaveV3Polygon.POOL.deposit(underlying, amount, address(AaveV3Polygon.COLLECTOR), 0);
    }
  }
}
