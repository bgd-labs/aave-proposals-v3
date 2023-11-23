// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Transfer AURA to GLC Safe
 * @author efecarranza.eth
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Ethereum_TransferAURAToGLCSafe_20231123 is IProposalGenericExecutor {
  address public constant AURA = 0xC0c293ce456fF0ED870ADd98a0828Dd4d2903DBF;
  address public constant GLC_SAFE = 0x205e795336610f5131Be52F09218AF19f0f3eC60;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.transfer(AURA, GLC_SAFE, IERC20(AURA).balanceOf(address(AaveV3Ethereum.COLLECTOR)));
  }
}
