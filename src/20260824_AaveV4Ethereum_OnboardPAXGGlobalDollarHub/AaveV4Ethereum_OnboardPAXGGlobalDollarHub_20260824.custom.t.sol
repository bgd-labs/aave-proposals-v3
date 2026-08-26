// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV4EthereumAssets, AaveV4EthereumHubs, AaveV4EthereumSpokes} from 'aave-address-book/AaveV4Ethereum.sol';
import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';
import {ISpoke} from 'aave-v4/spoke/interfaces/ISpoke.sol';

import 'forge-std/Test.sol';
import {ProtocolV4TestBaseEthereum} from 'aave-helpers/src/v4-protocol-test/ProtocolV4TestBaseEthereum.sol';
import {AaveV4Ethereum_OnboardPAXGGlobalDollarHub_20260824} from './AaveV4Ethereum_OnboardPAXGGlobalDollarHub_20260824.sol';

interface ITimelockController {
  function getMinDelay() external view returns (uint256);

  function DEFAULT_ADMIN_ROLE() external view returns (bytes32);

  function PROPOSER_ROLE() external view returns (bytes32);

  function EXECUTOR_ROLE() external view returns (bytes32);

  function CANCELLER_ROLE() external view returns (bytes32);

  function hasRole(bytes32 role, address account) external view returns (bool);
}

contract AaveV4Ethereum_OnboardPAXGGlobalDollarHub_20260824_CustomTest is
  ProtocolV4TestBaseEthereum
{
  bytes32 internal constant ZEPPELINOS_ADMIN_SLOT = keccak256('org.zeppelinos.proxy.admin');
  address internal constant PAXG_TIMELOCK = 0x4a515afE11581FD87BA90D6459DC93DB6591F5e3;
  address internal constant PAXG_TIMELOCK_CONTROLLER = 0x3Af3e85f4f97De7AD0f000B724Fb77fE5ffc024B;

  AaveV4Ethereum_OnboardPAXGGlobalDollarHub_20260824 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25833443);
    proposal = new AaveV4Ethereum_OnboardPAXGGlobalDollarHub_20260824();
  }

  function test_preState() public view {
    IHub hub = IHub(address(AaveV4EthereumHubs.GLOBAL_DOLLAR_HUB));
    uint256 usdgAssetId = hub.getAssetId(address(AaveV4EthereumAssets.USDG_UNDERLYING));

    assertFalse(hub.isUnderlyingListed(proposal.PAXG()), 'PAXG already listed');
    assertFalse(
      hub.isSpokeListed(usdgAssetId, address(AaveV4EthereumSpokes.GOLD_SPOKE)),
      'Global Dollar USDG already listed on Gold Spoke'
    );
    assertFalse(
      hub.isSpokeListed(usdgAssetId, address(AaveV4EthereumSpokes.USDG_PENDLE_SPOKE)),
      'Global Dollar USDG already listed on Pendle Spoke'
    );

    ISpoke.LiquidationConfig memory cfg = ISpoke(address(AaveV4EthereumSpokes.GOLD_SPOKE))
      .getLiquidationConfig();
    assertEq(uint256(cfg.targetHealthFactor), uint256(1.3075e18), 'targetHealthFactor pre-state');
    assertEq(
      uint256(cfg.healthFactorForMaxBonus),
      uint256(0.9e18),
      'healthFactorForMaxBonus pre-state'
    );
    assertEq(uint256(cfg.liquidationBonusFactor), uint256(90_00), 'bonusFactor pre-state');
  }

  function test_paxgProxyAdminTimelock() public view {
    address proxyAdmin = address(uint160(uint256(vm.load(proposal.PAXG(), ZEPPELINOS_ADMIN_SLOT))));
    assertEq(proxyAdmin, PAXG_TIMELOCK, 'PAXG proxy admin is not the timelock');

    ITimelockController timelock = ITimelockController(PAXG_TIMELOCK);
    assertEq(timelock.getMinDelay(), 1 days, 'unexpected PAXG timelock delay');
    assertTrue(
      timelock.hasRole(timelock.PROPOSER_ROLE(), PAXG_TIMELOCK_CONTROLLER),
      'unexpected PAXG timelock proposer'
    );
    assertTrue(
      timelock.hasRole(timelock.EXECUTOR_ROLE(), PAXG_TIMELOCK_CONTROLLER),
      'unexpected PAXG timelock executor'
    );
    assertTrue(
      timelock.hasRole(timelock.CANCELLER_ROLE(), PAXG_TIMELOCK_CONTROLLER),
      'unexpected PAXG timelock canceller'
    );
    assertTrue(
      timelock.hasRole(timelock.DEFAULT_ADMIN_ROLE(), PAXG_TIMELOCK),
      'timelock is not self-administered'
    );
  }

  function test_existingGoldReserveConfigUnchanged() public {
    ISpoke spoke = ISpoke(address(AaveV4EthereumSpokes.GOLD_SPOKE));
    IHub hub = IHub(address(AaveV4EthereumHubs.CORE_HUB));
    uint256 assetId = hub.getAssetId(address(AaveV4EthereumAssets.XAUt_UNDERLYING));
    uint256 reserveId = spoke.getReserveId(address(hub), assetId);
    ISpoke.Reserve memory reserve = spoke.getReserve(reserveId);
    ISpoke.DynamicReserveConfig memory before = spoke.getDynamicReserveConfig(
      reserveId,
      reserve.dynamicConfigKey
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    ISpoke.DynamicReserveConfig memory afterConfig = spoke.getDynamicReserveConfig(
      reserveId,
      reserve.dynamicConfigKey
    );
    assertEq(afterConfig.collateralFactor, before.collateralFactor, 'collateralFactor changed');
    assertEq(
      afterConfig.maxLiquidationBonus,
      before.maxLiquidationBonus,
      'maxLiquidationBonus changed'
    );
    assertEq(afterConfig.liquidationFee, before.liquidationFee, 'liquidationFee changed');
  }
}
