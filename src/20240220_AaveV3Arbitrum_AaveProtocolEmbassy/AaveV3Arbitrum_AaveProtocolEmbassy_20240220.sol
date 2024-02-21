// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Aave Protocol Embassy
 * @author karpatkey_TokenLogic_ACI
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xe9da0e50526a98a55aae743f44afc21a86076a12184a6c6c9022aa63dcb0be73
 * - Discussion: https://governance.aave.com/t/arfc-establishing-the-aave-protocol-embassy-ape/16445
 */
contract AaveV3Arbitrum_AaveProtocolEmbassy_20240220 is IProposalGenericExecutor {
  address public constant SAFE = 0xa9e777D56C0Ad861f6a03967E080e767ad8D39b6;

  function execute() external {
    AaveV3Arbitrum.COLLECTOR.transfer(
      AaveV3ArbitrumAssets.ARB_UNDERLYING,
      SAFE,
      IERC20(AaveV3ArbitrumAssets.ARB_UNDERLYING).balanceOf(address(AaveV3Arbitrum.COLLECTOR))
    );
  }
}
