// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ISvrOracleSteward} from '../interfaces/ISvrOracleSteward.sol';

/**
 * @title Extend SVR V1 to more reserves
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/direct-to-aip-aave-chainlink-svr-v1-activation-phase-2/21940
 */
contract AaveV3Ethereum_ExtendSVRV1ToMoreReserves_20250429 is IProposalGenericExecutor {
  address public constant SVR_BTC_USD = 0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A;
  address public constant SVR_eBTC = 0x577C217cB5b1691A500D48aA7F69346409cFd668;
  address public constant SVR_WBTC = 0xDaa4B74C6bAc4e25188e64ebc68DB5050b690cAc;

  function execute() external {
    ISvrOracleSteward.AssetOracle[] memory configInput = new ISvrOracleSteward.AssetOracle[](3);
    configInput[0] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.cbBTC_UNDERLYING,
      svrOracle: SVR_BTC_USD
    });
    configInput[1] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.eBTC_UNDERLYING,
      svrOracle: SVR_eBTC
    });
    configInput[2] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.WBTC_UNDERLYING,
      svrOracle: SVR_WBTC
    });
    ISvrOracleSteward(AaveV3Ethereum.SVR_STEWARD).enableSvrOracles(configInput);
  }
}
