// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_ClaimingAAVERewardsForTheSablierLegacyV11Contract_20250728} from './AaveV3Ethereum_ClaimingAAVERewardsForTheSablierLegacyV11Contract_20250728.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

/**
 * @dev Test for AaveV3Ethereum_ClaimingAAVERewardsForTheSablierLegacyV11Contract_20250728
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250728_AaveV3Ethereum_ClaimingAAVERewardsForTheSablierLegacyV11Contract/AaveV3Ethereum_ClaimingAAVERewardsForTheSablierLegacyV11Contract_20250728.t.sol -vv
 */
contract AaveV3Ethereum_ClaimingAAVERewardsForTheSablierLegacyV11Contract_20250728_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_ClaimingAAVERewardsForTheSablierLegacyV11Contract_20250728 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23018377);
    proposal = new AaveV3Ethereum_ClaimingAAVERewardsForTheSablierLegacyV11Contract_20250728();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_ClaimingAAVERewardsForTheSablierLegacyV11Contract_20250728',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_transferAmount() public {
    IStakeToken stakeAave = IStakeToken(AaveSafetyModule.STK_AAVE);
    IERC20 aaveToken = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING);

    uint256 ownedBefore = stakeAave.stakerRewardsToClaim(proposal.SABLIER_LEGACY());
    uint256 balanceBefore = aaveToken.balanceOf(proposal.SABLIER_RECEIVER());

    executePayload(vm, address(proposal));

    uint256 ownedAfter = stakeAave.stakerRewardsToClaim(proposal.SABLIER_LEGACY());
    uint256 balanceAfter = aaveToken.balanceOf(proposal.SABLIER_RECEIVER());

    assertEq(ownedAfter, 0, "token left to claim");
    assertEq(ownedBefore, balanceAfter - balanceBefore, "improper amount of reward were transfered");
  }
}
