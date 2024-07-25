// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IPoolAddressesProviderRegistry} from 'aave-v3-core/contracts/interfaces/IPoolAddressesProviderRegistry.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_LidoEthereumInstanceActivation_20240720} from './AaveV3EthereumLido_LidoEthereumInstanceActivation_20240720.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

/**
 * @dev Test for AaveV3EthereumLido_LidoEthereumInstanceActivation_20240720
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240720_AaveV3EthereumLido_LidoEthereumInstanceActivation/AaveV3EthereumLido_LidoEthereumInstanceActivation_20240720.t.sol -vv
 */
contract AaveV3EthereumLido_LidoEthereumInstanceActivation_20240720_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_LidoEthereumInstanceActivation_20240720 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20347071);
    proposal = new AaveV3EthereumLido_LidoEthereumInstanceActivation_20240720();

    deal(proposal.WETH(), GovernanceV3Ethereum.EXECUTOR_LVL_1, 1e17);
    deal(proposal.wstETH(), GovernanceV3Ethereum.EXECUTOR_LVL_1, 1e17);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_LidoEthereumInstanceActivation_20240720',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_collectorHaswstETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3EthereumLido
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.wstETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.COLLECTOR)), 1e17);
  }

  function test_collectorHasWETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3EthereumLido
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.WETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.COLLECTOR)), 1e17);
  }

  function test_lidoEthereumAddressesProvider_setAddress_incentivesController_Ethereum() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      AaveV3EthereumLido.POOL_ADDRESSES_PROVIDER.getAddress(keccak256('INCENTIVES_CONTROLLER')),
      address(AaveV3Ethereum.DEFAULT_INCENTIVES_CONTROLLER)
    );
  }

  function test_ethereumAddressesProviderRegistry_registry_lidoAddressesProvider() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      IPoolAddressesProviderRegistry(AaveV3Ethereum.POOL_ADDRESSES_PROVIDER_REGISTRY)
        .getAddressesProviderIdByAddress(address(AaveV3EthereumLido.POOL_ADDRESSES_PROVIDER)),
      43
    );
  }

  function test_lidoAclManager_roles() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertTrue(
      AaveV3EthereumLido.ACL_MANAGER.isPoolAdmin(0x2CFe3ec4d5a6811f4B8067F0DE7e47DfA938Aa30)
    );
    assertTrue(
      AaveV3EthereumLido.ACL_MANAGER.isRiskAdmin(AaveV3EthereumLido.CAPS_PLUS_RISK_STEWARD)
    );
  }

  function test_emissions_admin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aWETH, , ) = AaveV3EthereumLido.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.WETH()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(aWETH),
      proposal.ACI_MULTISIG()
    );
    assertEq(aWETH, 0xfA1fDbBD71B0aA16162D76914d69cD8CB3Ef92da);
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(proposal.WETH()),
      proposal.ACI_MULTISIG()
    );
  }

  function test_deployment_service_fees() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      IERC20(MiscEthereum.GHO_TOKEN).balanceOf(0x6D53be86136c3d4AA6448Ce4bF6178AD66e63661),
      15000e18
    );
  }
}
