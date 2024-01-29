// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

interface IWETH {
  function withdraw(uint256) external;
}

/**
 * @title Treasury Management - GSM Funding & RWA Strategy Preparations (Part 1), Frontier Staking as a Service
 * @author efecarranza.eth
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb39537e468eef8c212c67a539cdc6d802cd857f186a4f66aefd44faaadd6ba19
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x6fc11878e04e6bd26def1077115f67294c7a4cb0b91d4c4eacfa4e036791cfef
 * - Discussion: https://governance.aave.com/t/arfc-treasury-management-gsm-funding-rwa-strategy-preparations/16128
 */
contract AaveV2Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229 is
  IProposalGenericExecutor
{
  address public constant ONE_WAY_BONDING_CURVE = 0x04f90d449D4f8316eDd6Ef4F963b657f8444a4cA;
  address public constant CRV_BAD_DEBT_REPAYMENT = 0x46A1B7d4a2920270c7eB2C2Db4DF2259A109bcb4;
  address public constant AAVE_COLLECTOR_CONSOLIDATION = 0xa426759e433224C2b04f6619aB44217DaD626c6e;

  address public constant SAFE = 0xCDb4fA6ba08bF1FB7Aa9fDf6002E78EDc431a642;
  uint256 public constant WETH_TO_WITHDRAW = 128 ether;

  function execute() external {
    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.WETH_A_TOKEN,
      address(this),
      WETH_TO_WITHDRAW
    );

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.WETH_UNDERLYING,
      IERC20(AaveV2EthereumAssets.WETH_A_TOKEN).balanceOf(address(this)),
      address(this)
    );

    IWETH(AaveV2EthereumAssets.WETH_UNDERLYING).withdraw(
      IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).balanceOf(address(this))
    );

    SAFE.call{value: address(this).balance}('');

    AaveV2Ethereum.COLLECTOR.approve(AaveV2EthereumAssets.USDC_A_TOKEN, ONE_WAY_BONDING_CURVE, 0);
    AaveV2Ethereum.COLLECTOR.approve(AaveV2EthereumAssets.USDC_A_TOKEN, CRV_BAD_DEBT_REPAYMENT, 0);

    AaveV2Ethereum.COLLECTOR.approve(
      AaveV2EthereumAssets.ENS_A_TOKEN,
      AAVE_COLLECTOR_CONSOLIDATION,
      0
    );
    AaveV2Ethereum.COLLECTOR.approve(
      AaveV2EthereumAssets.MANA_A_TOKEN,
      AAVE_COLLECTOR_CONSOLIDATION,
      0
    );
    AaveV2Ethereum.COLLECTOR.approve(
      AaveV2EthereumAssets.UST_A_TOKEN,
      AAVE_COLLECTOR_CONSOLIDATION,
      0
    );
    AaveV2Ethereum.COLLECTOR.approve(
      AaveV2EthereumAssets.sUSD_UNDERLYING,
      AAVE_COLLECTOR_CONSOLIDATION,
      0
    );
    AaveV2Ethereum.COLLECTOR.approve(
      AaveV2EthereumAssets.RAI_A_TOKEN,
      AAVE_COLLECTOR_CONSOLIDATION,
      0
    );
    AaveV2Ethereum.COLLECTOR.approve(
      AaveV2EthereumAssets.ZRX_A_TOKEN,
      AAVE_COLLECTOR_CONSOLIDATION,
      0
    );
    AaveV2Ethereum.COLLECTOR.approve(
      AaveV2EthereumAssets.AMPL_A_TOKEN,
      AAVE_COLLECTOR_CONSOLIDATION,
      0
    );
    AaveV2Ethereum.COLLECTOR.approve(
      AaveV2EthereumAssets.sUSD_A_TOKEN,
      AAVE_COLLECTOR_CONSOLIDATION,
      0
    );
    AaveV2Ethereum.COLLECTOR.approve(
      AaveV2EthereumAssets.TUSD_UNDERLYING,
      AAVE_COLLECTOR_CONSOLIDATION,
      0
    );
    AaveV2Ethereum.COLLECTOR.approve(
      AaveV2EthereumAssets.BUSD_UNDERLYING,
      AAVE_COLLECTOR_CONSOLIDATION,
      0
    );
    AaveV2Ethereum.COLLECTOR.approve(
      AaveV2EthereumAssets.TUSD_A_TOKEN,
      AAVE_COLLECTOR_CONSOLIDATION,
      0
    );
    AaveV2Ethereum.COLLECTOR.approve(
      AaveV2EthereumAssets.DPI_A_TOKEN,
      AAVE_COLLECTOR_CONSOLIDATION,
      0
    );
    AaveV2Ethereum.COLLECTOR.approve(
      AaveV2EthereumAssets.FRAX_A_TOKEN,
      AAVE_COLLECTOR_CONSOLIDATION,
      0
    );
    AaveV2Ethereum.COLLECTOR.approve(
      AaveV2EthereumAssets.BUSD_A_TOKEN,
      AAVE_COLLECTOR_CONSOLIDATION,
      0
    );
  }

  receive() external payable {}
}
