// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3PayloadEthereumLido} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereumLido.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @title Onboard GHO and Migrate Streams to Lido Instance
 * @author karpatkey_TokenLogic
 * - Snapshot: TBD
 * - Discussion: https://governance.aave.com/t/arfc-onboard-gho-and-migrate-streams-to-lido-instance/19686
 */
contract AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance_20241104 is
  AaveV3PayloadEthereumLido
{
  using SafeERC20 for IERC20;

  uint256 public constant STREAM_0 = 100034;
  uint256 public constant STREAM_1 = 100039;
  uint256 public constant STREAM_2 = 100046;
  uint256 public constant STREAM_3 = 100048;

  address public constant AGD_MULTISIG = 0x89C51828427F70D77875C6747759fB17Ba10Ceb0;

  uint256 public GHO_SEED_AMOUNT;

  function _postExecute() internal override {
    (address aTokenAddress, , ) = AaveV3EthereumLido
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(AaveV3EthereumAssets.GHO_UNDERLYING);

    uint256[] memory streamIds = new uint256[](4);
    streamIds[0] = STREAM_0;
    streamIds[1] = STREAM_1;
    streamIds[2] = STREAM_2;
    streamIds[3] = STREAM_3;
    // sends all remaining balances to receiver of stream
    for (uint256 i = 0; i < 4; ) {
      (
        ,
        address recipient,
        uint256 deposit,
        ,
        uint256 startTime,
        uint256 stopTime,
        uint256 remainingBalance,
        uint256 ratePerSecond
      ) = AaveV3EthereumLido.COLLECTOR.getStream(streamIds[i]);

      uint256 withdrawalBalance = AaveV3EthereumLido.COLLECTOR.balanceOf(streamIds[i], recipient);
      AaveV3EthereumLido.COLLECTOR.cancelStream(streamIds[i]);

      if (remainingBalance > withdrawalBalance) {
        // create streams with a token
        CollectorUtils.stream(
          AaveV3EthereumLido.COLLECTOR,
          CollectorUtils.CreateStreamInput({
            underlying: aTokenAddress,
            receiver: recipient,
            amount: remainingBalance - withdrawalBalance,
            start: startTime < block.timestamp ? block.timestamp : startTime,
            duration: startTime < block.timestamp
              ? stopTime - block.timestamp
              : stopTime - startTime
          })
        );
      }

      unchecked {
        ++i;
      }
    }

    GHO_SEED_AMOUNT = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3EthereumLido.COLLECTOR)
    );
    AaveV3EthereumLido.COLLECTOR.transfer(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      address(this),
      GHO_SEED_AMOUNT
    );
    IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).forceApprove(
      address(AaveV3EthereumLido.POOL),
      GHO_SEED_AMOUNT
    );
    AaveV3EthereumLido.POOL.supply(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      GHO_SEED_AMOUNT,
      address(AaveV3EthereumLido.COLLECTOR),
      0
    );

    if (
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
        address(AaveV3EthereumLido.COLLECTOR),
        AGD_MULTISIG
      ) > 0
    ) {
      AaveV3EthereumLido.COLLECTOR.approve(AaveV3EthereumAssets.GHO_UNDERLYING, AGD_MULTISIG, 0);
    }
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: AaveV3EthereumAssets.GHO_UNDERLYING,
      assetSymbol: 'GHO',
      priceFeed: 0xD110cac5d8682A3b045D5524a9903E031d70FCCd,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 7_50,
      reserveFactor: 10_00,
      supplyCap: 20_000_000,
      borrowCap: 2_500_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 92_00,
        baseVariableBorrowRate: 4_50,
        variableRateSlope1: 3_00,
        variableRateSlope2: 50_00
      })
    });

    return listings;
  }
}
