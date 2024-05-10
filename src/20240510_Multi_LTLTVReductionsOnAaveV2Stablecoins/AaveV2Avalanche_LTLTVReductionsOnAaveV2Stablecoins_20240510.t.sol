// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Avalanche, AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';
import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Avalanche_LTLTVReductionsOnAaveV2Stablecoins_20240510} from './AaveV2Avalanche_LTLTVReductionsOnAaveV2Stablecoins_20240510.sol';

/**
 * @dev Test for AaveV2Avalanche_LTLTVReductionsOnAaveV2Stablecoins_20240510
 * command: FOUNDRY_PROFILE=avalanche forge test --match-path=src/20240510_Multi_LTLTVReductionsOnAaveV2Stablecoins/AaveV2Avalanche_LTLTVReductionsOnAaveV2Stablecoins_20240510.t.sol -vv
 */
contract AaveV2Avalanche_LTLTVReductionsOnAaveV2Stablecoins_20240510_Test is ProtocolV2TestBase {
  AaveV2Avalanche_LTLTVReductionsOnAaveV2Stablecoins_20240510 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 45274752);
    proposal = new AaveV2Avalanche_LTLTVReductionsOnAaveV2Stablecoins_20240510();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV2Avalanche_LTLTVReductionsOnAaveV2Stablecoins_20240510',
      AaveV2Avalanche.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](1);

    assetsChanged[0] = AaveV2AvalancheAssets.USDCe_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    ReserveConfig memory USDCe_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2AvalancheAssets.USDCe_UNDERLYING
    );
    USDCe_UNDERLYING_CONFIG.liquidationThreshold = 78_00;
    _validateReserveConfig(USDCe_UNDERLYING_CONFIG, allConfigsAfter);
  }
}
