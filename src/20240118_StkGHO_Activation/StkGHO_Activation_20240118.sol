// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IStakeToken} from './IStakeToken.sol';

/**
 * @title StkGHO Activation
 * @author the3d.eth
 * - Snapshot: 'https://snapshot.org/#/aave.eth/proposal/0x4bc99a842adab6cdd8c7d5c7a787ee4c0056be554fde0d008d53b45b3e795065
 * - Discussion: https://governance.aave.com/t/arfc-upgrade-safety-module-with-stkgho/15635
 */
contract StkGHO_Activation_20240118 is IProposalGenericExecutor {
  uint256 public constant STKGHO_EMISSION_PER_SECOND = 578703703703704; // 50 AAVE/day
  uint256 public constant DISTRIBUTION_DURATION = 90 days; // three months
  address public constant STKGHO_PROXY = 0x1a88Df1cFe15Af22B3c4c783D4e6F7F9e0C1885d;

  function execute() external {
    IStakeToken(STKGHO_PROXY).setDistributionEnd(block.timestamp + DISTRIBUTION_DURATION);

    IStakeToken.AssetConfigInput[] memory enableConfigs = new IStakeToken.AssetConfigInput[](1);
    enableConfigs[0] = IStakeToken.AssetConfigInput({
      emissionPerSecond: uint128(STKGHO_EMISSION_PER_SECOND),
      totalStaked: 0, // it's overwritten internally
      underlyingAsset: AaveV3Ethereum.GHO_TOKEN
    });

    IStakeToken(STKGHO_PROXY).configureAssets(enableConfigs);

    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      STKGHO_PROXY,
      STKGHO_EMISSION_PER_SECOND * DISTRIBUTION_DURATION
    );
  }
}
