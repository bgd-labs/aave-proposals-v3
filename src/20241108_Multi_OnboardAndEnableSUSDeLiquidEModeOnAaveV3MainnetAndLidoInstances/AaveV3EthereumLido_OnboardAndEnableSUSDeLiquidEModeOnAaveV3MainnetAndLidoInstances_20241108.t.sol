// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances_20241108} from './AaveV3EthereumLido_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances_20241108.sol';

/**
 * @dev Test for AaveV3EthereumLido_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances_20241108
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241108_Multi_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances/AaveV3EthereumLido_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances_20241108.t.sol -vv
 */
contract AaveV3EthereumLido_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances_20241108_Test is
  ProtocolV3TestBase
{
  AaveV3EthereumLido_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances_20241108
    internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21171005);
    proposal = new AaveV3EthereumLido_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances_20241108();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances_20241108',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_collectorHassUSDeFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3EthereumLido
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.sUSDe());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3EthereumLido.COLLECTOR)),
      100 * 10 ** 18
    );
  }

  function test_sUSDeAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address asUSDe, , ) = AaveV3EthereumLido.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.sUSDe()
    );
    assertEq(
      IEmissionManager(AaveV3EthereumLido.EMISSION_MANAGER).getEmissionAdmin(proposal.sUSDe()),
      proposal.sUSDe_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3EthereumLido.EMISSION_MANAGER).getEmissionAdmin(asUSDe),
      proposal.sUSDe_ADMIN()
    );
  }
}
