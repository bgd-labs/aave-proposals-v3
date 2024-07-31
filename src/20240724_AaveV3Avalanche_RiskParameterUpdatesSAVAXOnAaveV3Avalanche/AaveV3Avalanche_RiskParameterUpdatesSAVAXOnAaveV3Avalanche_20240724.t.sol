// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_RiskParameterUpdatesSAVAXOnAaveV3Avalanche_20240724} from './AaveV3Avalanche_RiskParameterUpdatesSAVAXOnAaveV3Avalanche_20240724.sol';

/**
 * @dev Test for AaveV3Avalanche_RiskParameterUpdatesSAVAXOnAaveV3Avalanche_20240724
 * command: FOUNDRY_PROFILE=avalanche forge test --match-path=src/20240724_AaveV3Avalanche_RiskParameterUpdatesSAVAXOnAaveV3Avalanche/AaveV3Avalanche_RiskParameterUpdatesSAVAXOnAaveV3Avalanche_20240724.t.sol -vv
 */
contract AaveV3Avalanche_RiskParameterUpdatesSAVAXOnAaveV3Avalanche_20240724_Test is
  ProtocolV3TestBase
{
  struct Change {
    address asset;
    uint256 lt;
    uint256 ltv;
  }

  AaveV3Avalanche_RiskParameterUpdatesSAVAXOnAaveV3Avalanche_20240724 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 48390154);
    proposal = new AaveV3Avalanche_RiskParameterUpdatesSAVAXOnAaveV3Avalanche_20240724();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV3Avalanche_RiskParameterUpdatesSAVAXOnAaveV3Avalanche_20240724',
      AaveV3Avalanche.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3AvalancheAssets.sAVAX_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    ReserveConfig memory config = _findReserveConfig(
      allConfigsAfter,
      AaveV3AvalancheAssets.sAVAX_UNDERLYING
    );
    assertEq(config.ltv, 40_00);
    assertEq(config.liquidationThreshold, 45_00);
  }
}
