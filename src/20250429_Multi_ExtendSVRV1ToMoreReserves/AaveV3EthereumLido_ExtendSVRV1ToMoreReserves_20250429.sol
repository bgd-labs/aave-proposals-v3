// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {ISvrOracleSteward} from '../interfaces/ISvrOracleSteward.sol';

/**
 * @title Extend SVR V1 to more reserves
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/direct-to-aip-aave-chainlink-svr-v1-activation-phase-2/21940
 */
contract AaveV3EthereumLido_ExtendSVRV1ToMoreReserves_20250429 is IProposalGenericExecutor {
  address public constant SVR_rsETH = 0x7292C95A5f6A501a9c4B34f6393e221F2A0139c3;
  address public constant SVR_ezETH = 0xF3d49021fF3bbBFDfC1992A4b09E5D1d141D044C;
  address public constant SVR_WETH = 0x5424384B256154046E9667dDFaaa5e550145215e;
  address public constant SVR_wstETH = 0xe1D97bF61901B075E9626c8A2340a7De385861Ef;
  address public constant SVR_USDC = 0x3f73F03aa83B2A48ed27E964eD0fDb590332095B;

  function execute() external {
    AaveV3EthereumLido.ACL_MANAGER.addAssetListingAdmin(AaveV3EthereumLido.SVR_STEWARD);
    ISvrOracleSteward.AssetOracle[] memory configInput = new ISvrOracleSteward.AssetOracle[](5);
    configInput[0] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumLidoAssets.rsETH_UNDERLYING,
      svrOracle: SVR_rsETH
    });
    configInput[1] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumLidoAssets.ezETH_UNDERLYING,
      svrOracle: SVR_ezETH
    });
    configInput[2] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumLidoAssets.WETH_UNDERLYING,
      svrOracle: SVR_WETH
    });
    configInput[3] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumLidoAssets.wstETH_UNDERLYING,
      svrOracle: SVR_wstETH
    });
    configInput[4] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumLidoAssets.USDC_UNDERLYING,
      svrOracle: SVR_USDC
    });
    ISvrOracleSteward(AaveV3EthereumLido.SVR_STEWARD).enableSvrOracles(configInput);
  }
}
