// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IPool, DataTypes} from 'aave-v3-origin/contracts/interfaces/IPool.sol';
import {OwnableUpgradeable} from 'openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol';
import {Initializable} from 'openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {IGhoToken} from '../interfaces/IGhoToken.sol';

/**
 * @title Direct deposit module for GHO
 * @author BGD Labs @bgdlabs
 */
contract D3MVault is Initializable, OwnableUpgradeable {
  using SafeERC20 for IERC20;
  IPool public immutable POOL;
  address public immutable COLLECTOR;
  IGhoToken public immutable GHO;

  struct D3MVaultStorage {
    uint256 amountMinted;
  }

  // keccak256(abi.encode(uint256(keccak256("aave.storage.D3MVaultStorageLocation")) - 1)) & ~bytes32(uint256(0xff))
  bytes32 private constant D3MVaultStorageLocation =
    0x5a3fda545d5a39b1b1d31fac31b4cd89c3626ba0174da6f40c47c9cb53793d00; // TODO: update this

  function _getD3MVaultStorage() private pure returns (D3MVaultStorage storage $) {
    assembly {
      $.slot := D3MVaultStorageLocation
    }
  }

  constructor(IPool pool, address collector, address gho) {
    POOL = pool;
    COLLECTOR = collector;
    GHO = IGhoToken(gho);
    _disableInitializers();
  }

  function initialize(address owner) external virtual initializer {
    __Ownable_init(owner);
  }

  /**
   * @dev mints GHO and supplies it to the pool
   */
  function mintAndSupply(uint256 amount) external onlyOwner {
    _getD3MVaultStorage().amountMinted += amount;

    GHO.mint(address(this), amount);
    IERC20(address(GHO)).forceApprove(address(POOL), amount);
    POOL.supply(address(GHO), amount, address(this), 0);
  }

  /**
   * @dev withdraws GHO from the pool and burns it
   */
  function withdrawAndBurn(uint256 amount) external onlyOwner {
    // violating CEI because there might be rounding on the withdrawal, but we want exact accounting on amountMinted
    uint256 balanceBefore = IERC20(address(GHO)).balanceOf(address(this));
    POOL.withdraw(address(GHO), amount, address(this));
    uint256 balanceAfter = IERC20(address(GHO)).balanceOf(address(this));
    uint256 diff = balanceAfter - balanceBefore;
    _getD3MVaultStorage().amountMinted -= diff;

    GHO.burn(diff);
  }

  function transferExcessToTreasury() external {
    DataTypes.ReserveDataLegacy memory reserveData = POOL.getReserveData(address(GHO));
    uint256 balanceIncrease = IERC20(reserveData.aTokenAddress).balanceOf(address(this)) -
      _getD3MVaultStorage().amountMinted;

    IERC20(reserveData.aTokenAddress).transfer(address(COLLECTOR), balanceIncrease);
  }
}
