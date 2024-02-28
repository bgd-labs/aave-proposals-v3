// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title Cut Gauntlet Service Provider Stream
 * @author ACI
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/gauntlet-is-leaving-aave/16700
 */
contract AaveV3Ethereum_CutGauntletServiceProviderStream_20240227 is IProposalGenericExecutor {
  address public constant GAUNTLET_RECIPIENT = 0xD20c9667bf0047F313228F9fE11F8b9F8Dc29bBa;
  uint256 public constant COLLECTOR_aUSDT_STREAM = 100021;
  uint256 public constant COLLECTOR_GHO_STREAM = 100022;

  function execute() external {
    AaveV2Ethereum.COLLECTOR.cancelStream(COLLECTOR_GHO_STREAM);
    AaveV2Ethereum.COLLECTOR.cancelStream(COLLECTOR_aUSDT_STREAM);
  }
}
