// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_OnboardEBTCAndAddEBTCWBTCEMode_20250324} from './AaveV3Ethereum_OnboardEBTCAndAddEBTCWBTCEMode_20250324.sol';

/**
 * @dev Test for AaveV3Ethereum_OnboardEBTCAndAddEBTCWBTCEMode_20250324
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250324_AaveV3Ethereum_OnboardEBTCAndAddEBTCWBTCEMode/AaveV3Ethereum_OnboardEBTCAndAddEBTCWBTCEMode_20250324.t.sol -vv
 */
contract AaveV3Ethereum_OnboardEBTCAndAddEBTCWBTCEMode_20250324_Test is ProtocolV3TestBase {
  AaveV3Ethereum_OnboardEBTCAndAddEBTCWBTCEMode_20250324 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22116242);
    proposal = new AaveV3Ethereum_OnboardEBTCAndAddEBTCWBTCEMode_20250324();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_OnboardEBTCAndAddEBTCWBTCEMode_20250324',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_dustBinHaseBTCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Ethereum.POOL.getReserveAToken(proposal.eBTC());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.DUST_BIN)), 2 * 10 ** 5);
  }

  function test_eBTCAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aeBTC = AaveV3Ethereum.POOL.getReserveAToken(proposal.eBTC());
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(proposal.eBTC()),
      proposal.eBTC_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(aeBTC),
      proposal.eBTC_LM_ADMIN()
    );
  }
}
