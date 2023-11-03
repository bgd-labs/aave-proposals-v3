// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_AaveV2EthereumLTReduction_20231030} from './AaveV2Ethereum_AaveV2EthereumLTReduction_20231030.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';

/**
 * @dev Test for AaveV2Ethereum_AaveV2EthereumLTReduction_20231030
 * command: make test-contract filter=AaveV2Ethereum_AaveV2EthereumLTReduction_20231030_Test
 */
contract AaveV2Ethereum_AaveV2EthereumLTReduction_20231030_Test is ProtocolV2TestBase {
  AaveV2Ethereum_AaveV2EthereumLTReduction_20231030 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18463852);
    proposal = new AaveV2Ethereum_AaveV2EthereumLTReduction_20231030();
  }

  function testProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV2Ethereum_AaveV2EthereumLTReduction_20231030',
      AaveV2Ethereum.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](15);

    assetsChanged[0] = AaveV2EthereumAssets.ONE_INCH_UNDERLYING;
    assetsChanged[1] = AaveV2EthereumAssets.BAL_UNDERLYING;
    assetsChanged[2] = AaveV2EthereumAssets.CRV_UNDERLYING;
    assetsChanged[3] = AaveV2EthereumAssets.CVX_UNDERLYING;
    assetsChanged[4] = AaveV2EthereumAssets.DPI_UNDERLYING;
    assetsChanged[5] = AaveV2EthereumAssets.ENS_UNDERLYING;
    assetsChanged[6] = AaveV2EthereumAssets.MANA_UNDERLYING;
    assetsChanged[7] = AaveV2EthereumAssets.MKR_UNDERLYING;
    assetsChanged[8] = AaveV2EthereumAssets.REN_UNDERLYING;
    assetsChanged[9] = AaveV2EthereumAssets.SNX_UNDERLYING;
    assetsChanged[10] = AaveV2EthereumAssets.UNI_UNDERLYING;
    assetsChanged[11] = AaveV2EthereumAssets.xSUSHI_UNDERLYING;
    assetsChanged[12] = AaveV2EthereumAssets.YFI_UNDERLYING;
    assetsChanged[13] = AaveV2EthereumAssets.ZRX_UNDERLYING;
    assetsChanged[14] = AaveV2EthereumAssets.LINK_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    {
      ReserveConfig memory ONE_INCH_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.ONE_INCH_UNDERLYING
      );
      ONE_INCH_UNDERLYING_CONFIG.liquidationThreshold = 1_00;
      _validateReserveConfig(ONE_INCH_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory BAL_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.BAL_UNDERLYING
      );
      BAL_UNDERLYING_CONFIG.liquidationThreshold = 21_00;
      _validateReserveConfig(BAL_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory CRV_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.CRV_UNDERLYING
      );
      CRV_UNDERLYING_CONFIG.liquidationThreshold = 38_00;
      _validateReserveConfig(CRV_UNDERLYING_CONFIG, allConfigsAfter);
    }

    {
      ReserveConfig memory CVX_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.CVX_UNDERLYING
      );
      CVX_UNDERLYING_CONFIG.liquidationThreshold = 30_00;
      _validateReserveConfig(CVX_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory DPI_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.DPI_UNDERLYING
      );
      DPI_UNDERLYING_CONFIG.liquidationThreshold = 14_00;
      _validateReserveConfig(DPI_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory ENS_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.ENS_UNDERLYING
      );
      ENS_UNDERLYING_CONFIG.liquidationThreshold = 47_00;
      _validateReserveConfig(ENS_UNDERLYING_CONFIG, allConfigsAfter);
    }

    {
      ReserveConfig memory MANA_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.MANA_UNDERLYING
      );
      MANA_UNDERLYING_CONFIG.liquidationThreshold = 37_00;
      _validateReserveConfig(MANA_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory MKR_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.MKR_UNDERLYING
      );
      MKR_UNDERLYING_CONFIG.liquidationThreshold = 30_00;
      _validateReserveConfig(MKR_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory REN_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.REN_UNDERLYING
      );
      REN_UNDERLYING_CONFIG.liquidationThreshold = 25_00;
      _validateReserveConfig(REN_UNDERLYING_CONFIG, allConfigsAfter);
    }

    {
      ReserveConfig memory SNX_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.SNX_UNDERLYING
      );
      SNX_UNDERLYING_CONFIG.liquidationThreshold = 41_00;
      _validateReserveConfig(SNX_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory UNI_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.UNI_UNDERLYING
      );
      UNI_UNDERLYING_CONFIG.liquidationThreshold = 64_00;
      _validateReserveConfig(UNI_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory xSUSHI_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.xSUSHI_UNDERLYING
      );
      xSUSHI_UNDERLYING_CONFIG.liquidationThreshold = 1_00;
      _validateReserveConfig(xSUSHI_UNDERLYING_CONFIG, allConfigsAfter);
    }

    {
      ReserveConfig memory YFI_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.YFI_UNDERLYING
      );
      YFI_UNDERLYING_CONFIG.liquidationThreshold = 43_00;
      _validateReserveConfig(YFI_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory ZRX_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.ZRX_UNDERLYING
      );
      ZRX_UNDERLYING_CONFIG.liquidationThreshold = 34_00;
      _validateReserveConfig(ZRX_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory LINK_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.LINK_UNDERLYING
      );
      LINK_UNDERLYING_CONFIG.liquidationThreshold = 81_00;
      _validateReserveConfig(LINK_UNDERLYING_CONFIG, allConfigsAfter);
    }
  }
}
