// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_OnboardAUSD_20241125} from './AaveV3Avalanche_OnboardAUSD_20241125.sol';

/**
 * @dev Test for AaveV3Avalanche_OnboardAUSD_20241125
 * command: FOUNDRY_PROFILE=avalanche forge test --match-path=src/20241125_AaveV3Avalanche_OnboardAUSD/AaveV3Avalanche_OnboardAUSD_20241125.t.sol -vv
 */
contract AaveV3Avalanche_OnboardAUSD_20241125_Test is ProtocolV3TestBase {
  AaveV3Avalanche_OnboardAUSD_20241125 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 54627124);
    proposal = new AaveV3Avalanche_OnboardAUSD_20241125();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Avalanche_OnboardAUSD_20241125', AaveV3Avalanche.POOL, address(proposal));
  }

  function test_collectorHasAUSDFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Avalanche
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.AUSD());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Avalanche.COLLECTOR)), 100 * 10 ** 6);
  }

  function test_AUSDAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aAUSD, , ) = AaveV3Avalanche.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.AUSD()
    );
    assertEq(
      IEmissionManager(AaveV3Avalanche.EMISSION_MANAGER).getEmissionAdmin(proposal.AUSD()),
      proposal.AUSD_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Avalanche.EMISSION_MANAGER).getEmissionAdmin(aAUSD),
      proposal.AUSD_ADMIN()
    );
  }
}
