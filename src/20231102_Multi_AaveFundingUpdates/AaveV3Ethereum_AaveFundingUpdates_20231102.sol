// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IMigrationHelper} from 'aave-address-book/common/IMigrationHelper.sol';
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

  uint256 public constant DAI_TO_DEPOSIT = 1_000_000e18;
  uint256 public constant USDT_TO_KEEP_V2 = 700_000e6;

  function execute() external {
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
}
