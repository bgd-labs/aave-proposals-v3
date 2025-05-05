// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_OnboardUSDtbToAaveV3CoreInstance_20250430} from './AaveV3Ethereum_OnboardUSDtbToAaveV3CoreInstance_20250430.sol';

/**
 * @dev Test for AaveV3Ethereum_OnboardUSDtbToAaveV3CoreInstance_20250430
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250430_AaveV3Ethereum_OnboardUSDtbToAaveV3CoreInstance/AaveV3Ethereum_OnboardUSDtbToAaveV3CoreInstance_20250430.t.sol -vv
 */
contract AaveV3Ethereum_OnboardUSDtbToAaveV3CoreInstance_20250430_Test is ProtocolV3TestBase {
  AaveV3Ethereum_OnboardUSDtbToAaveV3CoreInstance_20250430 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22416484);
    proposal = new AaveV3Ethereum_OnboardUSDtbToAaveV3CoreInstance_20250430();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  /// forge-config: default.evm_version = 'cancun'
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_OnboardUSDtbToAaveV3CoreInstance_20250430',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasUSDtbFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Ethereum.POOL.getReserveAToken(proposal.USDtb());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.DUST_BIN)), 100 * 10 ** 18);
  }

  function test_USDtbAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aUSDtb = AaveV3Ethereum.POOL.getReserveAToken(proposal.USDtb());
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(proposal.USDtb()),
      proposal.USDtb_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(aUSDtb),
      proposal.USDtb_LM_ADMIN()
    );
  }
}
