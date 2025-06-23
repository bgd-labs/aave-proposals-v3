// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AddEURCToAaveV3CoreInstance_20250622} from './AaveV3Ethereum_AddEURCToAaveV3CoreInstance_20250622.sol';

/**
 * @dev Test for AaveV3Ethereum_AddEURCToAaveV3CoreInstance_20250622
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250622_AaveV3Ethereum_AddEURCToAaveV3CoreInstance/AaveV3Ethereum_AddEURCToAaveV3CoreInstance_20250622.t.sol -vv
 */
contract AaveV3Ethereum_AddEURCToAaveV3CoreInstance_20250622_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AddEURCToAaveV3CoreInstance_20250622 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22766614);
    proposal = new AaveV3Ethereum_AddEURCToAaveV3CoreInstance_20250622();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AddEURCToAaveV3CoreInstance_20250622',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasEURCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Ethereum.POOL.getReserveAToken(proposal.EURC());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.DUST_BIN)), 100 * 10 ** 6);
  }

  function test_EURCAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aEURC = AaveV3Ethereum.POOL.getReserveAToken(proposal.EURC());
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(proposal.EURC()),
      proposal.EURC_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(aEURC),
      proposal.EURC_LM_ADMIN()
    );
  }
}
