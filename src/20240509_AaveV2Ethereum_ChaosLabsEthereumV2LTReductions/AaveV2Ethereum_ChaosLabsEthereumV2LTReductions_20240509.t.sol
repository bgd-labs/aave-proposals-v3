// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_ChaosLabsEthereumV2LTReductions_20240509} from './AaveV2Ethereum_ChaosLabsEthereumV2LTReductions_20240509.sol';

/**
 * @dev Test for AaveV2Ethereum_ChaosLabsEthereumV2LTReductions_20240509
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240509_AaveV2Ethereum_ChaosLabsEthereumV2LTReductions/AaveV2Ethereum_ChaosLabsEthereumV2LTReductions_20240509.t.sol -vv
 */
contract AaveV2Ethereum_ChaosLabsEthereumV2LTReductions_20240509_Test is ProtocolV2TestBase {
  AaveV2Ethereum_ChaosLabsEthereumV2LTReductions_20240509 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19832836);
    proposal = new AaveV2Ethereum_ChaosLabsEthereumV2LTReductions_20240509();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV2Ethereum_ChaosLabsEthereumV2LTReductions_20240509',
      AaveV2Ethereum.POOL,
      address(proposal)
    );
    address[] memory assetsChanged = new address[](2);

    assetsChanged[0] = AaveV2EthereumAssets.LINK_UNDERLYING;
    assetsChanged[1] = AaveV2EthereumAssets.ZRX_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    ReserveConfig memory LINK_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.LINK_UNDERLYING
    );
    LINK_UNDERLYING_CONFIG.liquidationThreshold = 65_00;
    _validateReserveConfig(LINK_UNDERLYING_CONFIG, allConfigsAfter);

    ReserveConfig memory ZRX_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.ZRX_UNDERLYING
    );
    ZRX_UNDERLYING_CONFIG.liquidationThreshold = 1;
    _validateReserveConfig(ZRX_UNDERLYING_CONFIG, allConfigsAfter);
  }
}
