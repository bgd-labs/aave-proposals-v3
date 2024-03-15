// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {DataTypes} from 'aave-v3-core/contracts/protocol/libraries/types/DataTypes.sol';

import {AaveV3Arbitrum_ARBRemoveIsolation_20240315} from './AaveV3Arbitrum_ARBRemoveIsolation_20240315.sol';

/**
 * @dev Test for AaveV3Arbitrum_ARBRemoveIsolation_20240315
 * command: make test-contract filter=AaveV3Arbitrum_ARBRemoveIsolation_20240315
 */
contract AaveV3Arbitrum_ARBRemoveIsolation_20240315_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_ARBRemoveIsolation_20240315 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 190684329);
    proposal = new AaveV3Arbitrum_ARBRemoveIsolation_20240315();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    uint256 iCeiling = AaveV3Arbitrum.AAVE_PROTOCOL_DATA_PROVIDER.getDebtCeiling(
      AaveV3ArbitrumAssets.ARB_UNDERLYING
    );
    assertGt(iCeiling, 0, 'Ceiling already at 0');

    executePayload(vm, address(proposal));

    uint256 pCeiling = AaveV3Arbitrum.AAVE_PROTOCOL_DATA_PROVIDER.getDebtCeiling(
      AaveV3ArbitrumAssets.ARB_UNDERLYING
    );
    DataTypes.ReserveData memory data = AaveV3Arbitrum.POOL.getReserveData(
      AaveV3ArbitrumAssets.ARB_UNDERLYING
    );

    assertEq(pCeiling, 0, 'Ceiling not updated to 0');
    assertEq(data.isolationModeTotalDebt, 0, 'IsolationMode total Debt not 0');
    //0x912CE59144191C1204E64559FE8253a0e49E6548
  }
}
