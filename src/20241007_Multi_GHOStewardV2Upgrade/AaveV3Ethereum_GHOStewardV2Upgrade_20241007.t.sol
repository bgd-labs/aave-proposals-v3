// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IACLManager} from 'aave-address-book/AaveV3.sol';
import {IAccessControl} from '@openzeppelin/contracts/access/IAccessControl.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {IDefaultInterestRateStrategyV2} from './AaveV3.sol';
import {ReserveConfiguration} from './ReserveConfiguration.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';

import {AaveV3Ethereum_GHOStewardV2Upgrade_20241007} from './AaveV3Ethereum_GHOStewardV2Upgrade_20241007.sol';
import {IGhoAaveSteward} from 'src/interfaces/IGhoAaveSteward.sol';
import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
import {IGhoCcipSteward} from 'src/interfaces/IGhoCcipSteward.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGsm} from 'src/interfaces/IGsm.sol';
import {IUpgradeableLockReleaseTokenPool} from 'src/interfaces/ccip/IUpgradeableLockReleaseTokenPool.sol';

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
    uint256 currentBorrowCap = _getGhoBorrowCap();
    uint256 newBorrowCap = currentBorrowCap + 1;
    vm.startPrank(RISK_COUNCIL);
    IGhoAaveSteward(proposal.GHO_AAVE_STEWARD()).updateGhoBorrowCap(newBorrowCap);
    assertEq(_getGhoBorrowCap(), newBorrowCap);
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
