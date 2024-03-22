// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadMetis} from 'aave-helpers/v3-config-engine/AaveV3PayloadMetis.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title Stablecoin IR Updates
 * @author Chaos Labs, ACI
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xe2dd228640c3cad93f5418c40c4b5743b3c6c85aa0aae9eee53cbdbca2ed5c2d
 * - Discussion: https://governance.aave.com/t/arfc-stablecoin-ir-curve-amendment-on-aave-v2-and-v3/16864
 */
contract AaveV3Metis_StablecoinIRUpdates_20240322 is AaveV3PayloadMetis {
  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV3ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV3ConfigEngine.RateStrategyUpdate[](0);

    return rateStrategies;
  }
}
