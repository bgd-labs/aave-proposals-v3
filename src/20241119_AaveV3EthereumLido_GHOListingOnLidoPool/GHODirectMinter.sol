// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IPool, DataTypes} from 'aave-v3-origin/contracts/interfaces/IPool.sol';
import {OwnableUpgradeable} from 'openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol';
import {Initializable} from 'openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {IGhoToken} from '../interfaces/IGhoToken.sol';

/**
 * @title GHODirectMinter
 * @notice Acts as a facilitator
 * Instead of minting and burning on demand on each user interaction, the facilitator mints an amount upfront and makes it available via supply.
 * @author BGD Labs @bgdlabs
 */
contract GHODirectMinter is Initializable, OwnableUpgradeable {
  using SafeERC20 for IERC20;
  IPool public immutable POOL;
  address public immutable COLLECTOR;
  IGhoToken public immutable GHO;

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
    GHO.mint(address(this), amount);
    IERC20(address(GHO)).forceApprove(address(POOL), amount);
    POOL.supply(address(GHO), amount, address(this), 0);
  }

  /**
   * @dev withdraws GHO from the pool and burns it
   */
  function withdrawAndBurn(uint256 amount) external onlyOwner {
    uint256 amountWithdrawn = POOL.withdraw(address(GHO), amount, address(this));

    GHO.burn(amountWithdrawn);
  }

  function transferExcessToTreasury() external {
    (uint256 capacity, ) = GHO.getFacilitatorBucket(address(this));
    DataTypes.ReserveDataLegacy memory reserveData = POOL.getReserveData(address(GHO));
    uint256 balanceIncrease = IERC20(reserveData.aTokenAddress).balanceOf(address(this)) - capacity;

    IERC20(reserveData.aTokenAddress).transfer(address(COLLECTOR), balanceIncrease);
  }
}
