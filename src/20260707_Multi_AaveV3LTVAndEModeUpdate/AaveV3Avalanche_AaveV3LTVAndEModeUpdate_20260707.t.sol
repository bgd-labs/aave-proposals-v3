// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_AaveV3LTVAndEModeUpdate_20260707} from './AaveV3Avalanche_AaveV3LTVAndEModeUpdate_20260707.sol';

/**
 * @dev Test for AaveV3Avalanche_AaveV3LTVAndEModeUpdate_20260707
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260707_Multi_AaveV3LTVAndEModeUpdate/AaveV3Avalanche_AaveV3LTVAndEModeUpdate_20260707.t.sol -vv
 */
contract AaveV3Avalanche_AaveV3LTVAndEModeUpdate_20260707_Test is ProtocolV3TestBase {
  AaveV3Avalanche_AaveV3LTVAndEModeUpdate_20260707 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 90217434);
    proposal = new AaveV3Avalanche_AaveV3LTVAndEModeUpdate_20260707();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_AaveV3LTVAndEModeUpdate_20260707',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }

  /**
   * @dev checks whether reserve configurations changed or stayed unchanged as expected
   */
  function test_reserveConfigChanges() public {
    address[] memory updatedAssets = new address[](1);
    updatedAssets[0] = AaveV3AvalancheAssets.AUSD_UNDERLYING;
    reserveConfigChangesTest(AaveV3Avalanche.POOL, address(proposal), updatedAssets);
  }

  function _expectedCollateralChanges()
    internal
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[] memory collateralUpdate;
    collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](1);

    collateralUpdate[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3AvalancheAssets.AUSD_UNDERLYING,
      ltv: 0,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    return collateralUpdate;
  }
}
