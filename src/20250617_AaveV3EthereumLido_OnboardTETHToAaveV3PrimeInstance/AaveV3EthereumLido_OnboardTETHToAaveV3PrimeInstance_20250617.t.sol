// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_OnboardTETHToAaveV3PrimeInstance_20250617} from './AaveV3EthereumLido_OnboardTETHToAaveV3PrimeInstance_20250617.sol';

/**
 * @dev Test for AaveV3EthereumLido_OnboardTETHToAaveV3PrimeInstance_20250617
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250617_AaveV3EthereumLido_OnboardTETHToAaveV3PrimeInstance/AaveV3EthereumLido_OnboardTETHToAaveV3PrimeInstance_20250617.t.sol -vv
 */
contract AaveV3EthereumLido_OnboardTETHToAaveV3PrimeInstance_20250617_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_OnboardTETHToAaveV3PrimeInstance_20250617 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22746776);
    proposal = new AaveV3EthereumLido_OnboardTETHToAaveV3PrimeInstance_20250617();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_OnboardTETHToAaveV3PrimeInstance_20250617',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_dustBinHastETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3EthereumLido.POOL.getReserveAToken(proposal.tETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3EthereumLido.DUST_BIN)), 4 * 10 ** 16);
  }

  function test_tETHAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address atETH = AaveV3EthereumLido.POOL.getReserveAToken(proposal.tETH());
    assertEq(
      IEmissionManager(AaveV3EthereumLido.EMISSION_MANAGER).getEmissionAdmin(proposal.tETH()),
      proposal.tETH_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3EthereumLido.EMISSION_MANAGER).getEmissionAdmin(atETH),
      proposal.tETH_LM_ADMIN()
    );
  }
}
