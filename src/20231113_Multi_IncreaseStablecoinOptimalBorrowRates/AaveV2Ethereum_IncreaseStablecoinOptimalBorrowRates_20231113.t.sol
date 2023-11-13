// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_IncreaseStablecoinOptimalBorrowRates_20231113} from './AaveV2Ethereum_IncreaseStablecoinOptimalBorrowRates_20231113.sol';

/**
 * @dev Test for AaveV2Ethereum_IncreaseStablecoinOptimalBorrowRates_20231113
 * command: make test-contract filter=AaveV2Ethereum_IncreaseStablecoinOptimalBorrowRates_20231113
 */
contract AaveV2Ethereum_IncreaseStablecoinOptimalBorrowRates_20231113_Test is ProtocolV2TestBase {
  AaveV2Ethereum_IncreaseStablecoinOptimalBorrowRates_20231113 internal proposal;

  struct Changes {
    address asset;
    uint256 reserveFactor;
  }

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18565299);
    proposal = new AaveV2Ethereum_IncreaseStablecoinOptimalBorrowRates_20231113();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) =  defaultTest(
      'AaveV2Ethereum_IncreaseStablecoinOptimalBorrowRates_20231113',
      AaveV2Ethereum.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](7);
    assetsChanged[0] = AaveV2EthereumAssets.USDC_UNDERLYING;
    assetsChanged[1] = AaveV2EthereumAssets.USDT_UNDERLYING;
    assetsChanged[2] = AaveV2EthereumAssets.LUSD_UNDERLYING;
    assetsChanged[3] = AaveV2EthereumAssets.FRAX_UNDERLYING;
    assetsChanged[4] = AaveV2EthereumAssets.sUSD_UNDERLYING;
    assetsChanged[5] = AaveV2EthereumAssets.GUSD_UNDERLYING;
    assetsChanged[6] = AaveV2EthereumAssets.USDP_UNDERLYING;

    Changes[] memory assetChanges = new Changes[](3);
    assetChanges[0] = Changes({
      asset: AaveV2EthereumAssets.USDC_UNDERLYING,
      reserveFactor: 25_00
    });
    assetChanges[1] = Changes({
      asset: AaveV2EthereumAssets.USDT_UNDERLYING,
      reserveFactor: 25_00
    });
    assetChanges[2] = Changes({
      asset: AaveV2EthereumAssets.LUSD_UNDERLYING,
      reserveFactor: 25_00
    });

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    for (uint i = 0; i < assetChanges.length; i++) {
      ReserveConfig memory cfg = _findReserveConfig(allConfigsAfter, assetChanges[i].asset);
      assertEq(cfg.reserveFactor, assetChanges[i].reserveFactor);
    }
  }
}
