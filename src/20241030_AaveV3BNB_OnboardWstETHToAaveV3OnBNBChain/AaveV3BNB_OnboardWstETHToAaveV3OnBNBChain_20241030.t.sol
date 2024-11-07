// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3BNB_OnboardWstETHToAaveV3OnBNBChain_20241030} from './AaveV3BNB_OnboardWstETHToAaveV3OnBNBChain_20241030.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @dev Test for AaveV3BNB_OnboardWstETHToAaveV3OnBNBChain_20241030
 * command: FOUNDRY_PROFILE=bnb forge test --match-path=src/20241030_AaveV3BNB_OnboardWstETHToAaveV3OnBNBChain/AaveV3BNB_OnboardWstETHToAaveV3OnBNBChain_20241030.t.sol -vv
 */
contract AaveV3BNB_OnboardWstETHToAaveV3OnBNBChain_20241030_Test is ProtocolV3TestBase {
  AaveV3BNB_OnboardWstETHToAaveV3OnBNBChain_20241030 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('bnb'), 43567833);
    proposal = new AaveV3BNB_OnboardWstETHToAaveV3OnBNBChain_20241030();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3BNB_OnboardWstETHToAaveV3OnBNBChain_20241030',
      AaveV3BNB.POOL,
      address(proposal)
    );
  }

  function test_collectorHaswstETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3BNB.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.wstETH()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3BNB.COLLECTOR)), 4 * 10 ** 16);
  }

  function test_wstETHAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address awstETH, , ) = AaveV3BNB.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.wstETH()
    );
    assertEq(
      IEmissionManager(AaveV3BNB.EMISSION_MANAGER).getEmissionAdmin(proposal.wstETH()),
      proposal.wstETH_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3BNB.EMISSION_MANAGER).getEmissionAdmin(awstETH),
      proposal.wstETH_LM_ADMIN()
    );
  }
}
