// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_Disable_Stable_Borrows_20231104} from './AaveV2Ethereum_Disable_Stable_Borrows_20231104.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IAaveOracle, ILendingPool, ILendingPoolAddressesProvider, ILendingPoolConfigurator, IAaveProtocolDataProvider, DataTypes, TokenData, ILendingRateOracle, IDefaultInterestRateStrategy} from 'aave-address-book/AaveV2.sol';

/**
 * @dev Test for AaveV2Ethereum_Disable_Stable_Borrows_20231104
 * command: make test-contract filter=AaveV2Ethereum_Disable_Stable_Borrows_20231104
 */
contract AaveV2Ethereum_Disable_Stable_Borrows_20231104_Test is ProtocolV2TestBase {
  AaveV2Ethereum_Disable_Stable_Borrows_20231104 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18500285);
    proposal = new AaveV2Ethereum_Disable_Stable_Borrows_20231104();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    // Small patch to get the diffs without executing e2e tests as pool is paused and actions will fail
    string memory reportName = 'AaveV2Ethereum_Disable_Stable_Borrows_20231104';
    address payload = address(proposal);
    ILendingPool pool = AaveV2Ethereum.POOL;

    string memory beforeString = string(abi.encodePacked(reportName, '_before'));
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(beforeString, pool);

    executePayload(vm, payload);

    string memory afterString = string(abi.encodePacked(reportName, '_after'));
    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(afterString, pool);

    diffReports(beforeString, afterString);

    address[] memory assetsChanged = new address[](13);

    assetsChanged[0] = AaveV2EthereumAssets.USDT_UNDERLYING;
    assetsChanged[1] = AaveV2EthereumAssets.WBTC_UNDERLYING;
    assetsChanged[2] = AaveV2EthereumAssets.WETH_UNDERLYING;
    assetsChanged[3] = AaveV2EthereumAssets.ZRX_UNDERLYING;
    assetsChanged[4] = AaveV2EthereumAssets.BAT_UNDERLYING;
    assetsChanged[5] = AaveV2EthereumAssets.ENJ_UNDERLYING;
    assetsChanged[6] = AaveV2EthereumAssets.KNC_UNDERLYING;
    assetsChanged[7] = AaveV2EthereumAssets.LINK_UNDERLYING;
    assetsChanged[8] = AaveV2EthereumAssets.MANA_UNDERLYING;
    assetsChanged[9] = AaveV2EthereumAssets.MKR_UNDERLYING;
    assetsChanged[10] = AaveV2EthereumAssets.REN_UNDERLYING;
    assetsChanged[11] = AaveV2EthereumAssets.USDC_UNDERLYING;
    assetsChanged[12] = AaveV2EthereumAssets.LUSD_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    for (uint256 i = 0; i < assetsChanged.length; i++) {
      ReserveConfig memory config = _findReserveConfig(
        allConfigsBefore,
        assetsChanged[i]
      );
      config.stableBorrowRateEnabled = false;
      _validateReserveConfig(config, allConfigsAfter);
    }

    for (uint256 i = 0; i < allConfigsAfter.length; i++) {
      require(allConfigsAfter[i].stableBorrowRateEnabled == false);
    }
  }
}
