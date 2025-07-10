// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine, IPool} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import {IAaveStewardInjector} from '../interfaces/IAaveStewardInjector.sol';
/**
 * @title Onboard sUSDe September expiry PT tokens on Aave V3 Core Instance
 * @author Aave-Chan Initiative
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-onboard-susde-september-expiry-pt-tokens-on-aave-v3-core-instance/22313
 */
contract AaveV3Ethereum_OnboardSUSDeSeptemberExpiryPTTokensOnAaveV3CoreInstance_20250627 is
  AaveV3PayloadEthereum
{
  using SafeERC20 for IERC20;

  address public constant PT_sUSDe_25SEP2025 = 0x9F56094C450763769BA0EA9Fe2876070c0fD5F77;
  uint256 public constant PT_sUSDe_25SEP2025_SEED_AMOUNT = 100e18;
  address public constant PT_sUSDe_25SEP2025_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    // we whitelist the two newly created eModeId on the injector
    uint8 nextID = _findFirstUnusedEmodeCategory(AaveV3Ethereum.POOL);
    address[] memory marketsToWhitelist = new address[](2);
    marketsToWhitelist[0] = address(uint160(nextID - 1)); // on the injector we encode eModeId to address
    marketsToWhitelist[1] = address(uint160(nextID - 2)); // on the injector we encode eModeId to address
    IAaveStewardInjector(AaveV3Ethereum.EDGE_INJECTOR_PENDLE_EMODE).addMarkets(marketsToWhitelist);
    address[] memory assetToWhitelist = new address[](1);
    assetToWhitelist[0] = PT_sUSDe_25SEP2025; // on the injector we encode eModeId to address
    IAaveStewardInjector(AaveV3Ethereum.EDGE_INJECTOR_DISCOUNT_RATE).addMarkets(assetToWhitelist);

    IERC20(PT_sUSDe_25SEP2025).forceApprove(
      address(AaveV3Ethereum.POOL),
      PT_sUSDe_25SEP2025_SEED_AMOUNT
    );
    AaveV3Ethereum.POOL.supply(
      PT_sUSDe_25SEP2025,
      PT_sUSDe_25SEP2025_SEED_AMOUNT,
      AaveV3Ethereum.DUST_BIN,
      0
    );

    address aPT_sUSDe_25SEP2025 = AaveV3Ethereum.POOL.getReserveAToken(PT_sUSDe_25SEP2025);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(
      PT_sUSDe_25SEP2025,
      PT_sUSDe_25SEP2025_LM_ADMIN
    );
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(
      aPT_sUSDe_25SEP2025,
      PT_sUSDe_25SEP2025_LM_ADMIN
    );
  }

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeUpdates = new IAaveV3ConfigEngine.EModeCategoryCreation[](2);

    address[] memory borrow1 = new address[](4);
    borrow1[0] = AaveV3EthereumAssets.USDC_UNDERLYING;
    borrow1[1] = AaveV3EthereumAssets.USDT_UNDERLYING;
    borrow1[2] = AaveV3EthereumAssets.USDe_UNDERLYING;
    borrow1[3] = AaveV3EthereumAssets.USDS_UNDERLYING;

    address[] memory collatboth = new address[](1);
    collatboth[0] = PT_sUSDe_25SEP2025;

    address[] memory borrow2 = new address[](1);
    borrow2[0] = AaveV3EthereumAssets.USDe_UNDERLYING;

    eModeUpdates[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 87_70,
      liqThreshold: 89_70,
      liqBonus: 5_00,
      label: 'PT-sUSDe Stablecoins September 2025',
      borrowables: borrow1,
      collaterals: collatboth
    });
    eModeUpdates[1] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 89_10,
      liqThreshold: 91_10,
      liqBonus: 3_00,
      label: 'PT-sUSDe USDe September 2025',
      borrowables: borrow2,
      collaterals: collatboth
    });

    return eModeUpdates;
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: PT_sUSDe_25SEP2025,
      assetSymbol: 'PT_sUSDE_25SEP2025',
      priceFeed: 0x7585693910f39df4959912B27D09EAEef06C1a93,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 7_50,
      reserveFactor: 10_00,
      supplyCap: 200_000_000,
      borrowCap: 1,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 6_00,
        variableRateSlope2: 50_00
      })
    });

    return listings;
  }
  /**
   * @dev eModes must have a non-zero lt so we select the first that has a zero lt.
   */
  function _findFirstUnusedEmodeCategory(IPool pool) private view returns (uint8) {
    // eMode id 0 is skipped intentially as it is the reserved default
    for (uint8 i = 1; i < 256; i++) {
      if (pool.getEModeCategoryCollateralConfig(i).liquidationThreshold == 0) return i;
    }
    revert('NoAvailableEmodeCategory');
  }
}
