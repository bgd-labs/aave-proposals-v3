// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {IERC20Metadata, IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {IPendlePriceCapAdapter} from 'src/interfaces/IPendlePriceCapAdapter.sol';

import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_OnboardPTUSDG28MAY2026OnV3Core_20260407} from './AaveV3Ethereum_OnboardPTUSDG28MAY2026OnV3Core_20260407.sol';

/**
 * @dev Test for AaveV3Ethereum_OnboardPTUSDG28MAY2026OnV3Core_20260407
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260407_AaveV3Ethereum_OnboardPTUSDG28MAY2026OnV3Core/AaveV3Ethereum_OnboardPTUSDG28MAY2026OnV3Core_20260407.t.sol -vv
 */
contract AaveV3Ethereum_OnboardPTUSDG28MAY2026OnV3Core_20260407_Test is ProtocolV3TestBase {
  AaveV3Ethereum_OnboardPTUSDG28MAY2026OnV3Core_20260407 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24829171);
    proposal = new AaveV3Ethereum_OnboardPTUSDG28MAY2026OnV3Core_20260407();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_OnboardPTUSDG28MAY2026OnV3Core_20260407',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasPT_USDG_28MAY2026Funds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Ethereum.POOL.getReserveAToken(proposal.PT_USDG_28MAY2026());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.DUST_BIN)), 100e6);
  }

  function test_e2e_in_emode() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address collateralSupplier = vm.addr(3);
    uint8 eModeId = _findEModeCategoryId('PT_USDG_28MAY2026__Stablecoins');
    vm.prank(collateralSupplier);
    AaveV3Ethereum.POOL.setUserEMode(eModeId);

    ReserveConfig memory collateralConfig = _getStructReserveConfig(
      AaveV3Ethereum.POOL,
      proposal.PT_USDG_28MAY2026()
    );
    collateralConfig.usageAsCollateralEnabled = true; // workaround until https://github.com/aave-dao/aave-helpers/pull/686
    ReserveConfig[4] memory borrowables = [
      _getStructReserveConfig(AaveV3Ethereum.POOL, AaveV3EthereumAssets.USDT_UNDERLYING),
      _getStructReserveConfig(AaveV3Ethereum.POOL, AaveV3EthereumAssets.USDe_UNDERLYING),
      _getStructReserveConfig(AaveV3Ethereum.POOL, AaveV3EthereumAssets.USDC_UNDERLYING),
      _getStructReserveConfig(AaveV3Ethereum.POOL, AaveV3EthereumAssets.USDG_UNDERLYING)
    ];
    uint256 snapshot = vm.snapshotState();
    for (uint256 i = 0; i < borrowables.length; i++) {
      borrowables[i].borrowingEnabled = true;
      e2eTestAsset(AaveV3Ethereum.POOL, collateralConfig, borrowables[i]);
      vm.revertToState(snapshot);
    }
  }

  function test_PT_USDG_28MAY2026Admin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aPT_USDG_28MAY2026 = AaveV3Ethereum.POOL.getReserveAToken(proposal.PT_USDG_28MAY2026());
    address vPT_USDG_28MAY2026 = AaveV3Ethereum.POOL.getReserveVariableDebtToken(
      proposal.PT_USDG_28MAY2026()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(
        proposal.PT_USDG_28MAY2026()
      ),
      proposal.PT_USDG_28MAY2026_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(aPT_USDG_28MAY2026),
      proposal.PT_USDG_28MAY2026_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(vPT_USDG_28MAY2026),
      proposal.PT_USDG_28MAY2026_LM_ADMIN()
    );
  }

  function test_oracle_config() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address underlying = proposal.PT_USDG_28MAY2026();
    address base = AaveV3EthereumAssets.USDG_UNDERLYING;
    IPendlePriceCapAdapter source = IPendlePriceCapAdapter(
      AaveV3Ethereum.ORACLE.getSourceOfAsset(underlying)
    );

    assertEq(source.ASSET_TO_USD_AGGREGATOR(), AaveV3Ethereum.ORACLE.getSourceOfAsset(base));
    assertEq(source.MAX_DISCOUNT_RATE_PER_YEAR(), 18.82e16);
    assertEq(source.discountRatePerYear(), 5.12e16);
  }

  function _findEModeCategoryId(string memory label) internal view returns (uint8) {
    for (uint8 i = 1; i < 255; i++) {
      if (
        keccak256(bytes(AaveV3Ethereum.POOL.getEModeCategoryLabel(i))) == keccak256(bytes(label))
      ) {
        return i;
      }
    }
    revert('eMode category not found');
  }
}
