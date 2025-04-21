// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

import {IStakeToken} from './IStakeToken.sol';

/**
 * @title stkABPT - Emissions Update
 * @author TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x8dbeee9b489266cfefb8cb3c75fb0791d364975eed48cee951ff04fd17ee57c1
 * - Discussion: https://governance.aave.com/t/arfc-stkabpt-emissions-update/21683
 */
contract AaveV3Ethereum_StkABPTEmissionsUpdate_20250417 is IProposalGenericExecutor {
  uint128 public constant AAVE_EMISSION_PER_SECOND_STK_ABPT = uint128(240e18) / 1 days; // 360 AAVE per day

  function execute() external {
    uint256 distributionDuration = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .distributionEnd() - block.timestamp;
    uint256 newAllowance = distributionDuration * AAVE_EMISSION_PER_SECOND_STK_ABPT;

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
