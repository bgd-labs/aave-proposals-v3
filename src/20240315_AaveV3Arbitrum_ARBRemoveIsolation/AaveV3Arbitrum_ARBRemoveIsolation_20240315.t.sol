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
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 194086877);
    proposal = new AaveV3Arbitrum_ARBRemoveIsolation_20240315();
  }

  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_ARBRemoveIsolation_20240315',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_removalFromIsolation() public {
    uint iCeiling = AaveV3Arbitrum.AAVE_PROTOCOL_DATA_PROVIDER.getDebtCeiling(
      AaveV3ArbitrumAssets.ARB_UNDERLYING
    );
    DataTypes.ReserveData memory iData = AaveV3Arbitrum.POOL.getReserveData(
      AaveV3ArbitrumAssets.ARB_UNDERLYING
    );

    assertGt(iCeiling, 0, 'Ceiling already at 0');
    assertGt(iData.isolationModeTotalDebt, 0, 'IsolationMode total Debt not 0');

    executePayload(vm, address(proposal));

    uint pCeiling = AaveV3Arbitrum.AAVE_PROTOCOL_DATA_PROVIDER.getDebtCeiling(
      AaveV3ArbitrumAssets.ARB_UNDERLYING
    );
    DataTypes.ReserveData memory pData = AaveV3Arbitrum.POOL.getReserveData(
      AaveV3ArbitrumAssets.ARB_UNDERLYING
    );

    assertEq(pCeiling, 0, 'Ceiling not updated to 0');
    assertEq(pData.isolationModeTotalDebt, 0, 'IsolationMode total Debt not 0');
  }
}
