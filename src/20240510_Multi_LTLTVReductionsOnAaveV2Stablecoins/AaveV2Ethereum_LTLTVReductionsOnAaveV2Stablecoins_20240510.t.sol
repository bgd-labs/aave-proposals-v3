// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_LTLTVReductionsOnAaveV2Stablecoins_20240510} from './AaveV2Ethereum_LTLTVReductionsOnAaveV2Stablecoins_20240510.sol';

/**
 * @dev Test for AaveV2Ethereum_LTLTVReductionsOnAaveV2Stablecoins_20240510
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240510_Multi_LTLTVReductionsOnAaveV2Stablecoins/AaveV2Ethereum_LTLTVReductionsOnAaveV2Stablecoins_20240510.t.sol -vv
 */
contract AaveV2Ethereum_LTLTVReductionsOnAaveV2Stablecoins_20240510_Test is ProtocolV2TestBase {
  AaveV2Ethereum_LTLTVReductionsOnAaveV2Stablecoins_20240510 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19841442);
    proposal = new AaveV2Ethereum_LTLTVReductionsOnAaveV2Stablecoins_20240510();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV2Ethereum_LTLTVReductionsOnAaveV2Stablecoins_20240510',
      AaveV2Ethereum.POOL,
      address(proposal)
    );
    address[] memory assetsChanged = new address[](1);

    assetsChanged[0] = AaveV2EthereumAssets.USDC_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    ReserveConfig memory USDC_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.USDC_UNDERLYING
    );
    USDC_UNDERLYING_CONFIG.ltv = 75_00;
    _validateReserveConfig(USDC_UNDERLYING_CONFIG, allConfigsAfter);
  }
}
