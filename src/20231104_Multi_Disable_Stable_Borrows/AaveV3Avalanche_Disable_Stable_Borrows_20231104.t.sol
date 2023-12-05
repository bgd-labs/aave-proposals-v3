// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_Disable_Stable_Borrows_20231104} from './AaveV3Avalanche_Disable_Stable_Borrows_20231104.sol';
import {AaveV3AvalancheAssets, AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';

/**
 * @dev Test for AaveV3Avalanche_Disable_Stable_Borrows_20231104
 * command: make test-contract filter=AaveV3Avalanche_Disable_Stable_Borrows_20231104
 */
contract AaveV3Avalanche_Disable_Stable_Borrows_20231104_Test is ProtocolV3TestBase {
  AaveV3Avalanche_Disable_Stable_Borrows_20231104 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 37334525);
    proposal = new AaveV3Avalanche_Disable_Stable_Borrows_20231104();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV3Avalanche_Disable_Stable_Borrows_20231104',
      AaveV3Avalanche.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](3);

    assetsChanged[0] = AaveV3AvalancheAssets.DAIe_UNDERLYING;
    assetsChanged[1] = AaveV3AvalancheAssets.USDC_UNDERLYING;
    assetsChanged[2] = AaveV3AvalancheAssets.USDt_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    for (uint256 i = 0; i < assetsChanged.length; i++) {
      ReserveConfig memory config = _findReserveConfig(allConfigsBefore, assetsChanged[i]);
      config.stableBorrowRateEnabled = false;
      _validateReserveConfig(config, allConfigsAfter);
    }

    for (uint256 i = 0; i < allConfigsAfter.length; i++) {
      require(allConfigsAfter[i].stableBorrowRateEnabled == false);
    }
  }
}
