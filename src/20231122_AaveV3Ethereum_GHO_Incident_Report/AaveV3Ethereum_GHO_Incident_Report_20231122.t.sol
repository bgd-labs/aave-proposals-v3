// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_GHO_Incident_Report_20231122} from './AaveV3Ethereum_GHO_Incident_Report_20231122.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @dev Test for AaveV3Ethereum_GHO_Incident_Report_20231122
 * command: make test-contract filter=AaveV3Ethereum_GHO_Incident_Report_20231122
 */
contract AaveV3Ethereum_GHO_Incident_Report_20231122_Test is ProtocolV3TestBase {
  AaveV3Ethereum_GHO_Incident_Report_20231122 internal proposal;
  address RECEIVER = 0x7D51910845011B41Cc32806644dA478FEfF2f11F;
  address COLLECTOR = address(AaveV3Ethereum.COLLECTOR);
  address GHO_TOKEN = AaveV3EthereumAssets.GHO_UNDERLYING;

  uint256 public constant GHO_AMOUNT = 50_000e18;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18641141);
    proposal = new AaveV3Ethereum_GHO_Incident_Report_20231122();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_GHO_Incident_Report_20231122',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function testTokenTransfer() public {
    uint256 ghoBalanceBeforeFunding = IERC20(GHO_TOKEN).balanceOf(COLLECTOR);

    uint256 receiverBalanceBeforeFunding = IERC20(GHO_TOKEN).balanceOf(RECEIVER);

    executePayload(vm, address(proposal));

    assertEq(IERC20(GHO_TOKEN).balanceOf(RECEIVER), receiverBalanceBeforeFunding + GHO_AMOUNT);
    assertEq(IERC20(GHO_TOKEN).balanceOf(COLLECTOR), ghoBalanceBeforeFunding - GHO_AMOUNT);
  }
}
