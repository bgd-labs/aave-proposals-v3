// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {Ownable} from 'solidity-utils/contracts/oz-common/Ownable.sol';
import {Rescuable} from 'solidity-utils/contracts/utils/Rescuable.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

interface WithdrawalQueueERC721 {
  function requestWithdrawalsWstETH(
    uint256[] calldata _amounts,
    address _owner
  ) external returns (uint256[] memory requestIds);

  function claimWithdrawalsTo(
    uint256[] calldata _requestIds,
    uint256[] calldata _hints,
    address _recipient
  ) external;

  function findCheckpointHints(
    uint256[] calldata _requestIds,
    uint256 _firstIndex,
    uint256 _lastIndex
  ) external view returns (uint256[] memory hintIds);

  function getLastCheckpointIndex() external view returns (uint256);
}

interface IWETH {
  function deposit() external payable;
}

contract AaveStethWithdrawer is Ownable, Rescuable {
  using SafeERC20 for IERC20;
  uint256[] public requestIds;

  WithdrawalQueueERC721 public constant WSETH_WITHDRAWAL_QUEUE =
    WithdrawalQueueERC721(0x889edC2eDab5f40e902b864aD4d7AdE8E412F9B1);

  constructor(address _owner) {
    _transferOwnership(_owner);
    IERC20(AaveV3EthereumAssets.wstETH_UNDERLYING).approve(
      address(WSETH_WITHDRAWAL_QUEUE),
      type(uint256).max
    );
  }

  function startWithdraw(uint256 amount) external {
    uint256[] memory amounts = new uint256[](1);
    amounts[0] = amount;

    requestIds = WSETH_WITHDRAWAL_QUEUE.requestWithdrawalsWstETH(amounts, address(this));
  }

  function finalizeWithdraw() external {
    uint256[] memory hintIds = WSETH_WITHDRAWAL_QUEUE.findCheckpointHints(
      requestIds,
      1,
      WSETH_WITHDRAWAL_QUEUE.getLastCheckpointIndex()
    );

    WSETH_WITHDRAWAL_QUEUE.claimWithdrawalsTo(requestIds, hintIds, address(this));

    uint256 ethBalance = address(this).balance;

    IWETH(AaveV3EthereumAssets.WETH_UNDERLYING).deposit{value: ethBalance}();

    IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).transfer(
      address(AaveV3Ethereum.COLLECTOR),
      ethBalance
    );
  }

  function whoCanRescue() public view override returns (address) {
    return owner();
  }
}
