// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';

/**
 * @title Claiming AAVE Rewards for the Sablier Legacy v1.1 Contract
 * @author Aave-Chan Initiative
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/arfc-claiming-aave-rewards-for-the-sablier-legacy-v1-1-contract/21975
 */
contract AaveV3Ethereum_ClaimingAAVERewardsForTheSablierLegacyV11Contract_20250728 is
  IProposalGenericExecutor
{
  address public constant SABLIER_LEGACY = 0xCD18eAa163733Da39c232722cBC4E8940b1D8888;
  address public constant SABLIER_RECEIVER = 0x5cE95bff1297dADBDcF9929a10Bd02BDfab0DCC6;

  function execute() external {
    IStakeToken(AaveSafetyModule.STK_AAVE).claimRewardsOnBehalf(
      SABLIER_LEGACY,
      SABLIER_RECEIVER,
      type(uint256).max
    );
  }
}
