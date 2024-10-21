// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_OnboardEzETHToLidoInstance_20241021} from './AaveV3EthereumLido_OnboardEzETHToLidoInstance_20241021.sol';

/**
 * @dev Test for AaveV3EthereumLido_OnboardEzETHToLidoInstance_20241021
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241021_AaveV3EthereumLido_OnboardEzETHToLidoInstance/AaveV3EthereumLido_OnboardEzETHToLidoInstance_20241021.t.sol -vv
 */
contract AaveV3EthereumLido_OnboardEzETHToLidoInstance_20241021_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_OnboardEzETHToLidoInstance_20241021 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21011916);
    proposal = new AaveV3EthereumLido_OnboardEzETHToLidoInstance_20241021();

    deal(proposal.ezETH(), GovernanceV3Ethereum.EXECUTOR_LVL_1, proposal.ezETH_SEED_AMOUNT());
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_OnboardEzETHToLidoInstance_20241021',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_collectorHasezETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3EthereumLido
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.ezETH());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3EthereumLido.COLLECTOR)),
      proposal.ezETH_SEED_AMOUNT()
    );
  }

  function test_ezETH_USDS_emode() public {}

  function test_ezETH_wstETH_emode() public {}

  function test_ezETHAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aezETH, , ) = AaveV3EthereumLido.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.ezETH()
    );
    assertEq(
      IEmissionManager(AaveV3EthereumLido.EMISSION_MANAGER).getEmissionAdmin(proposal.ezETH()),
      proposal.ezETH_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3EthereumLido.EMISSION_MANAGER).getEmissionAdmin(aezETH),
      proposal.ezETH_LM_ADMIN()
    );
  }
}
