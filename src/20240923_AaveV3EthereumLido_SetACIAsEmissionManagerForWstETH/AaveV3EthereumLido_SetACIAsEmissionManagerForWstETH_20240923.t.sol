// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_SetACIAsEmissionManagerForWstETH_20240923} from './AaveV3EthereumLido_SetACIAsEmissionManagerForWstETH_20240923.sol';

/**
 * @dev Test for AaveV3EthereumLido_SetACIAsEmissionManagerForWstETH_20240923
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240923_AaveV3EthereumLido_SetACIAsEmissionManagerForWstETH/AaveV3EthereumLido_SetACIAsEmissionManagerForWstETH_20240923.t.sol -vv
 */
contract AaveV3EthereumLido_SetACIAsEmissionManagerForWstETH_20240923_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_SetACIAsEmissionManagerForWstETH_20240923 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20812951);
    proposal = new AaveV3EthereumLido_SetACIAsEmissionManagerForWstETH_20240923();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_SetACIAsEmissionManagerForWstETH_20240923',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_emissions_admin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      IEmissionManager(AaveV3EthereumLido.EMISSION_MANAGER).getEmissionAdmin(
        AaveV3EthereumLidoAssets.wstETH_UNDERLYING
      ),
      proposal.ACI_MULTISIG()
    );
    assertEq(
      IEmissionManager(AaveV3EthereumLido.EMISSION_MANAGER).getEmissionAdmin(proposal.tBTC()),
      proposal.ACI_MULTISIG()
    );
  }
}
