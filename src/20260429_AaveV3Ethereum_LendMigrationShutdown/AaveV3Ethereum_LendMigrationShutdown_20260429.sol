// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IProxyAdminOzV4} from 'solidity-utils/contracts/transparent-proxy/interfaces/IProxyAdminOzV4.sol';
import {ILendToAaveMigrator} from 'src/interfaces/ILendToAaveMigrator.sol';

/**
 * @title Lend Migration Shutdown
 * @author Aave Labs
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0x4d9eb143c46a637dbf98d63ad00a6e53739a9b6affc0eed7d3cd35680500afaa
 * - Discussion: https://governance.aave.com/t/arfc-winding-down-lend-migration-contract/23126
 */
contract AaveV3Ethereum_LendMigrationShutdown_20260429 is IProposalGenericExecutor {
  /// @notice Address of the LendToAaveMigrator transparent proxy on mainnet
  address public constant LEND_TO_AAVE_MIGRATOR_PROXY = 0x317625234562B1526Ea2FaC4030Ea499C5291de4;

  /// @notice Address of the new LendToAaveMigrator implementation to upgrade to
  address public immutable LEND_TO_AAVE_MIGRATOR_IMPL = 0x2Da544ae1EA4E19b680E7A39520c64E5D35c0345;

  /// @inheritdoc IProposalGenericExecutor
  function execute() external {
    IProxyAdminOzV4(MiscEthereum.PROXY_ADMIN).upgradeAndCall(
      LEND_TO_AAVE_MIGRATOR_PROXY,
      LEND_TO_AAVE_MIGRATOR_IMPL,
      abi.encodeCall(ILendToAaveMigrator.initialize, ())
    );
  }
}
