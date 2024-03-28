// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_BorrowCapReductionsOnAaveV3Ethereum_20240311} from './AaveV3Ethereum_BorrowCapReductionsOnAaveV3Ethereum_20240311.sol';

/**
 * @dev Test for AaveV3Ethereum_BorrowCapReductionsOnAaveV3Ethereum_20240311
 * command: make test-contract filter=AaveV3Ethereum_BorrowCapReductionsOnAaveV3Ethereum_20240311
 */
contract AaveV3Ethereum_BorrowCapReductionsOnAaveV3Ethereum_20240311_Test is ProtocolV3TestBase {
  struct Change {
    address asset;
    uint256 borrowCap;
  }

  AaveV3Ethereum_BorrowCapReductionsOnAaveV3Ethereum_20240311 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19503431);
    proposal = new AaveV3Ethereum_BorrowCapReductionsOnAaveV3Ethereum_20240311();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV3Ethereum_BorrowCapReductionsOnAaveV3Ethereum_20240311',
      AaveV3Ethereum.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](11);
    assetsChanged[0] = AaveV3EthereumAssets.MKR_UNDERLYING;
    assetsChanged[1] = AaveV3EthereumAssets.LDO_UNDERLYING;
    assetsChanged[2] = AaveV3EthereumAssets.UNI_UNDERLYING;
    assetsChanged[3] = AaveV3EthereumAssets.RPL_UNDERLYING;
    assetsChanged[4] = AaveV3EthereumAssets.SNX_UNDERLYING;
    assetsChanged[5] = AaveV3EthereumAssets.FXS_UNDERLYING;
    assetsChanged[6] = AaveV3EthereumAssets.CRV_UNDERLYING;
    assetsChanged[7] = AaveV3EthereumAssets.STG_UNDERLYING;
    assetsChanged[8] = AaveV3EthereumAssets.KNC_UNDERLYING;
    assetsChanged[9] = AaveV3EthereumAssets.ONE_INCH_UNDERLYING;
    assetsChanged[10] = AaveV3EthereumAssets.BAL_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    Change[] memory assetsChanges = new Change[](11);

    assetsChanges[0] = Change({asset: AaveV3EthereumAssets.MKR_UNDERLYING, borrowCap: 1_980});
    assetsChanges[1] = Change({asset: AaveV3EthereumAssets.LDO_UNDERLYING, borrowCap: 1_500_000});
    assetsChanges[2] = Change({asset: AaveV3EthereumAssets.UNI_UNDERLYING, borrowCap: 330_000});
    assetsChanges[3] = Change({asset: AaveV3EthereumAssets.RPL_UNDERLYING, borrowCap: 316_800});
    assetsChanges[4] = Change({asset: AaveV3EthereumAssets.SNX_UNDERLYING, borrowCap: 150_000});
    assetsChanges[5] = Change({asset: AaveV3EthereumAssets.FXS_UNDERLYING, borrowCap: 330_000});
    assetsChanges[6] = Change({asset: AaveV3EthereumAssets.CRV_UNDERLYING, borrowCap: 2_750_000});
    assetsChanges[7] = Change({asset: AaveV3EthereumAssets.STG_UNDERLYING, borrowCap: 3_200_000});
    assetsChanges[8] = Change({asset: AaveV3EthereumAssets.KNC_UNDERLYING, borrowCap: 350_000});
    assetsChanges[9] = Change({
      asset: AaveV3EthereumAssets.ONE_INCH_UNDERLYING,
      borrowCap: 475_200
    });
    assetsChanges[10] = Change({asset: AaveV3EthereumAssets.BAL_UNDERLYING, borrowCap: 244_200});

    for (uint i = 0; i < assetsChanges.length; i++) {
      ReserveConfig memory config = _findReserveConfig(allConfigsAfter, assetsChanges[i].asset);
      assertEq(config.borrowCap, assetsChanges[i].borrowCap);
    }
  }
}
