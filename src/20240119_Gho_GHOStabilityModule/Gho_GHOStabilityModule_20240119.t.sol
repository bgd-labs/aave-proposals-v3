// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV3EthereumAssets, AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {IPoolConfigurator} from 'aave-address-book/AaveV3.sol';
import {Gho_GHOStabilityModule_20240119} from './Gho_GHOStabilityModule_20240119.sol';

interface IGhoToken {
  struct Facilitator {
    uint128 bucketCapacity;
    uint128 bucketLevel;
    string label;
  }

  function getFacilitator(address facilitator) external view returns (Facilitator memory);

  function getFacilitatorsList() external view returns (address[] memory);
}

interface IGsm {
  function getFeeStrategy() external view returns (address);

  function getAvailableUnderlyingExposure() external view returns (uint256);

  function getIsFrozen() external view returns (bool);

  function getIsSeized() external view returns (bool);

  function UNDERLYING_ASSET() external view returns (address);
}

interface IFeeStrategy {
  function getBuyFee(uint256 grossAmount) external view returns (uint256);

  function getSellFee(uint256 grossAmount) external view returns (uint256);
}

interface IOracleSwapFreezer {
  function getCanUnfreeze() external view returns (bool);

  function getFreezeBound() external view returns (uint128, uint128);

  function getUnfreezeBound() external view returns (uint128, uint128);
}

/**
 * @dev Test for Gho_GHOStabilityModule_20240119
 * command: make test-contract filter=Gho_GHOStabilityModule_20240119
 */
contract Gho_GHOStabilityModule_20240119_Test is ProtocolV3TestBase {
  Gho_GHOStabilityModule_20240119 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19037431);
    proposal = new Gho_GHOStabilityModule_20240119();
  }

  function test_defaultProposalExecution() public {
    defaultTest('Gho_GHOStabilityModule_20240119', AaveV3Ethereum.POOL, address(proposal));
  }

  function test_checkConfig() public {
    uint256 facilitatorListLengthBefore = IGhoToken(AaveV3Ethereum.GHO_TOKEN)
      .getFacilitatorsList()
      .length;

    executePayload(vm, address(proposal));

    assertTrue(
      IGhoToken(AaveV3Ethereum.GHO_TOKEN).getFacilitatorsList().length ==
        facilitatorListLengthBefore + 2
    );
    IGhoToken.Facilitator memory gsmUsdc = IGhoToken(AaveV3Ethereum.GHO_TOKEN).getFacilitator(
      proposal.GSM_USDC()
    );
    assertEq(gsmUsdc.label, proposal.GSM_USDC_FACILITATOR_LABEL());
    assertEq(gsmUsdc.bucketCapacity, proposal.GSM_USDC_BUCKET_CAPACITY());
    assertEq(gsmUsdc.bucketLevel, 0);

    IGhoToken.Facilitator memory gsmUsdt = IGhoToken(AaveV3Ethereum.GHO_TOKEN).getFacilitator(
      proposal.GSM_USDT()
    );
    assertEq(gsmUsdt.label, proposal.GSM_USDT_FACILITATOR_LABEL());
    assertEq(gsmUsdt.bucketCapacity, proposal.GSM_USDT_BUCKET_CAPACITY());
    assertEq(gsmUsdt.bucketLevel, 0);

    // GSM USDC
    GsmConfig memory gsmUsdcConfig = GsmConfig({
      sellFee: 0.0020e4, // 0.2%
      buyFee: 0.0020e4, // 0.2%
      exposureCap: 500_000e6,
      isFrozen: false,
      isSeized: false,
      freezerCanUnfreeze: true,
      freezeLowerBound: 0.99e8,
      freezeUpperBound: 1.01e8,
      unfreezeLowerBound: 0.995e8,
      unfreezeUpperBound: 1.005e8
    });
    _checkGsmConfig(
      IGsm(proposal.GSM_USDC()),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      IOracleSwapFreezer(proposal.GSM_USDC_ORACLE_SWAP_FREEZER()),
      gsmUsdcConfig
    );

    // GSM USDT
    GsmConfig memory gsmUsdtConfig = GsmConfig({
      sellFee: 0.0020e4, // 0.2%
      buyFee: 0.0020e4, // 0.2%
      exposureCap: 500_000e6,
      isFrozen: false,
      isSeized: false,
      freezerCanUnfreeze: true,
      freezeLowerBound: 0.99e8,
      freezeUpperBound: 1.01e8,
      unfreezeLowerBound: 0.995e8,
      unfreezeUpperBound: 1.005e8
    });
    _checkGsmConfig(
      IGsm(proposal.GSM_USDT()),
      AaveV3EthereumAssets.USDT_UNDERLYING,
      IOracleSwapFreezer(proposal.GSM_USDT_ORACLE_SWAP_FREEZER()),
      gsmUsdtConfig
    );
  }

  struct GsmConfig {
    uint256 sellFee;
    uint256 buyFee;
    uint256 exposureCap;
    bool isFrozen;
    bool isSeized;
    bool freezerCanUnfreeze;
    uint256 freezeLowerBound;
    uint256 freezeUpperBound;
    uint256 unfreezeLowerBound;
    uint256 unfreezeUpperBound;
  }

  function _checkGsmConfig(
    IGsm gsm,
    address underlying,
    IOracleSwapFreezer freezer,
    GsmConfig memory config
  ) internal {
    assertEq(gsm.UNDERLYING_ASSET(), underlying, 'wrong underlying asset');
    assertEq(gsm.getAvailableUnderlyingExposure(), config.exposureCap, 'wrong exposure cap');
    assertEq(gsm.getIsFrozen(), config.isFrozen, 'wrong freeze state');
    assertEq(gsm.getIsSeized(), config.isSeized, 'wrong seized state');

    IFeeStrategy feeStrategy = IFeeStrategy(gsm.getFeeStrategy());
    assertEq(feeStrategy.getSellFee(10000), config.sellFee, 'wrong sell fee');
    assertEq(feeStrategy.getBuyFee(10000), config.buyFee, 'wrong buy fee');

    // Oracle freezer
    assertEq(freezer.getCanUnfreeze(), config.freezerCanUnfreeze, 'wrong freezer config');
    (uint256 lowerBound, uint256 upperBound) = freezer.getFreezeBound();
    assertEq(lowerBound, config.freezeLowerBound, 'wrong freeze lower bound');
    assertEq(upperBound, config.freezeUpperBound, 'wrong freeze upper bound');
    (lowerBound, upperBound) = freezer.getUnfreezeBound();
    assertEq(lowerBound, config.unfreezeLowerBound, 'wrong unfreeze lower bound');
    assertEq(upperBound, config.unfreezeUpperBound, 'wrong unfreeze upper bound');
  }
}
