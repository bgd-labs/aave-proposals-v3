// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IGhoAaveSteward} from 'src/interfaces/IGhoAaveSteward.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {IOwnable} from 'aave-address-book/common/IOwnable.sol';
import {IDefaultInterestRateStrategyV2} from 'aave-address-book/AaveV3.sol';

import {IRiskSteward} from './IRiskSteward.sol';
import {ReserveConfiguration} from 'aave-v3-origin/contracts/protocol/libraries/configuration/ReserveConfiguration.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_ExtendGHOStewardOnAavePrimeInstance_20250129} from './AaveV3EthereumLido_ExtendGHOStewardOnAavePrimeInstance_20250129.sol';

/**
 * @dev Test for AaveV3EthereumLido_ExtendGHOStewardOnAavePrimeInstance_20250129
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250129_AaveV3EthereumLido_ExtendGHOStewardOnAavePrimeInstance/AaveV3EthereumLido_ExtendGHOStewardOnAavePrimeInstance_20250129.t.sol -vv
 */
contract AaveV3EthereumLido_ExtendGHOStewardOnAavePrimeInstance_20250129_Test is
  ProtocolV3TestBase
{
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;
  AaveV3EthereumLido_ExtendGHOStewardOnAavePrimeInstance_20250129 internal proposal;
  // https://etherscan.io/address/0x5C905d62B22e4DAa4967E517C4a047Ff6026C731
  IGhoAaveSteward public constant NEW_GHO_AAVE_STEWARD =
    IGhoAaveSteward(0x5C905d62B22e4DAa4967E517C4a047Ff6026C731);

  // The address of council
  // https://etherscan.io/address/0x8513e6F37dBc52De87b166980Fa3F50639694B60
  address public constant RISK_COUNCIL = 0x8513e6F37dBc52De87b166980Fa3F50639694B60;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21738505);
    proposal = new AaveV3EthereumLido_ExtendGHOStewardOnAavePrimeInstance_20250129();
  }

  function testValidate() public {
    assertFalse(
      AaveV3EthereumLido.ACL_MANAGER.hasRole(
        AaveV3EthereumLido.ACL_MANAGER.RISK_ADMIN_ROLE(),
        address(NEW_GHO_AAVE_STEWARD)
      )
    );
    assertFalse(
      IRiskSteward(AaveV3EthereumLido.RISK_STEWARD).isAddressRestricted(
        AaveV3EthereumLidoAssets.GHO_UNDERLYING
      )
    );
    assertEq(address(proposal.NEW_GHO_AAVE_STEWARD()), address(NEW_GHO_AAVE_STEWARD));
    assertEq(IOwnable(address(NEW_GHO_AAVE_STEWARD)).owner(), GovernanceV3Ethereum.EXECUTOR_LVL_1);
    assertEq(
      NEW_GHO_AAVE_STEWARD.POOL_ADDRESSES_PROVIDER(),
      address(AaveV3EthereumLido.POOL_ADDRESSES_PROVIDER)
    );
    assertEq(
      NEW_GHO_AAVE_STEWARD.POOL_DATA_PROVIDER(),
      address(AaveV3EthereumLido.AAVE_PROTOCOL_DATA_PROVIDER)
    );
    assertEq(NEW_GHO_AAVE_STEWARD.GHO_TOKEN(), AaveV3EthereumLidoAssets.GHO_UNDERLYING);
    assertEq(NEW_GHO_AAVE_STEWARD.RISK_COUNCIL(), RISK_COUNCIL);
    assertEq(
      NEW_GHO_AAVE_STEWARD.getBorrowRateConfig(),
      IGhoAaveSteward.BorrowRateConfig({
        optimalUsageRatioMaxChange: 5_00,
        baseVariableBorrowRateMaxChange: 5_00,
        variableRateSlope1MaxChange: 5_00,
        variableRateSlope2MaxChange: 5_00
      })
    );

    executePayload(vm, address(proposal));

    assertTrue(
      AaveV3EthereumLido.ACL_MANAGER.hasRole(
        AaveV3EthereumLido.ACL_MANAGER.RISK_ADMIN_ROLE(),
        address(NEW_GHO_AAVE_STEWARD)
      )
    );
    assertTrue(
      IRiskSteward(AaveV3EthereumLido.RISK_STEWARD).isAddressRestricted(
        AaveV3EthereumLidoAssets.GHO_UNDERLYING
      )
    );
  }

  function test_ghoAaveSteward_updateGhoBorrowCap() public {
    executePayload(vm, address(proposal));

    uint256 currentBorrowCap = _getGhoBorrowCap();
    uint256 newBorrowCap = currentBorrowCap + 1;
    vm.startPrank(RISK_COUNCIL);
    IGhoAaveSteward(proposal.NEW_GHO_AAVE_STEWARD()).updateGhoBorrowCap(newBorrowCap);
    assertEq(_getGhoBorrowCap(), newBorrowCap);
  }

  function test_ghoAaveSteward_updateGhoSupplyCap() public {
    uint256 configValue = 830948836238514615306439858845646848;
    vm.mockCall(
      address(AaveV3EthereumLido.POOL),
      abi.encodeWithSelector(AaveV3EthereumLido.POOL.getConfiguration.selector),
      abi.encode(configValue)
    );

    uint256 currentSupplyCap = _getGhoSupplyCap();
    assertEq(currentSupplyCap, 10);
    uint256 newSupplyCap = currentSupplyCap + 1;

    executePayload(vm, address(proposal));

    IGhoAaveSteward steward = IGhoAaveSteward(proposal.NEW_GHO_AAVE_STEWARD());

    vm.startPrank(RISK_COUNCIL);
    steward.updateGhoSupplyCap(newSupplyCap);
    vm.stopPrank();

    vm.clearMockedCalls();

    assertEq(_getGhoSupplyCap(), newSupplyCap);
  }

  function test_ghoAaveSteward_revertsChangeOverMax() public {
    executePayload(vm, address(proposal));

    uint256 currentSupplyCap = _getGhoSupplyCap();
    assertEq(currentSupplyCap, 20000000);
    uint256 newSupplyCap = 2 * currentSupplyCap + 1;

    IGhoAaveSteward steward = IGhoAaveSteward(proposal.NEW_GHO_AAVE_STEWARD());

    // Can't update supply cap even by 1 since it's 0, and 100% of 0 is 0
    vm.expectRevert('INVALID_SUPPLY_CAP_UPDATE');
    vm.startPrank(RISK_COUNCIL);
    steward.updateGhoSupplyCap(newSupplyCap);
    vm.stopPrank();
  }

  function test_ghoAaveSteward_updateGhoBorrowRate() public {
    executePayload(vm, address(proposal));

    address rateStrategyAddress = AaveV3EthereumLido
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getInterestRateStrategyAddress(AaveV3EthereumLidoAssets.GHO_UNDERLYING);

    IDefaultInterestRateStrategyV2.InterestRateData
      memory mockResponse = IDefaultInterestRateStrategyV2.InterestRateData({
        optimalUsageRatio: 100,
        baseVariableBorrowRate: 100,
        variableRateSlope1: 100,
        variableRateSlope2: 100
      });
    vm.mockCall(
      rateStrategyAddress,
      abi.encodeWithSelector(
        IDefaultInterestRateStrategyV2(rateStrategyAddress).getInterestRateDataBps.selector,
        AaveV3EthereumLidoAssets.GHO_UNDERLYING
      ),
      abi.encode(mockResponse)
    );

    IDefaultInterestRateStrategyV2.InterestRateData memory currentRates = _getGhoBorrowRates();
    uint16 newOptimalUsageRatio = currentRates.optimalUsageRatio + 1;
    uint32 newBaseVariableBorrowRate = currentRates.baseVariableBorrowRate + 1;
    uint32 newVariableRateSlope1 = currentRates.variableRateSlope1 - 1;
    uint32 newVariableRateSlope2 = currentRates.variableRateSlope2 - 1;

    vm.startPrank(RISK_COUNCIL);
    IGhoAaveSteward(proposal.NEW_GHO_AAVE_STEWARD()).updateGhoBorrowRate(
      newOptimalUsageRatio,
      newBaseVariableBorrowRate,
      newVariableRateSlope1,
      newVariableRateSlope2
    );
    vm.stopPrank();

    vm.clearMockedCalls();

    assertEq(_getOptimalUsageRatio(), newOptimalUsageRatio);
    assertEq(_getBaseVariableBorrowRate(), newBaseVariableBorrowRate);
    assertEq(_getVariableRateSlope1(), newVariableRateSlope1);
    assertEq(_getVariableRateSlope2(), newVariableRateSlope2);
  }

  // Helpers

  function _getGhoBorrowCap() internal view returns (uint256) {
    DataTypes.ReserveConfigurationMap memory configuration = AaveV3EthereumLido
      .POOL
      .getConfiguration(AaveV3EthereumLidoAssets.GHO_UNDERLYING);
    return configuration.getBorrowCap();
  }

  function _getGhoSupplyCap() internal view returns (uint256) {
    DataTypes.ReserveConfigurationMap memory configuration = AaveV3EthereumLido
      .POOL
      .getConfiguration(AaveV3EthereumLidoAssets.GHO_UNDERLYING);
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
    address rateStrategyAddress = AaveV3EthereumLido
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getInterestRateStrategyAddress(AaveV3EthereumLidoAssets.GHO_UNDERLYING);
    return
      IDefaultInterestRateStrategyV2(rateStrategyAddress).getInterestRateDataBps(
        AaveV3EthereumLidoAssets.GHO_UNDERLYING
      );
  }

  function assertEq(
    IGhoAaveSteward.BorrowRateConfig memory a,
    IGhoAaveSteward.BorrowRateConfig memory b
  ) internal pure {
    assertEq(a.optimalUsageRatioMaxChange, b.optimalUsageRatioMaxChange);
    assertEq(a.baseVariableBorrowRateMaxChange, b.baseVariableBorrowRateMaxChange);
    assertEq(a.variableRateSlope1MaxChange, b.variableRateSlope1MaxChange);
    assertEq(a.variableRateSlope2MaxChange, b.variableRateSlope2MaxChange);
    assertEq(abi.encode(a), abi.encode(b)); // sanity check
  }
}
