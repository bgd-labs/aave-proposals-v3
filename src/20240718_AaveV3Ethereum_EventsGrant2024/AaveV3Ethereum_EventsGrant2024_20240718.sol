// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Events Grant 2024
 * @author Aave Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x5d4e3fba58f76f516afd0855a687027270b74163911116f14a4f5c01c34a9bd9
 * - Discussion: https://governance.aave.com/t/arfc-aave-events-sponsorship-proposal-2024/18276
 */
contract AaveV3Ethereum_EventsGrant2024_20240718 is IProposalGenericExecutor {
  address public constant AAVE_LABS = 0x1c037b3C22240048807cC9d7111be5d455F640bd;
  uint256 public constant GHO_GRANT_AMOUNT = 650_000 ether;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AAVE_LABS,
      GHO_GRANT_AMOUNT
    );
  }
}
