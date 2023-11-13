// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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

  uint256 public constant USDC_TO_SWAP = 700_000e6;
  uint256 public constant USDC_TO_DEPOSIT = 1_000_000e6;
  uint256 public constant USDT_TO_DEPOSIT_V3 = 350_000e6;
  uint256 public constant USDT_TO_DEPOSIT_V2 = 400_000e6;
  uint256 public constant DAI_TO_DEPOSIT = 500_000e18;

  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;

  function execute() external {
    // Deposit into V3

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      address(this),
      USDC_TO_DEPOSIT
    );
    IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).forceApprove(
      address(AaveV3Ethereum.POOL),
      USDC_TO_DEPOSIT
    );
    AaveV3Ethereum.POOL.deposit(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      USDC_TO_DEPOSIT,
      address(AaveV3Ethereum.COLLECTOR),
      0
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      address(this),
      USDT_TO_DEPOSIT_V2 + USDT_TO_DEPOSIT_V3
    );
    IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).forceApprove(
      address(AaveV3Ethereum.POOL),
      USDT_TO_DEPOSIT_V3
    );
    AaveV3Ethereum.POOL.deposit(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      USDT_TO_DEPOSIT_V3,
      address(AaveV3Ethereum.COLLECTOR),
      0
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      address(this),
      DAI_TO_DEPOSIT
    );
    IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).forceApprove(
      address(AaveV3Ethereum.POOL),
      DAI_TO_DEPOSIT
    );
    AaveV3Ethereum.POOL.deposit(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      DAI_TO_DEPOSIT,
      address(AaveV3Ethereum.COLLECTOR),
      0
    );

    // Swap USDC

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      AaveV3EthereumAssets.GHO_ORACLE,
      address(AaveV3Ethereum.COLLECTOR),
      USDC_TO_SWAP,
      100
    );
  }
}
