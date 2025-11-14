// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3InkWhitelabel} from 'aave-address-book/AaveV3InkWhitelabel.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3InkWhitelabel_OnboardUSDCOnAaveV3InkWhitelabel_20251113} from './AaveV3InkWhitelabel_OnboardUSDCOnAaveV3InkWhitelabel_20251113.sol';

/**
 * @dev Test for AaveV3InkWhitelabel_OnboardUSDCOnAaveV3InkWhitelabel_20251113
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251113_AaveV3InkWhitelabel_OnboardUSDCOnAaveV3InkWhitelabel/AaveV3InkWhitelabel_OnboardUSDCOnAaveV3InkWhitelabel_20251113.t.sol -vv
 */
contract AaveV3InkWhitelabel_OnboardUSDCOnAaveV3InkWhitelabel_20251113_Test is ProtocolV3TestBase {
  AaveV3InkWhitelabel_OnboardUSDCOnAaveV3InkWhitelabel_20251113 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('ink'), 29561410);
    proposal = new AaveV3InkWhitelabel_OnboardUSDCOnAaveV3InkWhitelabel_20251113();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3InkWhitelabel_OnboardUSDCOnAaveV3InkWhitelabel_20251113',
      AaveV3InkWhitelabel.POOL,
      address(proposal),
      true,
      true
    );
  }

  function test_dustBinHasUSDCFunds() public {
    executePayload(vm, address(proposal), AaveV3InkWhitelabel.POOL);
    address aTokenAddress = AaveV3InkWhitelabel.POOL.getReserveAToken(proposal.USDC());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3InkWhitelabel.DUST_BIN)), 10 ** 6);
  }

  function test_USDCAdmin() public {
    executePayload(vm, address(proposal), AaveV3InkWhitelabel.POOL);
    address aUSDC = AaveV3InkWhitelabel.POOL.getReserveAToken(proposal.USDC());
    assertEq(
      IEmissionManager(AaveV3InkWhitelabel.EMISSION_MANAGER).getEmissionAdmin(proposal.USDC()),
      proposal.USDC_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3InkWhitelabel.EMISSION_MANAGER).getEmissionAdmin(aUSDC),
      proposal.USDC_LM_ADMIN()
    );
  }
}
