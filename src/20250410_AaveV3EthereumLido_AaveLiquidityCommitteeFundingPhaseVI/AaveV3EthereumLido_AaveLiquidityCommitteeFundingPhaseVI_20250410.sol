// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
/**
 * @title Aave Liquidity Committee Funding Phase VI
 * @author TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x2af009587f8c624f798ec36e20572a69be7fc6321882b1ba19143da29d45f1ac
 * - Discussion: https://governance.aave.com/t/arfc-aave-liquidity-committee-funding-phase-vi/21682
 */
contract AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseVI_20250410 is
  IProposalGenericExecutor
{
  // https://etherscan.io/address/0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b
  address public constant ALC_SAFE = 0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b;
  uint256 public constant GHO_ALLOWANCE = 3_500_000e18;

  function execute() external {
    AaveV3EthereumLido.COLLECTOR.approve(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN),
      ALC_SAFE,
      GHO_ALLOWANCE
    );
  }
}
