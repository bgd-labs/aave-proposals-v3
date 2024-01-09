// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSwapper} from 'aave-helpers/swaps/AaveSwapper.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Aave Funding Updates
 * @author efecarranza.eth
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x099f88e1728760952be26fcb8fc99b26c29336e6a109820b391751b108399ee5
 * - Discussion: https://governance.aave.com/t/arfc-aave-funding-update/15194
 */
contract AaveV3Ethereum_AaveFundingUpdates_20231106 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  AaveSwapper public constant SWAPPER = AaveSwapper(MiscEthereum.AAVE_SWAPPER);

  uint256 public constant USDC_TO_DEPOSIT = 1_700_000e6;
  uint256 public constant USDT_TO_DEPOSIT = 750_000e6;
  uint256 public constant DAI_TO_SWAP = 500_000e18;
  uint256 public constant USDC_TO_SWAP = 1_000_000e6;

  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;

  // https://etherscan.io/address/0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC
  address public constant GHO_ORACLE = 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.USDC_A_TOKEN,
      address(this),
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) -
        10 ** 6 // USDC has 6 decimals, keep 10 units to not empty reserve
    );

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      address(this),
      USDC_TO_DEPOSIT
    );

    IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).transfer(address(SWAPPER), USDC_TO_SWAP);

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      address(SWAPPER),
      DAI_TO_SWAP
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      address(this),
      USDT_TO_DEPOSIT
    );

    // Deposit into V3

    IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).forceApprove(
      address(AaveV3Ethereum.POOL),
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(address(this))
    );

    AaveV3Ethereum.POOL.deposit(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(address(this)),
      address(AaveV3Ethereum.COLLECTOR),
      0
    );

    IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).forceApprove(
      address(AaveV2Ethereum.POOL),
      USDT_TO_DEPOSIT
    );
    AaveV2Ethereum.POOL.deposit(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      USDT_TO_DEPOSIT,
      address(AaveV3Ethereum.COLLECTOR),
      0
    );

    // Swaps

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      GHO_ORACLE,
      address(AaveV3Ethereum.COLLECTOR),
      USDC_TO_SWAP,
      100
    );

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.DAI_ORACLE,
      GHO_ORACLE,
      address(AaveV3Ethereum.COLLECTOR),
      DAI_TO_SWAP,
      100
    );
  }
}
