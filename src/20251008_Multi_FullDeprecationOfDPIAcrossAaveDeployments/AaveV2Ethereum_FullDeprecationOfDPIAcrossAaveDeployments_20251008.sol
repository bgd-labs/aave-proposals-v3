// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2PayloadEthereum} from 'aave-helpers/src/v2-config-engine/AaveV2PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV2ConfigEngine} from 'aave-helpers/src/v2-config-engine/IAaveV2ConfigEngine.sol';
import {IV2RateStrategyFactory} from 'aave-helpers/src/v2-config-engine/IV2RateStrategyFactory.sol';

/**
 * @title Full Deprecation of DPI Across Aave Deployments
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/direct-to-aip-full-deprecation-of-dpi-across-aave-deployments/23212
 */
contract AaveV2Ethereum_FullDeprecationOfDPIAcrossAaveDeployments_20251008 is
  AaveV2PayloadEthereum
{
  address public constant FIXED_DPI_ETH_FEED = 0x92A6A444f5b433235297d849d2F93B405657234a;

  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV2ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV2ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV2ConfigEngine.RateStrategyUpdate[](1);
    rateStrategies[0] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.DPI_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: _bpsToRay(40_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });

    return rateStrategies;
  }

  function _postExecute() internal override {
    address[] memory assets = new address[](1);
    address[] memory sources = new address[](1);

    assets[0] = AaveV2EthereumAssets.DPI_UNDERLYING;
    sources[0] = FIXED_DPI_ETH_FEED;

    AaveV2Ethereum.ORACLE.setAssetSources(assets, sources);
  }
}
