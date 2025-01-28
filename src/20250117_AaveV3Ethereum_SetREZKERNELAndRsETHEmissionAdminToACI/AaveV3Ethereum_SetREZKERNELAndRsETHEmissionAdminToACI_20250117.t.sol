// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_SetREZKERNELAndRsETHEmissionAdminToACI_20250117} from './AaveV3Ethereum_SetREZKERNELAndRsETHEmissionAdminToACI_20250117.sol';

/**
 * @dev Test for AaveV3Ethereum_SetREZKERNELAndRsETHEmissionAdminToACI_20250117
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250117_AaveV3Ethereum_SetREZKERNELAndRsETHEmissionAdminToACI/AaveV3Ethereum_SetREZKERNELAndRsETHEmissionAdminToACI_20250117.t.sol -vv
 */
contract AaveV3Ethereum_SetREZKERNELAndRsETHEmissionAdminToACI_20250117_Test is ProtocolV3TestBase {
  AaveV3Ethereum_SetREZKERNELAndRsETHEmissionAdminToACI_20250117 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21644687);
    proposal = new AaveV3Ethereum_SetREZKERNELAndRsETHEmissionAdminToACI_20250117();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_SetREZKERNELAndRsETHEmissionAdminToACI_20250117',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_REZAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(
        0x3B50805453023a91a8bf641e279401a0b23FA6F9
      ),
      0xdef1FA4CEfe67365ba046a7C630D6B885298E210
    );
  }
  function test_KERNELAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(
        0x3f80B1c54Ae920Be41a77f8B902259D48cf24cCf
      ),
      0xdef1FA4CEfe67365ba046a7C630D6B885298E210
    );
  }
  function test_rsETHAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(
        0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7
      ),
      0xdef1FA4CEfe67365ba046a7C630D6B885298E210
    );
  }
}
