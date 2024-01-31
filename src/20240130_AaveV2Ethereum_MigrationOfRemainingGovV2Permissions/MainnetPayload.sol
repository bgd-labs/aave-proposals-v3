// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {ParaswapClaim, ParaswapClaimer} from './ParaswapClaim.sol';

interface IAaveArcTimelock {
  function queue(
    address[] memory targets,
    uint256[] memory values,
    string[] memory signatures,
    bytes[] memory calldatas,
    bool[] memory withDelegatecalls
  ) external;

  function getActionsSetCount() external view returns (uint256);

  function execute(uint256 actionsSetId) external;

  function getEthereumGovernanceExecutor() external view returns (address);
}

/**
 * @title MainnetPayload
 * @author BGD Labs @bgdlabs
 * @notice Aave governance payload to claim rewards accrued as positive slippage on paraswap to the ethereum collector.
 * @notice Also migrates aave arc permissions from old governance v2 short executor, to the governance v3 executor.
 */
contract MainnetPayload is IProposalGenericExecutor, ParaswapClaim {
  function execute() external override {
    // paraswap
    address[] memory tokens = AaveV2Ethereum.POOL.getReservesList();
    claim(
      ParaswapClaimer.ETHEREUM,
      AaveGovernanceV2.SHORT_EXECUTOR,
      address(AaveV2Ethereum.COLLECTOR),
      tokens
    );

    // arc
    address[] memory targets = new address[](1);
    targets[0] = AaveGovernanceV2.ARC_TIMELOCK;
    uint256[] memory values = new uint256[](1);
    values[0] = 0;
    string[] memory signatures = new string[](1);
    signatures[0] = 'updateEthereumGovernanceExecutor(address)';
    bytes[] memory calldatas = new bytes[](1);
    calldatas[0] = abi.encode(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    bool[] memory withDelegatecalls = new bool[](1);
    withDelegatecalls[0] = true;

    // create payload for arc timelock
    IAaveArcTimelock(AaveGovernanceV2.ARC_TIMELOCK).queue(
      targets,
      values,
      signatures,
      calldatas,
      withDelegatecalls
    );
  }
}
