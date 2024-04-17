// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Scroll, AaveV3ScrollAssets} from 'aave-address-book/AaveV3Scroll.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Scroll wstETH Emission Manager
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb70490f6b0623631686d34f4ca99a7d45394ad29fdd504df3cd6e68790b22b9c
 * - Discussion: https://governance.aave.com/t/arfc-set-liquidity-observation-labs-as-emission-manager-for-wsteth-on-scroll/16813
 */
contract AaveV3Scroll_ScrollWstETHEmissionManager_20240312 is IProposalGenericExecutor {
  address public constant wstETH_EMISSION_ADMIN = 0xC18F11735C6a1941431cCC5BcF13AF0a052A5022;

  function execute() external {
    IEmissionManager(AaveV3Scroll.EMISSION_MANAGER).setEmissionAdmin(
      AaveV3ScrollAssets.wstETH_UNDERLYING,
      wstETH_EMISSION_ADMIN
    );
  }
}
