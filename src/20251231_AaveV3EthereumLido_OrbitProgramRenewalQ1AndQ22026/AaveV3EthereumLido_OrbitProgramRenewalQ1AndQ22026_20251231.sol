// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {OrbitProgramData} from './OrbitProgramData.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Orbit Program Renewal - Q1 and Q2 2026
 * @author Aave-chan initiative
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0xdd35aa587c490548ce8ebc6293231718e68d53ded7704f576fd07bcaabe722a8
 * - Discussion: https://governance.aave.com/t/arfc-orbit-program-renewal-q1-and-q2-2026/23695
 */
contract AaveV3EthereumLido_OrbitProgramRenewalQ1AndQ22026_20251231 is IProposalGenericExecutor {
  function execute() external {
    // custom code goes here
    address[] memory orbitAddresses = OrbitProgramData.getOrbitAddresses();
    uint256 orbitAddressesLength = orbitAddresses.length;
    uint256 actualAmount = 0;
    for (uint256 i = 0; i < orbitAddressesLength; i++) {
      if (orbitAddresses[i] == OrbitProgramData.EZREAL) {
        actualAmount = 2 * OrbitProgramData.STREAM_AMOUNT;
      } else {
        actualAmount = OrbitProgramData.STREAM_AMOUNT;
      }
      CollectorUtils.stream(
        AaveV3EthereumLido.COLLECTOR,
        CollectorUtils.CreateStreamInput({
          underlying: AaveV3EthereumLidoAssets.GHO_A_TOKEN,
          receiver: orbitAddresses[i],
          amount: actualAmount,
          start: block.timestamp,
          duration: OrbitProgramData.END_DATE - block.timestamp
        })
      );
    }
  }
}
