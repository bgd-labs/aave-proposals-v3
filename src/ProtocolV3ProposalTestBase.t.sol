// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {ProtocolV3ProposalTestBase} from './ProtocolV3ProposalTestBase.sol';
import {ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';

contract ProtocolV3ProposalTestBaseTest is ProtocolV3ProposalTestBase {
  address internal constant ASSET_A = address(1);
  address internal constant ASSET_B = address(2);
  address internal constant ASSET_C = address(3);

  function test_validateExpectedReserveConfigChanges() public view {
    this.validateReserveConfigChanges(_configsBefore(), _configsAfter());
  }

  function test_revertsWhenDeclaredBorrowCapIsNotApplied() public {
    ReserveConfig[] memory configsAfter = _configsAfter();
    configsAfter[1].borrowCap = 701;

    vm.expectRevert(bytes('_validateReserveConfig: InvalidBorrowCap()'));
    this.validateReserveConfigChanges(_configsBefore(), configsAfter);
  }

  function test_revertsWhenUndeclaredReserveConfigChanges() public {
    ReserveConfig[] memory configsAfter = _configsAfter();
    configsAfter[2].supplyCap = 301;

    vm.expectRevert(
      bytes('_noReservesConfigsChangesApartNewListings() : UNEXPECTED_SUPPLY_CAP_CHANGED')
    );
    this.validateReserveConfigChanges(_configsBefore(), configsAfter);
  }

  function validateReserveConfigChanges(
    ReserveConfig[] memory configsBefore,
    ReserveConfig[] memory configsAfter
  ) external pure {
    _validateReserveConfigChanges(configsBefore, configsAfter);
  }

  function _expectedCollateralChanges()
    internal
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[]
      memory updates = new IAaveV3ConfigEngine.CollateralUpdate[](1);
    updates[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: ASSET_A,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 5_00,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    return updates;
  }

  function _expectedCapsChanges()
    internal
    pure
    override
    returns (IAaveV3ConfigEngine.CapsUpdate[] memory)
  {
    IAaveV3ConfigEngine.CapsUpdate[] memory updates = new IAaveV3ConfigEngine.CapsUpdate[](1);
    updates[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: ASSET_B,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 700
    });
    return updates;
  }

  function _configsBefore() internal pure returns (ReserveConfig[] memory) {
    ReserveConfig[] memory configs = new ReserveConfig[](3);
    configs[0] = _reserveConfig('ASSET_A', ASSET_A, 75_00, 80_00, true, 1_000, 500);
    configs[1] = _reserveConfig('ASSET_B', ASSET_B, 70_00, 75_00, true, 2_000, 600);
    configs[2] = _reserveConfig('ASSET_C', ASSET_C, 60_00, 65_00, true, 300, 100);
    return configs;
  }

  function _configsAfter() internal pure returns (ReserveConfig[] memory) {
    ReserveConfig[] memory configs = _configsBefore();
    configs[0].ltv = 0;
    configs[0].liquidationThreshold = 0;
    configs[0].liquidationBonus = 105_00;
    configs[0].usageAsCollateralEnabled = false;
    configs[1].borrowCap = 700;
    return configs;
  }

  function _reserveConfig(
    string memory symbol,
    address underlying,
    uint256 ltv,
    uint256 liquidationThreshold,
    bool usageAsCollateralEnabled,
    uint256 supplyCap,
    uint256 borrowCap
  ) internal pure returns (ReserveConfig memory) {
    return
      ReserveConfig({
        symbol: symbol,
        underlying: underlying,
        aToken: address(uint160(underlying) + 10),
        variableDebtToken: address(uint160(underlying) + 20),
        decimals: 18,
        ltv: ltv,
        liquidationThreshold: liquidationThreshold,
        liquidationBonus: 106_00,
        liquidationProtocolFee: 10_00,
        reserveFactor: 20_00,
        usageAsCollateralEnabled: usageAsCollateralEnabled,
        borrowingEnabled: true,
        interestRateStrategy: address(uint160(underlying) + 30),
        isPaused: false,
        isActive: true,
        isFrozen: false,
        isFlashloanable: true,
        supplyCap: supplyCap,
        borrowCap: borrowCap,
        virtualBalance: 0,
        aTokenUnderlyingBalance: 0
      });
  }
}

contract ProtocolV3ProposalTestBaseNoChangesTest is ProtocolV3ProposalTestBase {
  address internal constant ASSET_A = address(1);
  address internal constant ASSET_B = address(2);

  function test_validateNoReserveConfigChanges() public view {
    this.validateReserveConfigChanges(_configsBefore(), _configsBefore());
  }

  function test_revertsWhenUnexpectedReserveConfigChanges() public {
    ReserveConfig[] memory configsAfter = _configsBefore();
    configsAfter[1].borrowCap = 701;

    vm.expectRevert(
      bytes('_noReservesConfigsChangesApartNewListings() : UNEXPECTED_BORROW_CAP_CHANGED')
    );
    this.validateReserveConfigChanges(_configsBefore(), configsAfter);
  }

  function validateReserveConfigChanges(
    ReserveConfig[] memory configsBefore,
    ReserveConfig[] memory configsAfter
  ) external pure {
    _validateReserveConfigChanges(configsBefore, configsAfter);
  }

  function _configsBefore() internal pure returns (ReserveConfig[] memory) {
    ReserveConfig[] memory configs = new ReserveConfig[](2);
    configs[0] = _reserveConfig('ASSET_A', ASSET_A, 75_00, 80_00, true, 1_000, 500);
    configs[1] = _reserveConfig('ASSET_B', ASSET_B, 70_00, 75_00, true, 2_000, 600);
    return configs;
  }

  function _reserveConfig(
    string memory symbol,
    address underlying,
    uint256 ltv,
    uint256 liquidationThreshold,
    bool usageAsCollateralEnabled,
    uint256 supplyCap,
    uint256 borrowCap
  ) internal pure returns (ReserveConfig memory) {
    return
      ReserveConfig({
        symbol: symbol,
        underlying: underlying,
        aToken: address(uint160(underlying) + 10),
        variableDebtToken: address(uint160(underlying) + 20),
        decimals: 18,
        ltv: ltv,
        liquidationThreshold: liquidationThreshold,
        liquidationBonus: 106_00,
        liquidationProtocolFee: 10_00,
        reserveFactor: 20_00,
        usageAsCollateralEnabled: usageAsCollateralEnabled,
        borrowingEnabled: true,
        interestRateStrategy: address(uint160(underlying) + 30),
        isPaused: false,
        isActive: true,
        isFrozen: false,
        isFlashloanable: true,
        supplyCap: supplyCap,
        borrowCap: borrowCap,
        virtualBalance: 0,
        aTokenUnderlyingBalance: 0
      });
  }
}
