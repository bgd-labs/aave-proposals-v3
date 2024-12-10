// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {OrbitProgramRenewalData} from './AaveV3Ethereum_OrbitProgramRenewalData_20241210.sol';

/**
 * @title Orbit Program Renewal
 * @author ACI
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x60613deb2c662057cc8028b431df84fe6e763d38f48f70594a7cb7fd91a8cb93
 * - Discussion: https://governance.aave.com/t/arfc-orbit-program-renewal-q4-2024/20084
 */
contract AaveV3Ethereum_OrbitProgramRenewal_20241210 is IProposalGenericExecutor {
  function execute() external {
    address[] memory orbitAddresses = OrbitProgramRenewalData.getOrbitAddresses();

    for (uint256 i = 0; i < orbitAddresses.length; i++) {
      AaveV3Ethereum.COLLECTOR.transfer(
        AaveV3EthereumAssets.GHO_UNDERLYING,
        orbitAddresses[i],
        OrbitProgramRenewalData.DIRECT_TRANSFER_AMOUNT
      );
      CollectorUtils.stream(
        AaveV3Ethereum.COLLECTOR,
        CollectorUtils.CreateStreamInput({
          underlying: AaveV3EthereumAssets.GHO_UNDERLYING,
          receiver: orbitAddresses[i],
          amount: OrbitProgramRenewalData.STREAM_AMOUNT,
          start: block.timestamp,
          duration: OrbitProgramRenewalData.STREAM_DURATION
        })
      );
    }
  }
}
