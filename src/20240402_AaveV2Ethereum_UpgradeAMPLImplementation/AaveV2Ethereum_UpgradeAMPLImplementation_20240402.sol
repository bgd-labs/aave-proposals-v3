// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
/**
 * @title Upgrade AMPL implementation
 * @author BGD Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb7226dd6441b67225924082215f7a512bfd98252897ee43a879084e07ab53607
 * - Discussion: https://governance.aave.com/t/arfc-aampl-interim-distribution/17184
 */
contract AaveV2Ethereum_UpgradeAMPLImplementation_20240402 is IProposalGenericExecutor {
  address constant A_TOKEN_IMPL = address(0);

  function execute() external {
    AaveV2Ethereum.POOL_CONFIGURATOR.updateAToken(
      AaveV2EthereumAssets.AMPL_UNDERLYING,
      A_TOKEN_IMPL
    );
  }
}
