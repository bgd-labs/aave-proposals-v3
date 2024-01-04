// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229} from './AaveV2Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229.sol';

/**
 * @dev Test for AaveV2Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229
 * command: make test-contract filter=AaveV2Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229
 */
contract AaveV2Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229_Test is
  ProtocolV2TestBase
{
  AaveV2Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229
    internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18934678);
    proposal = new AaveV2Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229();
  }

  function test_execute() public {
    assertGt(
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).allowance(
        address(AaveV2Ethereum.COLLECTOR),
        proposal.ONE_WAY_BONDING_CURVE()
      ),
      0
    );
    assertGt(
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).allowance(
        address(AaveV2Ethereum.COLLECTOR),
        proposal.CRV_BAD_DEBT_REPAYMENT()
      ),
      0
    );

    address[14] memory toRevokeConsolidator = [
      AaveV2EthereumAssets.ENS_A_TOKEN,
      AaveV2EthereumAssets.MANA_A_TOKEN,
      AaveV2EthereumAssets.UST_A_TOKEN,
      AaveV2EthereumAssets.sUSD_UNDERLYING,
      AaveV2EthereumAssets.RAI_A_TOKEN,
      AaveV2EthereumAssets.ZRX_A_TOKEN,
      AaveV2EthereumAssets.AMPL_A_TOKEN,
      AaveV2EthereumAssets.sUSD_A_TOKEN,
      AaveV2EthereumAssets.TUSD_UNDERLYING,
      AaveV2EthereumAssets.BUSD_UNDERLYING,
      AaveV2EthereumAssets.TUSD_A_TOKEN,
      AaveV2EthereumAssets.DPI_A_TOKEN,
      AaveV2EthereumAssets.FRAX_A_TOKEN,
      AaveV2EthereumAssets.BUSD_A_TOKEN
    ];

    for (uint256 i = 0; i < 14; i++) {
      assertGt(
        IERC20(toRevokeConsolidator[i]).allowance(
          address(AaveV2Ethereum.COLLECTOR),
          proposal.AAVE_COLLECTOR_CONSOLIDATION()
        ),
        0
      );
    }

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).allowance(
        address(AaveV2Ethereum.COLLECTOR),
        proposal.ONE_WAY_BONDING_CURVE()
      ),
      0
    );
    assertEq(
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).allowance(
        address(AaveV2Ethereum.COLLECTOR),
        proposal.CRV_BAD_DEBT_REPAYMENT()
      ),
      0
    );

    for (uint256 i = 0; i < 14; i++) {
      assertEq(
        IERC20(toRevokeConsolidator[i]).allowance(
          address(AaveV2Ethereum.COLLECTOR),
          proposal.AAVE_COLLECTOR_CONSOLIDATION()
        ),
        0
      );
    }
  }
}
