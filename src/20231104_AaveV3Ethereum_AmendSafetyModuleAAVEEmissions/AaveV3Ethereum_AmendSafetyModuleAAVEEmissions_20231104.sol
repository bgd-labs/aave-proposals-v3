// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IAaveEcosystemReserveController} from 'aave-address-book/common/IAaveEcosystemReserveController.sol';

library HelperStructs {
  struct AssetConfigInput {
    uint128 emissionPerSecond;
    uint256 totalStaked;
    address underlyingAsset;
  }

  struct UserStakeInput {
    address underlyingAsset;
    uint256 stakedByUser;
    uint256 totalStaked;
  }
}

interface IAaveDistributionManager {
  function configureAssets(HelperStructs.AssetConfigInput[] calldata assetsConfigInput) external;

  function STAKED_TOKEN() external returns (address);

  function totalSupply() external returns (uint256);
}

/**
 * @title AmendSafetyModuleAAVEEmissions
 * @author JosepBove (0xbove - Aave-Chan Initiative)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb0124fb0206676ee743e8d6221b7b3c317cb26a657551f11cb5fa23544772a73
 * - Discussion: https://governance.aave.com/t/arfc-treasury-management-amend-safety-module-aave-emissions/14936
 */
contract AaveV3Ethereum_AmendSafetyModuleAAVEEmissions_20231104 is IProposalGenericExecutor {
  address public constant STKAAVE = AaveSafetyModule.STK_AAVE;
  address public constant STKABPT = AaveSafetyModule.STK_ABPT;

  address public constant ECOSYSTEM_RESERVE = MiscEthereum.ECOSYSTEM_RESERVE;

  // New daily emission
  uint256 public constant DAILY_EMISSIONS = 385 ether;

  // Total cycle emission (90 days)
  uint256 public constant CYCLE_EMISSIONS = DAILY_EMISSIONS * 90;

  // Daily emission to seconds; 1 day * 24h * 3600 s = 86400
  uint128 public constant EMISSIONS_PER_SECOND = uint128(DAILY_EMISSIONS / 86400);

  IAaveEcosystemReserveController public constant ECOSYSTEM_RESERVE_CONTROLLER =
    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER;

  function execute() external {
    // stkAave from daily 550 to 385 converted to seconds as required
    _changeEmissions(STKAAVE, EMISSIONS_PER_SECOND);

    // stkABPT from daily 550 to 385 converted to seconds as required
    _changeEmissions(STKABPT, EMISSIONS_PER_SECOND);

    // Remove the approval as needed by the ecosystem reserve and change it to the emissions of a 90 day cycle
    _set90DayCycle();
  }

  function _changeEmissions(address asset, uint128 newEmissions) internal {
    IAaveDistributionManager distributionManager = IAaveDistributionManager(asset);

    HelperStructs.AssetConfigInput[] memory config = new HelperStructs.AssetConfigInput[](1);

    config[0] = HelperStructs.AssetConfigInput(
      newEmissions, // emissions per second
      distributionManager.totalSupply(), // total staked
      asset // underlying asset
    );

    distributionManager.configureAssets(config);
  }

  function _set90DayCycle() internal {
    // For requirement of the controller, first we reset allowance
    ECOSYSTEM_RESERVE_CONTROLLER.approve(
      ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      STKAAVE,
      0
    );

    ECOSYSTEM_RESERVE_CONTROLLER.approve(
      ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      STKABPT,
      0
    );

    // Then we set the amount 90 days * 385 daily emission (both on stkAave and stkABPT) => 90 * 550 = 34_650
    ECOSYSTEM_RESERVE_CONTROLLER.approve(
      ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      STKAAVE,
      CYCLE_EMISSIONS * 4 // account for pending unclaimed emission
    );

    ECOSYSTEM_RESERVE_CONTROLLER.approve(
      ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      STKABPT,
      CYCLE_EMISSIONS * 4 // account for pending unclaimed emission
    );
  }
}
