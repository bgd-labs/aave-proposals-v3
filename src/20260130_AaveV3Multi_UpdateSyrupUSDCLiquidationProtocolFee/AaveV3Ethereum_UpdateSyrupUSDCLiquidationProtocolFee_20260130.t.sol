// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum_UpdateSyrupUSDCLiquidationProtocolFee_20260130} from './AaveV3Ethereum_UpdateSyrupUSDCLiquidationProtocolFee_20260130.sol';
import {AaveV3Ethereum_ListingPTEthenaMay_20260129} from '../20260129_AaveV3Ethereum_ListingPTEthenaMay/AaveV3Ethereum_ListingPTEthenaMay_20260129.sol';
import {AaveV3Ethereum_OnboardStrataSrUSDePTTokensToV3CoreInstance_20260120} from '../20260120_AaveV3Ethereum_OnboardStrataSrUSDePTTokensToV3CoreInstance/AaveV3Ethereum_OnboardStrataSrUSDePTTokensToV3CoreInstance_20260120.sol';

/**
 * @dev Test for AaveV3Ethereum_UpdateSyrupUSDCLiquidationProtocolFee_20260130_Test
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260130_AaveV3Multi_UpdateSyrupUSDCLiquidationProtocolFee/AaveV3Ethereum_UpdateSyrupUSDCLiquidationProtocolFee_20260130.t.sol -vv
 */
contract AaveV3Ethereum_UpdateSyrupUSDCLiquidationProtocolFee_20260130_Test is ProtocolV3TestBase {
  AaveV3Ethereum_UpdateSyrupUSDCLiquidationProtocolFee_20260130 internal proposal;
  AaveV3Ethereum_ListingPTEthenaMay_20260129 internal ptEthenaProposal;
  AaveV3Ethereum_OnboardStrataSrUSDePTTokensToV3CoreInstance_20260120 internal strataProposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24379660);
    ptEthenaProposal = new AaveV3Ethereum_ListingPTEthenaMay_20260129();
    GovV3Helpers.executePayload(vm, address(ptEthenaProposal));
    strataProposal = new AaveV3Ethereum_OnboardStrataSrUSDePTTokensToV3CoreInstance_20260120();
    GovV3Helpers.executePayload(vm, address(strataProposal));
    proposal = new AaveV3Ethereum_UpdateSyrupUSDCLiquidationProtocolFee_20260130();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_UpdateSyrupUSDCLiquidationProtocolFee_20260130',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
