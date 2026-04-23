// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IWETH} from 'aave-v3-origin/contracts/helpers/interfaces/IWETH.sol';
import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {MiscBase} from 'aave-address-book/MiscBase.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title April Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-april-2026-funding-update/24447
 */
contract AaveV3Base_AprilFundingUpdate_20260423 is IProposalGenericExecutor {
  uint256 public constant WETH_ALLOWANCE = 625 ether;

  function execute() external {
    AaveV3Base.COLLECTOR.approve(
      IERC20(AaveV3BaseAssets.WETH_UNDERLYING),
      MiscBase.AFC_SAFE,
      WETH_ALLOWANCE
    );

    uint256 ethBalance = address(AaveV3Base.COLLECTOR).balance;
    AaveV3Base.COLLECTOR.transfer(
      IERC20(AaveV3Base.COLLECTOR.ETH_MOCK_ADDRESS()),
      address(this),
      ethBalance
    );
    IWETH(AaveV3BaseAssets.WETH_UNDERLYING).deposit{value: ethBalance}();
    IERC20(AaveV3BaseAssets.WETH_UNDERLYING).transfer(address(AaveV3Base.COLLECTOR), ethBalance);
  }
}
