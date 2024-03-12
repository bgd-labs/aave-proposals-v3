// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_EthereumV2ReserveFactorAdjustment_20240304} from './AaveV2Ethereum_EthereumV2ReserveFactorAdjustment_20240304.sol';

/**
 * @dev Test for AaveV2Ethereum_EthereumV2ReserveFactorAdjustment_20240304
 * command: make test-contract filter=AaveV2Ethereum_EthereumV2ReserveFactorAdjustment_20240304
 */
contract AaveV2Ethereum_EthereumV2ReserveFactorAdjustment_20240304_Test is ProtocolV2TestBase {
  AaveV2Ethereum_EthereumV2ReserveFactorAdjustment_20240304 internal proposal;

  struct Changes {
    address asset;
    uint256 reserveFactor;
  }

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19363829);
    proposal = new AaveV2Ethereum_EthereumV2ReserveFactorAdjustment_20240304();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV2Ethereum_ReserveFactorUpdates_20240102',
      AaveV2Ethereum.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](34);
    assetsChanged[0] = AaveV2EthereumAssets.ONE_INCH_UNDERLYING;
    assetsChanged[1] = AaveV2EthereumAssets.AMPL_UNDERLYING;
    assetsChanged[2] = AaveV2EthereumAssets.BUSD_UNDERLYING;
    assetsChanged[3] = AaveV2EthereumAssets.BAL_UNDERLYING;
    assetsChanged[4] = AaveV2EthereumAssets.BAT_UNDERLYING;
    assetsChanged[5] = AaveV2EthereumAssets.CRV_UNDERLYING;
    assetsChanged[6] = AaveV2EthereumAssets.CVX_UNDERLYING;
    assetsChanged[7] = AaveV2EthereumAssets.DAI_UNDERLYING;
    assetsChanged[8] = AaveV2EthereumAssets.DPI_UNDERLYING;
    assetsChanged[9] = AaveV2EthereumAssets.ENS_UNDERLYING;
    assetsChanged[10] = AaveV2EthereumAssets.ENJ_UNDERLYING;
    assetsChanged[11] = AaveV2EthereumAssets.FEI_UNDERLYING;
    assetsChanged[12] = AaveV2EthereumAssets.FRAX_UNDERLYING;
    assetsChanged[13] = AaveV2EthereumAssets.GUSD_UNDERLYING;
    assetsChanged[14] = AaveV2EthereumAssets.KNC_UNDERLYING;
    assetsChanged[15] = AaveV2EthereumAssets.LINK_UNDERLYING;
    assetsChanged[16] = AaveV2EthereumAssets.LUSD_UNDERLYING;
    assetsChanged[17] = AaveV2EthereumAssets.MANA_UNDERLYING;
    assetsChanged[18] = AaveV2EthereumAssets.MKR_UNDERLYING;
    assetsChanged[19] = AaveV2EthereumAssets.RAI_UNDERLYING;
    assetsChanged[20] = AaveV2EthereumAssets.REN_UNDERLYING;
    assetsChanged[21] = AaveV2EthereumAssets.SNX_UNDERLYING;
    assetsChanged[22] = AaveV2EthereumAssets.sUSD_UNDERLYING;
    assetsChanged[23] = AaveV2EthereumAssets.xSUSHI_UNDERLYING;
    assetsChanged[24] = AaveV2EthereumAssets.TUSD_UNDERLYING;
    assetsChanged[25] = AaveV2EthereumAssets.UNI_UNDERLYING;
    assetsChanged[26] = AaveV2EthereumAssets.USDC_UNDERLYING;
    assetsChanged[27] = AaveV2EthereumAssets.USDP_UNDERLYING;
    assetsChanged[28] = AaveV2EthereumAssets.USDT_UNDERLYING;
    assetsChanged[29] = AaveV2EthereumAssets.UST_UNDERLYING;
    assetsChanged[30] = AaveV2EthereumAssets.WBTC_UNDERLYING;
    assetsChanged[31] = AaveV2EthereumAssets.WETH_UNDERLYING;
    assetsChanged[32] = AaveV2EthereumAssets.YFI_UNDERLYING;
    assetsChanged[33] = AaveV2EthereumAssets.ZRX_UNDERLYING;

    Changes[] memory assetChanges = new Changes[](34);
    assetChanges[0] = Changes({
      asset: AaveV2EthereumAssets.ONE_INCH_UNDERLYING,
      reserveFactor: proposal.ONE_INCH_RF()
    });
    assetChanges[1] = Changes({
      asset: AaveV2EthereumAssets.AMPL_UNDERLYING,
      reserveFactor: proposal.AMPL_RF()
    });
    assetChanges[2] = Changes({
      asset: AaveV2EthereumAssets.BUSD_UNDERLYING,
      reserveFactor: proposal.BUSD_RF()
    });
    assetChanges[3] = Changes({
      asset: AaveV2EthereumAssets.BAL_UNDERLYING,
      reserveFactor: proposal.BAL_RF()
    });
    assetChanges[4] = Changes({
      asset: AaveV2EthereumAssets.BAT_UNDERLYING,
      reserveFactor: proposal.BAT_RF()
    });
    assetChanges[5] = Changes({
      asset: AaveV2EthereumAssets.CRV_UNDERLYING,
      reserveFactor: proposal.CRV_RF()
    });
    assetChanges[6] = Changes({
      asset: AaveV2EthereumAssets.CVX_UNDERLYING,
      reserveFactor: proposal.CVX_RF()
    });
    assetChanges[7] = Changes({
      asset: AaveV2EthereumAssets.DAI_UNDERLYING,
      reserveFactor: proposal.DAI_RF()
    });
    assetChanges[8] = Changes({
      asset: AaveV2EthereumAssets.DPI_UNDERLYING,
      reserveFactor: proposal.DPI_RF()
    });
    assetChanges[9] = Changes({
      asset: AaveV2EthereumAssets.ENS_UNDERLYING,
      reserveFactor: proposal.ENS_RF()
    });
    assetChanges[10] = Changes({
      asset: AaveV2EthereumAssets.ENJ_UNDERLYING,
      reserveFactor: proposal.ENJ_RF()
    });
    assetChanges[11] = Changes({
      asset: AaveV2EthereumAssets.FEI_UNDERLYING,
      reserveFactor: proposal.FEI_RF()
    });
    assetChanges[12] = Changes({
      asset: AaveV2EthereumAssets.FRAX_UNDERLYING,
      reserveFactor: proposal.FRAX_RF()
    });
    assetChanges[13] = Changes({
      asset: AaveV2EthereumAssets.GUSD_UNDERLYING,
      reserveFactor: proposal.GUSD_RF()
    });
    assetChanges[14] = Changes({
      asset: AaveV2EthereumAssets.KNC_UNDERLYING,
      reserveFactor: proposal.KNC_RF()
    });
    assetChanges[15] = Changes({
      asset: AaveV2EthereumAssets.LINK_UNDERLYING,
      reserveFactor: proposal.LINK_RF()
    });
    assetChanges[16] = Changes({
      asset: AaveV2EthereumAssets.LUSD_UNDERLYING,
      reserveFactor: proposal.LUSD_RF()
    });
    assetChanges[17] = Changes({
      asset: AaveV2EthereumAssets.MANA_UNDERLYING,
      reserveFactor: proposal.MANA_RF()
    });
    assetChanges[18] = Changes({
      asset: AaveV2EthereumAssets.MKR_UNDERLYING,
      reserveFactor: proposal.MKR_RF()
    });
    assetChanges[19] = Changes({
      asset: AaveV2EthereumAssets.RAI_UNDERLYING,
      reserveFactor: proposal.RAI_RF()
    });
    assetChanges[20] = Changes({
      asset: AaveV2EthereumAssets.REN_UNDERLYING,
      reserveFactor: proposal.REN_RF()
    });
    assetChanges[21] = Changes({
      asset: AaveV2EthereumAssets.SNX_UNDERLYING,
      reserveFactor: proposal.SNX_RF()
    });
    assetChanges[22] = Changes({
      asset: AaveV2EthereumAssets.sUSD_UNDERLYING,
      reserveFactor: proposal.sUSD_RF()
    });
    assetChanges[23] = Changes({
      asset: AaveV2EthereumAssets.xSUSHI_UNDERLYING,
      reserveFactor: proposal.xSUSHI_RF()
    });
    assetChanges[24] = Changes({
      asset: AaveV2EthereumAssets.TUSD_UNDERLYING,
      reserveFactor: proposal.TUSD_RF()
    });
    assetChanges[25] = Changes({
      asset: AaveV2EthereumAssets.UNI_UNDERLYING,
      reserveFactor: proposal.UNI_RF()
    });
    assetChanges[26] = Changes({
      asset: AaveV2EthereumAssets.USDC_UNDERLYING,
      reserveFactor: proposal.USDC_RF()
    });
    assetChanges[27] = Changes({
      asset: AaveV2EthereumAssets.USDP_UNDERLYING,
      reserveFactor: proposal.USDP_RF()
    });
    assetChanges[28] = Changes({
      asset: AaveV2EthereumAssets.USDT_UNDERLYING,
      reserveFactor: proposal.USDT_RF()
    });
    assetChanges[29] = Changes({
      asset: AaveV2EthereumAssets.UST_UNDERLYING,
      reserveFactor: proposal.UST_RF()
    });
    assetChanges[30] = Changes({
      asset: AaveV2EthereumAssets.WBTC_UNDERLYING,
      reserveFactor: proposal.WBTC_RF()
    });
    assetChanges[31] = Changes({
      asset: AaveV2EthereumAssets.WETH_UNDERLYING,
      reserveFactor: proposal.WETH_RF()
    });
    assetChanges[32] = Changes({
      asset: AaveV2EthereumAssets.YFI_UNDERLYING,
      reserveFactor: proposal.YFI_RF()
    });
    assetChanges[33] = Changes({
      asset: AaveV2EthereumAssets.ZRX_UNDERLYING,
      reserveFactor: proposal.ZRX_RF()
    });

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    for (uint i = 0; i < assetChanges.length; i++) {
      ReserveConfig memory cfg = _findReserveConfig(allConfigsAfter, assetChanges[i].asset);
      assertEq(cfg.reserveFactor, assetChanges[i].reserveFactor);
    }
  }
}
