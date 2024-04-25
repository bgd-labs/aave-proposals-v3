// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425} from './AaveV3Ethereum_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425.sol';

/**
 * @dev Test for AaveV3Ethereum_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425
 * command: make test-contract filter=AaveV3Ethereum_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425
 */
contract AaveV3Ethereum_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425_Test is
  ProtocolV3TestBase
{
  struct Change {
    address asset;
    uint256 lt;
    uint256 ltv;
  }

  AaveV3Ethereum_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19730712);
    proposal = new AaveV3Ethereum_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV3Ethereum_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425',
      AaveV3Ethereum.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](2);
    assetsChanged[0] = AaveV3EthereumAssets.USDC_UNDERLYING;
    assetsChanged[1] = AaveV3EthereumAssets.USDT_UNDERLYING;

    Change[] memory assetChanges = new Change[](2);
    assetChanges[0] = Change({asset: AaveV3EthereumAssets.USDC_UNDERLYING, ltv: 75_00, lt: 78_00});
    assetChanges[1] = Change({asset: AaveV3EthereumAssets.USDT_UNDERLYING, ltv: 75_00, lt: 78_00});

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    for (uint i = 0; i < assetChanges.length; i++) {
      ReserveConfig memory config = _findReserveConfig(allConfigsAfter, assetChanges[i].asset);
      assertEq(config.ltv, assetChanges[i].ltv);
      assertEq(config.liquidationThreshold, assetChanges[i].lt);
    }
  }
}
