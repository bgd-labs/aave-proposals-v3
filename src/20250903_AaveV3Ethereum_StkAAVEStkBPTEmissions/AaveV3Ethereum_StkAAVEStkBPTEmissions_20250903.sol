// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';

/**
 * @title stkAAVE + stkBPT Emissions
 * @author @TokenLogic
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Ethereum_StkAAVEStkBPTEmissions_20250903 is IProposalGenericExecutor {
  uint256 public constant DISTRIBUTION_DURATION = 90 days;
  uint128 public constant AAVE_EMISSION_PER_SECOND_STK_BPT = uint128(240 ether) / 1 days;
  uint128 public constant AAVE_EMISSION_PER_SECOND_STK_AAVE = uint128(360 ether) / 1 days;
  uint256 public constant TOTAL_ALLOWANCE = (DISTRIBUTION_DURATION *
    AAVE_EMISSION_PER_SECOND_STK_AAVE);

  function execute() external {
    uint256 remainingAllowance = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      address(MiscEthereum.ECOSYSTEM_RESERVE),
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    );

    uint256 newAllowance = DISTRIBUTION_DURATION *
      AAVE_EMISSION_PER_SECOND_STK_BPT +
      remainingAllowance;

    // configure with same settings to update internal state
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

    // Approval needs to be reset in order to increase it
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
      newAllowance
    );

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
      TOTAL_ALLOWANCE
    );
  }
}
