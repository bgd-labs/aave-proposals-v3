// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_EthereumV2LTReductions_20240416} from './AaveV2Ethereum_EthereumV2LTReductions_20240416.sol';

/**
 * @dev Test for AaveV2Ethereum_EthereumV2LTReductions_20240416
 * command: make test-contract filter=AaveV2Ethereum_EthereumV2LTReductions_20240416
 */
contract AaveV2Ethereum_EthereumV2LTReductions_20240416_Test is ProtocolV2TestBase {
  AaveV2Ethereum_EthereumV2LTReductions_20240416 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19666652);
    proposal = new AaveV2Ethereum_EthereumV2LTReductions_20240416();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV2Ethereum_EthereumV2LTReductions_20240416',
      AaveV2Ethereum.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](5);

    assetsChanged[0] = AaveV2EthereumAssets.CRV_UNDERLYING;
    assetsChanged[1] = AaveV2EthereumAssets.LINK_UNDERLYING;
    assetsChanged[2] = AaveV2EthereumAssets.MKR_UNDERLYING;
    assetsChanged[3] = AaveV2EthereumAssets.UNI_UNDERLYING;
    assetsChanged[4] = AaveV2EthereumAssets.ZRX_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);
    {
      ReserveConfig memory CRV_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.CRV_UNDERLYING
      );
      CRV_UNDERLYING_CONFIG.liquidationThreshold = 1;
      _validateReserveConfig(CRV_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory LINK_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.LINK_UNDERLYING
      );
      LINK_UNDERLYING_CONFIG.liquidationThreshold = 68_00;
      _validateReserveConfig(LINK_UNDERLYING_CONFIG, allConfigsAfter);
    }

    {
      ReserveConfig memory MKR_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.MKR_UNDERLYING
      );
      MKR_UNDERLYING_CONFIG.liquidationThreshold = 10_00;
      _validateReserveConfig(MKR_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory UNI_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.UNI_UNDERLYING
      );
      UNI_UNDERLYING_CONFIG.liquidationThreshold = 1;
      _validateReserveConfig(UNI_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory ZRX_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.ZRX_UNDERLYING
      );
      ZRX_UNDERLYING_CONFIG.liquidationThreshold = 5_00;
      _validateReserveConfig(ZRX_UNDERLYING_CONFIG, allConfigsAfter);
    }
  }
}
