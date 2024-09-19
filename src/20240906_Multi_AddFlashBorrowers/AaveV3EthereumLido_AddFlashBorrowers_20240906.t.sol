// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_AddFlashBorrowers_20240906} from './AaveV3EthereumLido_AddFlashBorrowers_20240906.sol';

/**
 * @dev Test for AaveV3EthereumLido_AddFlashBorrowers_20240906
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240906_Multi_AddFlashBorrowers/AaveV3EthereumLido_AddFlashBorrowers_20240906.t.sol -vv
 */
contract AaveV3EthereumLido_AddFlashBorrowers_20240906_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_AddFlashBorrowers_20240906 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20692293);
    proposal = new AaveV3EthereumLido_AddFlashBorrowers_20240906();
  }

  function test_isFlashBorrower() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    bool isFlashBorrower = AaveV3EthereumLido.ACL_MANAGER.isFlashBorrower(
      proposal.CIAN_FLASH_LOAN_HELPER()
    );
    assertEq(isFlashBorrower, true);

    isFlashBorrower = AaveV3EthereumLido.ACL_MANAGER.isFlashBorrower(
      proposal.INDEX_COOP_FLASH_MINT_LEVERAGED()
    );
    assertEq(isFlashBorrower, true);

    isFlashBorrower = AaveV3EthereumLido.ACL_MANAGER.isFlashBorrower(
      proposal.CONTANGO_PERMISSIONED_AAVE_WRAPPER()
    );
    assertEq(isFlashBorrower, true);
  }
}
