// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

interface IAaveOpEthERC20Bridge {
  function bridge(address token, address l1Token, uint256 amount) external;
}

/**
 * @title May Funding Update
 * @author karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-may-funding-update/17768
 */
contract AaveV3Optimism_MayFundingUpdate_20240603 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  IAaveOpEthERC20Bridge public constant BRIDGE =
    IAaveOpEthERC20Bridge(0xc3250A20F8a7BbDd23adE87737EE46A45Fe5543E);

  function execute() external {
    AaveV3Optimism.COLLECTOR.transfer(
      AaveV3OptimismAssets.USDC_UNDERLYING,
      address(BRIDGE),
      IERC20(AaveV3OptimismAssets.USDC_UNDERLYING).balanceOf(address(AaveV3Optimism.COLLECTOR))
    );

    AaveV3Optimism.COLLECTOR.transfer(
      AaveV3OptimismAssets.USDC_A_TOKEN,
      address(this),
      IERC20(AaveV3OptimismAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Optimism.COLLECTOR)) - 1e6
    );

    AaveV3Optimism.POOL.withdraw(
      AaveV3OptimismAssets.USDC_UNDERLYING,
      type(uint256).max,
      address(BRIDGE)
    );

    uint256 usdcBalance = IERC20(AaveV3OptimismAssets.USDC_UNDERLYING).balanceOf(address(BRIDGE));

    BRIDGE.bridge(
      AaveV3OptimismAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      usdcBalance
    );
  }
}
