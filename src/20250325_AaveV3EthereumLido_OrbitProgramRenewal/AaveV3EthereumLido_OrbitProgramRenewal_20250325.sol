// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {OrbitProgramRenewalData} from './OrbitProgramRenewalData.sol';
/**
 * @title Orbit Program Renewal
 * @author Aave-Chan Initiative
 * - Snapshot: https://governance.aave.com/t/arfc-orbit-program-renewal-q1-2025/21205
 * - Discussion: https://governance.aave.com/t/arfc-orbit-program-renewal-q1-2025/21205
 */
contract AaveV3EthereumLido_OrbitProgramRenewal_20250325 is IProposalGenericExecutor {
  function execute() external {
    address[] memory orbitAddresses = OrbitProgramRenewalData.getOrbitAddresses();

    for (uint256 i = 0; i < orbitAddresses.length; i++) {
      CollectorUtils.stream(
        AaveV3EthereumLido.COLLECTOR,
        CollectorUtils.CreateStreamInput({
          underlying: AaveV3EthereumLidoAssets.GHO_A_TOKEN,
          receiver: orbitAddresses[i],
          amount: OrbitProgramRenewalData.STREAM_AMOUNT,
          start: block.timestamp,
          duration: OrbitProgramRenewalData.STREAM_DURATION
        })
      );
    }
  }
}
