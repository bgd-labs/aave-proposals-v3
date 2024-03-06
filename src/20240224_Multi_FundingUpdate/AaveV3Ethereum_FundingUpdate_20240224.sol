// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveSwapper} from 'aave-helpers/swaps/AaveSwapper.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Funding Update
 * @author karpatkey_TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x4dd4dff7096bf7ab8c4c071975d40f4cf709c41b4b6b7c60777a6dd50d2ecd09
 * - Discussion: https://governance.aave.com/t/arfc-funding-update/16675
 */
contract AaveV3Ethereum_FundingUpdate_20240224 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  struct TokenToMigrate {
    address underlying;
    address aToken;
    uint256 qty;
  }

  struct TokenToSwap {
    address underlying;
    address aToken;
    uint256 balance;
  }

  AaveSwapper public constant SWAPPER = AaveSwapper(MiscEthereum.AAVE_SWAPPER);
  address public constant ALC_SAFE = 0x205e795336610f5131Be52F09218AF19f0f3eC60;

  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;

  address public constant GHO_USD_FEED = 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC;
  address public constant DPI_USD_FEED = 0xD2A593BF7594aCE1faD597adb697b5645d5edDB2;

  uint256 public constant USDC_V2_TO_MIGRATE = 300_000e6;

  uint256 public constant USDC_V3_TO_SWAP = 1_250_000e6;
  uint256 public constant USDT_V3_TO_SWAP = 1_500_000e6;
  uint256 public constant USDT_V2_TO_SWAP = 200_000e6;

  function execute() external {
    // Transer USDT to Swapper
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      address(SWAPPER),
      IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );

    _migrateV2ToV3();
    _transferToALC();
    _swap();
  }

  /**
   * @notice Swaps withdrawn tokens from V2 and V3 for GHO
   * - withdraws aDAIv2, aUSDTv3, aUSDTv2, aUSDCv3, aUSDCv2, aFRAXv2, aDPIv2
   * - transfers raw LUSD
   */
  function _swap() internal {
    _withdrawV3Tokens();
    _withdrawV2Tokens();

    // LUSD
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      address(SWAPPER),
      IERC20(AaveV3EthereumAssets.LUSD_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.LUSD_ORACLE,
      GHO_USD_FEED,
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV3EthereumAssets.LUSD_UNDERLYING).balanceOf(address(SWAPPER)),
      500
    );

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.DAI_ORACLE,
      GHO_USD_FEED,
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(SWAPPER)),
      100
    );

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV2EthereumAssets.DPI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      DPI_USD_FEED,
      GHO_USD_FEED,
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV2EthereumAssets.DPI_UNDERLYING).balanceOf(address(SWAPPER)),
      300
    );

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.FRAX_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.FRAX_ORACLE,
      GHO_USD_FEED,
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV3EthereumAssets.FRAX_UNDERLYING).balanceOf(address(SWAPPER)),
      300
    );

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      GHO_USD_FEED,
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(address(SWAPPER)),
      50
    );

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDT_ORACLE,
      GHO_USD_FEED,
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(address(SWAPPER)),
      50
    );
  }

  /**
   * @notice migrates all but one unit of the specified assets from AaveV2 to AaveV3
   * assets: WETH, WBTC and USDC
   */
  function _migrateV2ToV3() internal {
    TokenToMigrate[] memory tokens = new TokenToMigrate[](3);
    tokens[0] = TokenToMigrate(
      AaveV2EthereumAssets.WBTC_UNDERLYING,
      AaveV2EthereumAssets.WBTC_A_TOKEN,
      IERC20(AaveV2EthereumAssets.WBTC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) - 1e8
    );
    tokens[1] = TokenToMigrate(
      AaveV2EthereumAssets.WETH_UNDERLYING,
      AaveV2EthereumAssets.WETH_A_TOKEN,
      IERC20(AaveV2EthereumAssets.WETH_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) -
        1 ether
    );
    tokens[2] = TokenToMigrate(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      AaveV2EthereumAssets.USDC_A_TOKEN,
      USDC_V2_TO_MIGRATE
    );

    uint256 tokensLength = tokens.length;
    for (uint256 i = 0; i < tokensLength; i++) {
      AaveV3Ethereum.COLLECTOR.transfer(tokens[i].aToken, address(this), tokens[i].qty);

      AaveV2Ethereum.POOL.withdraw(tokens[i].underlying, type(uint256).max, address(this));

      uint256 amount = IERC20(tokens[i].underlying).balanceOf(address(this));
      IERC20(tokens[i].underlying).forceApprove(address(AaveV3Ethereum.POOL), amount);

      AaveV3Ethereum.POOL.deposit(
        tokens[i].underlying,
        amount,
        address(AaveV3Ethereum.COLLECTOR),
        0
      );
    }
  }

  /**
   * @notice transfers strategic assets to the ALC_SAFE
   * - withdraws aBALv2, aBALv3, aCRVv2, aCRVv3 to ALC_SAFE
   * - transfers raw BAL / CRV to ALC_SAFE
   */
  function _transferToALC() internal {
    // Aave V2 BAL
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.BAL_A_TOKEN,
      address(this),
      IERC20(AaveV2EthereumAssets.BAL_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) -
        1 ether
    );

    AaveV2Ethereum.POOL.withdraw(AaveV2EthereumAssets.BAL_UNDERLYING, type(uint256).max, ALC_SAFE);

    // Aave V3 BAL
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.BAL_A_TOKEN,
      address(this),
      IERC20(AaveV3EthereumAssets.BAL_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) -
        1 ether
    );

    AaveV3Ethereum.POOL.withdraw(AaveV3EthereumAssets.BAL_UNDERLYING, type(uint256).max, ALC_SAFE);

    // Aave V2 CRV
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.CRV_A_TOKEN,
      address(this),
      IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) -
        1 ether
    );

    AaveV2Ethereum.POOL.withdraw(AaveV2EthereumAssets.CRV_UNDERLYING, type(uint256).max, ALC_SAFE);

    // Aave V3 CRV
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.CRV_A_TOKEN,
      address(this),
      IERC20(AaveV3EthereumAssets.CRV_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) -
        1 ether
    );

    AaveV3Ethereum.POOL.withdraw(AaveV3EthereumAssets.CRV_UNDERLYING, type(uint256).max, ALC_SAFE);

    // BAL
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.BAL_UNDERLYING,
      ALC_SAFE,
      IERC20(AaveV3EthereumAssets.BAL_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );

    // CRV
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.CRV_UNDERLYING,
      ALC_SAFE,
      IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );
  }

  /**
   * @notice Withdraws v2 tokens
   */
  function _withdrawV2Tokens() internal {
    TokenToSwap[] memory tokens = new TokenToSwap[](5);
    tokens[0] = TokenToSwap(
      AaveV2EthereumAssets.LUSD_UNDERLYING,
      AaveV2EthereumAssets.LUSD_A_TOKEN,
      IERC20(AaveV2EthereumAssets.LUSD_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) -
        1 ether
    );
    tokens[1] = TokenToSwap(
      AaveV2EthereumAssets.DAI_UNDERLYING,
      AaveV2EthereumAssets.DAI_A_TOKEN,
      IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) -
        1 ether
    );
    tokens[2] = TokenToSwap(
      AaveV2EthereumAssets.DPI_UNDERLYING,
      AaveV2EthereumAssets.DPI_A_TOKEN,
      IERC20(AaveV2EthereumAssets.DPI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) -
        1 ether
    );
    tokens[3] = TokenToSwap(
      AaveV2EthereumAssets.FRAX_UNDERLYING,
      AaveV2EthereumAssets.FRAX_A_TOKEN,
      IERC20(AaveV2EthereumAssets.FRAX_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) -
        1 ether
    );
    tokens[4] = TokenToSwap(
      AaveV2EthereumAssets.USDT_UNDERLYING,
      AaveV2EthereumAssets.USDT_A_TOKEN,
      USDT_V2_TO_SWAP
    );

    uint256 tokensLength = tokens.length;
    for (uint256 i = 0; i < tokensLength; i++) {
      AaveV3Ethereum.COLLECTOR.transfer(tokens[i].aToken, address(this), tokens[i].balance);

      AaveV2Ethereum.POOL.withdraw(tokens[i].underlying, type(uint256).max, address(SWAPPER));
    }
  }

  /**
   * @notice Withdraws v3 tokens
   */
  function _withdrawV3Tokens() internal {
    TokenToSwap[] memory tokens = new TokenToSwap[](3);
    tokens[0] = TokenToSwap(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.USDC_A_TOKEN,
      USDC_V3_TO_SWAP
    );
    tokens[1] = TokenToSwap(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.USDT_A_TOKEN,
      USDT_V3_TO_SWAP - IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(address(SWAPPER))
    );
    tokens[2] = TokenToSwap(
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      AaveV3EthereumAssets.LUSD_A_TOKEN,
      IERC20(AaveV3EthereumAssets.LUSD_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) -
        1 ether
    );

    uint256 tokensLength = tokens.length;
    for (uint256 i = 0; i < tokensLength; i++) {
      AaveV3Ethereum.COLLECTOR.transfer(tokens[i].aToken, address(this), tokens[i].balance);

      AaveV3Ethereum.POOL.withdraw(tokens[i].underlying, type(uint256).max, address(SWAPPER));
    }
  }
}
