// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IACLManager, IDefaultInterestRateStrategyV2} from 'aave-address-book/AaveV3.sol';
import {IAccessControl} from '@openzeppelin/contracts/access/IAccessControl.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {ReserveConfiguration} from './ReserveConfiguration.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';

import {AaveV3Ethereum_GHOStewardV2Upgrade_20241007} from './AaveV3Ethereum_GHOStewardV2Upgrade_20241007.sol';
import {IGhoAaveSteward} from 'src/interfaces/IGhoAaveSteward.sol';
import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
import {IGhoCcipSteward} from 'src/interfaces/IGhoCcipSteward.sol';
import {IGsmSteward} from 'src/interfaces/IGsmSteward.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGsm} from 'src/interfaces/IGsm.sol';
import {IGsmFeeStrategy} from 'src/interfaces/IGsmFeeStrategy.sol';
import {RateLimiter, IUpgradeableLockReleaseTokenPool} from './Ccip.sol';

/**
 * @dev Test for AaveV3Ethereum_GHOStewardV2Upgrade_20241007
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241007_Multi_GHOStewardV2Upgrade/AaveV3Ethereum_GHOStewardV2Upgrade_20241007.t.sol -vv
 */
contract AaveV3Ethereum_GHOStewardV2Upgrade_20241007_Test is ProtocolV3TestBase {
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  AaveV3Ethereum_GHOStewardV2Upgrade_20241007 internal proposal;
  address public RISK_COUNCIL = 0x8513e6F37dBc52De87b166980Fa3F50639694B60;
  uint64 public remoteChainSelector = 4949039107694359620;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20967884);
    proposal = new AaveV3Ethereum_GHOStewardV2Upgrade_20241007();
  }

  function test_roles() public {
    assertTrue(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(proposal.OLD_STEWARD()));

    assertEq(
      IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).hasRole(
        IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).BUCKET_MANAGER_ROLE(),
        proposal.OLD_STEWARD()
      ),
      true,
      'Did not have bucket manager role'
    );

    assertEq(
      IGsm(MiscEthereum.GSM_USDC).hasRole(
        IGsm(MiscEthereum.GSM_USDC).CONFIGURATOR_ROLE(),
        proposal.OLD_STEWARD()
      ),
      true,
      'Did not have USDC GSM Configurator role'
    );

    assertEq(
      IGsm(MiscEthereum.GSM_USDT).hasRole(
        IGsm(MiscEthereum.GSM_USDT).CONFIGURATOR_ROLE(),
        proposal.OLD_STEWARD()
      ),
      true,
      'Did not have USDT GSM Configurator role'
    );

    // Gho Bucket Steward
    assertEq(
      IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).hasRole(
        IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).BUCKET_MANAGER_ROLE(),
        proposal.GHO_BUCKET_STEWARD()
      ),
      false
    );

    // Gho Aave Steward
    assertEq(
      IAccessControl(address(AaveV3Ethereum.ACL_MANAGER)).hasRole(
        IACLManager(address(AaveV3Ethereum.ACL_MANAGER)).RISK_ADMIN_ROLE(),
        proposal.GHO_AAVE_STEWARD()
      ),
      false
    );

    // Gho CCIP Steward
    assertEq(
      IUpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL).getBridgeLimitAdmin(),
      address(0)
    );
    assertEq(
      IUpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL).getRateLimitAdmin(),
      address(0)
    );

    // GHO GSM Steward
    assertEq(
      IGsm(MiscEthereum.GSM_USDC).hasRole(
        IGsm(MiscEthereum.GSM_USDC).CONFIGURATOR_ROLE(),
        proposal.GHO_GSM_STEWARD()
      ),
      false
    );
    assertEq(
      IGsm(MiscEthereum.GSM_USDT).hasRole(
        IGsm(MiscEthereum.GSM_USDT).CONFIGURATOR_ROLE(),
        proposal.GHO_GSM_STEWARD()
      ),
      false
    );

    executePayload(vm, address(proposal));

    assertFalse(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(proposal.OLD_STEWARD()));

    assertEq(
      IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).hasRole(
        IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).BUCKET_MANAGER_ROLE(),
        proposal.OLD_STEWARD()
      ),
      false
    );

    assertEq(
      IGsm(MiscEthereum.GSM_USDC).hasRole(
        IGsm(MiscEthereum.GSM_USDC).CONFIGURATOR_ROLE(),
        proposal.OLD_STEWARD()
      ),
      false
    );

    assertEq(
      IGsm(MiscEthereum.GSM_USDT).hasRole(
        IGsm(MiscEthereum.GSM_USDT).CONFIGURATOR_ROLE(),
        proposal.OLD_STEWARD()
      ),
      false
    );

    // Gho Bucket Steward
    assertEq(
      IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).hasRole(
        IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).BUCKET_MANAGER_ROLE(),
        proposal.GHO_BUCKET_STEWARD()
      ),
      true
    );

    assertTrue(
      IGhoBucketSteward(proposal.GHO_BUCKET_STEWARD()).isControlledFacilitator(
        AaveV3EthereumAssets.GHO_A_TOKEN
      )
    );
    assertTrue(
      IGhoBucketSteward(proposal.GHO_BUCKET_STEWARD()).isControlledFacilitator(
        MiscEthereum.GSM_USDC
      )
    );
    assertTrue(
      IGhoBucketSteward(proposal.GHO_BUCKET_STEWARD()).isControlledFacilitator(
        MiscEthereum.GSM_USDT
      )
    );

    // Gho Aave Steward
    assertEq(
      IAccessControl(address(AaveV3Ethereum.ACL_MANAGER)).hasRole(
        IACLManager(address(AaveV3Ethereum.ACL_MANAGER)).RISK_ADMIN_ROLE(),
        proposal.GHO_AAVE_STEWARD()
      ),
      true
    );

    assertEq(
      IUpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL).getBridgeLimitAdmin(),
      proposal.GHO_CCIP_STEWARD()
    );
    assertEq(
      IUpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL).getRateLimitAdmin(),
      proposal.GHO_CCIP_STEWARD()
    );

    // GHO GSM Steward
    assertEq(
      IGsm(MiscEthereum.GSM_USDC).hasRole(
        IGsm(MiscEthereum.GSM_USDC).CONFIGURATOR_ROLE(),
        proposal.GHO_GSM_STEWARD()
      ),
      true
    );
    assertEq(
      IGsm(MiscEthereum.GSM_USDT).hasRole(
        IGsm(MiscEthereum.GSM_USDT).CONFIGURATOR_ROLE(),
        proposal.GHO_GSM_STEWARD()
      ),
      true
    );
  }

  function test_ghoAaveSteward_updateGhoBorrowCap() public {
    executePayload(vm, address(proposal));

    uint256 currentBorrowCap = _getGhoBorrowCap();
    uint256 newBorrowCap = currentBorrowCap + 1;
    vm.startPrank(RISK_COUNCIL);
    IGhoAaveSteward(proposal.GHO_AAVE_STEWARD()).updateGhoBorrowCap(newBorrowCap);
    assertEq(_getGhoBorrowCap(), newBorrowCap);
  }

  function test_ghoAaveSteward_updateGhoSupplyCap() public {
    // Current config value is: 181338872942194741560446170431488
    // existingConfig |= (10 << 116); turns into 830948836238514615306439858845646848
    // this gives a value of 10 for the current supplyCap
    uint256 configValue = 830948836238514615306439858845646848;
    vm.mockCall(
      address(AaveV3Ethereum.POOL),
      abi.encodeWithSelector(AaveV3Ethereum.POOL.getConfiguration.selector),
      abi.encode(configValue)
    );

    uint256 currentSupplyCap = _getGhoSupplyCap();
    assertEq(currentSupplyCap, 10);
    uint256 newSupplyCap = currentSupplyCap + 1;

    executePayload(vm, address(proposal));

    IGhoAaveSteward steward = IGhoAaveSteward(proposal.GHO_AAVE_STEWARD());

    vm.startPrank(RISK_COUNCIL);
    steward.updateGhoSupplyCap(newSupplyCap);
    vm.stopPrank();

    vm.clearMockedCalls();

    assertEq(_getGhoSupplyCap(), newSupplyCap);
  }

  function test_ghoAaveSteward_revertsChangeFromZero() public {
    uint256 currentSupplyCap = _getGhoSupplyCap();
    assertEq(currentSupplyCap, 0);
    uint256 newSupplyCap = currentSupplyCap + 1;

    IGhoAaveSteward steward = IGhoAaveSteward(proposal.GHO_AAVE_STEWARD());

    // Can't update supply cap even by 1 since it's 0, and 100% of 0 is 0
    vm.expectRevert('INVALID_SUPPLY_CAP_UPDATE');
    vm.startPrank(RISK_COUNCIL);
    steward.updateGhoSupplyCap(newSupplyCap);
    vm.stopPrank();
  }

  function test_ghoAaveSteward_updateGhoBorrowRate() public {
    executePayload(vm, address(proposal));

    IDefaultInterestRateStrategyV2.InterestRateData memory currentRates = _getGhoBorrowRates();
    vm.startPrank(RISK_COUNCIL);
    IGhoAaveSteward(proposal.GHO_AAVE_STEWARD()).updateGhoBorrowRate(
      currentRates.optimalUsageRatio - 1,
      currentRates.baseVariableBorrowRate + 1,
      currentRates.variableRateSlope1 + 1,
      currentRates.variableRateSlope2 + 1
    );
    assertEq(_getOptimalUsageRatio(), currentRates.optimalUsageRatio - 1);
    assertEq(_getBaseVariableBorrowRate(), currentRates.baseVariableBorrowRate + 1);
    assertEq(_getVariableRateSlope1(), currentRates.variableRateSlope1 + 1);
    assertEq(_getVariableRateSlope2(), currentRates.variableRateSlope2 + 1);
  }

  function test_ghoBucketSteward_updateFacilitatorBucketCapacity() public {
    executePayload(vm, address(proposal));

    (uint256 currentBucketCapacity, ) = IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING)
      .getFacilitatorBucket(AaveV3EthereumAssets.GHO_A_TOKEN);
    vm.startPrank(RISK_COUNCIL);
    uint128 newBucketCapacity = uint128(currentBucketCapacity) + 1;
    IGhoBucketSteward(proposal.GHO_BUCKET_STEWARD()).updateFacilitatorBucketCapacity(
      AaveV3EthereumAssets.GHO_A_TOKEN,
      newBucketCapacity
    );
    (uint256 capacity, ) = IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).getFacilitatorBucket(
      AaveV3EthereumAssets.GHO_A_TOKEN
    );
    assertEq(newBucketCapacity, capacity);
  }

  function test_ghoBucketSteward_setControlledFacilitator() public {
    executePayload(vm, address(proposal));

    address[] memory newGsmList = new address[](1);
    newGsmList[0] = MiscEthereum.GSM_USDC;

    vm.startPrank(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    IGhoBucketSteward(proposal.GHO_BUCKET_STEWARD()).setControlledFacilitator(newGsmList, true);
    assertTrue(
      IGhoBucketSteward(proposal.GHO_BUCKET_STEWARD()).isControlledFacilitator(
        MiscEthereum.GSM_USDC
      )
    );

    IGhoBucketSteward(proposal.GHO_BUCKET_STEWARD()).setControlledFacilitator(newGsmList, false);
    assertFalse(
      IGhoBucketSteward(proposal.GHO_BUCKET_STEWARD()).isControlledFacilitator(
        MiscEthereum.GSM_USDC
      )
    );
  }

  function test_ghoCcipSteward_updateBridgeLimit() public {
    executePayload(vm, address(proposal));

    uint256 oldBridgeLimit = IUpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL)
      .getBridgeLimit();
    uint256 newBridgeLimit = oldBridgeLimit + 1;
    vm.startPrank(RISK_COUNCIL);
    IGhoCcipSteward(proposal.GHO_CCIP_STEWARD()).updateBridgeLimit(newBridgeLimit);
    uint256 currentBridgeLimit = IUpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL)
      .getBridgeLimit();
    assertEq(currentBridgeLimit, newBridgeLimit);
  }

  function test_ghoCcip_stewardUpdateRateLimit() public {
    executePayload(vm, address(proposal));

    RateLimiter.TokenBucket memory outboundConfig = IUpgradeableLockReleaseTokenPool(
      MiscEthereum.GHO_CCIP_TOKEN_POOL
    ).getCurrentOutboundRateLimiterState(remoteChainSelector);
    RateLimiter.TokenBucket memory inboundConfig = IUpgradeableLockReleaseTokenPool(
      MiscEthereum.GHO_CCIP_TOKEN_POOL
    ).getCurrentInboundRateLimiterState(remoteChainSelector);

    RateLimiter.Config memory newOutboundConfig = RateLimiter.Config({
      isEnabled: outboundConfig.isEnabled,
      capacity: outboundConfig.capacity + 1,
      rate: outboundConfig.rate
    });

    RateLimiter.Config memory newInboundConfig = RateLimiter.Config({
      isEnabled: outboundConfig.isEnabled,
      capacity: inboundConfig.capacity,
      rate: inboundConfig.rate
    });

    IGhoCcipSteward steward = IGhoCcipSteward(proposal.GHO_CCIP_STEWARD());

    // Currently rate limit set to 0, so can't even change by 1 because 100% of 0 is 0
    vm.expectRevert('INVALID_RATE_LIMIT_UPDATE');
    vm.startPrank(RISK_COUNCIL);
    steward.updateRateLimit(
      remoteChainSelector,
      newOutboundConfig.isEnabled,
      newOutboundConfig.capacity,
      newOutboundConfig.rate,
      newInboundConfig.isEnabled,
      newInboundConfig.capacity,
      newInboundConfig.rate
    );
  }

  function test_ghoGsmSteward_pdateExposureCap() public {
    executePayload(vm, address(proposal));

    uint128 oldExposureCap = IGsm(MiscEthereum.GSM_USDC).getExposureCap();
    uint128 newExposureCap = oldExposureCap + 1;

    vm.startPrank(RISK_COUNCIL);
    IGsmSteward(proposal.GHO_GSM_STEWARD()).updateGsmExposureCap(
      MiscEthereum.GSM_USDC,
      newExposureCap
    );
    uint128 currentExposureCap = IGsm(MiscEthereum.GSM_USDC).getExposureCap();
    assertEq(currentExposureCap, newExposureCap);
  }

  function test_ghoGsmSteward_updateGsmBuySellFees() public {
    executePayload(vm, address(proposal));

    address feeStrategy = IGsm(MiscEthereum.GSM_USDC).getFeeStrategy();
    uint256 buyFee = IGsmFeeStrategy(feeStrategy).getBuyFee(1e4);
    uint256 sellFee = IGsmFeeStrategy(feeStrategy).getSellFee(1e4);

    vm.startPrank(RISK_COUNCIL);
    IGsmSteward(proposal.GHO_GSM_STEWARD()).updateGsmBuySellFees(
      MiscEthereum.GSM_USDC,
      buyFee + 1,
      sellFee
    );
    address newStrategy = IGsm(MiscEthereum.GSM_USDC).getFeeStrategy();
    uint256 newBuyFee = IGsmFeeStrategy(newStrategy).getBuyFee(1e4);
    assertEq(newBuyFee, buyFee + 1);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_GHOStewardV2Upgrade_20241007',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  // Helpers

  function _getGhoBorrowCap() internal view returns (uint256) {
    DataTypes.ReserveConfigurationMap memory configuration = AaveV3Ethereum.POOL.getConfiguration(
      AaveV3EthereumAssets.GHO_UNDERLYING
    );
    return configuration.getBorrowCap();
  }

  function _getGhoSupplyCap() internal view returns (uint256) {
    DataTypes.ReserveConfigurationMap memory configuration = AaveV3Ethereum.POOL.getConfiguration(
      AaveV3EthereumAssets.GHO_UNDERLYING
    );
    return configuration.getSupplyCap();
  }

  function _getOptimalUsageRatio() internal view returns (uint16) {
    IDefaultInterestRateStrategyV2.InterestRateData memory currentRates = _getGhoBorrowRates();
    return currentRates.optimalUsageRatio;
  }

  function _getBaseVariableBorrowRate() internal view returns (uint32) {
    IDefaultInterestRateStrategyV2.InterestRateData memory currentRates = _getGhoBorrowRates();
    return currentRates.baseVariableBorrowRate;
  }

  function _getVariableRateSlope1() internal view returns (uint32) {
    IDefaultInterestRateStrategyV2.InterestRateData memory currentRates = _getGhoBorrowRates();
    return currentRates.variableRateSlope1;
  }

  function _getVariableRateSlope2() internal view returns (uint32) {
    IDefaultInterestRateStrategyV2.InterestRateData memory currentRates = _getGhoBorrowRates();
    return currentRates.variableRateSlope2;
  }

  function _getGhoBorrowRates()
    internal
    view
    returns (IDefaultInterestRateStrategyV2.InterestRateData memory)
  {
    address rateStrategyAddress = AaveV3Ethereum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getInterestRateStrategyAddress(AaveV3EthereumAssets.GHO_UNDERLYING);
    return
      IDefaultInterestRateStrategyV2(rateStrategyAddress).getInterestRateDataBps(
        AaveV3EthereumAssets.GHO_UNDERLYING
      );
  }
}
