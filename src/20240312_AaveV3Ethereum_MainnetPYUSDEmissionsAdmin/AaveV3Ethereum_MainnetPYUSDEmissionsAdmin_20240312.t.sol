// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_MainnetPYUSDEmissionsAdmin_20240312} from './AaveV3Ethereum_MainnetPYUSDEmissionsAdmin_20240312.sol';

/**
 * @dev Test for AaveV3Ethereum_MainnetPYUSDEmissionsAdmin_20240312
 * command: make test-contract filter=AaveV3Ethereum_MainnetPYUSDEmissionsAdmin_20240312
 */
contract AaveV3Ethereum_MainnetPYUSDEmissionsAdmin_20240312_Test is ProtocolV3TestBase {
  AaveV3Ethereum_MainnetPYUSDEmissionsAdmin_20240312 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19421865);
    proposal = new AaveV3Ethereum_MainnetPYUSDEmissionsAdmin_20240312();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_MainnetPYUSDEmissionsAdmin_20240312',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_isEmmissionAdmin() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(
        AaveV3EthereumAssets.PYUSD_UNDERLYING
      ),
      0xac140648435d03f784879cd789130F22Ef588Fcd
    );
  }
}
