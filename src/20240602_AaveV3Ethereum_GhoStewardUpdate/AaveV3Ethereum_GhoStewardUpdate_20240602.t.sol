// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IGhoStewardV2} from './interfaces/IGhoStewardV2.sol';
import {IGhoToken} from './interfaces/IGho.sol';
import {IGsmFeeStrategy} from './interfaces/IGsmFeeStrategy.sol';
import {IGsm} from './interfaces/IGSM.sol';
import {IDefaultInterestRateStrategy} from 'aave-v3-core/contracts/interfaces/IDefaultInterestRateStrategy.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_GhoStewardUpdate_20240602} from './AaveV3Ethereum_GhoStewardUpdate_20240602.sol';

/**
 * @dev Test for AaveV3Ethereum_GhoStewardUpdate_20240602
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240602_AaveV3Ethereum_GhoStewardUpdate/AaveV3Ethereum_GhoStewardUpdate_20240602.t.sol
 -vv
 */
contract AaveV3Ethereum_GhoStewardUpdate_20240602_Test is ProtocolV3TestBase {
  AaveV3Ethereum_GhoStewardUpdate_20240602 internal proposal;
  address public RISK_COUNCIL;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20017052);
    proposal = new AaveV3Ethereum_GhoStewardUpdate_20240602();
    RISK_COUNCIL = IGhoStewardV2(proposal.GHO_STEWARD()).RISK_COUNCIL();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_GhoStewardUpdate_20240602', AaveV3Ethereum.POOL, address(proposal));
  }

  function test_adminPermissions() public {
    executePayload(vm, address(proposal));

    // Check that the old steward has been removed from roles

    assertFalse(AaveV3Ethereum.ACL_MANAGER.isPoolAdmin(proposal.OLD_GHO_STEWARD()));

    assertFalse(
      IGhoToken(MiscEthereum.GHO_TOKEN).hasRole(
        IGhoToken(MiscEthereum.GHO_TOKEN).BUCKET_MANAGER_ROLE(),
        proposal.OLD_GHO_STEWARD()
      )
    );

    assertFalse(
      IGsm(MiscEthereum.GSM_USDT).hasRole(
        IGsm(MiscEthereum.GSM_USDT).CONFIGURATOR_ROLE(),
        proposal.OLD_GHO_STEWARD()
      )
    );

    assertFalse(
      IGsm(MiscEthereum.GSM_USDC).hasRole(
        IGsm(MiscEthereum.GSM_USDC).CONFIGURATOR_ROLE(),
        proposal.OLD_GHO_STEWARD()
      )
    );

    assertTrue(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(proposal.GHO_STEWARD()));
    assertTrue(
      IGhoToken(MiscEthereum.GHO_TOKEN).hasRole(
        IGhoToken(MiscEthereum.GHO_TOKEN).BUCKET_MANAGER_ROLE(),
        proposal.GHO_STEWARD()
      )
    );
    assertTrue(
      IGsm(MiscEthereum.GSM_USDT).hasRole(
        IGsm(MiscEthereum.GSM_USDT).CONFIGURATOR_ROLE(),
        proposal.GHO_STEWARD()
      )
    );
    assertTrue(
      IGsm(MiscEthereum.GSM_USDC).hasRole(
        IGsm(MiscEthereum.GSM_USDC).CONFIGURATOR_ROLE(),
        proposal.GHO_STEWARD()
      )
    );

    address[] memory controlledFacilitatorsList = IGhoStewardV2(proposal.GHO_STEWARD())
      .getControlledFacilitators();
    address[] memory ghoFacilitatorList = IGhoToken(MiscEthereum.GHO_TOKEN).getFacilitatorsList();
    assertEq(controlledFacilitatorsList.length, ghoFacilitatorList.length);

    for (uint256 i = 0; i < controlledFacilitatorsList.length; i++) {
      assertEq(controlledFacilitatorsList[i], ghoFacilitatorList[i]);
    }
  }

  function testUpdateGhoBorrowRate() public {
    executePayload(vm, address(proposal));

    uint256 oldBorrowRate = _getGhoBorrowRate();
    uint256 newBorrowRate = oldBorrowRate + 1;

    vm.startPrank(RISK_COUNCIL);
    IGhoStewardV2(proposal.GHO_STEWARD()).updateGhoBorrowRate(newBorrowRate);
    vm.stopPrank();

    uint256 currentBorrowRate = _getGhoBorrowRate();
    assertEq(currentBorrowRate, newBorrowRate);
  }

  function testLowerGhoBorrowRate() public {
    executePayload(vm, address(proposal));

    uint256 oldBorrowRate = _getGhoBorrowRate();
    uint256 newBorrowRate = oldBorrowRate - 1;

    vm.startPrank(RISK_COUNCIL);
    IGhoStewardV2(proposal.GHO_STEWARD()).updateGhoBorrowRate(newBorrowRate);
    vm.stopPrank();

    uint256 currentBorrowRate = _getGhoBorrowRate();
    assertEq(currentBorrowRate, newBorrowRate);
  }

  function testUpdateGhoBorrowCap() public {
    executePayload(vm, address(proposal));

    (uint256 oldBorrowCap, ) = AaveV3Ethereum.AAVE_PROTOCOL_DATA_PROVIDER.getReserveCaps(
      MiscEthereum.GHO_TOKEN
    );
    uint256 newBorrowCap = oldBorrowCap + 1;

    vm.startPrank(RISK_COUNCIL);
    IGhoStewardV2(proposal.GHO_STEWARD()).updateGhoBorrowCap(newBorrowCap);
    vm.stopPrank();

    (uint256 updatedBorrowCap, ) = AaveV3Ethereum.AAVE_PROTOCOL_DATA_PROVIDER.getReserveCaps(
      MiscEthereum.GHO_TOKEN
    );
    assertEq(newBorrowCap, updatedBorrowCap);
  }

  function testLowerGhoBorrowCap() public {
    executePayload(vm, address(proposal));

    (uint256 oldBorrowCap, ) = AaveV3Ethereum.AAVE_PROTOCOL_DATA_PROVIDER.getReserveCaps(
      MiscEthereum.GHO_TOKEN
    );
    uint256 newBorrowCap = oldBorrowCap - 1;

    vm.startPrank(RISK_COUNCIL);
    IGhoStewardV2(proposal.GHO_STEWARD()).updateGhoBorrowCap(newBorrowCap);
    vm.stopPrank();

    (uint256 updatedBorrowCap, ) = AaveV3Ethereum.AAVE_PROTOCOL_DATA_PROVIDER.getReserveCaps(
      MiscEthereum.GHO_TOKEN
    );
    assertEq(newBorrowCap, updatedBorrowCap);
  }

  function testUpdateFacilitatorBucketCapacity() public {
    executePayload(vm, address(proposal));
    address[] memory ghoFacilitatorList = IGhoToken(MiscEthereum.GHO_TOKEN).getFacilitatorsList();

    for (uint256 i = 0; i < ghoFacilitatorList.length; i++) {
      address ghoFacilitator = ghoFacilitatorList[i];
      (uint256 currentBucketCapacity, ) = IGhoToken(MiscEthereum.GHO_TOKEN).getFacilitatorBucket(
        ghoFacilitator
      );
      uint128 newBucketCapacity = uint128(currentBucketCapacity) + 1;

      vm.startPrank(RISK_COUNCIL);
      IGhoStewardV2(proposal.GHO_STEWARD()).updateFacilitatorBucketCapacity(
        ghoFacilitator,
        newBucketCapacity
      );
      vm.stopPrank();

      (uint256 updatedCapacity, ) = IGhoToken(MiscEthereum.GHO_TOKEN).getFacilitatorBucket(
        ghoFacilitator
      );
      assertEq(newBucketCapacity, updatedCapacity);
    }
  }

  function testUpdateGsmExposureCap() public {
    executePayload(vm, address(proposal));

    address[2] memory gsmList;
    gsmList[0] = MiscEthereum.GSM_USDC;
    gsmList[1] = MiscEthereum.GSM_USDT;

    for (uint256 i = 0; i < gsmList.length; i++) {
      address gsm = gsmList[i];

      uint128 oldExposureCap = IGsm(gsm).getExposureCap();
      uint128 newExposureCap = oldExposureCap + 1;

      vm.startPrank(RISK_COUNCIL);
      IGhoStewardV2(proposal.GHO_STEWARD()).updateGsmExposureCap(gsm, newExposureCap);
      vm.stopPrank();

      uint128 currentExposureCap = IGsm(gsm).getExposureCap();
      assertEq(currentExposureCap, newExposureCap);
    }
  }

  function testLowerGsmExposureCap() public {
    executePayload(vm, address(proposal));

    address[2] memory gsmList;
    gsmList[0] = MiscEthereum.GSM_USDC;
    gsmList[1] = MiscEthereum.GSM_USDT;

    for (uint256 i = 0; i < gsmList.length; i++) {
      address gsm = gsmList[i];

      uint128 oldExposureCap = IGsm(gsm).getExposureCap();
      uint128 newExposureCap = oldExposureCap - 1;

      vm.startPrank(RISK_COUNCIL);
      IGhoStewardV2(proposal.GHO_STEWARD()).updateGsmExposureCap(gsm, newExposureCap);
      vm.stopPrank();

      uint128 currentExposureCap = IGsm(gsm).getExposureCap();
      assertEq(currentExposureCap, newExposureCap);
    }
  }

  function testUpdateGsmBuySellFeesBuyFee() public {
    executePayload(vm, address(proposal));

    address[2] memory gsmList;
    gsmList[0] = MiscEthereum.GSM_USDC;
    gsmList[1] = MiscEthereum.GSM_USDT;

    for (uint256 i = 0; i < gsmList.length; i++) {
      address gsm = gsmList[i];

      address feeStrategy = IGsm(gsm).getFeeStrategy();
      uint256 buyFee = IGsmFeeStrategy(feeStrategy).getBuyFee(1e4);
      uint256 sellFee = IGsmFeeStrategy(feeStrategy).getSellFee(1e4);

      vm.startPrank(RISK_COUNCIL);
      IGhoStewardV2(proposal.GHO_STEWARD()).updateGsmBuySellFees(gsm, buyFee + 1, sellFee + 1);
      vm.stopPrank();

      address newStrategy = IGsm(gsm).getFeeStrategy();
      uint256 newBuyFee = IGsmFeeStrategy(newStrategy).getBuyFee(1e4);
      uint256 newSellFee = IGsmFeeStrategy(newStrategy).getSellFee(1e4);

      assertEq(newBuyFee, buyFee + 1);
      assertEq(newSellFee, sellFee + 1);
    }
  }

  function testLowerGsmBuySellFeesBuyFee() public {
    executePayload(vm, address(proposal));

    address[2] memory gsmList;
    gsmList[0] = MiscEthereum.GSM_USDC;
    gsmList[1] = MiscEthereum.GSM_USDT;

    for (uint256 i = 0; i < gsmList.length; i++) {
      address gsm = gsmList[i];

      address feeStrategy = IGsm(gsm).getFeeStrategy();
      uint256 buyFee = IGsmFeeStrategy(feeStrategy).getBuyFee(1e4);
      uint256 sellFee = IGsmFeeStrategy(feeStrategy).getSellFee(1e4);

      vm.startPrank(RISK_COUNCIL);
      IGhoStewardV2(proposal.GHO_STEWARD()).updateGsmBuySellFees(gsm, buyFee - 1, sellFee - 1);
      vm.stopPrank();

      address newStrategy = IGsm(gsm).getFeeStrategy();
      uint256 newBuyFee = IGsmFeeStrategy(newStrategy).getBuyFee(1e4);
      uint256 newSellFee = IGsmFeeStrategy(newStrategy).getSellFee(1e4);

      assertEq(newBuyFee, buyFee - 1);
      assertEq(newSellFee, sellFee - 1);
    }
  }

  function _getGhoBorrowRate() internal view returns (uint256) {
    address currentInterestRateStrategy = AaveV3Ethereum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getInterestRateStrategyAddress(address(MiscEthereum.GHO_TOKEN));
    return IDefaultInterestRateStrategy(currentInterestRateStrategy).getBaseVariableBorrowRate();
  }
}
