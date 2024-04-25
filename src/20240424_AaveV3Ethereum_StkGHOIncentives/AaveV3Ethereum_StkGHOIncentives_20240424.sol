// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

import {IStakeToken} from './IStakeToken.sol';

/**
 * @title stkGHO Incentives
 * @author karpatkey_TokenLogic_ACI
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x0f73500d0f65c72482d352080ea9aa0aa92264eb059b8f646cf6f0e86556bc3d
 * - Discussion: https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640
 */
contract AaveV3Ethereum_StkGHOIncentives_20240424 is IProposalGenericExecutor {
  uint256 public constant DISTRIBUTION_DURATION = 180 days;
  uint128 public constant AAVE_EMISSION_PER_SECOND_STK_GHO = uint128(100e18) / 1 days;
  address public constant MERIT_WALLET = 0xdeadD8aB03075b7FBA81864202a2f59EE25B312b;

  function execute() external {
    IStakeToken(AaveSafetyModule.STK_GHO).setDistributionEnd(
      block.timestamp + DISTRIBUTION_DURATION
    );

    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AaveSafetyModule.STK_GHO,
      0
    );

    uint256 remainingAllowance = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      address(MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER),
      AaveSafetyModule.STK_GHO
    );

    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AaveSafetyModule.STK_GHO,
      remainingAllowance + (AAVE_EMISSION_PER_SECOND_STK_GHO * DISTRIBUTION_DURATION)
    );

    // Allowance of 700 AAVE to Merit to compensate missed stkGHO rewards
    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      MERIT_WALLET,
      700 ether
    );
  }
}
