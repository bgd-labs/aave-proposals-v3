// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_OnboardUSDSAndSUSDS_20240914} from './AaveV3Ethereum_OnboardUSDSAndSUSDS_20240914.sol';

import {IPoolAddressesProviderRegistry} from 'aave-v3-core/contracts/interfaces/IPoolAddressesProviderRegistry.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @dev Test for AaveV3Ethereum_OnboardUSDSAndSUSDS_20240914
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240914_AaveV3Ethereum_OnboardUSDSAndSUSDS/AaveV3Ethereum_OnboardUSDSAndSUSDS_20240914.t.sol -vv
 */
contract AaveV3Ethereum_OnboardUSDSAndSUSDS_20240914_Test is ProtocolV3TestBase {
  AaveV3Ethereum_OnboardUSDSAndSUSDS_20240914 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20747338);
    proposal = new AaveV3Ethereum_OnboardUSDSAndSUSDS_20240914();
    deal2(proposal.USDS(), 0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A, 100e18);
    deal2(proposal.sUSDS(), 0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A, 100e18);

    //
    vm.mockCall(
      proposal.USDS(),
      abi.encodeWithSelector(IERC20.totalSupply.selector),
      abi.encode(100_000_000 * 1 ether)
    );

    vm.mockCall(
      proposal.sUSDS(),
      abi.encodeWithSelector(IERC20.totalSupply.selector),
      abi.encode(100_000_000 * 1 ether)
    );
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_OnboardUSDSAndSUSDS_20240914',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_collectorHasUSDSFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Ethereum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.USDS());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.COLLECTOR)), 10 ** 18);
  }
  function test_collectorHassUSDSFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Ethereum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.sUSDS());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.COLLECTOR)), 10 ** 18);
  }
}
