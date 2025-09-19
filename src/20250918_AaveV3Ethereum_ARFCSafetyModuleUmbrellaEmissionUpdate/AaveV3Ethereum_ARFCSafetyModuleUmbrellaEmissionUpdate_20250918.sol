// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title [ARFC] Safety Module & Umbrella Emission Update
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x6712b1677068d2d316af699757057a0c8c03e0ff0693c12aacc381d294c419a4
 * - Discussion: https://governance.aave.com/t/arfc-safety-module-umbrella-emission-update/23103
 */
contract AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate_20250918 is
  IProposalGenericExecutor
{
  uint256 public constant NEW_MAX_SLASHING_PCT = 0;

  function execute() external override {
    _disableSlashingLegacyModules();
    _updateUmbrellaEmissions();
  }

  function _disableSlashingLegacyModules() internal {
    IStakeToken(AaveSafetyModule.STK_AAVE).setMaxSlashablePercentage(NEW_MAX_SLASHING_PCT);

    IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).setMaxSlashablePercentage(
      NEW_MAX_SLASHING_PCT
    );
  }

  function _updateUmbrellaEmissions() internal {}
}
