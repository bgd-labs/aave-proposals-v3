// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IPoolDataProvider} from 'aave-v3-origin/contracts/interfaces/IPoolDataProvider.sol';
import {ProtocolV3HorizonTestBase, ReserveConfig} from 'tests/utils/ProtocolV3HorizonTestBase.sol';
import {AaveV3EthereumHorizon, AaveV3EthereumHorizonAssets} from 'aave-address-book-latest/AaveV3EthereumHorizon.sol';
import {AaveHorizonGovV3Helpers} from 'src/utils/AaveHorizonGovV3Helpers.sol';

/**
 * @dev Test for GHO caps update via multisig transaction.
 * command: FOUNDRY_PROFILE=test forge test --match-contract AaveV3Horizon_JAAASupplyCap_20260518 -vv
 */
contract AaveV3Horizon_JAAASupplyCap_20260518 is ProtocolV3HorizonTestBase {
  address internal constant OPS_TARGET = 0x83Cb1B4af26EEf6463aC20AFbAC9c0e2E017202F;
  // from Safe UI
  bytes internal constant OPS_DATA =
    hex'571f03e50000000000000000000000005a0f93d040de44e78f251b03c43be9cf317dcf6400000000000000000000000000000000000000000000000000000000014fb180';
  uint256 internal constant OPS_NONCE = 51;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25125902);
  }

  /**
   * @dev Full test suite: snapshots, state diff, validations, e2e.
   */
  function test_defaultProposalExecution() public {
    defaultTest_v3_3('AaveV3Horizon_JAAASupplyCap_20260518', _pool(), _executeJAAASupplyCapUpdate);
  }

  /**
   * @dev Custom before/after assertions for the JAAA supply cap change.
   */
  function test_jaaaSupplyCapChange() public {
    (, uint256 supplyCapBefore) = (
      IPoolDataProvider(AaveV3EthereumHorizon.AAVE_PROTOCOL_DATA_PROVIDER).getReserveCaps(
        AaveV3EthereumHorizonAssets.JAAA_UNDERLYING
      )
    );

    assertEq(supplyCapBefore, 13_000_000, 'Supply cap before');

    _executeJAAASupplyCapUpdate();

    (, uint256 supplyCapAfter) = (
      IPoolDataProvider(AaveV3EthereumHorizon.AAVE_PROTOCOL_DATA_PROVIDER).getReserveCaps(
        AaveV3EthereumHorizonAssets.JAAA_UNDERLYING
      )
    );

    assertEq(supplyCapAfter, 22_000_000, 'Supply cap after');
  }

  function test_calldata() public pure {
    AaveHorizonGovV3Helpers.Action memory action = AaveHorizonGovV3Helpers.Action({
      to: address(AaveV3EthereumHorizon.POOL_CONFIGURATOR),
      data: abi.encodeCall(
        AaveV3EthereumHorizon.POOL_CONFIGURATOR.setSupplyCap,
        (AaveV3EthereumHorizonAssets.JAAA_UNDERLYING, 22_000_000)
      )
    });
    (address to, bytes memory data, uint8 operation) = AaveHorizonGovV3Helpers
      .createOpsMultisigCalldata(action);
    assertEq(to, OPS_TARGET, 'ops target mismatch');
    assertEq(data, OPS_DATA, 'ops calldata mismatch');
    assertEq(operation, 0, 'ops operation mismatch');
  }

  function _executeJAAASupplyCapUpdate() internal {
    _executeOpsMultisigTx({to: OPS_TARGET, data: OPS_DATA, operation: 0, nonce: OPS_NONCE});
  }
}
