// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title UmbrellaActivation
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xbe792a1db33cd7803e23810553e5a6a728c3ac15827ad2652aa6de1858fa5596
 * - Discussion: https://governance.aave.com/t/arfc-aave-umbrella-activation/21521
 * @notice This payload decreases rewards distribution for the legacy stkTokens.
 */
contract AaveV3Ethereum_SafetyModuleRewardsDecrease_20250515 is IProposalGenericExecutor {
  uint128 public constant CURRENT_AAVE_EMISSION_PER_SECOND_AAVE = uint128(360 ether) / 1 days;
  uint128 public constant AAVE_EMISSION_PER_SECOND_AAVE = uint128(315 ether) / 1 days;

  uint128 public constant CURRENT_AAVE_EMISSION_PER_SECOND_STK_BPT = uint128(240 ether) / 1 days;
  uint128 public constant AAVE_EMISSION_PER_SECOND_STK_BPT = uint128(216 ether) / 1 days;

  uint128 public constant CURRENT_AAVE_EMISSION_PER_SECOND_GHO = uint128(100 ether) / 1 days;
  uint128 public constant AAVE_EMISSION_PER_SECOND_GHO = uint128(0);

  uint256 public constant STK_AAVE_MAX_SLASHABLE_PERCENTAGE = 20_00;
  uint256 public constant STK_BPT_MAX_SLASHABLE_PERCENTAGE = 20_00;

  function execute() external {
    _decreaseAaveEmission(
      AaveSafetyModule.STK_AAVE,
      CURRENT_AAVE_EMISSION_PER_SECOND_AAVE,
      AAVE_EMISSION_PER_SECOND_AAVE
    );
    _decreaseAaveEmission(
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2,
      CURRENT_AAVE_EMISSION_PER_SECOND_STK_BPT,
      AAVE_EMISSION_PER_SECOND_STK_BPT
    );
    _decreaseAaveEmission(
      AaveSafetyModule.STK_GHO,
      CURRENT_AAVE_EMISSION_PER_SECOND_GHO,
      AAVE_EMISSION_PER_SECOND_GHO
    );

    // Decrease `maxSlashablePercentage` to 20%
    IStakeToken(AaveSafetyModule.STK_AAVE).setMaxSlashablePercentage(
      STK_AAVE_MAX_SLASHABLE_PERCENTAGE
    );
    IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).setMaxSlashablePercentage(
      STK_BPT_MAX_SLASHABLE_PERCENTAGE
    );

    // Since Emission will be zero for StkGho, there's no sense not to end distribution at all
    IStakeToken(AaveSafetyModule.STK_GHO).setDistributionEnd(block.timestamp);
    // Set `maxSlashablePercentage` and `cooldown` to zero
    IStakeToken(AaveSafetyModule.STK_GHO).setMaxSlashablePercentage(0);
    IStakeToken(AaveSafetyModule.STK_GHO).setCooldownSeconds(0);
  }

  function _decreaseAaveEmission(
    address legacyStkToken,
    uint128 currentEmission,
    uint128 newEmission
  ) internal {
    uint256 newAllowance;

    if (legacyStkToken == AaveSafetyModule.STK_AAVE) {
      // stkAave rewards were extended just before `UmbrellaActivation` payload for 90 days with 360 Aave/day
      // If we leave as it's, then with new rate (315) this will result in +- 102 days, which is fine
      // so we wont update allowance in this case
    } else {
      // Both other legacy stk have not infinite `distributionEnd` and their distributions haven't skipped yet
      uint256 distributionTimeLeft = IStakeToken(legacyStkToken).distributionEnd() -
        block.timestamp;

      // Excess allowance that has not been claimed
      uint256 allowanceToKeep = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
        address(MiscEthereum.ECOSYSTEM_RESERVE),
        legacyStkToken
      ) - (distributionTimeLeft * currentEmission);

      newAllowance = allowanceToKeep + distributionTimeLeft * newEmission;

      MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
        MiscEthereum.ECOSYSTEM_RESERVE,
        AaveV3EthereumAssets.AAVE_UNDERLYING,
        legacyStkToken,
        0
      );

      MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
        MiscEthereum.ECOSYSTEM_RESERVE,
        AaveV3EthereumAssets.AAVE_UNDERLYING,
        legacyStkToken,
        newAllowance
      );
    }

    IStakeToken.AssetConfigInput[] memory stkConfigs = new IStakeToken.AssetConfigInput[](1);
    stkConfigs[0] = IStakeToken.AssetConfigInput({
      emissionPerSecond: newEmission,
      totalStaked: 0, // it's overwritten internally
      underlyingAsset: legacyStkToken
    });

    IStakeToken(legacyStkToken).configureAssets(stkConfigs);
  }
}
