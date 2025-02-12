// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';

/**
 * @title stkBPT Incentives
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640/13
 */
contract AaveV3Ethereum_StkBPTIncentives_20250210 is IProposalGenericExecutor {
  uint256 public constant DISTRIBUTION_DURATION = 180 days;
  uint128 public constant AAVE_EMISSION_PER_SECOND_STK_BPT = uint128(360 ether) / 1 days;

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
  }
}
