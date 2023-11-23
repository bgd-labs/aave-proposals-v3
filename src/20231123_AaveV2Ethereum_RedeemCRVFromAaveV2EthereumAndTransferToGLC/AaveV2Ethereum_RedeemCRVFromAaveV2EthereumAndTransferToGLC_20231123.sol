// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Redeem CRV from AaveV2Ethereum and Transfer to GLC
 * @author efecarranza.eth
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV2Ethereum_RedeemCRVFromAaveV2EthereumAndTransferToGLC_20231123 is
  IProposalGenericExecutor
{
  address public constant GLC_SAFE = 0x205e795336610f5131Be52F09218AF19f0f3eC60;

  function execute() external {
    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.CRV_A_TOKEN,
      address(this),
      IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR))
    );

    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.CRV_UNDERLYING,
      address(this),
      IERC20(AaveV2EthereumAssets.CRV_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR))
    );

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.CRV_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    IERC20(AaveV2EthereumAssets.CRV_UNDERLYING).transfer(
      GLC_SAFE,
      IERC20(AaveV2EthereumAssets.CRV_UNDERLYING).balanceOf(address(this))
    );
  }
}
