// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425} from './AaveV3Avalanche_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425.sol';

/**
 * @dev Test for AaveV3Avalanche_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425
 * command: make test-contract filter=AaveV3Avalanche_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425
 */
contract AaveV3Avalanche_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425_Test is
  ProtocolV3TestBase
{
  struct Change {
    address asset;
    uint256 lt;
    uint256 ltv;
  }

  AaveV3Avalanche_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 44637823);
    proposal = new AaveV3Avalanche_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV3Avalanche_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425',
      AaveV3Avalanche.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3AvalancheAssets.USDC_UNDERLYING;

    Change[] memory assetChanges = new Change[](1);
    assetChanges[0] = Change({asset: AaveV3AvalancheAssets.USDC_UNDERLYING, ltv: 75_00, lt: 81_00});

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    for (uint i = 0; i < assetChanges.length; i++) {
      ReserveConfig memory config = _findReserveConfig(allConfigsAfter, assetChanges[i].asset);
      assertEq(config.ltv, assetChanges[i].ltv);
      assertEq(config.liquidationThreshold, assetChanges[i].lt);
    }
  }
}
