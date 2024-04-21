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

  address public constant AGD_MULTISIG = 0x89C51828427F70D77875C6747759fB17Ba10Ceb0;
  uint256 public constant AGD_GHO_ALLOWANCE = 613_000 ether;

  function execute() external {
    _agdAllowance();
    _v2ToV3Migration();
    _swaps();
  }

  function _agdAllowance() internal {
    AaveV3Ethereum.COLLECTOR.approve(AaveV2EthereumAssets.USDT_A_TOKEN, AGD_MULTISIG, 0);
    AaveV3Ethereum.COLLECTOR.approve(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AGD_MULTISIG,
      AGD_GHO_ALLOWANCE
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

  function _swaps() internal {}
}
