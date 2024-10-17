// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_ReserveFactorUpdatesMidOctober_20241004} from './AaveV2Ethereum_ReserveFactorUpdatesMidOctober_20241004.sol';

/**
 * @dev Test for AaveV2Ethereum_ReserveFactorUpdatesMidOctober_20241004
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241004_Multi_ReserveFactorUpdatesMidOctober/AaveV2Ethereum_ReserveFactorUpdatesMidOctober_20241004.t.sol -vv
 */
contract AaveV2Ethereum_ReserveFactorUpdatesMidOctober_20241004_Test is ProtocolV2TestBase {
  AaveV2Ethereum_ReserveFactorUpdatesMidOctober_20241004 internal proposal;

  struct Changes {
    address asset;
    uint256 reserveFactor;
  }

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20892487);
    proposal = new AaveV2Ethereum_ReserveFactorUpdatesMidOctober_20241004();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV2Ethereum_ReserveFactorUpdatesMidOctober_20241004',
      AaveV2Ethereum.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](6);
    assetsChanged[0] = AaveV2EthereumAssets.DAI_UNDERLYING;
    assetsChanged[1] = AaveV2EthereumAssets.LINK_UNDERLYING;
    assetsChanged[2] = AaveV2EthereumAssets.USDC_UNDERLYING;
    assetsChanged[3] = AaveV2EthereumAssets.USDT_UNDERLYING;
    assetsChanged[4] = AaveV2EthereumAssets.WBTC_UNDERLYING;
    assetsChanged[5] = AaveV2EthereumAssets.WETH_UNDERLYING;

    Changes[] memory assetChanges = new Changes[](6);
    assetChanges[0] = Changes({
      asset: AaveV2EthereumAssets.DAI_UNDERLYING,
      reserveFactor: proposal.DAI_RF()
    });
    assetChanges[1] = Changes({
      asset: AaveV2EthereumAssets.LINK_UNDERLYING,
      reserveFactor: proposal.LINK_RF()
    });
    assetChanges[2] = Changes({
      asset: AaveV2EthereumAssets.USDC_UNDERLYING,
      reserveFactor: proposal.USDC_RF()
    });
    assetChanges[3] = Changes({
      asset: AaveV2EthereumAssets.USDT_UNDERLYING,
      reserveFactor: proposal.USDT_RF()
    });
    assetChanges[4] = Changes({
      asset: AaveV2EthereumAssets.WBTC_UNDERLYING,
      reserveFactor: proposal.WBTC_RF()
    });
    assetChanges[5] = Changes({
      asset: AaveV2EthereumAssets.WETH_UNDERLYING,
      reserveFactor: proposal.WETH_RF()
    });

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    for (uint i = 0; i < assetChanges.length; i++) {
      ReserveConfig memory cfg = _findReserveConfig(allConfigsAfter, assetChanges[i].asset);
      assertEq(cfg.reserveFactor, assetChanges[i].reserveFactor);
    }
  }
}
