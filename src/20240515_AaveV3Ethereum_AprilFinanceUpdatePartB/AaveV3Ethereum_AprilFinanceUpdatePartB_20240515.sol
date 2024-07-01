// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveSwapper} from 'aave-helpers/swaps/AaveSwapper.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {CollectorUtils, ICollector} from '../CollectorUtils.sol';

/**
 * @title April Finance Update Part B
 * @author @karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-april-finance-update/17390
 */
contract AaveV3Ethereum_AprilFinanceUpdatePartB_20240515 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  AaveSwapper public constant SWAPPER = AaveSwapper(MiscEthereum.AAVE_SWAPPER);

  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;
  address public constant GHO_USD_FEED = 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC;

  address public constant ALC_SAFE = 0x205e795336610f5131Be52F09218AF19f0f3eC60;

  uint256 public constant ALC_ALLOWANCES = 1_000_000e6;

  function execute() external {
    // Swap DAI
    AaveV3Ethereum.COLLECTOR.swap(
      SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV3EthereumAssets.DAI_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.GHO_UNDERLYING,
        fromUnderlyingPriceFeed: AaveV3EthereumAssets.DAI_ORACLE,
        toUnderlyingPriceFeed: GHO_USD_FEED,
        amount: type(uint256).max,
        slippage: 1_50
      })
    );

    // ALC Allowances
    AaveV3Ethereum.COLLECTOR.approve(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      ALC_SAFE,
      ALC_ALLOWANCES
    );
    AaveV3Ethereum.COLLECTOR.approve(AaveV3EthereumAssets.USDT_A_TOKEN, ALC_SAFE, ALC_ALLOWANCES);

    // Deposit into V3: USDC
    AaveV3Ethereum.COLLECTOR.depositToV3(
      AaveV3Ethereum.POOL,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)) -
        ALC_ALLOWANCES
    );

    // Deposit into V3: wETH
    AaveV3Ethereum.COLLECTOR.depositToV3(
      AaveV3Ethereum.POOL,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      type(uint256).max
    );

    // Deposit into V3: wBTC
    AaveV3Ethereum.COLLECTOR.depositToV3(
      AaveV3Ethereum.POOL,
      AaveV3EthereumAssets.WBTC_UNDERLYING,
      type(uint256).max
    );
  }
}
