// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_OnboardTBTCToAaveV3OnArbitrum_20250818} from './AaveV3Arbitrum_OnboardTBTCToAaveV3OnArbitrum_20250818.sol';

/**
 * @dev Test for AaveV3Arbitrum_OnboardTBTCToAaveV3OnArbitrum_20250818
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250818_AaveV3Arbitrum_OnboardTBTCToAaveV3OnArbitrum/AaveV3Arbitrum_OnboardTBTCToAaveV3OnArbitrum_20250818.t.sol -vv
 */
contract AaveV3Arbitrum_OnboardTBTCToAaveV3OnArbitrum_20250818_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_OnboardTBTCToAaveV3OnArbitrum_20250818 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 369802211);
    proposal = new AaveV3Arbitrum_OnboardTBTCToAaveV3OnArbitrum_20250818();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_OnboardTBTCToAaveV3OnArbitrum_20250818',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_dustBinHastBTCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Arbitrum.POOL.getReserveAToken(proposal.tBTC());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Arbitrum.DUST_BIN)),
      proposal.tBTC_SEED_AMOUNT()
    );
  }

  function test_tBTCAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address atBTC = AaveV3Arbitrum.POOL.getReserveAToken(proposal.tBTC());
    assertEq(
      IEmissionManager(AaveV3Arbitrum.EMISSION_MANAGER).getEmissionAdmin(proposal.tBTC()),
      proposal.tBTC_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Arbitrum.EMISSION_MANAGER).getEmissionAdmin(atBTC),
      proposal.tBTC_LM_ADMIN()
    );
  }
}
