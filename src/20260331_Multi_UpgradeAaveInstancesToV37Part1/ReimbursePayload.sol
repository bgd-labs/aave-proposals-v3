// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Upgrade Aave instances to v3.7 Part 1
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.org/#/aavedao.eth/proposal/0x2cdd27eda22b36ddde2303c3d69859f74b330eb93661e632700d18c6095335a8
 * - Discussion: https://governance.aave.com/t/arfc-bgd-aave-v3-7/24075
 */
contract ReimbursePayload is IProposalGenericExecutor {
  address public constant BGD = 0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF;
  address public constant CERTORA = 0x0F11640BF66e2D9352d9c41434A5C6E597c5e4c8;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.transfer(IERC20(AaveV3EthereumAssets.USDT_A_TOKEN), BGD, 62_422e6);
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING),
      CERTORA,
      12_240e18
    );
  }
}
