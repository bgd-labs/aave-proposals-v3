// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Treasury Management - GSM Funding & RWA Strategy Preparations (Part 1)
 * @author efecarranza.eth
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV2Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229 is
  IProposalGenericExecutor
{
  address public constant ONE_WAY_BONDING_CURVE = 0x04f90d449D4f8316eDd6Ef4F963b657f8444a4cA;
  address public constant CRV_BAD_DEBT_REPAYMENT = 0x46A1B7d4a2920270c7eB2C2Db4DF2259A109bcb4;
  address public constant AAVE_COLLECTOR_CONSOLIDATION = 0xa426759e433224C2b04f6619aB44217DaD626c6e;

  function execute() external {
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
}
