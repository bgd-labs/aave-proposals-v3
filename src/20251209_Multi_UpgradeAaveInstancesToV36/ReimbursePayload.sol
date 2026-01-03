// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Reimbursement for v3.6 audits
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/arfc-bgd-aave-v3-6/23172
 */
contract ReimbursePayload is IProposalGenericExecutor {
  address public constant CERTORA = 0x0F11640BF66e2D9352d9c41434A5C6E597c5e4c8;
  address public constant BGD = 0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF;

  function execute() external override {
    AaveV3Ethereum.COLLECTOR.transfer(IERC20(AaveV3EthereumAssets.USDT_A_TOKEN), BGD, 113_752e6);

    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING),
      CERTORA,
      30_400e18
    );
  }
}
