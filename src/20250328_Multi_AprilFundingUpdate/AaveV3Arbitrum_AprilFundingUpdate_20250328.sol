// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {IAaveArbEthERC20Bridge} from 'aave-helpers/src/bridges/arbitrum/IAaveArbEthERC20Bridge.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

import {IPoolExposureSteward} from './IPoolExposureSteward.sol';

/**
 * @title April Funding update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-april-funding-update/21590
 */
contract AaveV3Arbitrum_AprilFundingUpdate_20250328 is IProposalGenericExecutor {
  function execute() external {
    _deposit();
  }

  function _deposit() internal {
    IPoolExposureSteward(AaveV3Arbitrum.POOL_EXPOSURE_STEWARD).depositV3(
      address(AaveV3Arbitrum.POOL),
      AaveV3ArbitrumAssets.USDCn_UNDERLYING,
      type(uint256).max
    );
    IPoolExposureSteward(AaveV3Arbitrum.POOL_EXPOSURE_STEWARD).depositV3(
      address(AaveV3Arbitrum.POOL),
      AaveV3ArbitrumAssets.WETH_UNDERLYING,
      type(uint256).max
    );
    IPoolExposureSteward(AaveV3Arbitrum.POOL_EXPOSURE_STEWARD).depositV3(
      address(AaveV3Arbitrum.POOL),
      AaveV3ArbitrumAssets.USDT_UNDERLYING,
      type(uint256).max
    );
    IPoolExposureSteward(AaveV3Arbitrum.POOL_EXPOSURE_STEWARD).depositV3(
      address(AaveV3Arbitrum.POOL),
      AaveV3ArbitrumAssets.WBTC_UNDERLYING,
      type(uint256).max
    );
    IPoolExposureSteward(AaveV3Arbitrum.POOL_EXPOSURE_STEWARD).depositV3(
      address(AaveV3Arbitrum.POOL),
      AaveV3ArbitrumAssets.ARB_UNDERLYING,
      type(uint256).max
    );
    IPoolExposureSteward(AaveV3Arbitrum.POOL_EXPOSURE_STEWARD).depositV3(
      address(AaveV3Arbitrum.POOL),
      AaveV3ArbitrumAssets.wstETH_UNDERLYING,
      type(uint256).max
    );
    IPoolExposureSteward(AaveV3Arbitrum.POOL_EXPOSURE_STEWARD).depositV3(
      address(AaveV3Arbitrum.POOL),
      AaveV3ArbitrumAssets.GHO_UNDERLYING,
      type(uint256).max
    );
    IPoolExposureSteward(AaveV3Arbitrum.POOL_EXPOSURE_STEWARD).depositV3(
      address(AaveV3Arbitrum.POOL),
      AaveV3ArbitrumAssets.LINK_UNDERLYING,
      type(uint256).max
    );
  }
}
