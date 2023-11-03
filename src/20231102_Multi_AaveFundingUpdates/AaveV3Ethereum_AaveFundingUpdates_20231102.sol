// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV2EthereumArc} from 'aave-address-book/AaveV2EthereumArc.sol';
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
  uint256 public constant USDT_TO_KEEP_V2 = 700_000e6;

  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;
  address public constant ARC_USDC = 0xd35f648C3C7f17cd1Ba92e5eac991E3EfcD4566d;
  address public constant GHO_ETH_FEED = address(0); // TODO: Create!!
  address public constant TUSD_USD_FEED = 0xec746eCF986E2927Abd291a2A1716c940100f8Ba;

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

    // Migration
    address[] memory toMigrate = new address[](2);
    toMigrate[0] = AaveV2EthereumAssets.USDT_UNDERLYING;
    toMigrate[1] = AaveV2EthereumAssets.DAI_UNDERLYING;

    IMigrationHelper.RepaySimpleInput[] memory toRepay = new IMigrationHelper.RepaySimpleInput[](0);
    IMigrationHelper.PermitInput[] memory permits = new IMigrationHelper.PermitInput[](0);
    IMigrationHelper.CreditDelegationInput[]
      memory creditDelegationPermits = new IMigrationHelper.CreditDelegationInput[](0);

    // Migrate all but 0.7M aUSDT from Aave v2 to v3
    uint256 amountUSDT = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    ) - USDT_TO_KEEP_V2;
    AaveV3Ethereum.COLLECTOR.transfer(AaveV2EthereumAssets.USDT_A_TOKEN, address(this), amountUSDT);
    IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).forceApprove(
      AaveV2Ethereum.MIGRATION_HELPER,
      amountUSDT
    );

    // Migrate all aDAI from Aave v2 to v3
    uint256 amountDAI = IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    AaveV3Ethereum.COLLECTOR.transfer(AaveV2EthereumAssets.DAI_A_TOKEN, address(this), amountDAI);
    IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).forceApprove(
      AaveV2Ethereum.MIGRATION_HELPER,
      amountDAI
    );

    MIGRATION.migrate(toMigrate, toRepay, permits, creditDelegationPermits);

    IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).safeTransfer(
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(address(this))
    );

    IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).safeTransfer(
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(address(this))
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
      AaveV3EthereumAssets.GHO_ORACLE,
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
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV2EthereumAssets.UST_ORACLE,
      GHO_ETH_FEED,
      address(AaveV3Ethereum.COLLECTOR),
      balanceUst,
      600
    );

    uint256 balanceATusd = IERC20(AaveV2EthereumAssets.TUSD_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.TUSD_UNDERLYING,
      address(this),
      balanceATusd
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
      AaveV3EthereumAssets.GHO_ORACLE,
      address(AaveV3Ethereum.COLLECTOR),
      balanceUst,
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
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV2EthereumAssets.GUSD_ORACLE,
      GHO_ETH_FEED,
      address(AaveV3Ethereum.COLLECTOR),
      balanceGUsd,
      500
    );

    uint256 balanceArcUsdc = IERC20(ARC_USDC).balanceOf(address(AaveV2Ethereum.COLLECTOR));

    AaveV2Ethereum.COLLECTOR.transfer(ARC_USDC, address(this), balanceArcUsdc);
    AaveV2EthereumArc.POOL.withdraw(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      type(uint256).max,
      address(SWAPPER)
    );

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      AaveV3EthereumAssets.GHO_ORACLE,
      address(AaveV3Ethereum.COLLECTOR),
      balanceArcUsdc,
      300
    );
  }
}
