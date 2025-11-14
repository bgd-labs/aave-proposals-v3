// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {OrbitProgramData} from './OrbitProgramData.sol';

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Orbit Renewal
 * @author ACI
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0x4f2381126a2ddf4073916bbdd6d25b031c2dabd022d23887cee6f315693fd7c4
 * - Discussion: https://governance.aave.com/t/arfc-orbit-program-renewal-q3-and-q4-2025/23289
 */
contract AaveV3EthereumLido_OrbitRenewal_20251103 is IProposalGenericExecutor {
  function execute() external {
    address[] memory orbitAddresses = OrbitProgramData.getOrbitAddresses();
    uint256 orbitAddressesLength = orbitAddresses.length;
    for (uint256 i = 0; i < orbitAddressesLength; i++) {
      CollectorUtils.stream(
        AaveV3EthereumLido.COLLECTOR,
        CollectorUtils.CreateStreamInput({
          underlying: AaveV3EthereumLidoAssets.GHO_UNDERLYING,
          receiver: orbitAddresses[i],
          amount: OrbitProgramData.STREAM_AMOUNT,
          start: block.timestamp,
          duration: 1767225599 - block.timestamp // until 31st Dec 2025 23:59:59 UTC
        })
      );
    }
  }
}
