// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import {OrbitProgramData} from './OrbitProgramData.sol';

// Helper interface to withdraw ETH
interface IWETH {
  function withdraw(uint256) external;
}

/**
 * @title Orbit Program Renewal - Q3 2024
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xea325542397fce607755f6c14be407f60a71a81f3a23c6b3a67e298b9dd8c091
 * - Discussion: https://governance.aave.com/t/arfc-orbit-program-renewal-q3-2024/18834
 */
contract AaveV3Ethereum_OrbitProgramRenewalQ32024_20240905 is IProposalGenericExecutor {
  error EthTransferFailed(address account);

  function execute() external {
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.WETH_UNDERLYING,
      address(this),
      OrbitProgramData.TOTAL_WETH_REBATE
    );

    IWETH(AaveV3EthereumAssets.WETH_UNDERLYING).withdraw(OrbitProgramData.TOTAL_WETH_REBATE);

    OrbitProgramData.GasUsage[] memory usage = OrbitProgramData.getGasUsageData();
    uint256 usageLength = usage.length;
    for (uint256 i = 0; i < usageLength; i++) {
      (bool ok, ) = usage[i].account.call{value: usage[i].usage}('');
      if (!ok) revert EthTransferFailed(usage[i].account);
    }

    address[] memory orbitAddresses = OrbitProgramData.getOrbitAddresses();
    uint256 orbitAddressesLength = orbitAddresses.length;
    for (uint256 i = 0; i < orbitAddressesLength; i++) {
      AaveV3Ethereum.COLLECTOR.transfer(
        AaveV3EthereumAssets.GHO_UNDERLYING,
        orbitAddresses[i],
        OrbitProgramData.OVERDUE_AMOUNT
      );
      CollectorUtils.stream(
        AaveV3Ethereum.COLLECTOR,
        CollectorUtils.CreateStreamInput({
          underlying: AaveV3EthereumAssets.GHO_UNDERLYING,
          receiver: orbitAddresses[i],
          amount: OrbitProgramData.STREAM_AMOUNT,
          start: block.timestamp,
          duration: OrbitProgramData.STREAM_DURATION
        })
      );
    }
  }

  receive() external payable {}
}
