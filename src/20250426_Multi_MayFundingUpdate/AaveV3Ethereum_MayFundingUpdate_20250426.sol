// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
/**
 * @title May Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: TODO
 */
contract AaveV3Ethereum_MayFundingUpdate_20250426 is IProposalGenericExecutor {
  address public constant AAVE_FINANCE_COMMITEE = 0x22740deBa78d5a0c24C58C740e3715ec29de1bFa;
  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;

  uint256 public constant USDT_BUYBACK_AMOUNT = 3_000_000e6;
  uint256 public constant USDC_BUYBACK_AMOUNT = 3_000_000e6;

  function execute() external {
    _aaveBuybackAllowance();
  }

  function _aaveBuybackAllowance() internal {
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN),
      AAVE_FINANCE_COMMITEE,
      USDT_BUYBACK_AMOUNT
    );
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN),
      AAVE_FINANCE_COMMITEE,
      USDC_BUYBACK_AMOUNT
    );
  }
}
