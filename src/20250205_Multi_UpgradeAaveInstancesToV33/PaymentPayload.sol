// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Payment for audits
 * @author @BGDLabs
 * Reimburse payments done on behalf of the DAO.
 */
contract PaymentPayload is IProposalGenericExecutor {
  address public constant BGD = 0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF;
  uint256 public constant AMOUNT = 66_400e6;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.transfer(AaveV3EthereumAssets.USDC_A_TOKEN, BGD, AMOUNT);
  }
}
