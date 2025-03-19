// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';
import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {AaveV3Metis} from 'aave-address-book/AaveV3Metis.sol';
import {AaveV3Linea} from 'aave-address-book/AaveV3Linea.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3EthereumEtherFi} from 'aave-address-book/AaveV3EthereumEtherFi.sol';
import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';

import {BaseActivationTest} from './BaseActivationTest.sol';

contract Mainnet_ActivationPayload_20250228_Test is
  BaseActivationTest(
    'mainnet',
    22022760,
    AaveV3Ethereum.POOL,
    AaveV3Ethereum.COLLECTOR,
    AaveV3Ethereum.CLINIC_STEWARD,
    30_000e8
  )
{}

contract MainnetLido_ActivationPayload_20250228_Test is
  BaseActivationTest(
    'mainnet',
    22022760,
    AaveV3EthereumLido.POOL,
    AaveV3EthereumLido.COLLECTOR,
    AaveV3EthereumLido.CLINIC_STEWARD,
    5_000e8
  )
{}

contract Polygon_ActivationPayload_20250228_Test is
  BaseActivationTest(
    'polygon',
    68912683,
    AaveV3Polygon.POOL,
    AaveV3Polygon.COLLECTOR,
    AaveV3Polygon.CLINIC_STEWARD,
    30_000e8
  )
{}

contract Avalanche_ActivationPayload_20250228_Test is
  BaseActivationTest(
    'avalanche',
    58556475,
    AaveV3Avalanche.POOL,
    AaveV3Avalanche.COLLECTOR,
    AaveV3Avalanche.CLINIC_STEWARD,
    350_000e8
  )
{}

contract Optimism_ActivationPayload_20250228_Test is
  BaseActivationTest(
    'optimism',
    133043418,
    AaveV3Optimism.POOL,
    AaveV3Optimism.COLLECTOR,
    AaveV3Optimism.CLINIC_STEWARD,
    5_000e8
  )
{}

contract Arbitrum_ActivationPayload_20250228_Test is
  BaseActivationTest(
    'arbitrum',
    311933992,
    AaveV3Arbitrum.POOL,
    AaveV3Arbitrum.COLLECTOR,
    AaveV3Arbitrum.CLINIC_STEWARD,
    60_000e8
  )
{}

contract Metis_ActivationPayload_20250228_Test is
  BaseActivationTest(
    'metis',
    19887365,
    AaveV3Metis.POOL,
    AaveV3Metis.COLLECTOR,
    AaveV3Metis.CLINIC_STEWARD,
    1_000e8
  )
{}

contract Base_ActivationPayload_20250228_Test is
  BaseActivationTest(
    'base',
    27448115,
    AaveV3Base.POOL,
    AaveV3Base.COLLECTOR,
    AaveV3Base.CLINIC_STEWARD,
    15_000e8
  )
{}

contract Gnosis_ActivationPayload_20250228_Test is
  BaseActivationTest(
    'gnosis',
    38977275,
    AaveV3Gnosis.POOL,
    AaveV3Gnosis.COLLECTOR,
    AaveV3Gnosis.CLINIC_STEWARD,
    1_000e8
  )
{}

contract Scroll_ActivationPayload_20250228_Test is
  BaseActivationTest(
    'scroll',
    13965056,
    AaveV3Scroll.POOL,
    AaveV3Scroll.COLLECTOR,
    AaveV3Scroll.CLINIC_STEWARD,
    1_000e8
  )
{}

contract BNB_ActivationPayload_20250228_Test is
  BaseActivationTest(
    'bnb',
    47367949,
    AaveV3BNB.POOL,
    AaveV3BNB.COLLECTOR,
    AaveV3BNB.CLINIC_STEWARD,
    2_000e8
  )
{}

contract Linea_ActivationPayload_20250228_Test is
  BaseActivationTest(
    'linea',
    16806735,
    AaveV3Linea.POOL,
    AaveV3Linea.COLLECTOR,
    AaveV3Linea.CLINIC_STEWARD,
    1_000e8
  )
{}
