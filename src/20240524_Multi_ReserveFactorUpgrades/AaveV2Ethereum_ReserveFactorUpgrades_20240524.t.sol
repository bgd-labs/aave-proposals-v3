// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_ReserveFactorUpgrades_20240524} from './AaveV2Ethereum_ReserveFactorUpgrades_20240524.sol';

/**
 * @dev Test for AaveV2Ethereum_ReserveFactorUpgrades_20240524
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240524_Multi_ReserveFactorUpgrades/AaveV2Ethereum_ReserveFactorUpgrades_20240524.t.sol -vv
 */
contract AaveV2Ethereum_ReserveFactorUpgrades_20240524_Test is ProtocolV2TestBase {
  AaveV2Ethereum_ReserveFactorUpgrades_20240524 internal proposal;

  struct Changes {
    address asset;
    uint256 reserveFactor;
  }

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19937538);
    proposal = new AaveV2Ethereum_ReserveFactorUpgrades_20240524();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV2Ethereum_ReserveFactorUpgrades_20240524',
      AaveV2Ethereum.POOL,
      address(proposal)
    );
    address[] memory assetsChanged = new address[](11);
    assetsChanged[0] = AaveV2EthereumAssets.DAI_UNDERLYING;
    assetsChanged[1] = AaveV2EthereumAssets.FRAX_UNDERLYING;
    assetsChanged[2] = AaveV2EthereumAssets.GUSD_UNDERLYING;
    assetsChanged[3] = AaveV2EthereumAssets.LINK_UNDERLYING;
    assetsChanged[4] = AaveV2EthereumAssets.LUSD_UNDERLYING;
    assetsChanged[5] = AaveV2EthereumAssets.sUSD_UNDERLYING;
    assetsChanged[6] = AaveV2EthereumAssets.USDC_UNDERLYING;
    assetsChanged[7] = AaveV2EthereumAssets.USDP_UNDERLYING;
    assetsChanged[8] = AaveV2EthereumAssets.USDT_UNDERLYING;
    assetsChanged[9] = AaveV2EthereumAssets.WBTC_UNDERLYING;
    assetsChanged[10] = AaveV2EthereumAssets.WETH_UNDERLYING;

    Changes[] memory assetChanges = new Changes[](11);
    assetChanges[0] = Changes({
      asset: AaveV2EthereumAssets.DAI_UNDERLYING,
      reserveFactor: proposal.DAI_RF()
    });
    assetChanges[1] = Changes({
      asset: AaveV2EthereumAssets.FRAX_UNDERLYING,
      reserveFactor: proposal.FRAX_RF()
    });
    assetChanges[2] = Changes({
      asset: AaveV2EthereumAssets.GUSD_UNDERLYING,
      reserveFactor: proposal.GUSD_RF()
    });
    assetChanges[3] = Changes({
      asset: AaveV2EthereumAssets.LINK_UNDERLYING,
      reserveFactor: proposal.LINK_RF()
    });
    assetChanges[4] = Changes({
      asset: AaveV2EthereumAssets.LUSD_UNDERLYING,
      reserveFactor: proposal.LUSD_RF()
    });
    assetChanges[5] = Changes({
      asset: AaveV2EthereumAssets.sUSD_UNDERLYING,
      reserveFactor: proposal.sUSD_RF()
    });
    assetChanges[6] = Changes({
      asset: AaveV2EthereumAssets.USDC_UNDERLYING,
      reserveFactor: proposal.USDC_RF()
    });
    assetChanges[7] = Changes({
      asset: AaveV2EthereumAssets.USDP_UNDERLYING,
      reserveFactor: proposal.USDP_RF()
    });
    assetChanges[8] = Changes({
      asset: AaveV2EthereumAssets.USDT_UNDERLYING,
      reserveFactor: proposal.USDT_RF()
    });
    assetChanges[9] = Changes({
      asset: AaveV2EthereumAssets.WBTC_UNDERLYING,
      reserveFactor: proposal.WBTC_RF()
    });
    assetChanges[10] = Changes({
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
