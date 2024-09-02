// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3EthereumEtherFi} from 'aave-address-book/AaveV3EthereumEtherFi.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumEtherFi_EtherFiEthereumActivation_20240902} from './AaveV3EthereumEtherFi_EtherFiEthereumActivation_20240902.sol';
import {IPoolAddressesProviderRegistry} from 'aave-v3-core/contracts/interfaces/IPoolAddressesProviderRegistry.sol';

/**
 * @dev Test for AaveV3EthereumEtherFi_EtherFiEthereumActivation_20240902
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240902_AaveV3EthereumEtherFi_EtherFiEthereumActivation/AaveV3EthereumEtherFi_EtherFiEthereumActivation_20240902.t.sol -vv
 */
contract AaveV3EthereumEtherFi_EtherFiEthereumActivation_20240902_Test is ProtocolV3TestBase {
  AaveV3EthereumEtherFi_EtherFiEthereumActivation_20240902 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20662348);
    proposal = new AaveV3EthereumEtherFi_EtherFiEthereumActivation_20240902();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumEtherFi_EtherFiEthereumActivation_20240902',
      AaveV3EthereumEtherFi.POOL,
      address(proposal)
    );
  }

  /*
  @dev Skip until list of flash borrowers
  function test_isFlashBorrower() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    bool isFlashBorrower = AaveV3EthereumEtherFi.ACL_MANAGER.isFlashBorrower(
      proposal.NEW_FLASH_BORROWER()
    );
    assertEq(isFlashBorrower, true);
  }
  */
  function test_collectorHasweETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3EthereumEtherFi
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.weETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3EthereumEtherFi.COLLECTOR)), 10 ** 18);
  }
  function test_collectorHasUSDCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3EthereumEtherFi
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.USDC());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3EthereumEtherFi.COLLECTOR)), 10 ** 6);
  }
  function test_collectorHasPYUSDFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3EthereumEtherFi
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.PYUSD());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3EthereumEtherFi.COLLECTOR)), 10 ** 6);
  }
  function test_collectorHasFRAXFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3EthereumEtherFi
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.FRAX());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3EthereumEtherFi.COLLECTOR)), 10 ** 18);
  }

  function test_ethereumAddressesProviderRegistry_registry_EtherFiAddressesProvider() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      IPoolAddressesProviderRegistry(AaveV3Ethereum.POOL_ADDRESSES_PROVIDER_REGISTRY)
        .getAddressesProviderIdByAddress(address(AaveV3EthereumEtherFi.POOL_ADDRESSES_PROVIDER)),
      45
    );
  }

  function test_EtherFiAclManager_roles() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertTrue(
      AaveV3EthereumEtherFi.ACL_MANAGER.isPoolAdmin(0x2CFe3ec4d5a6811f4B8067F0DE7e47DfA938Aa30)
    );
    assertTrue(
      AaveV3EthereumEtherFi.ACL_MANAGER.isRiskAdmin(AaveV3EthereumEtherFi.CAPS_PLUS_RISK_STEWARD)
    );
  }
}
