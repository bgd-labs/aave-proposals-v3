// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

interface IAavePolEthERC20Bridge {
  function bridge(address token, uint256 amount) external;
}

interface IWMatic {
  function withdraw(uint256 amount) external;
}

interface IAavePolEthPlasmaBridge {
  function bridge(uint256 amount) external;
}

/**
 * @title April Finance Update
 * @author @karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-april-finance-update/17390
 */
contract AaveV2Polygon_AprilFinanceUpdate_20240421 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  struct TokenToBridge {
    address underlying;
    address aToken;
    uint256 balance;
  }

  error FailedToSendMATIC();

  IAavePolEthERC20Bridge public constant bridge =
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE);

  IAavePolEthPlasmaBridge public constant plasmaBridge =
    IAavePolEthPlasmaBridge(0xc980508cC8866f726040Da1C0C61f682e74aBc39);

  function execute() external {
    _migrateV2ToV3();
    _withdrawV2Tokens();
    _withdrawV3Tokens();
    _withdrawMatic();

    bridge.bridge(
      AaveV3PolygonAssets.USDC_UNDERLYING,
      IERC20(AaveV3PolygonAssets.USDC_UNDERLYING).balanceOf(address(bridge))
    );

    bridge.bridge(
      AaveV3PolygonAssets.DAI_UNDERLYING,
      IERC20(AaveV3PolygonAssets.DAI_UNDERLYING).balanceOf(address(bridge))
    );
  }

  function _migrateV2ToV3() internal {
    AaveV3Polygon.COLLECTOR.transfer(
      AaveV2PolygonAssets.USDT_A_TOKEN,
      address(this),
      IERC20(AaveV2PolygonAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 1e6
    );

    AaveV2Polygon.POOL.withdraw(
      AaveV2PolygonAssets.USDT_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    uint256 amount = IERC20(AaveV2PolygonAssets.USDT_UNDERLYING).balanceOf(address(this));
    IERC20(AaveV2PolygonAssets.USDT_UNDERLYING).forceApprove(address(AaveV3Polygon.POOL), amount);

    AaveV3Polygon.POOL.deposit(
      AaveV2PolygonAssets.USDT_UNDERLYING,
      amount,
      address(AaveV3Polygon.COLLECTOR),
      0
    );
  }

  function _withdrawMatic() internal {
    TokenToBridge[] memory tokens = new TokenToBridge[](2);
    tokens[0] = TokenToBridge(
      AaveV2PolygonAssets.WMATIC_UNDERLYING,
      AaveV2PolygonAssets.WMATIC_A_TOKEN,
      IERC20(AaveV2PolygonAssets.WMATIC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) -
        1 ether
    );
    tokens[1] = TokenToBridge(
      AaveV2PolygonAssets.WMATIC_UNDERLYING,
      AaveV2PolygonAssets.WMATIC_A_TOKEN,
      IERC20(AaveV2PolygonAssets.WMATIC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) -
        1 ether
    );

    uint256 tokensLength = tokens.length;
    for (uint256 i = 0; i < tokensLength; i++) {
      AaveV3Polygon.COLLECTOR.transfer(tokens[i].aToken, address(this), tokens[i].balance);

      AaveV2Polygon.POOL.withdraw(tokens[i].underlying, type(uint256).max, address(this));
    }

    // (bool ok, ) = plasmaBridge.call{value: address(this).balance}('');

    // if (!ok) revert FailedToSendMATIC();
  }

  /**
   * @notice Withdraws v2 tokens to bridge
   */
  function _withdrawV2Tokens() internal {
    TokenToBridge[] memory tokens = new TokenToBridge[](2);
    tokens[0] = TokenToBridge(
      AaveV2PolygonAssets.DAI_UNDERLYING,
      AaveV2PolygonAssets.DAI_A_TOKEN,
      IERC20(AaveV2PolygonAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 1 ether
    );
    tokens[1] = TokenToBridge(
      AaveV2PolygonAssets.USDC_UNDERLYING,
      AaveV2PolygonAssets.USDC_A_TOKEN,
      IERC20(AaveV2PolygonAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 1e6
    );

    uint256 tokensLength = tokens.length;
    for (uint256 i = 0; i < tokensLength; i++) {
      AaveV3Polygon.COLLECTOR.transfer(tokens[i].aToken, address(this), tokens[i].balance);

      AaveV2Polygon.POOL.withdraw(tokens[i].underlying, type(uint256).max, address(bridge));
    }
  }

  /**
   * @notice Withdraws v3 tokens to bridge
   */
  function _withdrawV3Tokens() internal {
    TokenToBridge[] memory tokens = new TokenToBridge[](2);
    tokens[0] = TokenToBridge(
      AaveV2PolygonAssets.DAI_UNDERLYING,
      AaveV2PolygonAssets.DAI_A_TOKEN,
      IERC20(AaveV2PolygonAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 1 ether
    );
    tokens[1] = TokenToBridge(
      AaveV2PolygonAssets.USDC_UNDERLYING,
      AaveV2PolygonAssets.USDC_A_TOKEN,
      IERC20(AaveV2PolygonAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 1e6
    );

    uint256 tokensLength = tokens.length;
    for (uint256 i = 0; i < tokensLength; i++) {
      AaveV3Polygon.COLLECTOR.transfer(tokens[i].aToken, address(this), tokens[i].balance);

      AaveV2Polygon.POOL.withdraw(tokens[i].underlying, type(uint256).max, address(bridge));
    }
  }

  receive() external payable {}
}
