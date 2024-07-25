// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3PayloadEthereumLido} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereumLido.sol';
import {EngineFlags} from 'aave-v3-periphery/contracts/v3-config-engine/EngineFlags.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-periphery/contracts/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';
import {IPoolAddressesProviderRegistry} from 'aave-v3-core/contracts/interfaces/IPoolAddressesProviderRegistry.sol';

/**
 * @title Lido Ethereum Instance Activation
 * @author Catapulta @catapulta_sh
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x9403b7f704ade0d6510591e4846fd85c84b19d134c0814511af914751ecfad5d
 * - Discussion: https://governance.aave.com/t/arfc-deploy-a-lido-aave-v3-instance/18047
 */
contract AaveV3EthereumLido_LidoEthereumInstanceActivation_20240720 is AaveV3PayloadEthereumLido {
  using SafeERC20 for IERC20;

  address public constant ACI_MULTISIG = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  address public constant wstETH = 0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0;
  uint256 public constant wstETH_SEED_AMOUNT = 1e17;
  address public constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
  uint256 public constant WETH_SEED_AMOUNT = 1e17;

  function _preExecute() internal override {
    bytes32 incentivesControllerTagId = keccak256('INCENTIVES_CONTROLLER');
    AaveV3EthereumLido.POOL_ADDRESSES_PROVIDER.setAddress(
      incentivesControllerTagId,
      address(AaveV3Ethereum.DEFAULT_INCENTIVES_CONTROLLER)
    );
    // Set Lido Ethereum as ID 43, previous instance is Scroll with ID 42
    IPoolAddressesProviderRegistry(AaveV3Ethereum.POOL_ADDRESSES_PROVIDER_REGISTRY)
      .registerAddressesProvider(address(AaveV3EthereumLido.POOL_ADDRESSES_PROVIDER), 43);
  }

  function _postExecute() internal override {
    AaveV3EthereumLido.ACL_MANAGER.addPoolAdmin(0x2CFe3ec4d5a6811f4B8067F0DE7e47DfA938Aa30);
    AaveV3EthereumLido.ACL_MANAGER.addRiskAdmin(AaveV3EthereumLido.CAPS_PLUS_RISK_STEWARD);

    (address aEthLidoWETH, , ) = AaveV3EthereumLido
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(WETH);

    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(aEthLidoWETH, ACI_MULTISIG);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(WETH, ACI_MULTISIG);

    // Seed wstETH and WETH to the pool
    IERC20(wstETH).forceApprove(address(AaveV3EthereumLido.POOL), wstETH_SEED_AMOUNT);
    AaveV3EthereumLido.POOL.supply(
      wstETH,
      wstETH_SEED_AMOUNT,
      address(AaveV3Ethereum.COLLECTOR),
      0
    );
    IERC20(WETH).forceApprove(address(AaveV3EthereumLido.POOL), WETH_SEED_AMOUNT);
    AaveV3EthereumLido.POOL.supply(WETH, WETH_SEED_AMOUNT, address(AaveV3Ethereum.COLLECTOR), 0);

    // Catapulta service fee
    AaveV3Ethereum.COLLECTOR.transfer(
      MiscEthereum.GHO_TOKEN,
      0x6D53be86136c3d4AA6448Ce4bF6178AD66e63661,
      15000e18
    );
  }

  function eModeCategoriesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryUpdate[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryUpdate[]
      memory eModeUpdates = new IAaveV3ConfigEngine.EModeCategoryUpdate[](1);

    eModeUpdates[0] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 1,
      ltv: 93_50,
      liqThreshold: 95_50,
      liqBonus: 1_00,
      priceSource: 0x0000000000000000000000000000000000000000,
      label: 'ETH correlated'
    });

    return eModeUpdates;
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](2);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: wstETH,
      assetSymbol: 'wstETH',
      priceFeed: 0xB4aB0c94159bc2d8C133946E7241368fc2F2a010,
      eModeCategory: 1,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 80_00,
      liqThreshold: 81_00,
      liqBonus: 6_00,
      reserveFactor: 5_00,
      supplyCap: 650_000,
      borrowCap: 12_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 3_50,
        variableRateSlope2: 85_00
      })
    });
    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: WETH,
      assetSymbol: 'WETH',
      priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419,
      eModeCategory: 1,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 82_00,
      liqThreshold: 83_00,
      liqBonus: 5_00,
      reserveFactor: 10_00,
      supplyCap: 900_000,
      borrowCap: 810_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 2_50,
        variableRateSlope2: 85_00
      })
    });

    return listings;
  }
}
