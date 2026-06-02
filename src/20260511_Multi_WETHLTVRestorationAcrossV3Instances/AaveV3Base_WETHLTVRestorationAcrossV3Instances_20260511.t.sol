// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {IPool} from 'aave-address-book/AaveV3.sol';

import {WETHLTVRestorationEmodeBaseTest} from './setup/WETHLTVRestorationEmodeBaseTest.t.sol';
import {AaveV3Base_WETHLTVRestorationAcrossV3Instances_20260511} from './AaveV3Base_WETHLTVRestorationAcrossV3Instances_20260511.sol';

/**
 * @dev Test for AaveV3Base_WETHLTVRestorationAcrossV3Instances_20260511
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260511_Multi_WETHLTVRestorationAcrossV3Instances/AaveV3Base_WETHLTVRestorationAcrossV3Instances_20260511.t.sol -vv
 */
contract AaveV3Base_WETHLTVRestorationAcrossV3Instances_20260511_Test is
  WETHLTVRestorationEmodeBaseTest
{
  uint8 internal constant ETH_EMODE_ID = 1;
  uint256 internal constant EXPECTED_LTV = 80_00;
  uint256 internal constant EXPECTED_LT = 83_00;
  uint256 internal constant EXPECTED_LB = 105_00;
  uint256 internal constant EXPECTED_EMODE_LTV = 90_00;
  uint256 internal constant EXPECTED_EMODE_LT = 93_00;

  AaveV3Base_WETHLTVRestorationAcrossV3Instances_20260511 internal proposal;

  function setUp() public {
    vm.createSelectFork({urlOrAlias: vm.rpcUrl('base'), blockNumber: 45849591});
    proposal = new AaveV3Base_WETHLTVRestorationAcrossV3Instances_20260511();
  }

  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_WETHLTVRestorationAcrossV3Instances_20260511',
      AaveV3Base.POOL,
      address(proposal)
    );
  }

  function test_emodeIdGetter() public view {
    assertEq(proposal.ETH_EMODE_ID(), ETH_EMODE_ID);
  }

  function _pool() internal pure override returns (IPool) {
    return AaveV3Base.POOL;
  }

  function _weth() internal pure override returns (address) {
    return AaveV3BaseAssets.WETH_UNDERLYING;
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

  function _changedEmodeId() internal pure override returns (uint8) {
    return ETH_EMODE_ID;
  }

  function _expectedChangedEmodeLtv() internal pure override returns (uint256) {
    return EXPECTED_EMODE_LTV;
  }

  function _expectedChangedEmodeLt() internal pure override returns (uint256) {
    return EXPECTED_EMODE_LT;
  }

  function _defaultBorrowAsset() internal pure override returns (address) {
    return AaveV3BaseAssets.USDC_UNDERLYING;
  }

  function _emodeBorrowAsset() internal pure override returns (address) {
    return AaveV3BaseAssets.WETH_UNDERLYING;
  }
}
