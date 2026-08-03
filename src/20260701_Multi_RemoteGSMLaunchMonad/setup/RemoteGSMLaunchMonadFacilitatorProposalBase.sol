// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SafeCast} from 'openzeppelin-contracts/contracts/utils/math/SafeCast.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';

import {RemoteGSMLaunchMonadSetup} from './RemoteGSMLaunchMonadSetup.sol';

/**
 * @title Remote GSM Launch: Monad
 * @author TokenLogic
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0x24f105bd023c476a9b85fa87ff795bfeec769fa799ce6ada8e2724c9738049f6
 * - Discussion: https://governance.aave.com/t/arfc-deploy-aave-protocol-v3-7-on-monad/24943
 */
abstract contract RemoteGSMLaunchMonadFacilitatorProposalBase is IProposalGenericExecutor {
  using SafeCast for uint256;

  function GHO_TOKEN() public view virtual returns (address);

  function GHO_CCIP_TOKEN_POOL() public view virtual returns (address);

  function execute() external {
    IGhoToken gho = IGhoToken(GHO_TOKEN());
    address ghoCcipTokenPool = GHO_CCIP_TOKEN_POOL();

    // Increase bucket capacity to allow token movements to this network, accounting for the extra
    // supply minted on Ethereum and initially bridged to Monad in this proposal.
    (uint256 currentFacilitatorBucketCapacity, ) = gho.getFacilitatorBucket(ghoCcipTokenPool);

    gho.setFacilitatorBucketCapacity(
      ghoCcipTokenPool,
      currentFacilitatorBucketCapacity.toUint128() +
        RemoteGSMLaunchMonadSetup.GHO_BRIDGE_AMOUNT.toUint128()
    );
  }
}
