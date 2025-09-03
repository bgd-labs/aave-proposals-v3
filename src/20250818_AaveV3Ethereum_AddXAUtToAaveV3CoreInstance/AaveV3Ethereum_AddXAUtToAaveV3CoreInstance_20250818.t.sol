// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AddXAUtToAaveV3CoreInstance_20250818} from './AaveV3Ethereum_AddXAUtToAaveV3CoreInstance_20250818.sol';

/**
 * @dev Test for AaveV3Ethereum_AddXAUtToAaveV3CoreInstance_20250818
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250818_AaveV3Ethereum_AddXAUtToAaveV3CoreInstance/AaveV3Ethereum_AddXAUtToAaveV3CoreInstance_20250818.t.sol -vv
 */
contract AaveV3Ethereum_AddXAUtToAaveV3CoreInstance_20250818_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AddXAUtToAaveV3CoreInstance_20250818 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23177168);
    proposal = new AaveV3Ethereum_AddXAUtToAaveV3CoreInstance_20250818();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AddXAUtToAaveV3CoreInstance_20250818',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasXAUtFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Ethereum.POOL.getReserveAToken(proposal.XAUt());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.DUST_BIN)),
      proposal.XAUt_SEED_AMOUNT()
    );
  }

  function test_XAUtAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aXAUt = AaveV3Ethereum.POOL.getReserveAToken(proposal.XAUt());
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(proposal.XAUt()),
      proposal.XAUt_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(aXAUt),
      proposal.XAUt_LM_ADMIN()
    );
  }
}
