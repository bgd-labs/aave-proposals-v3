// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV4Ethereum} from 'aave-address-book/AaveV4Ethereum.sol';
import {AaveV4Payload} from 'aave-v4/config-engine/AaveV4Payload.sol';

/**
 * @dev Base smart contract for an Aave V4 governance payload on Ethereum.
 * @author Aave Labs
 */
abstract contract AaveV4PayloadEthereum is AaveV4Payload(AaveV4Ethereum.CONFIG_ENGINE) {}
