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
 * @title April Finance Update
 * @author @karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-april-finance-update/17390
 */
contract AaveV2Ethereum_AprilFinanceUpdate_20240421 is IProposalGenericExecutor {
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

  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;
  address public constant GHO_USD_FEED = 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC;

  address public constant AGD_MULTISIG = 0x89C51828427F70D77875C6747759fB17Ba10Ceb0;
  uint256 public constant AGD_GHO_ALLOWANCE = 613_000 ether;

  uint256 public constant USDC_V3_TO_SWAP = 1_400_000e6; // 1.4M
  uint256 public constant DAI_V3_TO_SWAP = 2_000_000 ether;
  uint256 public constant USDT_V2_TO_KEEP = 650_000e6; // 650,000

  address public constant BGD_RECIPIENT = 0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF;
  uint256 public constant USDC_AMOUNT_REIMBURSEMENT = 42_000e6;
  uint256 public constant USDT_AMOUNT_REIMBURSEMENT = 109_200e6;
  uint256 public constant LINK_AMOUNT_REIMBURSEMENT = 1640 ether;

  uint256 public constant MERIT_GHO_ALLOWANCE = 3_000_000 ether;
  uint256 public constant MERIT_WETH_V3_ALLOWANCE = 645 ether;
  address public constant MERIT_WALLET = 0xdeadD8aB03075b7FBA81864202a2f59EE25B312b;

  function execute() external {
    _bgdReimbursements();
    _allowances();
    _v2ToV3Migration();
    _swaps();
  }

  function _bgdReimbursements() internal {
    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.USDC_A_TOKEN,
      BGD_RECIPIENT,
      USDC_AMOUNT_REIMBURSEMENT
    );
    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.USDT_A_TOKEN,
      BGD_RECIPIENT,
      USDT_AMOUNT_REIMBURSEMENT
    );
    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.LINK_A_TOKEN,
      BGD_RECIPIENT,
      LINK_AMOUNT_REIMBURSEMENT
    );
  }

  function _allowances() internal {
    if (
      IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        AGD_MULTISIG
      ) >= 612944900000
    ) {
      AaveV3Ethereum.COLLECTOR.approve(AaveV2EthereumAssets.USDT_A_TOKEN, AGD_MULTISIG, 0);
      AaveV3Ethereum.COLLECTOR.approve(
        AaveV3EthereumAssets.GHO_UNDERLYING,
        AGD_MULTISIG,
        AGD_GHO_ALLOWANCE
      );
    }

    AaveV3Ethereum.COLLECTOR.approve(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      MERIT_WALLET,
      MERIT_GHO_ALLOWANCE
    );

    AaveV3Ethereum.COLLECTOR.approve(
      AaveV3EthereumAssets.WETH_A_TOKEN,
      MERIT_WALLET,
      MERIT_WETH_V3_ALLOWANCE
    );
  }

  /**
   * @notice migrates all but one unit of the specified assets from AaveV2 to AaveV3
   * assets: WETH, WBTC, LINK and SNX
   */
  function _v2ToV3Migration() internal {
    TokenToMigrate[] memory tokens = new TokenToMigrate[](4);
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
      AaveV2EthereumAssets.LINK_UNDERLYING,
      AaveV2EthereumAssets.LINK_A_TOKEN,
      IERC20(AaveV2EthereumAssets.LINK_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) -
        1 ether
    );
    tokens[3] = TokenToMigrate(
      AaveV2EthereumAssets.SNX_UNDERLYING,
      AaveV2EthereumAssets.SNX_A_TOKEN,
      IERC20(AaveV2EthereumAssets.SNX_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) -
        1 ether
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

  function _swaps() internal {
    _withdrawV2Tokens();
    _withdrawV3Tokens();

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.DAI_ORACLE,
      GHO_USD_FEED,
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(SWAPPER)),
      50
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
      100
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
      100
    );
  }

  /**
   * @notice Withdraws v2 tokens to swapper
   */
  function _withdrawV2Tokens() internal {
    TokenToSwap[] memory tokens = new TokenToSwap[](3);
    tokens[0] = TokenToSwap(
      AaveV2EthereumAssets.DAI_UNDERLYING,
      AaveV2EthereumAssets.DAI_A_TOKEN,
      IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) -
        1 ether
    );
    tokens[1] = TokenToSwap(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      AaveV2EthereumAssets.USDC_A_TOKEN,
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) - 1e6
    );
    tokens[2] = TokenToSwap(
      AaveV2EthereumAssets.USDT_UNDERLYING,
      AaveV2EthereumAssets.USDT_A_TOKEN,
      IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) -
        USDT_V2_TO_KEEP
    );

    uint256 tokensLength = tokens.length;
    for (uint256 i = 0; i < tokensLength; i++) {
      AaveV3Ethereum.COLLECTOR.transfer(tokens[i].aToken, address(this), tokens[i].balance);

      AaveV2Ethereum.POOL.withdraw(tokens[i].underlying, type(uint256).max, address(SWAPPER));
    }
  }

  /**
   * @notice Withdraws v3 tokens to swapper
   */
  function _withdrawV3Tokens() internal {
    TokenToSwap[] memory tokens = new TokenToSwap[](2);
    tokens[0] = TokenToSwap(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.USDC_A_TOKEN,
      USDC_V3_TO_SWAP
    );
    tokens[1] = TokenToSwap(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.DAI_A_TOKEN,
      DAI_V3_TO_SWAP
    );

    uint256 tokensLength = tokens.length;
    for (uint256 i = 0; i < tokensLength; i++) {
      AaveV3Ethereum.COLLECTOR.transfer(tokens[i].aToken, address(this), tokens[i].balance);

      AaveV3Ethereum.POOL.withdraw(tokens[i].underlying, type(uint256).max, address(SWAPPER));
    }
  }
}
