// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_OnboardUSDSAndSUSDS_20240914} from './AaveV3EthereumLido_OnboardUSDSAndSUSDS_20240914.sol';

/**
 * @dev Test for AaveV3EthereumLido_OnboardUSDSAndSUSDS_20240914
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240914_Multi_OnboardUSDSAndSUSDS/AaveV3EthereumLido_OnboardUSDSAndSUSDS_20240914.t.sol -vv
 */
contract AaveV3EthereumLido_OnboardUSDSAndSUSDS_20240914_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_OnboardUSDSAndSUSDS_20240914 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20776605);
    proposal = new AaveV3EthereumLido_OnboardUSDSAndSUSDS_20240914();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_OnboardUSDSAndSUSDS_20240914',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_collectorHasUSDSFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3EthereumLido
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.USDS());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3EthereumLido.COLLECTOR)), 100e18);
  }
}
