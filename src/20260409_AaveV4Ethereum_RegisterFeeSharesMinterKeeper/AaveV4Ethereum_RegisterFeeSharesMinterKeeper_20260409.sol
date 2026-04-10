// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs} from 'aave-address-book/AaveV4Ethereum.sol';
import {IHub} from 'aave-address-book/AaveV4.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';

import {IAaveCLRobotOperator} from 'src/interfaces/IAaveCLRobotOperator.sol';
import {FeeSharesMinterBase} from './dependencies/FeeSharesMinterBase.sol';

/**
 * @title Register FeeSharesMinter Keeper
 * @author Aave Labs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV4Ethereum_RegisterFeeSharesMinterKeeper_20260409 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;
  using CollectorUtils for ICollector;

  uint96 public constant LINK_AMOUNT = 200 ether;
  uint256 public constant TOTAL_KEEPERS = 31;
  uint32 public constant KEEPER_GAS_LIMIT = 100_000;
  uint16 public constant MIN_ACCRUED_FEES_PERCENT = 5_00; // 5% // TODO: Verify initial config

  function execute() external {
    // TODO: Replace this deployment with the pre-deployed address once available.
    address feeSharesMinter = address(new FeeSharesMinterBase(GovernanceV3Ethereum.EXECUTOR_LVL_1));

    AaveV4Ethereum.ACCESS_MANAGER.grantRole(Roles.HUB_FEE_MINTER_ROLE, feeSharesMinter, 0);

    _configureHubAssets(AaveV4EthereumHubs.CORE_HUB, feeSharesMinter);
    _configureHubAssets(AaveV4EthereumHubs.PLUS_HUB, feeSharesMinter);
    _configureHubAssets(AaveV4EthereumHubs.PRIME_HUB, feeSharesMinter);

    uint256 withdrawnBalance = AaveV3Ethereum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.LINK_UNDERLYING,
        amount: LINK_AMOUNT
      }),
      address(this)
    );
    IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).forceApprove(
      MiscEthereum.AAVE_CL_ROBOT_OPERATOR,
      withdrawnBalance
    );

    uint96 linkPerKeeper = uint96(withdrawnBalance / TOTAL_KEEPERS);
    uint256 keepersRegistered;

    keepersRegistered = _registerHubKeepers(
      AaveV4EthereumHubs.CORE_HUB,
      feeSharesMinter,
      linkPerKeeper,
      keepersRegistered,
      withdrawnBalance
    );
    keepersRegistered = _registerHubKeepers(
      AaveV4EthereumHubs.PLUS_HUB,
      feeSharesMinter,
      linkPerKeeper,
      keepersRegistered,
      withdrawnBalance
    );
    keepersRegistered = _registerHubKeepers(
      AaveV4EthereumHubs.PRIME_HUB,
      feeSharesMinter,
      linkPerKeeper,
      keepersRegistered,
      withdrawnBalance
    );
  }

  function _registerHubKeepers(
    IHub hub,
    address feeSharesMinter,
    uint96 linkPerKeeper,
    uint256 keepersRegistered,
    uint256 withdrawnBalance
  ) internal returns (uint256) {
    uint256 assetCount = hub.getAssetCount();
    for (uint256 assetId; assetId < assetCount; ++assetId) {
      bool isLast = keepersRegistered == TOTAL_KEEPERS - 1;

      IAaveCLRobotOperator(MiscEthereum.AAVE_CL_ROBOT_OPERATOR).register(
        'FeeSharesMinter',
        feeSharesMinter,
        abi.encode(address(hub), assetId),
        KEEPER_GAS_LIMIT,
        isLast
          ? uint96(withdrawnBalance) - linkPerKeeper * uint96(keepersRegistered)
          : linkPerKeeper,
        0,
        ''
      );

      ++keepersRegistered;
    }

    return keepersRegistered;
  }

  function _configureHubAssets(IHub hub, address feeSharesMinter) internal {
    FeeSharesMinterBase minter = FeeSharesMinterBase(feeSharesMinter);
    uint256 assetCount = hub.getAssetCount();
    for (uint256 assetId; assetId < assetCount; ++assetId) {
      minter.setConfig(address(hub), assetId, MIN_ACCRUED_FEES_PERCENT);
    }
  }
}
