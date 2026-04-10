// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Ownable2Step, Ownable} from 'openzeppelin-contracts/contracts/access/Ownable2Step.sol';
import {Rescuable} from 'solidity-utils/contracts/utils/Rescuable.sol';
import {IRescuableBase} from 'solidity-utils/contracts/utils/interfaces/IRescuableBase.sol';
import {RescuableBase} from 'solidity-utils/contracts/utils/RescuableBase.sol';
import {IFeeSharesMinterBase} from 'src/interfaces/IFeeSharesMinterBase.sol';
import {IHub} from './IHub.sol';

/// @title FeeSharesMinterBase
/// @author Aave Labs
/// @notice Contract to mint fee shares on the Hub when specific conditions are met.
contract FeeSharesMinterBase is IFeeSharesMinterBase, Ownable2Step, Rescuable {
  uint256 internal constant PERCENTAGE_FACTOR = 1e4;

  mapping(address hub => mapping(uint256 assetId => uint16 minAccruedFeesPercent))
    internal _configs;

  constructor(address owner) Ownable(owner) {}

  /// @inheritdoc IFeeSharesMinterBase
  function setConfig(
    address hub,
    uint256 assetId,
    uint16 minAccruedFeesPercent
  ) external onlyOwner {
    require(minAccruedFeesPercent <= PERCENTAGE_FACTOR, InvalidConfig());
    _configs[hub][assetId] = minAccruedFeesPercent;
    emit ConfigUpdated(hub, assetId, minAccruedFeesPercent);
  }

  /// @inheritdoc IFeeSharesMinterBase
  function performUpkeep(bytes calldata performData) external override {
    (address hub, uint256 assetId) = abi.decode(performData, (address, uint256));
    _performUpkeep(hub, assetId);
  }

  /// @inheritdoc IFeeSharesMinterBase
  function checkUpkeep(
    bytes calldata checkData
  ) external view override returns (bool, bytes memory) {
    (address hub, uint256 assetId) = abi.decode(checkData, (address, uint256));
    bool upkeepNeeded = _checkUpkeep(hub, assetId);
    bytes memory performData = checkData;
    return (upkeepNeeded, performData);
  }

  /// @inheritdoc IFeeSharesMinterBase
  function getConfig(address hub, uint256 assetId) external view returns (uint16) {
    return _configs[hub][assetId];
  }

  function _performUpkeep(address hub, uint256 assetId) internal virtual {
    require(_checkUpkeep(hub, assetId), ConditionsNotMet());
    IHub(hub).mintFeeShares(assetId);
  }

  function _checkUpkeep(address hub, uint256 assetId) internal view virtual returns (bool) {
    uint16 minAccruedFeesPercent = _configs[hub][assetId];

    IHub hubContract = IHub(hub);
    uint256 accruedFees = hubContract.getAssetAccruedFees(assetId);
    uint256 totalAddedAssets = hubContract.getAddedAssets(assetId);

    if ((accruedFees * PERCENTAGE_FACTOR) / totalAddedAssets < minAccruedFeesPercent) {
      return false;
    }

    uint256 expectedShares = hubContract.previewAddByAssets(assetId, accruedFees);
    return expectedShares > 0;
  }

  /// @inheritdoc Rescuable
  function whoCanRescue() public view override returns (address) {
    return owner();
  }

  function maxRescue(
    address
  ) public pure override(IRescuableBase, RescuableBase) returns (uint256) {
    return type(uint256).max;
  }
}
