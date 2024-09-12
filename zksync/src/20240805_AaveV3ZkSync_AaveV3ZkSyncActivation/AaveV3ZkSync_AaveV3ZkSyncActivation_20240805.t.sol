// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ProtocolV3TestBase} from 'aave-helpers/zksync/src/ProtocolV3TestBase.sol';
import {AaveV3ZkSync_AaveV3ZkSyncActivation_20240805} from './AaveV3ZkSync_AaveV3ZkSyncActivation_20240805.sol';
import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';
import {MiscZkSync} from 'aave-address-book/MiscZkSync.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @dev Test for AaveV3ZkSync_AaveV3ZkSyncActivation_20240805
 * command: FOUNDRY_PROFILE=zksync forge test --zksync --match-path=zksync/src/20240805_AaveV3ZkSync_AaveV3ZkSyncActivation/AaveV3ZkSync_AaveV3ZkSyncActivation_20240805.t.sol -vv
 */
contract AaveV3ZkSync_AaveV3ZkSyncActivation_20240805_Test is ProtocolV3TestBase {
  AaveV3ZkSync_AaveV3ZkSyncActivation_20240805 internal proposal;

  function setUp() public override {
    vm.createSelectFork(vm.rpcUrl('zksync'), 41829358);
    proposal = new AaveV3ZkSync_AaveV3ZkSyncActivation_20240805();

    super.setUp();
  }

  /**
   * @dev executes the generic test suite including e2e
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3ZkSync_AaveV3ZkSyncActivation_20240805',
      AaveV3ZkSync.POOL,
      address(proposal)
    );
  }

  function test_permissions() public {
    assertFalse(AaveV3ZkSync.ACL_MANAGER.isPoolAdmin(MiscZkSync.PROTOCOL_GUARDIAN));
    executePayload(vm, address(proposal));

    assertTrue(AaveV3ZkSync.ACL_MANAGER.isPoolAdmin(MiscZkSync.PROTOCOL_GUARDIAN));
    assertEq(
      IEmissionManager(AaveV3ZkSync.EMISSION_MANAGER).getEmissionAdmin(proposal.ZK()),
      proposal.ACI_MULTISIG()
    );
  }

  function test_collectorHasFunds() public {
    executePayload(vm, address(proposal));

    (address aUsdcAddress, , ) = AaveV3ZkSync.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.USDC()
    );
    (address aUsdtAddress, , ) = AaveV3ZkSync.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.USDT()
    );
    (address aWethAddress, , ) = AaveV3ZkSync.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.WETH()
    );
    (address aWstEthAddress, , ) = AaveV3ZkSync
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.wstETH());
    (address aZkAddress, , ) = AaveV3ZkSync.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.ZK()
    );

    assertGe(
      IERC20(aUsdcAddress).balanceOf(address(AaveV3ZkSync.COLLECTOR)),
      proposal.USDC_SEED_AMOUNT()
    );
    assertGe(
      IERC20(aUsdtAddress).balanceOf(address(AaveV3ZkSync.COLLECTOR)),
      proposal.USDT_SEED_AMOUNT()
    );
    assertGe(
      IERC20(aWethAddress).balanceOf(address(AaveV3ZkSync.COLLECTOR)),
      proposal.WETH_SEED_AMOUNT()
    );
    assertGe(
      IERC20(aWstEthAddress).balanceOf(address(AaveV3ZkSync.COLLECTOR)),
      proposal.wstETH_SEED_AMOUNT()
    );
    assertGe(
      IERC20(aZkAddress).balanceOf(address(AaveV3ZkSync.COLLECTOR)),
      proposal.ZK_SEED_AMOUNT()
    );
  }
}
