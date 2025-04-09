// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IGsm} from 'src/interfaces/IGsm.sol';

/**
 * @title April Funding update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-april-funding-update/21590
 */
contract AaveV3Ethereum_AprilFundingUpdate_20250328 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  address public constant MILKMAN = 0x060373D064d0168931dE2AB8DDA7410923d06E88;
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;
  // https://etherscan.io/address/0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC
  address public constant GHO_USD_FEED = 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC;

  uint256 public constant USDC_SWAP_AMOUNT = 2_000_000e6;
  uint256 public constant USDT_SWAP_AMOUNT = 2_000_000e6;

  address public constant FLUID = 0x6f40d4A6237C257fff2dB00FA0510DeEECd303eb;
  // https://etherscan.io/address/0xa9e777D56C0Ad861f6a03967E080e767ad8D39b6
  address public constant EMBASSY_SAFE = 0xa9e777D56C0Ad861f6a03967E080e767ad8D39b6;
  // https://etherscan.io/address/0xdeadD8aB03075b7FBA81864202a2f59EE25B312b
  address public constant MERIT_SAFE = 0xdeadD8aB03075b7FBA81864202a2f59EE25B312b;
  uint256 public constant MERIT_ALLOWANCE = 800_000e6;

  uint256 public constant FUNDING_LINK_AMOUNT = 50e18;
  uint256 public constant FUNDING_ETH_AMOUNT = 1 ether;
  uint128 public constant BUCKET_CAPACITY_GSM = 25_000_000e6;

  // https://etherscan.io/address/0x535b2f7C20B9C83d70e519cf9991578eF9816B7B
  address public constant NEW_GSM_USDT = 0x535b2f7C20B9C83d70e519cf9991578eF9816B7B;

  function execute() external {
    IGsm(NEW_GSM_USDT).updateExposureCap(BUCKET_CAPACITY_GSM);

    _withdrawAndSwap();
    _transferAndApprove();
    _fundToCrossChainController();
  }

  function _withdrawAndSwap() internal {
    AaveV3Ethereum.COLLECTOR.swap(
      MiscEthereum.AAVE_SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV3EthereumAssets.USDC_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.GHO_UNDERLYING,
        fromUnderlyingPriceFeed: AaveV3EthereumAssets.USDC_ORACLE,
        toUnderlyingPriceFeed: GHO_USD_FEED,
        amount: USDC_SWAP_AMOUNT,
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
        amount: USDT_SWAP_AMOUNT,
        slippage: 75
      })
    );
  }

  function _transferAndApprove() internal {
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(FLUID),
      EMBASSY_SAFE,
      IERC20(FLUID).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN),
      MERIT_SAFE,
      MERIT_ALLOWANCE
    );
  }

  function _fundToCrossChainController() internal {
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.LINK_UNDERLYING),
      GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER,
      FUNDING_LINK_AMOUNT
    );
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3Ethereum.COLLECTOR.ETH_MOCK_ADDRESS()),
      GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER,
      FUNDING_ETH_AMOUNT
    );
  }
}
