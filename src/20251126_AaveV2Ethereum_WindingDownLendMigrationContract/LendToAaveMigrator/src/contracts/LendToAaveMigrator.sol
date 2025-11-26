// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {VersionedInitializable} from './dependencies/upgradeability/VersionedInitializable.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title LendToAaveMigrator
 * @notice This contract implements the migration from LEND to AAVE token
 * @author Aave
 */
contract LendToAaveMigrator is VersionedInitializable {
  error MigrationFinished();
  error MigrationNotFinished();

  uint256 public constant MIGRATION_END_TIMESTAMP = 1767225600; // January 1, 2026, UTC

  IERC20 public immutable AAVE;
  IERC20 public immutable LEND;
  uint256 public immutable LEND_AAVE_RATIO;
  uint256 public constant REVISION = 3;

  uint256 public _totalLendMigrated;

  /**
   * @dev emitted on migration
   * @param sender the caller of the migration
   * @param amount the amount being migrated
   */
  event LendMigrated(address indexed sender, uint256 indexed amount);

  /**
   * @dev emitted on token rescue when initializing
   * @param from the origin of the rescued funds
   * @param to the destination of the rescued funds
   * @param amount the amount being rescued
   */
  event AaveTokensRescued(address from, address indexed to, uint256 amount);

  /**
   * @param aave the address of the AAVE token
   * @param lend the address of the LEND token
   * @param lendAaveRatio the exchange rate between LEND and AAVE
   */
  constructor(IERC20 aave, IERC20 lend, uint256 lendAaveRatio) {
    AAVE = aave;
    LEND = lend;
    LEND_AAVE_RATIO = lendAaveRatio;

    lastInitializedRevision = REVISION;
  }

  /**
   * @dev empty initializer
   */
  function initialize() public initializer {}

  /**
   * The DAO voted on stopping the migration on 1st of January 2026
   * Once that time has passed, all remaining AAVE tokens can be claimed to the treasury.
   */
  function transferRemainingFundsToTreasury() external {
    require(block.timestamp > MIGRATION_END_TIMESTAMP, MigrationNotFinished());
    AAVE.transfer(address(AaveV3Ethereum.COLLECTOR), AAVE.balanceOf(address(this)));
  }

  /**
   * @dev returns true if the migration started
   */
  function migrationStarted() external view returns (bool) {
    return lastInitializedRevision != 0;
  }

  /**
   * @dev executes the migration from LEND to AAVE. Users need to give allowance to this contract to transfer LEND before executing
   * this transaction.
   * burns the migrated LEND amount
   * @param amount the amount of LEND to be migrated
   */
  function migrateFromLEND(uint256 amount) external {
    require(block.timestamp <= MIGRATION_END_TIMESTAMP, MigrationFinished());
    require(lastInitializedRevision != 0, 'MIGRATION_NOT_STARTED');

    _totalLendMigrated = _totalLendMigrated + amount;
    LEND.transferFrom(msg.sender, address(this), amount);
    AAVE.transfer(msg.sender, amount / LEND_AAVE_RATIO);

    LEND.transfer(address(LEND), amount);

    emit LendMigrated(msg.sender, amount);
  }

  /**
   * @dev returns the implementation revision
   * @return the implementation revision
   */
  function getRevision() internal pure override returns (uint256) {
    return REVISION;
  }
}
