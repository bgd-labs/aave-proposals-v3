// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2EthereumAMM} from 'aave-address-book/AaveV2EthereumAMM.sol';
import {AaveV2Avalanche} from 'aave-address-book/AaveV2Avalanche.sol';
import {AaveV2Polygon} from 'aave-address-book/AaveV2Polygon.sol';

import 'forge-std/Test.sol';
import {ClinicStewardV2Activation_20250904} from './ClinicStewardV2Activation_20250904.sol';

import {ClinicStewardV2Deployments} from './Deployments.sol';

import {BaseActivationTest} from './BaseActivationTest.sol';

/**
 * @dev Test for ClinicStewardV2Activation_20250904
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250904_Multi_AaveV2Deprecation/ClinicStewardV2Activation_20250904.t.sol --mc ClinicStewardActivation_Mainnet_Core_20250904_Test -vv
 */
contract ClinicStewardActivation_Mainnet_Core_20250904_Test is
  BaseActivationTest(
    'mainnet',
    'core',
    23326493,
    AaveV2Ethereum.POOL,
    AaveV2Ethereum.COLLECTOR,
    ClinicStewardV2Deployments.MAINNET_CORE,
    1_000_000e8
  )
{}

/**
 * @dev Test for ClinicStewardV2Activation_20250904
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250904_Multi_AaveV2Deprecation/ClinicStewardV2Activation_20250904.t.sol --mc ClinicStewardActivation_Mainnet_Amm_20250904_Test -vv
 */
contract ClinicStewardActivation_Mainnet_Amm_20250904_Test is
  BaseActivationTest(
    'mainnet',
    'amm',
    23326493,
    AaveV2EthereumAMM.POOL,
    AaveV2EthereumAMM.COLLECTOR,
    ClinicStewardV2Deployments.MAINNET_AMM,
    1_000e8
  )
{}

/**
 * @dev Test for ClinicStewardV2Activation_20250904
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250904_Multi_AaveV2Deprecation/ClinicStewardV2Activation_20250904.t.sol --mc ClinicStewardActivation_Avalanche_20250904_Test -vv
 */
contract ClinicStewardActivation_Avalanche_20250904_Test is
  BaseActivationTest(
    'avalanche',
    '',
    68482232,
    AaveV2Avalanche.POOL,
    AaveV2Avalanche.COLLECTOR,
    ClinicStewardV2Deployments.AVALANCHE,
    2_500e8
  )
{}

/**
 * @dev Test for ClinicStewardV2Activation_20250904
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250904_Multi_AaveV2Deprecation/ClinicStewardV2Activation_20250904.t.sol --mc ClinicStewardActivation_Polygon_20250904_Test -vv
 */
contract ClinicStewardActivation_Polygon_20250904_Test is
  BaseActivationTest(
    'polygon',
    '',
    76251363,
    AaveV2Polygon.POOL,
    AaveV2Polygon.COLLECTOR,
    ClinicStewardV2Deployments.POLYGON,
    5_000e8
  )
{}
