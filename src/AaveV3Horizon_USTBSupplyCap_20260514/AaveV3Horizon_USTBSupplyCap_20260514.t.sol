// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IPoolDataProvider} from 'aave-v3-origin/contracts/interfaces/IPoolDataProvider.sol';
import {ProtocolV3HorizonTestBase, ReserveConfig} from 'tests/utils/ProtocolV3HorizonTestBase.sol';
import {AaveV3EthereumHorizon, AaveV3EthereumHorizonAssets} from 'aave-address-book-latest/AaveV3EthereumHorizon.sol';
import {AaveHorizonGovV3Helpers} from 'src/utils/AaveHorizonGovV3Helpers.sol';

/**
 * @dev Test for GHO caps update via multisig transaction.
 * command: FOUNDRY_PROFILE=test forge test --match-contract AaveV3Horizon_USTBSupplyCap_20260514 -vv
 */
contract AaveV3Horizon_USTBSupplyCap_20260514 is ProtocolV3HorizonTestBase {
  address internal constant OPS_TARGET = 0x83Cb1B4af26EEf6463aC20AFbAC9c0e2E017202F;
  // from Safe UI
  bytes internal constant OPS_DATA =
    hex'571f03e500000000000000000000000043415eb6ff9db7e26a15b704e7a3edce97d31c4e00000000000000000000000000000000000000000000000000000000007a1200';
  uint256 internal constant OPS_NONCE = 49;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25095755);
  }

  /**
   * @dev Full test suite: snapshots, state diff, validations, e2e.
   */
  function test_defaultProposalExecution() public {
    defaultTest_v3_3('AaveV3Horizon_USTBSupplyCap_20260514', _pool(), _executeUSTBSupplyCapUpdate);
  }

  /**
   * @dev Custom before/after assertions for the USTB supply cap change.
   */
  function test_ustbSupplyCapChange() public {
    (, uint256 supplyCapBefore) = (
      IPoolDataProvider(AaveV3EthereumHorizon.AAVE_PROTOCOL_DATA_PROVIDER).getReserveCaps(
        AaveV3EthereumHorizonAssets.USTB_UNDERLYING
      )
    );

    assertEq(supplyCapBefore, 6_000_000, 'Supply cap before');

    _executeUSTBSupplyCapUpdate();

    (, uint256 supplyCapAfter) = (
      IPoolDataProvider(AaveV3EthereumHorizon.AAVE_PROTOCOL_DATA_PROVIDER).getReserveCaps(
        AaveV3EthereumHorizonAssets.USTB_UNDERLYING
      )
    );

    assertEq(supplyCapAfter, 8_000_000, 'Supply cap after');
  }

  function test_calldata() public pure {
    AaveHorizonGovV3Helpers.Action memory action = AaveHorizonGovV3Helpers.Action({
      to: address(AaveV3EthereumHorizon.POOL_CONFIGURATOR),
      data: abi.encodeCall(
        AaveV3EthereumHorizon.POOL_CONFIGURATOR.setSupplyCap,
        (AaveV3EthereumHorizonAssets.USTB_UNDERLYING, 8_000_000)
      )
    });
    (address to, bytes memory data, uint8 operation) = AaveHorizonGovV3Helpers
      .createOpsMultisigCalldata(action);
    assertEq(to, OPS_TARGET, 'ops target mismatch');
    assertEq(data, OPS_DATA, 'ops calldata mismatch');
    assertEq(operation, 0, 'ops operation mismatch');
  }

  function _executeUSTBSupplyCapUpdate() internal {
    _executeOpsMultisigTx({to: OPS_TARGET, data: OPS_DATA, operation: 0, nonce: OPS_NONCE});
  }
}
