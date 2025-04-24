// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';

/**
 * @title Lower stkABPT Emissions
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x8dbeee9b489266cfefb8cb3c75fb0791d364975eed48cee951ff04fd17ee57c1
 * - Discussion: https://governance.aave.com/t/arfc-stkabpt-emissions-update/21683
 */
contract AaveV3Ethereum_LowerStkABPTEmissions_20250423 is IProposalGenericExecutor {
  uint128 public constant CURRENT_AAVE_EMISSION_PER_SECOND_STK_BPT = uint128(360 ether) / 1 days;
  uint128 public constant AAVE_EMISSION_PER_SECOND_STK_BPT = uint128(240 ether) / 1 days;

  function execute() external {
    uint256 distributionTimeLeft = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .distributionEnd() - block.timestamp;

    // Excess allowance that has not been claimed
    uint256 allowanceToKeep = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      address(MiscEthereum.ECOSYSTEM_RESERVE),
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    ) - (distributionTimeLeft * CURRENT_AAVE_EMISSION_PER_SECOND_STK_BPT);

    uint256 newAllowance = distributionTimeLeft * AAVE_EMISSION_PER_SECOND_STK_BPT;

    IStakeToken.AssetConfigInput[] memory bptConfigs = new IStakeToken.AssetConfigInput[](1);
    bptConfigs[0] = IStakeToken.AssetConfigInput({
      emissionPerSecond: AAVE_EMISSION_PER_SECOND_STK_BPT,
      totalStaked: 0, // it's overwritten internally
      underlyingAsset: AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    });
    IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).configureAssets(bptConfigs);

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
