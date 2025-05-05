// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title stkGHO Emissions
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640/18
 */
contract AaveV3Ethereum_StkGHOEmissions_20250505 is IProposalGenericExecutor {
  uint256 public constant DISTRIBUTION_DURATION = 180 days;
  uint128 public constant AAVE_EMISSION_PER_SECOND_STK_GHO = uint128(100 ether) / 1 days;

  function execute() external {
    uint256 remainingAllowance = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      address(MiscEthereum.ECOSYSTEM_RESERVE),
      AaveSafetyModule.STK_GHO
    );

    uint256 newAllowance = DISTRIBUTION_DURATION *
      AAVE_EMISSION_PER_SECOND_STK_GHO +
      remainingAllowance;

    IStakeToken.AssetConfigInput[] memory config = new IStakeToken.AssetConfigInput[](1);
    config[0] = IStakeToken.AssetConfigInput({
      emissionPerSecond: AAVE_EMISSION_PER_SECOND_STK_GHO,
      totalStaked: 0, // it's overwritten internally
      underlyingAsset: AaveSafetyModule.STK_GHO
    });
    IStakeToken(AaveSafetyModule.STK_GHO).configureAssets(config);

    IStakeToken(AaveSafetyModule.STK_GHO).setDistributionEnd(
      block.timestamp + DISTRIBUTION_DURATION
    );

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
