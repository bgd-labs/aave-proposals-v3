// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
/**
 * @title Gho Steward CCIP Extension
 * @author Aave Labs
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/arfc-extend-gho-stewards-to-arbitrum/18298
 */
contract AaveV3Arbitrum_GhoStewardCCIPExtension_20240726 is IProposalGenericExecutor {
  function execute() external {
    // Existing remote pool
    UpgradeableBurnMintTokenPool remotePool = UpgradeableBurnMintTokenPool(
      0xF168B83598516A532a85995b52504a2Fa058C068
    );
    // TODO: Get address
    // Assume new implementation deployed
    UpgradeableBurnMintTokenPool tokenPoolImpl = UpgradeableBurnMintTokenPool(
      0x1F168B83598516A532a85995b52504a2Fa058C068
    );

    // Upgrade remote pool to new implementation
    TransparentUpgradeableProxy(payable(address(remotePool))).upgradeTo(address(tokenPoolImpl));

    // TODO: Grant appropriate access to remote pool

    // TODO: Deploy steward(s)

    // TODO: Grant ratelimitadmin to appropriate steward
  }
}
