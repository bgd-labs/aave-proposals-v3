// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_OnboardRsETHToAaveV3Ethereum_20241104} from './AaveV3Ethereum_OnboardRsETHToAaveV3Ethereum_20241104.sol';

/**
 * @dev Test for AaveV3Ethereum_OnboardRsETHToAaveV3Ethereum_20241104
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241104_AaveV3Ethereum_OnboardRsETHToAaveV3Ethereum/AaveV3Ethereum_OnboardRsETHToAaveV3Ethereum_20241104.t.sol -vv
 */
contract AaveV3Ethereum_OnboardRsETHToAaveV3Ethereum_20241104_Test is ProtocolV3TestBase {
  AaveV3Ethereum_OnboardRsETHToAaveV3Ethereum_20241104 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21136339);
    proposal = new AaveV3Ethereum_OnboardRsETHToAaveV3Ethereum_20241104();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_OnboardRsETHToAaveV3Ethereum_20241104',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_collectorHasrsETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Ethereum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.rsETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.COLLECTOR)), 4 * 10 ** 16);
  }

  function test_rsETHAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address arsETH, , ) = AaveV3Ethereum.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.rsETH()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(proposal.rsETH()),
      proposal.rsETH_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(arsETH),
      proposal.rsETH_ADMIN()
    );
  }
}
