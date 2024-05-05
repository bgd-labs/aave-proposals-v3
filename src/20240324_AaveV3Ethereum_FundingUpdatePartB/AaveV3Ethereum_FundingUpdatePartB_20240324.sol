// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveSwapper} from 'aave-helpers/swaps/AaveSwapper.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

interface IWETH {
  function deposit(uint256) external payable;
}

/**
 * @title Funding Update (Part B)
 * @author karpatkey_TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x4dd4dff7096bf7ab8c4c071975d40f4cf709c41b4b6b7c60777a6dd50d2ecd09
 * - Discussion: https://governance.aave.com/t/arfc-funding-update/16675/4
 */
contract AaveV3Ethereum_FundingUpdatePartB_20240324 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  AaveSwapper public constant SWAPPER = AaveSwapper(MiscEthereum.AAVE_SWAPPER);

  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;

  address public constant ALC_SAFE = 0x205e795336610f5131Be52F09218AF19f0f3eC60;
  address public constant GHO_USD_FEED = 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC;
  address public constant DPI_USD_FEED = 0xD2A593BF7594aCE1faD597adb697b5645d5edDB2;

  address public constant ETH_MOCK_ADDRESS = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

  uint256 public constant USDC_V2_TO_SWAP = 640_000e6;
  uint256 public constant DPI_TO_SWAP = 350 ether;

  function execute() external {
    // BAL
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.BAL_UNDERLYING,
      ALC_SAFE,
      IERC20(AaveV3EthereumAssets.BAL_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );

    // CRV
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.CRV_UNDERLYING,
      ALC_SAFE,
      IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );

    // DAI Deposit
    uint256 daiBalance = IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      address(this),
      daiBalance
    );
    IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).forceApprove(
      address(AaveV3Ethereum.POOL),
      daiBalance
    );

    AaveV3Ethereum.POOL.deposit(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      daiBalance,
      address(AaveV3Ethereum.COLLECTOR),
      0
    );

    // wETH Deposit
    uint256 ethBalance = address(AaveV3Ethereum.COLLECTOR).balance;
    AaveV3Ethereum.COLLECTOR.transfer(ETH_MOCK_ADDRESS, address(this), ethBalance);
    IWETH(AaveV3EthereumAssets.WETH_UNDERLYING).deposit{value: ethBalance}(ethBalance);
    IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).forceApprove(
      address(AaveV3Ethereum.POOL),
      ethBalance
    );

    AaveV3Ethereum.POOL.deposit(
      AaveV3EthereumAssets.WETH_UNDERLYING,
      ethBalance,
      address(AaveV3Ethereum.COLLECTOR),
      0
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.USDC_A_TOKEN,
      address(this),
      USDC_V2_TO_SWAP
    );

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      type(uint256).max,
      address(SWAPPER)
    );

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      GHO_USD_FEED,
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(address(SWAPPER)),
      100
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.DPI_UNDERLYING,
      address(SWAPPER),
      DPI_TO_SWAP
    );

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV2EthereumAssets.DPI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      DPI_USD_FEED,
      GHO_USD_FEED,
      address(AaveV3Ethereum.COLLECTOR),
      DPI_TO_SWAP,
      700
    );
  }

  receive() external payable {}
}
