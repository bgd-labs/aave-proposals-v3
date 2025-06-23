// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ISvrOracleSteward} from '../interfaces/ISvrOracleSteward.sol';

/**
 * @title Enable additional SVR oracles
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/direct-to-aip-aave-chainlink-svr-v1-activation-phase-3/22387
 */
contract AaveV3Ethereum_EnableAdditionalSVROracles_20250613 is IProposalGenericExecutor {
  address public constant SVR_WETH = 0x5424384B256154046E9667dDFaaa5e550145215e;
  address public constant SVR_weETH = 0x87625393534d5C102cADB66D37201dF24cc26d4C;
  address public constant SVR_osETH = 0x2b86D519eF34f8Adfc9349CDeA17c09Aa9dB60E2;
  address public constant SVR_ETHx = 0xd7b163B671f8cE9379DF8Ff7F75fA72Ccec1841c;
  address public constant SVR_rsETH = 0x7292C95A5f6A501a9c4B34f6393e221F2A0139c3;
  address public constant SVR_wstETH = 0xe1D97bF61901B075E9626c8A2340a7De385861Ef;
  address public constant SVR_rETH = 0x6929706c42d637DF5Ebf7F0BcfF2aF47F84Ea69D;
  address public constant SVR_cbETH = 0x889399C34461b25d70d43931e6cE9E40280E617B;
  address public constant SVR_USDC = 0x3f73F03aa83B2A48ed27E964eD0fDb590332095B;

  function execute() external {
    ISvrOracleSteward.AssetOracle[] memory configInput = new ISvrOracleSteward.AssetOracle[](9);
    configInput[0] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.WETH_UNDERLYING,
      svrOracle: SVR_WETH
    });
    configInput[1] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.weETH_UNDERLYING,
      svrOracle: SVR_weETH
    });
    configInput[2] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.osETH_UNDERLYING,
      svrOracle: SVR_osETH
    });
    configInput[3] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.ETHx_UNDERLYING,
      svrOracle: SVR_ETHx
    });
    configInput[4] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.rsETH_UNDERLYING,
      svrOracle: SVR_rsETH
    });
    configInput[5] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.wstETH_UNDERLYING,
      svrOracle: SVR_wstETH
    });
    configInput[6] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.rETH_UNDERLYING,
      svrOracle: SVR_rETH
    });
    configInput[7] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.cbETH_UNDERLYING,
      svrOracle: SVR_cbETH
    });
    configInput[8] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.USDC_UNDERLYING,
      svrOracle: SVR_USDC
    });
    ISvrOracleSteward(AaveV3Ethereum.SVR_STEWARD).enableSvrOracles(configInput);
  }
}
