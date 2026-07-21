// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IPriceCapAdapterStable} from 'src/interfaces/IPriceCapAdapterStable.sol';
import {AaveV3Horizon_PriceFeed_20260404} from './AaveV3Horizon_PriceFeed_20260404.sol';
import {AaveV3Horizon_PriceFeed_20260404_Test} from './AaveV3Horizon_PriceFeed_20260404.t.sol';

/**
 * @dev Fork variant of {AaveV3Horizon_PriceFeed_20260404_Test} that points at the
 * already-deployed payload on mainnet.
 * command: FOUNDRY_PROFILE=test forge test --match-contract AaveV3Horizon_PriceFeed_20260404_DeployedForkTest -vv
 */
contract AaveV3Horizon_PriceFeed_20260404_DeployedForkTest is
  AaveV3Horizon_PriceFeed_20260404_Test
{
  // https://etherscan.io/address/0xda6b3b075232725cdc34e0cb47859e5960765e7b
  address internal constant DEPLOYED_PAYLOAD = 0xdA6B3B075232725cDC34E0cb47859E5960765e7B;
  uint256 internal constant DEPLOYED_FORK_BLOCK = 25424006;

  function setUp() public override {
    vm.createSelectFork(vm.rpcUrl('mainnet'), DEPLOYED_FORK_BLOCK);

    require(
      DEPLOYED_PAYLOAD.code.length > 0,
      'DEPLOYED_PAYLOAD has no code at fork block - update DEPLOYED_PAYLOAD / DEPLOYED_FORK_BLOCK'
    );
    proposal = AaveV3Horizon_PriceFeed_20260404(DEPLOYED_PAYLOAD);

    newRlusdOracle = proposal.NEW_RLUSD_ORACLE();
    newUsdcOracle = proposal.NEW_USDC_ORACLE();

    rlusdAdapter = IPriceCapAdapterStable(newRlusdOracle);
    usdcAdapter = IPriceCapAdapterStable(newUsdcOracle);
  }
}
