// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title February Funding Update
 * @author @TokenLogic
 * - Snapshot: Direct-To-AIP
 * - Discussion: https://governance.aave.com/t/arfc-february-funding-update/20712
 */
contract AaveV3Ethereum_FebruaryFundingUpdate_20250120 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  address public constant MILKMAN = 0x060373D064d0168931dE2AB8DDA7410923d06E88;
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;
  // https://etherscan.io/address/0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC
  address public constant GHO_USD_FEED = 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC;
  address public constant LUSD_FEED = 0x3D7aE7E594f2f2091Ad8798313450130d0Aba3a0;
  address public constant DPI_FEED = 0xD2A593BF7594aCE1faD597adb697b5645d5edDB2;

  // https://etherscan.io/address/0x6f40d4a6237c257fff2db00fa0510deeecd303eb
  address public constant FLUID = 0x6f40d4A6237C257fff2dB00FA0510DeEECd303eb;
  address public constant MERIT_SAFE = 0xdeadD8aB03075b7FBA81864202a2f59EE25B312b;
  address public constant ACI_SAFE = 0xac140648435d03f784879cd789130F22Ef588Fcd;
  address public constant ALC_SAFE = 0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b;

  uint256 public constant FLUID_AMOUNT = 95_417 ether;
  uint256 public constant USDC_ACI_REIMBURSEMENT = 26500e6;
  uint256 public constant ETH_ACI_REIMBURSEMENT = 3.404 ether;
  uint256 public constant PYUSD_ACI_REIMBURSEMENT = 149e6;

  uint256 public constant AMOUNT_WITHDRAW_USDC = 1_500_000e6;
  uint256 public constant AMOUNT_WITHDRAW_USDT = 2_000_000e6;

  uint256 public constant AMOUNT_SWAP_USDC = 1_500_000e6;
  uint256 public constant AMOUNT_SWAP_USDT = 1_500_000e6;

  function execute() external {
    _transfers();
    _transfersALC();
    _withdrawForMigration();
    _withdrawAndSwapToETH();
    _withdrawAndSwapToUSDS();
    _swap();
    _deposit();
  }

  function _transfers() internal {
    AaveV3Ethereum.COLLECTOR.transfer(FLUID, MERIT_SAFE, FLUID_AMOUNT);
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDC_A_TOKEN,
      ACI_SAFE,
      USDC_ACI_REIMBURSEMENT
    );
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.WETH_UNDERLYING,
      ACI_SAFE,
      ETH_ACI_REIMBURSEMENT
    );
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.PYUSD_UNDERLYING,
      ACI_SAFE,
      PYUSD_ACI_REIMBURSEMENT
    );
  }

  function _transfersALC() internal {
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.BAL_UNDERLYING,
      ALC_SAFE,
      IERC20(AaveV3EthereumAssets.BAL_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.CRV_UNDERLYING,
      ALC_SAFE,
      IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );

    AaveV3Ethereum.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Ethereum.POOL),
        underlying: AaveV2EthereumAssets.BAL_UNDERLYING,
        amount: IERC20(AaveV2EthereumAssets.BAL_A_TOKEN).balanceOf(
          address(AaveV3Ethereum.COLLECTOR)
        ) - 1 ether
      }),
      ALC_SAFE
    );

    AaveV3Ethereum.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Ethereum.POOL),
        underlying: AaveV2EthereumAssets.CRV_UNDERLYING,
        amount: IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).balanceOf(
          address(AaveV3Ethereum.COLLECTOR)
        ) - 1 ether
      }),
      ALC_SAFE
    );

    AaveV3Ethereum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.BAL_UNDERLYING,
        amount: IERC20(AaveV3EthereumAssets.BAL_A_TOKEN).balanceOf(
          address(AaveV3Ethereum.COLLECTOR)
        ) - 1 ether
      }),
      ALC_SAFE
    );

    AaveV3Ethereum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.CRV_UNDERLYING,
        amount: IERC20(AaveV3EthereumAssets.CRV_A_TOKEN).balanceOf(
          address(AaveV3Ethereum.COLLECTOR)
        ) - 1 ether
      }),
      ALC_SAFE
    );
  }

  function _withdrawForMigration() internal {
    AaveV3Ethereum.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Ethereum.POOL),
        underlying: AaveV2EthereumAssets.WETH_UNDERLYING,
        amount: IERC20(AaveV2EthereumAssets.WETH_A_TOKEN).balanceOf(
          address(AaveV3Ethereum.COLLECTOR)
        ) - 1 ether
      }),
      address(AaveV3Ethereum.COLLECTOR)
    );

    AaveV3Ethereum.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Ethereum.POOL),
        underlying: AaveV2EthereumAssets.WBTC_UNDERLYING,
        amount: IERC20(AaveV2EthereumAssets.WBTC_A_TOKEN).balanceOf(
          address(AaveV3Ethereum.COLLECTOR)
        ) - 1e8
      }),
      address(AaveV3Ethereum.COLLECTOR)
    );

    AaveV3Ethereum.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Ethereum.POOL),
        underlying: AaveV2EthereumAssets.LINK_UNDERLYING,
        amount: IERC20(AaveV2EthereumAssets.LINK_A_TOKEN).balanceOf(
          address(AaveV3Ethereum.COLLECTOR)
        ) - 1 ether
      }),
      address(AaveV3Ethereum.COLLECTOR)
    );

    AaveV3Ethereum.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Ethereum.POOL),
        underlying: AaveV2EthereumAssets.MKR_UNDERLYING,
        amount: IERC20(AaveV2EthereumAssets.MKR_A_TOKEN).balanceOf(
          address(AaveV3Ethereum.COLLECTOR)
        ) - 1 ether
      }),
      address(AaveV3Ethereum.COLLECTOR)
    );

    AaveV3Ethereum.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Ethereum.POOL),
        underlying: AaveV2EthereumAssets.USDC_UNDERLYING,
        amount: AMOUNT_WITHDRAW_USDC
      }),
      address(AaveV3Ethereum.COLLECTOR)
    );

    AaveV3Ethereum.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Ethereum.POOL),
        underlying: AaveV2EthereumAssets.USDT_UNDERLYING,
        amount: AMOUNT_WITHDRAW_USDT
      }),
      address(AaveV3Ethereum.COLLECTOR)
    );
  }

  function _withdrawAndSwapToETH() internal {
    AaveV3Ethereum.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Ethereum.POOL),
        underlying: AaveV2EthereumAssets.DPI_UNDERLYING,
        amount: IERC20(AaveV2EthereumAssets.DPI_A_TOKEN).balanceOf(
          address(AaveV3Ethereum.COLLECTOR)
        ) - 1 ether
      }),
      address(AaveV3Ethereum.COLLECTOR)
    );

    AaveV3Ethereum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.LUSD_UNDERLYING,
        amount: IERC20(AaveV3EthereumAssets.LUSD_A_TOKEN).balanceOf(
          address(AaveV3Ethereum.COLLECTOR)
        ) - 1 ether
      }),
      address(AaveV3Ethereum.COLLECTOR)
    );

    AaveV3Ethereum.COLLECTOR.swap(
      MiscEthereum.AAVE_SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV2EthereumAssets.DPI_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.WETH_UNDERLYING,
        fromUnderlyingPriceFeed: DPI_FEED,
        toUnderlyingPriceFeed: AaveV3EthereumAssets.WETH_ORACLE,
        amount: type(uint256).max,
        slippage: 400
      })
    );

    AaveV3Ethereum.COLLECTOR.swap(
      MiscEthereum.AAVE_SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV3EthereumAssets.LUSD_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.WETH_UNDERLYING,
        fromUnderlyingPriceFeed: LUSD_FEED,
        toUnderlyingPriceFeed: AaveV3EthereumAssets.WETH_ORACLE,
        amount: type(uint256).max,
        slippage: 400
      })
    );
  }

  function _withdrawAndSwapToUSDS() internal {
    AaveV3Ethereum.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Ethereum.POOL),
        underlying: AaveV2EthereumAssets.DAI_UNDERLYING,
        amount: IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(
          address(AaveV3Ethereum.COLLECTOR)
        ) - 1 ether
      }),
      address(AaveV3Ethereum.COLLECTOR)
    );

    AaveV3Ethereum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.DAI_UNDERLYING,
        amount: IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(
          address(AaveV3Ethereum.COLLECTOR)
        ) - 1 ether
      }),
      address(AaveV3Ethereum.COLLECTOR)
    );

    AaveV3Ethereum.COLLECTOR.swap(
      MiscEthereum.AAVE_SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV3EthereumAssets.DAI_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.USDS_UNDERLYING,
        fromUnderlyingPriceFeed: AaveV3EthereumAssets.DAI_ORACLE,
        toUnderlyingPriceFeed: AaveV3EthereumAssets.USDS_ORACLE,
        amount: type(uint256).max,
        slippage: 75
      })
    );
  }

  function _swap() internal {
    AaveV3Ethereum.COLLECTOR.swap(
      MiscEthereum.AAVE_SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV3EthereumAssets.USDC_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.GHO_UNDERLYING,
        fromUnderlyingPriceFeed: AaveV3EthereumAssets.USDC_ORACLE,
        toUnderlyingPriceFeed: GHO_USD_FEED,
        amount: AMOUNT_SWAP_USDC,
        slippage: 75
      })
    );

    AaveV3Ethereum.COLLECTOR.swap(
      MiscEthereum.AAVE_SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV3EthereumAssets.USDT_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.GHO_UNDERLYING,
        fromUnderlyingPriceFeed: AaveV3EthereumAssets.USDT_ORACLE,
        toUnderlyingPriceFeed: GHO_USD_FEED,
        amount: AMOUNT_SWAP_USDT,
        slippage: 75
      })
    );
  }

  function _deposit() internal {
    AaveV3Ethereum.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.USDC_UNDERLYING,
        amount: type(uint256).max
      })
    );

    AaveV3Ethereum.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.USDT_UNDERLYING,
        amount: type(uint256).max
      })
    );

    AaveV3Ethereum.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.WETH_UNDERLYING,
        amount: type(uint256).max
      })
    );

    AaveV3Ethereum.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.WBTC_UNDERLYING,
        amount: type(uint256).max
      })
    );

    AaveV3Ethereum.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.LINK_UNDERLYING,
        amount: type(uint256).max
      })
    );

    AaveV3Ethereum.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.MKR_UNDERLYING,
        amount: type(uint256).max
      })
    );
  }
}
