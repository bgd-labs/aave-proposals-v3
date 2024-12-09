// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_OnboardRsETHToLidoInstance_20241205} from './AaveV3EthereumLido_OnboardRsETHToLidoInstance_20241205.sol';

import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

/**
 * @dev Test for AaveV3EthereumLido_OnboardRsETHToLidoInstance_20241205
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241205_AaveV3EthereumLido_OnboardRsETHToLidoInstance/AaveV3EthereumLido_OnboardRsETHToLidoInstance_20241205.t.sol -vv
 */
contract AaveV3EthereumLido_OnboardRsETHToLidoInstance_20241205_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_OnboardRsETHToLidoInstance_20241205 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21365501);

    proposal = new AaveV3EthereumLido_OnboardRsETHToLidoInstance_20241205();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_OnboardRsETHToLidoInstance_20241205',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_collectorHasrsETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3EthereumLido
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.rsETH());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3EthereumLido.COLLECTOR)),
      0.03 * 10 ** 18
    );
  }

  function test_rsETHAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address arsETH, , ) = AaveV3EthereumLido.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.rsETH()
    );
    assertEq(
      IEmissionManager(AaveV3EthereumLido.EMISSION_MANAGER).getEmissionAdmin(proposal.rsETH()),
      proposal.rsETH_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3EthereumLido.EMISSION_MANAGER).getEmissionAdmin(arsETH),
      proposal.rsETH_ADMIN()
    );
  }
}
