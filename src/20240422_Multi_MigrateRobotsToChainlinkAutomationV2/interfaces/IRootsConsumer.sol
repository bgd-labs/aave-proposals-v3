// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title IRootsConsumer
 * @author BGD Labs
 * @notice Defines the interface for the contract to fetch api response to register storage roots.
 **/
interface IRootsConsumer {
  /**
   * @notice Emitted when we get a response from chainlink api and the storage roots are registered to the data warehouse.
   * @param requestId request id received by chainlink.
   * @param blockHash block hash for which roots have beeen registered.
   */
  event RootsRegisteredFulfilled(bytes32 indexed requestId, bytes32 indexed blockHash);

  /**
   * @notice Emitted when we set a new api url to fetch the roots data.
   * @param newApiUrl url of the new chainlink api request.
   */
  event ApiUrlSet(string indexed newApiUrl);

  /**
   * @notice Emitted when we set a new jobId of the chainlink operator.
   * @param newJobId jobId which has been set.
   */
  event JobIdSet(bytes32 indexed newJobId);

  /**
   * @notice Emitted when we set a new fee to pay for the chainlink api request.
   * @param newFee fee set for the api request.
   */
  event FeeSet(uint256 indexed newFee);

  /**
   * @notice Emitted when we set a new chainlink operator.
   * @param newOperator address of the chainlink operator.
   */
  event OperatorSet(address indexed newOperator);

  /**
   * @notice Emitted when the link withdraw address has been changed of the consumer.
   * @param newWithdrawAddress address of the new withdraw address where link will be withdrawn to.
   */
  event WithdrawAddressSet(address indexed newWithdrawAddress);

  /**
   * @notice Emitted when we set a new robot keeper.
   * @param newRobotKeeper address of the new robot keeper.
   */
  event RobotKeeperSet(address indexed newRobotKeeper);

  /**
   * @notice Emitted when we send a request by the keeper to register the roots.
   * @param blockHash blockHash for which the roots need to be registered.
   * @param requestUrl url to request data needed to register the roots.
   * @param fee fee paid to the chainlink operator for the request.
   */
  event OperatorRequestSent(
    bytes32 indexed blockHash,
    string indexed requestUrl,
    uint256 indexed fee
  );

  /**
   * @notice method to request data needed to register roots via chainlink api.
   * @param blockHash block hash for which roots needs to be registered.
   **/
  function requestSubmitRoots(bytes32 blockHash) external;

  /**
   * @notice method called by chainlink node operator containing the api response as encoded data, used for registering roots.
   * @param requestId request id received by chainlink.
   * @param response encoded data received as the api response which is used to register the roots.
   **/
  function fulfillRegisterRoots(bytes32 requestId, bytes calldata response) external;

  /**
   * @notice method called by the owner / robot guardian to change the chainlink operator.
   * @param chainlinkOperator new operator for api requests.
   **/
  function setOperator(address chainlinkOperator) external;

  /**
   * @notice method called by the owner / robot guardian to change the fee paid to the operator.
   * @param fee new fee paid to the operator.
   **/
  function setFee(uint256 fee) external;

  /**
   * @notice method called by the owner / robot guardian to change the api url we use to fetch data to register roots.
   * @param api_url new api url to set.
   **/
  function setApiUrl(string memory api_url) external;

  /**
   * @notice method called by the owner / robot guardian to change the jobId of the operator.
   * @param jobId new job id of the operator.
   **/
  function setJobId(bytes32 jobId) external;

  /**
   * @notice method called by owner / robot guardian to set the robot keeper which can request to submit roots.
   * @param robotKeeper new address of the robot keeper to set.
   **/
  function setRobotKeeper(address robotKeeper) external;

  /**
   * @notice method to get the fee to be paid to the chainlink operator.
   * @return operator fee.
   */
  function getFee() external view returns (uint256);

  /**
   * @notice method to get the job id of the chainlink operator.
   * @return job id.
   */
  function getJobId() external view returns (bytes32);

  /**
   * @notice method to get the api url which returns the data to register storage roots.
   * @return url of the backend api.
   */
  function getApiUrl() external view returns (string memory);

  /**
   * @notice method to get the the robot keeper which can request to submit roots.
   * @return address of the robot keeeper contract.
   */
  function getRobotKeeper() external view returns (address);

  /**
   * @notice method to get the address of the data warehouse contract.
   * @return address of the data warehouse contract.
   */
  function DATA_WAREHOUSE() external view returns (address);
}
