// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {ProxyAdmin, ITransparentUpgradeableProxy} from 'openzeppelin-contracts/contracts/proxy/transparent/ProxyAdmin.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {LendToAaveMigrator, IERC20} from './LendToAaveMigrator/src/contracts/LendToAaveMigrator.sol';

/**
 * @title Winding down Lend Migration Contract
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0x4d9eb143c46a637dbf98d63ad00a6e53739a9b6affc0eed7d3cd35680500afaa
 * - Discussion: https://governance.aave.com/t/arfc-winding-down-lend-migration-contract/23126
 */
contract AaveV2Ethereum_WindingDownLendMigrationContract_20251126 is IProposalGenericExecutor {
  address public constant LEND_MIGARTION_CONTRACT = 0x317625234562B1526Ea2FaC4030Ea499C5291de4;
  address public constant LEND = 0x80fB784B7eD66730e8b1DBd9820aFD29931aab03;
  LendToAaveMigrator public immutable LEND_TO_AAVE_MIGRATOR_IMPLEMENTATION;

  constructor() {
    LEND_TO_AAVE_MIGRATOR_IMPLEMENTATION = new LendToAaveMigrator(
      IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING),
      IERC20(LEND),
      100
    );
  }

  function execute() external {
    ProxyAdmin(MiscEthereum.PROXY_ADMIN).upgradeAndCall(
      ITransparentUpgradeableProxy(LEND_MIGARTION_CONTRACT),
      address(LEND_TO_AAVE_MIGRATOR_IMPLEMENTATION),
      abi.encodeWithSelector(LendToAaveMigrator.initialize.selector)
    );
  }
}
