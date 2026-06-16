// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IPool} from 'aave-v3-origin/contracts/interfaces/IPool.sol';
import {IDefaultInterestRateStrategyV2} from 'aave-v3-origin/contracts/interfaces/IDefaultInterestRateStrategyV2.sol';
import {ProtocolV3HorizonTestBase, ReserveConfig} from 'tests/utils/ProtocolV3HorizonTestBase.sol';
import {HorizonConfigAssertionHelper} from 'tests/utils/HorizonConfigAssertionHelper.sol';
import {AaveV3Horizon_mGLOBALListing_20260616} from 'src/AaveV3Horizon_mGLOBALListing_20260616/AaveV3Horizon_mGLOBALListing_20260616.sol';
import {AaveV3EthereumHorizonCustom} from 'src/utils/AaveV3EthereumHorizonCustom.sol';

abstract contract AaveV3Horizon_mGLOBALListing_20260616_TestBase is ProtocolV3HorizonTestBase {
  AaveV3Horizon_mGLOBALListing_20260616 internal proposal;

  ExpectedAssetConfig internal expectedAssetConfig;

  function setUp() public virtual {
    _setExpectedConfig();
  }

  function _setExpectedConfig() internal virtual override {
    expectedAssetConfig = ExpectedAssetConfig({
      underlying: AaveV3EthereumHorizonCustom.MGLOBAL_UNDERLYING,
      isRwa: true,
      oracle: AaveV3EthereumHorizonCustom.MGLOBAL_PRICE_FEED,
      aTokenName: 'Aave Horizon RWA mGLOBAL',
      aTokenSymbol: 'aHorRwamGLOBAL',
      variableDebtTokenName: 'Aave Horizon RWA Variable Debt mGLOBAL',
      variableDebtTokenSymbol: 'variableDebtHorRwamGLOBAL',
      supplyCap: 60_000_000, // keep in sync with payload supplyCap
      borrowCap: 0,
      reserveFactor: 0,
      borrowingEnabled: false,
      flashloanable: false,
      ltv: 70_00,
      liquidationThreshold: 75_00,
      liquidationBonus: 100_00 + 6_00,
      debtCeiling: 0,
      liqProtocolFee: 0,
      rateData: IDefaultInterestRateStrategyV2.InterestRateData({
        optimalUsageRatio: 99_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 0,
        variableRateSlope2: 0
      })
    });
  }
}

/**
 * @dev Test for Horizon mGLOBAL listing (pre-execution).
 * command: FOUNDRY_PROFILE=test forge test --match-contract AaveV3Horizon_mGLOBALListing_20260616_Test -vv
 */
contract AaveV3Horizon_mGLOBALListing_20260616_Test is
  AaveV3Horizon_mGLOBALListing_20260616_TestBase
{
  function setUp() public virtual override {
    super.setUp();
    vm.createSelectFork(vm.rpcUrl('mainnet')); // TODO: pin to a block once the asset/feed are deployed
    proposal = new AaveV3Horizon_mGLOBALListing_20260616();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function _executeMGLOBALListing() internal {
    _executeHorizonPayload(address(proposal));
  }

  function test_defaultProposalExecution() public virtual {
    defaultTest_v3_3('AaveV3Horizon_mGLOBALListing_20260616', _pool(), _executeMGLOBALListing);
  }

  /**
   * @dev verifies the exact config values set by the mGLOBAL listing payload
   */
  function test_mglobalConfig() public virtual {
    IPool pool = _pool();

    // execute payload
    _executeHorizonPayload(address(proposal));

    // verify mGLOBAL asset config
    _assertAssetConfig(pool, expectedAssetConfig);
  }
}
