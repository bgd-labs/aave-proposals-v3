// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAaveStethWithdrawer {
  /// @notice emited when a new Withdrawal is requested
  /// @param amounts the amounts requested to be withdrawn
  /// @param index the storage index of the respective requestIds used to finalize the withdrawal
  event StartedWithdrawal(uint256[] amounts, uint256 index);

  /// @notice emited when a new Withdrawal is requested
  /// @param amount the amount of WETH withdrawn to collector
  /// @param index the storage index of the respective requestIds used to finalize the withdrawal
  event FinalizedWithdrawal(uint256 amount, uint256 index);

  /// @notice Starts a new withdrawal
  /// @param amounts a list of amounts to be withdrawn. each amount must be > 100 wei and < 1000 ETH
  function startWithdraw(uint256[] calldata amounts) external;

  /// @notice Finalizes a withdrawal
  /// @param index the index of the withdrawal request data of the withdrawal to be finalized
  function finalizeWithdraw(uint256 index) external;

  /// @notice Gets the requestIds from a specific withdrawal request
  /// @param index the index of the withdrawal request data to be returned
  /// @return requestIds an array containing all the requestIds of a single withdrawal request
  function getRequestIds(uint256 index) external view returns (uint256[] memory requestIds);
}

interface IWithdrawalQueueERC721 {
  /// @notice Request the batch of wstETH for withdrawal. Approvals for the passed amounts should be done before.
  /// @param _amounts an array of wstETH amount values.
  ///  The standalone withdrawal request will be created for each item in the passed list.
  /// @param _owner address that will be able to manage the created requests.
  ///  If `address(0)` is passed, `msg.sender` will be used as an owner.
  /// @return requestIds an array of the created withdrawal request ids
  function requestWithdrawalsWstETH(
    uint256[] calldata _amounts,
    address _owner
  ) external returns (uint256[] memory requestIds);

  /// @notice Claim a batch of withdrawal requests if they are finalized sending ether to `_recipient`
  /// @param _requestIds array of request ids to claim
  /// @param _hints checkpoint hint for each id. Can be obtained with `findCheckpointHints()`
  /// @param _recipient address where claimed ether will be sent to
  /// @dev
  ///  Reverts if recipient is equal to zero
  ///  Reverts if requestIds and hints arrays length differs
  ///  Reverts if any requestId or hint in arguments are not valid
  ///  Reverts if any request is not finalized or already claimed
  ///  Reverts if msg sender is not an owner of the requests
  function claimWithdrawalsTo(
    uint256[] calldata _requestIds,
    uint256[] calldata _hints,
    address _recipient
  ) external;

  /// @notice Finds the list of hints for the given `_requestIds` searching among the checkpoints with indices
  ///  in the range  `[_firstIndex, _lastIndex]`.
  ///  NB! Array of request ids should be sorted
  ///  NB! `_firstIndex` should be greater than 0, because checkpoint list is 1-based array
  ///  Usage: findCheckpointHints(_requestIds, 1, getLastCheckpointIndex())
  /// @param _requestIds ids of the requests sorted in the ascending order to get hints for
  /// @param _firstIndex left boundary of the search range. Should be greater than 0
  /// @param _lastIndex right boundary of the search range. Should be less than or equal to getLastCheckpointIndex()
  /// @return hintIds array of hints used to find required checkpoint for the request
  function findCheckpointHints(
    uint256[] calldata _requestIds,
    uint256 _firstIndex,
    uint256 _lastIndex
  ) external view returns (uint256[] memory hintIds);

  /// @notice length of the checkpoint array. Last possible value for the hint.
  ///  NB! checkpoints are indexed from 1, so it returns 0 if there is no checkpoints
  function getLastCheckpointIndex() external view returns (uint256);
}

interface IWETH {
  function deposit() external payable;
}
