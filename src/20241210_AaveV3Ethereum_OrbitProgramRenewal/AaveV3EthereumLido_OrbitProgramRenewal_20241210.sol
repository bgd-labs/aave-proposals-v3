// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {OrbitProgramRenewalData} from './AaveV3EthereumLido_OrbitProgramRenewalData_20241210.sol';

/**
 * @title Orbit Program Renewal
 * @author ACI
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x60613deb2c662057cc8028b431df84fe6e763d38f48f70594a7cb7fd91a8cb93
 * - Discussion: https://governance.aave.com/t/arfc-orbit-program-renewal-q4-2024/20084
 */
contract AaveV3EthereumLido_OrbitProgramRenewal_20241210 is IProposalGenericExecutor {
  function execute() external {
    address[] memory orbitAddresses = OrbitProgramRenewalData.getOrbitAddresses();

    for (uint256 i = 0; i < orbitAddresses.length; i++) {
      AaveV3EthereumLido.COLLECTOR.transfer(
        AaveV3EthereumLidoAssets.GHO_A_TOKEN,
        orbitAddresses[i],
        OrbitProgramRenewalData.DIRECT_TRANSFER_AMOUNT
      );
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
