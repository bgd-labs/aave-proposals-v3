// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2EthereumAMM} from 'aave-address-book/AaveV2EthereumAMM.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_AaveV2DeprecationUpdate_20250925} from './AaveV2Ethereum_AaveV2DeprecationUpdate_20250925.sol';
import {IERC20Metadata} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_AaveV2DeprecationUpdate_20250925} from './AaveV2Ethereum_AaveV2DeprecationUpdate_20250925.sol';
import {IClinicSteward} from 'src/interfaces/IClinicSteward.sol';

/**
 * @dev Test for AaveV2Ethereum_AaveV2DeprecationUpdate_20250925
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250925_Multi_AaveV2DeprecationUpdate/AaveV2Ethereum_AaveV2DeprecationUpdate_20250925.t.sol -vv
 */
contract AaveV2Ethereum_AaveV2DeprecationUpdate_20250925_Test is ProtocolV2TestBase {
  AaveV2Ethereum_AaveV2DeprecationUpdate_20250925 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23435818);
    proposal = new AaveV2Ethereum_AaveV2DeprecationUpdate_20250925();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Ethereum_AaveV2DeprecationUpdate_20250925',
      AaveV2Ethereum.POOL,
      address(proposal),
      // set to generate seatbelt (disabled to avoid generation on ci)
      true,
      true
    );

    // validate token metadata
    assertEq(IERC20Metadata(AaveV2EthereumAssets.WBTC_A_TOKEN).symbol(), 'aWBTC');
    assertEq(
      IERC20Metadata(AaveV2EthereumAssets.WBTC_A_TOKEN).name(),
      'Aave interest bearing WBTC'
    );

    // validate budgets
    assertEq(IClinicSteward(AaveV2Ethereum.CLINIC_STEWARD).availableBudget(), 1_000_000e8);
    assertEq(IClinicSteward(AaveV2EthereumAMM.CLINIC_STEWARD).availableBudget(), 2_500e8);
  }

  function test_reserveFreezing() public {
    address[6] memory assets = [
      AaveV2EthereumAssets.WETH_UNDERLYING,
      AaveV2EthereumAssets.WBTC_UNDERLYING,
      AaveV2EthereumAssets.USDC_UNDERLYING,
      AaveV2EthereumAssets.USDT_UNDERLYING,
      AaveV2EthereumAssets.DAI_UNDERLYING,
      AaveV2EthereumAssets.stETH_UNDERLYING
    ];

    executePayload(vm, address(proposal));

    ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(AaveV2Ethereum.POOL);

    for (uint256 i = 0; i < assets.length; i++) {
      ReserveConfig memory cfgAfter = _findReserveConfig(allConfigsAfter, assets[i]);
      assertTrue(cfgAfter.isFrozen, 'Reserve should be frozen');
    }
  }
}
