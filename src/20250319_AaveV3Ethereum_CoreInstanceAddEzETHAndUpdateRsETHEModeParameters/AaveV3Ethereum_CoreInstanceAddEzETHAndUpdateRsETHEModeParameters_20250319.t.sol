// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_CoreInstanceAddEzETHAndUpdateRsETHEModeParameters_20250319} from './AaveV3Ethereum_CoreInstanceAddEzETHAndUpdateRsETHEModeParameters_20250319.sol';

/**
 * @dev Test for AaveV3Ethereum_CoreInstanceAddEzETHAndUpdateRsETHEModeParameters_20250319
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250319_AaveV3Ethereum_CoreInstanceAddEzETHAndUpdateRsETHEModeParameters/AaveV3Ethereum_CoreInstanceAddEzETHAndUpdateRsETHEModeParameters_20250319.t.sol -vv
 */
contract AaveV3Ethereum_CoreInstanceAddEzETHAndUpdateRsETHEModeParameters_20250319_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_CoreInstanceAddEzETHAndUpdateRsETHEModeParameters_20250319 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22083013);
    proposal = new AaveV3Ethereum_CoreInstanceAddEzETHAndUpdateRsETHEModeParameters_20250319();
    deal(proposal.ezETH(), AaveV3Ethereum.ACL_ADMIN, proposal.ezETH_SEED_AMOUNT());
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_CoreInstanceAddEzETHAndUpdateRsETHEModeParameters_20250319',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasezETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Ethereum.POOL.getReserveAToken(proposal.ezETH());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.DUST_BIN)),
      proposal.DUST_AMOUNT()
    );
  }
}
