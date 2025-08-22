// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';

import {IGhoToken} from './interfaces/IGhoToken.sol';
import {IGhoDirectMinter} from './interfaces/IGhoDirectMinter.sol';
import {IGhoBucketSteward} from './interfaces/IGhoBucketSteward.sol';

/**
 * @title GHO facilitator replacement
 * @author BGD Labs @bgdlabs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Ethereum_GHOFacilitatorReplacement_20250821 is IProposalGenericExecutor {
  address public constant OLD_FACILITATOR = 0x593B09afc075B3c326CE2AD7750888645BA8943d;

  address public constant NEW_FACILITATOR = 0x5513224daaEABCa31af5280727878d52097afA05;

  function execute() external {
    (uint256 capacityFromOldFacilitator, uint256 levelFromOldFacilitator) = IGhoToken(
      AaveV3EthereumAssets.GHO_UNDERLYING
    ).getFacilitatorBucket(OLD_FACILITATOR);

    // grant roles to the new facilitator
    AaveV3Ethereum.ACL_MANAGER.addRiskAdmin(NEW_FACILITATOR);
    IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).addFacilitator({
      facilitatorAddress: NEW_FACILITATOR,
      facilitatorLabel: 'CoreGhoDirectMinter',
      bucketCapacity: uint128(capacityFromOldFacilitator)
    });

    // mint GHO to the new facilitator
    IGhoDirectMinter(NEW_FACILITATOR).mintAndSupply(levelFromOldFacilitator);

    // withdraw GHO from the old facilitator
    IGhoDirectMinter(OLD_FACILITATOR).withdrawAndBurn(levelFromOldFacilitator);
    IGhoDirectMinter(OLD_FACILITATOR).transferExcessToTreasury();

    // revoke roles from the old facilitator
    IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).removeFacilitator(OLD_FACILITATOR);
    AaveV3Ethereum.ACL_MANAGER.removeRiskAdmin(OLD_FACILITATOR);

    address[] memory vaults = new address[](1);
    vaults[0] = NEW_FACILITATOR;
    IGhoBucketSteward(GhoEthereum.GHO_BUCKET_STEWARD).setControlledFacilitator(vaults, true);
    vaults[0] = OLD_FACILITATOR;
    IGhoBucketSteward(GhoEthereum.GHO_BUCKET_STEWARD).setControlledFacilitator(vaults, false);
  }
}
