// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_IncreaseGHOBorrowRate100BpsTo635OnAaveV3_20231205} from './AaveV3Ethereum_IncreaseGHOBorrowRate100BpsTo635OnAaveV3_20231205.sol';

contract mock_proposal is AaveV3PayloadEthereum {
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](1);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.GHO_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 50_000_000
    });

    return capsUpdate;
  }
}
/**
 * @dev Test for AaveV3Ethereum_IncreaseGHOBorrowRate100BpsTo635OnAaveV3_20231205
 * command: make test-contract filter=AaveV3Ethereum_IncreaseGHOBorrowRate100BpsTo635OnAaveV3_20231205
 */
contract AaveV3Ethereum_IncreaseGHOBorrowRate100BpsTo635OnAaveV3_20231205_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_IncreaseGHOBorrowRate100BpsTo635OnAaveV3_20231205 internal proposal;
  mock_proposal internal mock;
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18722560);
    proposal = new AaveV3Ethereum_IncreaseGHOBorrowRate100BpsTo635OnAaveV3_20231205();
    mock = new mock_proposal();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    GovV3Helpers.executePayload(
      vm,
      address(mock)
    );
    defaultTest(
      'AaveV3Ethereum_IncreaseGHOBorrowRate100BpsTo635OnAaveV3_20231205',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
