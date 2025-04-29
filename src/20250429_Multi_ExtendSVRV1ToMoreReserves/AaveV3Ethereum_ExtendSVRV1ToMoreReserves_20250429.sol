// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ISvrOracleSteward} from '../interfaces/ISvrOracleSteward.sol';

/**
 * @title Extend SVR V1 to more reserves
 * @author BGD Labs @bgdlabs
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/arfc-aave-chainlink-svr-v1-phase-1-activation/21247
 */
contract AaveV3Ethereum_ExtendSVRV1ToMoreReserves_20250429 is IProposalGenericExecutor {
  address public constant SVR_weETH = 0x87625393534d5C102cADB66D37201dF24cc26d4C;
  address public constant SVR_BTC_USD = 0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A;
  address public constant SVR_rETH = 0x6929706c42d637DF5Ebf7F0BcfF2aF47F84Ea69D;
  address public constant SVR_eBTC = 0x577C217cB5b1691A500D48aA7F69346409cFd668;
  address public constant SVR_cbETH = address(0);
  address public constant SVR_osETH = 0x2b86D519eF34f8Adfc9349CDeA17c09Aa9dB60E2;
  address public constant SVR_ETHx = 0xd7b163B671f8cE9379DF8Ff7F75fA72Ccec1841c;
  address public constant SVR_rsETH = 0x7292C95A5f6A501a9c4B34f6393e221F2A0139c3;

  function execute() external {
    ISvrOracleSteward.AssetOracle[] memory configInput = new ISvrOracleSteward.AssetOracle[](6);
    configInput[0] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.weETH_UNDERLYING,
      svrOracle: SVR_weETH
    });
    configInput[1] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.cbBTC_UNDERLYING,
      svrOracle: SVR_BTC_USD
    });
    configInput[2] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.rETH_UNDERLYING,
      svrOracle: SVR_rETH
    });
    configInput[3] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.eBTC_UNDERLYING,
      svrOracle: SVR_eBTC
    });
    configInput[4] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.cbETH_UNDERLYING,
      svrOracle: SVR_cbETH
    });
    configInput[5] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.osETH_UNDERLYING,
      svrOracle: SVR_osETH
    });
    configInput[6] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.ETHx_UNDERLYING,
      svrOracle: SVR_ETHx
    });
    configInput[7] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.rsETH_UNDERLYING,
      svrOracle: SVR_rsETH
    });
    ISvrOracleSteward(AaveV3Ethereum.SVR_STEWARD).enableSvrOracles(configInput);
  }
}
