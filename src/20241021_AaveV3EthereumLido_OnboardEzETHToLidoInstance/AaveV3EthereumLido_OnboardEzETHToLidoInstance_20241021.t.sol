// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {Errors} from 'aave-v3-origin/contracts/protocol/libraries/helpers/Errors.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_OnboardEzETHToLidoInstance_20241021} from './AaveV3EthereumLido_OnboardEzETHToLidoInstance_20241021.sol';

/**
 * @dev Test for AaveV3EthereumLido_OnboardEzETHToLidoInstance_20241021
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241021_AaveV3EthereumLido_OnboardEzETHToLidoInstance/AaveV3EthereumLido_OnboardEzETHToLidoInstance_20241021.t.sol -vv
 */
contract AaveV3EthereumLido_OnboardEzETHToLidoInstance_20241021_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_OnboardEzETHToLidoInstance_20241021 internal proposal;
  address internal ezETH;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21019869);
    proposal = new AaveV3EthereumLido_OnboardEzETHToLidoInstance_20241021();
    ezETH = proposal.ezETH();

    deal(ezETH, GovernanceV3Ethereum.EXECUTOR_LVL_1, proposal.ezETH_SEED_AMOUNT());
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_OnboardEzETHToLidoInstance_20241021',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_collectorHasezETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3EthereumLido
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(ezETH);
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3EthereumLido.COLLECTOR)),
      proposal.ezETH_SEED_AMOUNT()
    );
  }

  function test_ezETH_USDS_emode() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = address(5);
    deal(ezETH, user, 1 ether);
    deal(AaveV3EthereumLidoAssets.USDS_UNDERLYING, user, 3000 ether);

    vm.startPrank(user);
    AaveV3EthereumLido.POOL.setUserEMode(2);

    IERC20(ezETH).approve(address(AaveV3EthereumLido.POOL), 1 ether);
    IERC20(AaveV3EthereumLidoAssets.USDS_UNDERLYING).approve(
      address(AaveV3EthereumLido.POOL),
      3000 ether
    );

    // USDS as collateral and ezETH as borrowable - reverts
    AaveV3EthereumLido.POOL.supply(AaveV3EthereumLidoAssets.USDS_UNDERLYING, 3000 ether, user, 0);
    vm.expectRevert(bytes(Errors.BORROWING_NOT_ENABLED));
    AaveV3EthereumLido.POOL.borrow(ezETH, 0.1 ether, 2, 0, user);

    // ezETH as collateral and USDS as borrowable
    AaveV3EthereumLido.POOL.supply(ezETH, 1 ether, user, 0);
    AaveV3EthereumLido.POOL.borrow(
      AaveV3EthereumLidoAssets.USDS_UNDERLYING,
      1500 ether,
      2,
      0,
      user
    );
  }

  function test_ezETH_wstETH_emode() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = address(8);
    deal(ezETH, user, 1 ether);
    deal(AaveV3EthereumLidoAssets.wstETH_UNDERLYING, user, 1 ether);

    vm.startPrank(user);
    AaveV3EthereumLido.POOL.setUserEMode(3);

    IERC20(ezETH).approve(address(AaveV3EthereumLido.POOL), 1 ether);
    IERC20(AaveV3EthereumLidoAssets.wstETH_UNDERLYING).approve(
      address(AaveV3EthereumLido.POOL),
      1 ether
    );

    // wstETH as collateral and ezETH as borrowable - reverts
    AaveV3EthereumLido.POOL.supply(AaveV3EthereumLidoAssets.wstETH_UNDERLYING, 1 ether, user, 0);
    vm.expectRevert(bytes(Errors.BORROWING_NOT_ENABLED));
    AaveV3EthereumLido.POOL.borrow(ezETH, 0.9 ether, 2, 0, user);

    // ezETH as collateral and wstETH as borrowable
    AaveV3EthereumLido.POOL.supply(ezETH, 1 ether, user, 0);
    AaveV3EthereumLido.POOL.borrow(
      AaveV3EthereumLidoAssets.wstETH_UNDERLYING,
      0.9 ether,
      2,
      0,
      user
    );
  }

  function test_wstETH_removalFromBorroableOnEmodeOne() public {
    address user = address(8);
    deal(user, 1 ether);
    deal(AaveV3EthereumLidoAssets.wstETH_UNDERLYING, user, 2 ether);

    vm.prank(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    // as caps have been reached
    AaveV3EthereumLido.POOL_CONFIGURATOR.setBorrowCap(
      AaveV3EthereumLidoAssets.wstETH_UNDERLYING,
      350_000
    );

    vm.startPrank(user);
    AaveV3EthereumLido.POOL.setUserEMode(1);

    IERC20(AaveV3EthereumLidoAssets.wstETH_UNDERLYING).approve(
      address(AaveV3EthereumLido.POOL),
      1 ether
    );
    AaveV3EthereumLido.POOL.supply(AaveV3EthereumLidoAssets.wstETH_UNDERLYING, 1 ether, user, 0);
    AaveV3EthereumLido.POOL.borrow(
      AaveV3EthereumLidoAssets.wstETH_UNDERLYING,
      0.92 ether,
      2,
      0,
      user
    );

    (, , , , , uint256 prevHealthFactor) = AaveV3EthereumLido.POOL.getUserAccountData(user);

    GovV3Helpers.executePayload(vm, address(proposal));

    (, , , , , uint256 currentHealthFactor) = AaveV3EthereumLido.POOL.getUserAccountData(user);
    assertEq(prevHealthFactor, currentHealthFactor);

    // wstETH cannot be borrowed in EModeId 1
    vm.expectRevert(bytes(Errors.NOT_BORROWABLE_IN_EMODE));
    AaveV3EthereumLido.POOL.borrow(
      AaveV3EthereumLidoAssets.wstETH_UNDERLYING,
      0.01 ether,
      2,
      0,
      user
    );
  }

  function test_ezETHAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aezETH, , ) = AaveV3EthereumLido.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      ezETH
    );
    assertEq(
      IEmissionManager(AaveV3EthereumLido.EMISSION_MANAGER).getEmissionAdmin(ezETH),
      proposal.ezETH_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3EthereumLido.EMISSION_MANAGER).getEmissionAdmin(aezETH),
      proposal.ezETH_LM_ADMIN()
    );
  }
}
