// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

interface IAavePolEthERC20Bridge {
  function bridge(address token, uint256 amount) external;
}

/**
 * @title Aave Funding Updates
 * @author efecarranza.eth
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x099f88e1728760952be26fcb8fc99b26c29336e6a109820b391751b108399ee5
 * - Discussion: https://governance.aave.com/t/arfc-aave-funding-update/15194
 */
contract AaveV2Polygon_AaveFundingUpdates_20231102 is IProposalGenericExecutor {
  IAavePolEthERC20Bridge public constant bridge =
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE);
  uint256 public constant USDC_TO_WITHDRAW = 1_700_000e6;
  uint256 public constant USDT_TO_WITHDRAW = 750_000e6;
  uint256 public constant DAI_TO_WITHDRAW = 500_000e18;

  function execute() external {
    AaveV2Polygon.COLLECTOR.transfer(
      AaveV2PolygonAssets.USDC_A_TOKEN,
      address(this),
      USDC_TO_WITHDRAW
    );
    AaveV2Polygon.COLLECTOR.transfer(
      AaveV2PolygonAssets.USDT_A_TOKEN,
      address(this),
      USDT_TO_WITHDRAW
    );
    AaveV2Polygon.COLLECTOR.transfer(
      AaveV2PolygonAssets.DAI_A_TOKEN,
      address(this),
      DAI_TO_WITHDRAW
    );

    uint256 usdcWithdrawn = AaveV2Polygon.POOL.withdraw(
      AaveV2PolygonAssets.USDC_UNDERLYING,
      type(uint256).max,
      MiscPolygon.AAVE_POL_ETH_BRIDGE
    );
    uint256 usdtWithdrawn = AaveV2Polygon.POOL.withdraw(
      AaveV2PolygonAssets.USDT_UNDERLYING,
      type(uint256).max,
      MiscPolygon.AAVE_POL_ETH_BRIDGE
    );
    uint256 daiWithdrawn = AaveV2Polygon.POOL.withdraw(
      AaveV2PolygonAssets.DAI_UNDERLYING,
      type(uint256).max,
      MiscPolygon.AAVE_POL_ETH_BRIDGE
    );

    bridge.bridge(AaveV2PolygonAssets.USDC_UNDERLYING, usdcWithdrawn);
    bridge.bridge(AaveV2PolygonAssets.USDT_UNDERLYING, usdtWithdrawn);
    bridge.bridge(AaveV2PolygonAssets.DAI_UNDERLYING, daiWithdrawn);
  }
}
