// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Safety Module Emissions Update
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640/26
 */
contract AaveV3Ethereum_SafetyModuleEmissionsUpdate_20251029 is IProposalGenericExecutor {
  uint256 public constant DISTRIBUTION_DURATION = 90 days;

  // stkAAVE
  uint128 public constant AAVE_EMISSION_PER_SECOND_STK_AAVE = uint128(260 ether) / 1 days;

  // stkABPT
  uint128 public constant AAVE_EMISSION_PER_SECOND_STK_BPT = uint128(130 ether) / 1 days;

  // stkABPT_V1
  uint256 public constant STK_BPT_V1_ALLOWANCE = 1_000 ether;

  function execute() external {
    _stkAAVE();
    _stkABPT();
    _stkABPT_V1();
  }

  function _stkAAVE() internal {
    // Excess allowance that has not been claimed
    uint256 allowanceToKeep = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      address(MiscEthereum.ECOSYSTEM_RESERVE),
      AaveSafetyModule.STK_AAVE
    );

    uint256 newAllowance = DISTRIBUTION_DURATION * AAVE_EMISSION_PER_SECOND_STK_AAVE;

    IStakeToken.AssetConfigInput[] memory config = new IStakeToken.AssetConfigInput[](1);
    config[0] = IStakeToken.AssetConfigInput({
      emissionPerSecond: AAVE_EMISSION_PER_SECOND_STK_AAVE,
      totalStaked: 0, // it's overwritten internally
      underlyingAsset: AaveSafetyModule.STK_AAVE
    });
    IStakeToken(AaveSafetyModule.STK_AAVE).configureAssets(config);

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
    uint256 newAllowance = DISTRIBUTION_DURATION * AAVE_EMISSION_PER_SECOND_STK_BPT;

    // Excess allowance that has not been claimed
    uint256 allowanceToKeep = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      address(MiscEthereum.ECOSYSTEM_RESERVE),
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    );

    IStakeToken.AssetConfigInput[] memory config = new IStakeToken.AssetConfigInput[](1);
    config[0] = IStakeToken.AssetConfigInput({
      emissionPerSecond: AAVE_EMISSION_PER_SECOND_STK_BPT,
      totalStaked: 0, // it's overwritten internally
      underlyingAsset: AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    });
    IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).configureAssets(config);
    IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).setDistributionEnd(
      block.timestamp + DISTRIBUTION_DURATION
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

  function _stkABPT_V1() internal {
    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AaveSafetyModule.STK_ABPT,
      0
    );

    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AaveSafetyModule.STK_ABPT,
      STK_BPT_V1_ALLOWANCE
    );
  }
}
