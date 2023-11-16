// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_CRVUSDOnboardingOnAaveV3Ethereum_20231116} from './AaveV3Ethereum_CRVUSDOnboardingOnAaveV3Ethereum_20231116.sol';

/**
 * @dev Test for AaveV3Ethereum_CRVUSDOnboardingOnAaveV3Ethereum_20231116
 * command: make test-contract filter=AaveV3Ethereum_CRVUSDOnboardingOnAaveV3Ethereum_20231116
 */
contract AaveV3Ethereum_CRVUSDOnboardingOnAaveV3Ethereum_20231116_Test is ProtocolV3TestBase {
  AaveV3Ethereum_CRVUSDOnboardingOnAaveV3Ethereum_20231116 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18583576);
    proposal = new AaveV3Ethereum_CRVUSDOnboardingOnAaveV3Ethereum_20231116();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_CRVUSDOnboardingOnAaveV3Ethereum_20231116',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_collectorHascrvUSDFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Ethereum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.crvUSD());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.COLLECTOR)), 10e18);
  }
}
