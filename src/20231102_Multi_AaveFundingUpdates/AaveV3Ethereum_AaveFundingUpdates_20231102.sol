// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IMigrationHelper} from 'aave-address-book/common/IMigrationHelper.sol';
import {AaveSwapper} from 'aave-helpers/swaps/AaveSwapper.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Aave Funding Updates
 * @author efecarranza.eth
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x099f88e1728760952be26fcb8fc99b26c29336e6a109820b391751b108399ee5
 * - Discussion: https://governance.aave.com/t/arfc-aave-funding-update/15194
 */
contract AaveV3Ethereum_AaveFundingUpdates_20231102 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  IMigrationHelper public constant MIGRATION = IMigrationHelper(AaveV2Ethereum.MIGRATION_HELPER);
  AaveSwapper public constant SWAPPER = AaveSwapper(MiscEthereum.AAVE_SWAPPER);

  uint256 public constant DAI_TO_DEPOSIT = 1_000_000e18;
  uint256 public constant DAI_TO_SWAP = 500_000e18;

  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;
  address public constant TUSD_USD_FEED = 0xec746eCF986E2927Abd291a2A1716c940100f8Ba;
  address public constant BUSD_USD_FEED = 0x833D8Eb16D306ed1FbB5D7A2E019e106B960965A;

  // https://etherscan.io/address/0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC
  address public constant GHO_ORACLE = 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC;

  function execute() external {
    _migration();
    _swaps();
  }

  function _migration() internal {
    // Deposit 1M units of DAI from Treasury into Aave v3
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.DAI_UNDERLYING,
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

    // Migrate all aDAI from Aave v2 to v3
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.DAI_A_TOKEN,
      address(this),
      IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );
    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.DAI_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    uint256 amountDai = IERC20(AaveV2EthereumAssets.DAI_UNDERLYING).balanceOf(address(this));
    IERC20(AaveV2EthereumAssets.DAI_UNDERLYING).forceApprove(
      address(AaveV3Ethereum.POOL),
      amountDai
    );

    AaveV3Ethereum.POOL.deposit(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      amountDai,
      address(AaveV3Ethereum.COLLECTOR),
      0
    );
  }

  function _swaps() internal {
    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      address(SWAPPER),
      DAI_TO_SWAP
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

    uint256 balanceUst = IERC20(AaveV2EthereumAssets.UST_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.UST_UNDERLYING,
      address(SWAPPER),
      balanceUst
    );

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV2EthereumAssets.UST_UNDERLYING,
      AaveV2EthereumAssets.USDC_UNDERLYING,
      AaveV2EthereumAssets.UST_ORACLE,
      AaveV2EthereumAssets.USDC_ORACLE,
      address(AaveV3Ethereum.COLLECTOR),
      balanceUst,
      600
    );

    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.TUSD_A_TOKEN,
      address(this),
      IERC20(AaveV2EthereumAssets.TUSD_A_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR))
    );
    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.TUSD_UNDERLYING,
      type(uint256).max,
      address(SWAPPER)
    );

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV2EthereumAssets.TUSD_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      TUSD_USD_FEED,
      GHO_ORACLE,
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV2EthereumAssets.TUSD_UNDERLYING).balanceOf(address(SWAPPER)),
      300
    );

    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.BUSD_A_TOKEN,
      address(this),
      IERC20(AaveV2EthereumAssets.BUSD_A_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR))
    );
    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.BUSD_UNDERLYING,
      type(uint256).max,
      address(SWAPPER)
    );

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV2EthereumAssets.BUSD_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      BUSD_USD_FEED,
      GHO_ORACLE,
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV2EthereumAssets.BUSD_UNDERLYING).balanceOf(address(SWAPPER)),
      300
    );

    uint256 balanceGUsd = IERC20(AaveV2EthereumAssets.GUSD_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.GUSD_UNDERLYING,
      address(SWAPPER),
      balanceGUsd
    );

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV2EthereumAssets.GUSD_UNDERLYING,
      AaveV2EthereumAssets.USDC_UNDERLYING,
      AaveV2EthereumAssets.GUSD_ORACLE,
      AaveV2EthereumAssets.USDC_ORACLE,
      address(AaveV3Ethereum.COLLECTOR),
      balanceGUsd,
      500
    );
  }
}
