// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Metis, AaveV3MetisAssets} from 'aave-address-book/AaveV3Metis.sol';
import {AaveV3PayloadMetis} from 'aave-helpers/v3-config-engine/AaveV3PayloadMetis.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Metis_IncreaseStablecoinOptimalBorrowRates_20231113} from './AaveV3Metis_IncreaseStablecoinOptimalBorrowRates_20231113.sol';
contract mock_proposal is AaveV3PayloadMetis {
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](5);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3MetisAssets.mUSDC_UNDERLYING,
      supplyCap: 10_000_000,
      borrowCap: 6_000_000
    });

    capsUpdate[1] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3MetisAssets.mUSDT_UNDERLYING,
      supplyCap: 10_000_000,
      borrowCap: 6_000_000
    });

    capsUpdate[2] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3MetisAssets.Metis_UNDERLYING,
      supplyCap: 1_000_000,
      borrowCap: 100_000
    });

    capsUpdate[3] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3MetisAssets.mDAI_UNDERLYING,
      supplyCap: 10_000_000,
      borrowCap: 6_000_000
    });

    capsUpdate[4] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3MetisAssets.WETH_UNDERLYING,
      supplyCap: 1_000,
      borrowCap: 600
    });

    return capsUpdate;
  }
}
/**
 * @dev Test for AaveV3Metis_IncreaseStablecoinOptimalBorrowRates_20231113
 * command: make test-contract filter=AaveV3Metis_IncreaseStablecoinOptimalBorrowRates_20231113
 */
contract AaveV3Metis_IncreaseStablecoinOptimalBorrowRates_20231113_Test is ProtocolV3TestBase {
  AaveV3Metis_IncreaseStablecoinOptimalBorrowRates_20231113 internal proposal;
  mock_proposal internal mock;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('metis'), 9334608);
    proposal = new AaveV3Metis_IncreaseStablecoinOptimalBorrowRates_20231113();
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
      'AaveV3Metis_IncreaseStablecoinOptimalBorrowRates_20231113',
      AaveV3Metis.POOL,
      address(proposal)
    );
  }
}
