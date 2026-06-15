// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Onboard syrupUSDC to Aave V3 Core Instance
 * @author Aavechan Initiative @aci
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0xf5951af5d6d7d70be998a72c531708db3ff9c46b033e3e27bfd59fb87542d0ea
 * - Discussion: https://governance.aave.com/t/arfc-onboard-syrupusdc-to-aave-v3-core-instance/22456
 */
contract AaveV3Ethereum_OnboardSyrupUSDCToAaveV3CoreInstance_20260421 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  address public constant syrupUSDC = 0x80ac24aA929eaF5013f6436cdA2a7ba190f5Cc0b;
  uint256 public constant syrupUSDC_SEED_AMOUNT = 100e6;
  address public constant syrupUSDC_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(syrupUSDC, syrupUSDC_SEED_AMOUNT, syrupUSDC_LM_ADMIN);
  }

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](1);

    address[] memory collateralAssets_SyrupUSDC__USDC__USDT = new address[](1);
    address[] memory borrowableAssets_SyrupUSDC__USDC__USDT = new address[](2);

    collateralAssets_SyrupUSDC__USDC__USDT[0] = syrupUSDC;
    borrowableAssets_SyrupUSDC__USDC__USDT[0] = AaveV3EthereumAssets.USDC_UNDERLYING;
    borrowableAssets_SyrupUSDC__USDC__USDT[1] = AaveV3EthereumAssets.USDT_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 90_00,
      liqThreshold: 92_00,
      liqBonus: 4_00,
      label: 'syrupUSDC__USDC__USDT',
      collaterals: collateralAssets_SyrupUSDC__USDC__USDT,
      borrowables: borrowableAssets_SyrupUSDC__USDC__USDT
    });

    return eModeCreations;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: syrupUSDC,
      assetSymbol: 'syrupUSDC',
      priceFeed: 0xE4E9d021D3A44E8bc9949690E298C6b41C6EF354,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 50_00,
      supplyCap: 200_000_000,
      borrowCap: 1,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
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
      address vToken = AaveV3Ethereum.POOL.getReserveVariableDebtToken(asset);
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(asset, lmAdmin);
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(aToken, lmAdmin);
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(vToken, lmAdmin);
    }
  }
}
