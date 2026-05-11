// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Linea, AaveV3LineaAssets} from 'aave-address-book/AaveV3Linea.sol';
import {IPool} from 'aave-address-book/AaveV3.sol';

import {WETHLTVRestorationBaseTest} from './setup/WETHLTVRestorationBaseTest.t.sol';
import {AaveV3Linea_WETHLTVRestorationAcrossV3Instances_20260511} from './AaveV3Linea_WETHLTVRestorationAcrossV3Instances_20260511.sol';

/**
 * @dev Test for AaveV3Linea_WETHLTVRestorationAcrossV3Instances_20260511
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260511_Multi_WETHLTVRestorationAcrossV3Instances/AaveV3Linea_WETHLTVRestorationAcrossV3Instances_20260511.t.sol -vv
 */
contract AaveV3Linea_WETHLTVRestorationAcrossV3Instances_20260511_Test is
  WETHLTVRestorationBaseTest
{
  uint256 internal constant EXPECTED_LTV = 80_00;
  uint256 internal constant EXPECTED_LT = 83_00;
  uint256 internal constant EXPECTED_LB = 106_00;

  AaveV3Linea_WETHLTVRestorationAcrossV3Instances_20260511 internal proposal;

  function setUp() public {
    vm.createSelectFork({urlOrAlias: vm.rpcUrl('linea'), blockNumber: 30600604});
    proposal = new AaveV3Linea_WETHLTVRestorationAcrossV3Instances_20260511();
  }

  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Linea_WETHLTVRestorationAcrossV3Instances_20260511',
      AaveV3Linea.POOL,
      address(proposal)
    );
  }

  function _pool() internal pure override returns (IPool) {
    return AaveV3Linea.POOL;
  }

  function _weth() internal pure override returns (address) {
    return AaveV3LineaAssets.WETH_UNDERLYING;
  }

  function _proposal() internal view override returns (address) {
    return address(proposal);
  }

  function _expectedLtv() internal pure override returns (uint256) {
    return EXPECTED_LTV;
  }

  function _expectedLt() internal pure override returns (uint256) {
    return EXPECTED_LT;
  }

  function _expectedLb() internal pure override returns (uint256) {
    return EXPECTED_LB;
  }

  function _defaultBorrowAsset() internal pure override returns (address) {
    return AaveV3LineaAssets.USDC_UNDERLYING;
  }
}
