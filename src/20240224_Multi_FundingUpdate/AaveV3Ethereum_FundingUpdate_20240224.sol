// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveSwapper} from 'aave-helpers/swaps/AaveSwapper.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Funding Update
 * @author karpatkey_TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x4dd4dff7096bf7ab8c4c071975d40f4cf709c41b4b6b7c60777a6dd50d2ecd09
 * - Discussion: https://governance.aave.com/t/arfc-funding-update/16675
 */
contract AaveV3Ethereum_FundingUpdate_20240224 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  struct TokenToSwap {
    address underlying;
    address aToken;
    address oracle;
  }

  AaveSwapper public constant SWAPPER = AaveSwapper(MiscEthereum.AAVE_SWAPPER);
  address public constant ALC_SAFE = 0x205e795336610f5131Be52F09218AF19f0f3eC60;

  address public constant TUSD_USD_FEED = 0xec746eCF986E2927Abd291a2A1716c940100f8Ba; // CHECK!
  address public constant BUSD_USD_FEED = 0x833D8Eb16D306ed1FbB5D7A2E019e106B960965A; // CHECK!
  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;

  uint256 public constant USDC_V2_TO_MIGRATE = 300_000e6;
  uint256 public constant USDC_V3_TO_SWAP = 1_250_000e6;
  uint256 public constant USDT_V3_TO_SWAP = 1_500_000e6;
  uint256 public constant USDT_V2_TO_SWAP = 200_000e6;
  uint256 public constant BUSD_V2_TO_SWAP = 50 ether;

  function execute() external {
    _migrate();
    _swap();
  }

  function _swap() internal {
    // AaveV3EthereumAssets.LUSD_A_TOKEN,

    address[7] memory tokens = aTokensToWithdraw();

    for (uint256 i = 0; i < 6; i++) {
      AaveV3Ethereum.COLLECTOR.transfer(
        tokens[i],
        address(SWAPPER),
        IERC20(tokens[i]).balanceOf(address(AaveV3Ethereum.COLLECTOR)) - 1 ether
      );

      SWAPPER.swap(
        MILKMAN,
        PRICE_CHECKER,
        AaveV2EthereumAssets.UST_UNDERLYING,
        AaveV2EthereumAssets.USDC_UNDERLYING,
        AaveV2EthereumAssets.UST_ORACLE,
        AaveV2EthereumAssets.USDC_ORACLE,
        address(AaveV3Ethereum.COLLECTOR),
        balanceUst,
        600
      );
    }
  }

  function _migrate() internal {}

  function _tokensToMigrate() internal view returns (address[] memory) {}

  function aTokensToWithdraw() public pure returns (address[6] memory) {
    address[6] memory addresses = [
      AaveV2EthereumAssets.LUSD_A_TOKEN,
      AaveV2EthereumAssets.TUSD_A_TOKEN,
      AaveV2EthereumAssets.AMPL_A_TOKEN,
      AaveV2EthereumAssets.DAI_A_TOKEN,
      AaveV2EthereumAssets.DPI_A_TOKEN,
      AaveV2EthereumAssets.FRAX_A_TOKEN
    ];
    return addresses;
  }

  function underlyingTokensToWithdraw() public pure returns (address[7] memory) {
    address[7] memory addresses = [
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      AaveV2EthereumAssets.LUSD_UNDERLYING,
      AaveV2EthereumAssets.TUSD_UNDERLYING,
      AaveV2EthereumAssets.AMPL_UNDERLYING,
      AaveV2EthereumAssets.DAI_UNDERLYING,
      AaveV2EthereumAssets.DPI_UNDERLYING,
      AaveV2EthereumAssets.FRAX_UNDERLYING
    ];
    return addresses;
  }
}
