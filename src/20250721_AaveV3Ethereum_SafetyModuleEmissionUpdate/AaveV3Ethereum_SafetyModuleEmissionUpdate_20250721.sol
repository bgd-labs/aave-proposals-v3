// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';

/**
 * @title Safety Module Emission Update
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x844e6490591165e166fe511c1c527798369a21394fd93812d299cc320ec91dd5
 * - Discussion: https://governance.aave.com/t/arfc-safety-module-emission-update/22554
 */
contract AaveV3Ethereum_SafetyModuleEmissionUpdate_20250721 is IProposalGenericExecutor {
  // stkAAVE
  uint256 public constant DISTRIBUTION_DURATION = 90 days;
  uint128 public constant AAVE_EMISSION_PER_SECOND_STK_AAVE = uint128(260 ether) / 1 days;

  // stkABPT
  uint128 public constant CURRENT_AAVE_EMISSION_PER_SECOND_STK_BPT = uint128(216 ether) / 1 days;
  uint128 public constant AAVE_EMISSION_PER_SECOND_STK_BPT = uint128(130 ether) / 1 days;

  uint256 public constant NEW_MAX_SLASHING_PCT = 1000;

  function execute() external {
    _stkAAVE();
    _stkABPT();
  }

  function _stkAAVE() internal {
    // Excess allowance that has not been claimed
    uint256 allowanceToKeep = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      address(MiscEthereum.ECOSYSTEM_RESERVE),
      AaveSafetyModule.STK_AAVE
    );

    uint256 newAllowance = DISTRIBUTION_DURATION * AAVE_EMISSION_PER_SECOND_STK_AAVE;

    IStakeToken.AssetConfigInput[] memory bptConfigs = new IStakeToken.AssetConfigInput[](1);
    bptConfigs[0] = IStakeToken.AssetConfigInput({
      emissionPerSecond: AAVE_EMISSION_PER_SECOND_STK_AAVE,
      totalStaked: 0, // it's overwritten internally
      underlyingAsset: AaveSafetyModule.STK_AAVE
    });
    IStakeToken(AaveSafetyModule.STK_AAVE).configureAssets(bptConfigs);
    IStakeToken(AaveSafetyModule.STK_AAVE).setMaxSlashablePercentage(NEW_MAX_SLASHING_PCT);

    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AaveSafetyModule.STK_AAVE,
      0
    );

    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AaveSafetyModule.STK_AAVE,
      newAllowance + allowanceToKeep
    );
  }

  function _stkABPT() internal {
    uint256 distributionTimeLeft = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .distributionEnd() - block.timestamp;

    // Excess allowance that has not been claimed
    uint256 allowanceToKeep = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      address(MiscEthereum.ECOSYSTEM_RESERVE),
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    ) - (distributionTimeLeft * CURRENT_AAVE_EMISSION_PER_SECOND_STK_BPT);

    uint256 newAllowance = DISTRIBUTION_DURATION * AAVE_EMISSION_PER_SECOND_STK_BPT;

    IStakeToken.AssetConfigInput[] memory bptConfigs = new IStakeToken.AssetConfigInput[](1);
    bptConfigs[0] = IStakeToken.AssetConfigInput({
      emissionPerSecond: AAVE_EMISSION_PER_SECOND_STK_BPT,
      totalStaked: 0, // it's overwritten internally
      underlyingAsset: AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    });
    IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).configureAssets(bptConfigs);
    IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).setDistributionEnd(
      block.timestamp + DISTRIBUTION_DURATION
    );
    IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).setMaxSlashablePercentage(
      NEW_MAX_SLASHING_PCT
    );

    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2,
      0
    );

    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2,
      newAllowance + allowanceToKeep
    );
  }
}
