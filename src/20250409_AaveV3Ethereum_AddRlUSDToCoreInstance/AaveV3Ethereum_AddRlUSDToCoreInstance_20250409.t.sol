// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AddRlUSDToCoreInstance_20250409} from './AaveV3Ethereum_AddRlUSDToCoreInstance_20250409.sol';

/**
 * @dev Test for AaveV3Ethereum_AddRlUSDToCoreInstance_20250409
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250409_AaveV3Ethereum_AddRlUSDToCoreInstance/AaveV3Ethereum_AddRlUSDToCoreInstance_20250409.t.sol -vv
 */
contract AaveV3Ethereum_AddRlUSDToCoreInstance_20250409_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AddRlUSDToCoreInstance_20250409 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22266958);

    proposal = new AaveV3Ethereum_AddRlUSDToCoreInstance_20250409();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  /// forge-config: default.evm_version = 'cancun'
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AddRlUSDToCoreInstance_20250409',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasRLUSDFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Ethereum.POOL.getReserveAToken(proposal.RLUSD());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.DUST_BIN)), 100 * 10 ** 18);
  }

  function test_RLUSDAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aRLUSD = AaveV3Ethereum.POOL.getReserveAToken(proposal.RLUSD());
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(proposal.RLUSD()),
      proposal.RLUSD_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(aRLUSD),
      proposal.RLUSD_LM_ADMIN()
    );
  }
}
