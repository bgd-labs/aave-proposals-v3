// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine, IPool} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {IAaveStewardInjector} from '../interfaces/IAaveStewardInjector.sol';
import {IAgentHub} from '../interfaces/chaos-agents/IAgentHub.sol';
import {IPool} from 'aave-v3-origin/contracts/interfaces/IPool.sol';

/**
 * @title Onboard Strata srUSDe PT tokens to V3 Core Instance
 * @author Aavechan Initiative @aci
 * - Snapshot: https://snapshot.org/#/aavedao.eth/proposal/0x064b74d6b55b4cdabd6233555cf29e6fcc6118ed8c9050f1807c8db8525d7ae5
 * - Discussion: https://governance.aave.com/t/arfc-onboard-strata-srusde-pt-tokens-to-v3-core-instance/23481
 */
contract AaveV3Ethereum_OnboardStrataSrUSDePTTokensToV3CoreInstance_20260120 is
  AaveV3PayloadEthereum
{
  using SafeERC20 for IERC20;

  address public constant PT_srUSDe_2APR2026 = 0x9Bf45ab47747F4B4dD09B3C2c73953484b4eB375;
  uint256 public constant PT_srUSDe_2APR2026_SEED_AMOUNT = 100e18;
  address public constant PT_srUSDe_2APR2026_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    // we whitelist the two newly created eModeId on the injector
    uint8 nextID = _findFirstUnusedEmodeCategory(AaveV3Ethereum.POOL);

    // whitelist the new eModes on automated chaos-agents [agentId 0: EModeCategoryUpdate_Core]
    IAgentHub(MiscEthereum.AGENT_HUB).addAllowedMarket(0, address(uint160(nextID - 1)));
    IAgentHub(MiscEthereum.AGENT_HUB).addAllowedMarket(0, address(uint160(nextID - 2)));

    _supplyAndConfigureLMAdmin(
      PT_srUSDe_2APR2026,
      PT_srUSDe_2APR2026_SEED_AMOUNT,
      PT_srUSDe_2APR2026_LM_ADMIN
    );
  }

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](2);

    address[] memory collateralAssets_PT_srUSDe_1APR2026_sUSDe__USDT_USDe_USDC = new address[](2);
    address[] memory borrowableAssets_PT_srUSDe_1APR2026_sUSDe__USDT_USDe_USDC = new address[](3);

    collateralAssets_PT_srUSDe_1APR2026_sUSDe__USDT_USDe_USDC[0] = PT_srUSDe_2APR2026;
    collateralAssets_PT_srUSDe_1APR2026_sUSDe__USDT_USDe_USDC[1] = AaveV3EthereumAssets
      .sUSDe_UNDERLYING;
    borrowableAssets_PT_srUSDe_1APR2026_sUSDe__USDT_USDe_USDC[0] = AaveV3EthereumAssets
      .USDC_UNDERLYING;
    borrowableAssets_PT_srUSDe_1APR2026_sUSDe__USDT_USDe_USDC[1] = AaveV3EthereumAssets
      .USDT_UNDERLYING;
    borrowableAssets_PT_srUSDe_1APR2026_sUSDe__USDT_USDe_USDC[2] = AaveV3EthereumAssets
      .USDe_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 89_50,
      liqThreshold: 91_50,
      liqBonus: 4_50,
      label: 'PT_srUSDe_1APR2026_sUSDe__USDT_USDe_USDC',
      collaterals: collateralAssets_PT_srUSDe_1APR2026_sUSDe__USDT_USDe_USDC,
      borrowables: borrowableAssets_PT_srUSDe_1APR2026_sUSDe__USDT_USDe_USDC
    });

    address[] memory collateralAssets_PT_srUSDe_1APR2026_sUSDe__USDe = new address[](2);
    address[] memory borrowableAssets_PT_srUSDe_1APR2026_sUSDe__USDe = new address[](1);

    collateralAssets_PT_srUSDe_1APR2026_sUSDe__USDe[0] = PT_srUSDe_2APR2026;
    collateralAssets_PT_srUSDe_1APR2026_sUSDe__USDe[1] = AaveV3EthereumAssets.sUSDe_UNDERLYING;
    borrowableAssets_PT_srUSDe_1APR2026_sUSDe__USDe[0] = AaveV3EthereumAssets.USDe_UNDERLYING;

    eModeCreations[1] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 91_20,
      liqThreshold: 93_20,
      liqBonus: 2_60,
      label: 'PT_srUSDe_1APR2026_sUSDe__USDe',
      collaterals: collateralAssets_PT_srUSDe_1APR2026_sUSDe__USDe,
      borrowables: borrowableAssets_PT_srUSDe_1APR2026_sUSDe__USDe
    });

    return eModeCreations;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: PT_srUSDe_2APR2026,
      assetSymbol: 'PT_srUSDe_2APR2026',
      priceFeed: 0xB539C6C0fc36ff1572B13ACec343B854937db576,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 50_00,
      supplyCap: 50_000_000,
      borrowCap: 1,
      debtCeiling: 0,
      liqProtocolFee: 0,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 10_00,
        variableRateSlope2: 300_00
      })
    });

    return listings;
  }
  function _supplyAndConfigureLMAdmin(address asset, uint256 seedAmount, address lmAdmin) internal {
    IERC20(asset).forceApprove(address(AaveV3Ethereum.POOL), seedAmount);
    AaveV3Ethereum.POOL.supply(asset, seedAmount, address(AaveV3Ethereum.DUST_BIN), 0);

    if (lmAdmin != address(0)) {
      address aToken = AaveV3Ethereum.POOL.getReserveAToken(asset);
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(asset, lmAdmin);
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(aToken, lmAdmin);
    }
  }

  function _findFirstUnusedEmodeCategory(IPool pool) private view returns (uint8) {
    // eMode id 0 is skipped intentially as it is the reserved default
    for (uint8 i = 1; i < 256; i++) {
      if (pool.getEModeCategoryCollateralConfig(i).liquidationThreshold == 0) return i;
    }
    revert('NoAvailableEmodeCategory');
  }
}
