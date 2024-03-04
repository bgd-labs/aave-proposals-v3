// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

import {IStakeToken} from './IStakeToken.sol';

/**
 * @title Amend Safety Module Emissions
 * @author karpatkey_TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x0f73500d0f65c72482d352080ea9aa0aa92264eb059b8f646cf6f0e86556bc3d
 * - Discussion: https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640
 */
contract AaveV3Ethereum_AmendSafetyModuleEmissions_20240229 is IProposalGenericExecutor {
  uint128 public constant AAVE_EMISSION_PER_SECOND_STK_GHO = uint128(100e18) / 1 days; // 100 AAVE per day
  uint128 public constant AAVE_EMISSION_PER_SECOND_STK_AAVE = uint128(360e18) / 1 days; // 360 AAVE per day
  uint128 public constant AAVE_EMISSION_PER_SECOND_STK_ABPT = uint128(360e18) / 1 days; // 360 AAVE per day

  function execute() external {
    uint256 currentAllowance = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveSafetyModule.STK_GHO
    );

    uint256 distributionDuration = IStakeToken(AaveSafetyModule.STK_GHO).distributionEnd() -
      block.timestamp;
    (uint128 emissionPerSecond, , ) = IStakeToken(AaveSafetyModule.STK_GHO).assets(
      AaveSafetyModule.STK_GHO
    );
    uint256 newAllowance = currentAllowance +
      distributionDuration *
      (AAVE_EMISSION_PER_SECOND_STK_GHO - emissionPerSecond);

    // stkGHO
    IStakeToken.AssetConfigInput[] memory ghoConfigs = new IStakeToken.AssetConfigInput[](1);
    ghoConfigs[0] = IStakeToken.AssetConfigInput({
      emissionPerSecond: AAVE_EMISSION_PER_SECOND_STK_GHO,
      totalStaked: 0, // it's overwritten internally
      underlyingAsset: AaveSafetyModule.STK_GHO
    });
    IStakeToken(AaveSafetyModule.STK_GHO).configureAssets(ghoConfigs);

    // stkAAVE
    IStakeToken.AssetConfigInput[] memory aaveConfigs = new IStakeToken.AssetConfigInput[](1);
    aaveConfigs[0] = IStakeToken.AssetConfigInput({
      emissionPerSecond: AAVE_EMISSION_PER_SECOND_STK_AAVE,
      totalStaked: 0, // it's overwritten internally
      underlyingAsset: AaveSafetyModule.STK_AAVE
    });
    IStakeToken(AaveSafetyModule.STK_AAVE).configureAssets(aaveConfigs);

    // stkABPT
    IStakeToken.AssetConfigInput[] memory abptConfigs = new IStakeToken.AssetConfigInput[](1);
    abptConfigs[0] = IStakeToken.AssetConfigInput({
      emissionPerSecond: AAVE_EMISSION_PER_SECOND_STK_ABPT,
      totalStaked: 0, // it's overwritten internally
      underlyingAsset: AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    });
    IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).configureAssets(abptConfigs);

    // Allowance for stkGHO to pull funds
    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AaveSafetyModule.STK_GHO,
      0
    );

    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AaveSafetyModule.STK_GHO,
      newAllowance
    );
  }
}
