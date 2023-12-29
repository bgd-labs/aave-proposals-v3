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
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18891644);
    proposal = new AaveV2Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229();
  }

  function test_execute() public {
    assertGt(
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).allowance(
        address(AaveV2Ethereum.COLLECTOR),
        proposal.TO_REVOKE_ONE()
      ),
      0
    );
    assertGt(
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).allowance(
        address(AaveV2Ethereum.COLLECTOR),
        proposal.TO_REVOKE_TWO()
      ),
      0
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).allowance(
        address(AaveV2Ethereum.COLLECTOR),
        proposal.TO_REVOKE_ONE()
      ),
      0
    );
    assertEq(
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).allowance(
        address(AaveV2Ethereum.COLLECTOR),
        proposal.TO_REVOKE_TWO()
      ),
      0
    );
  }
}
