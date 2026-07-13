// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_AaveV3LTVAndEModeUpdate_20260707} from './AaveV3EthereumLido_AaveV3LTVAndEModeUpdate_20260707.sol';

/**
 * @dev Test for AaveV3EthereumLido_AaveV3LTVAndEModeUpdate_20260707
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260707_Multi_AaveV3LTVAndEModeUpdate/AaveV3EthereumLido_AaveV3LTVAndEModeUpdate_20260707.t.sol -vv
 */
contract AaveV3EthereumLido_AaveV3LTVAndEModeUpdate_20260707_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_AaveV3LTVAndEModeUpdate_20260707 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25524764);
    proposal = new AaveV3EthereumLido_AaveV3LTVAndEModeUpdate_20260707();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_AaveV3LTVAndEModeUpdate_20260707',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  /**
   * @dev checks whether reserve configurations changed or stayed unchanged as expected
   */
  function test_reserveConfigChanges() public {
    address[] memory updatedAssets = new address[](1);
    updatedAssets[0] = AaveV3EthereumLidoAssets.wstETH_UNDERLYING;
    reserveConfigChangesTest(AaveV3EthereumLido.POOL, address(proposal), updatedAssets);
  }

  function _expectedCapsChanges()
    internal
    pure
    override
    returns (IAaveV3ConfigEngine.CapsUpdate[] memory)
  {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate;
    capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](1);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumLidoAssets.wstETH_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 18_000
    });
    return capsUpdate;
  }
}
