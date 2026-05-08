// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {ERC4626} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/ERC4626.sol';
import {AccessControl} from 'openzeppelin-contracts/contracts/access/AccessControl.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {IsGho} from '../interfaces/IsGho.sol';
import {IsGhoSteward} from '../interfaces/IsGhoSteward.sol';
import {AaveV3Ethereum_SGhoLaunch_20260427} from './AaveV3Ethereum_SGhoLaunch_20260427.sol';

/**
 * @dev Test for AaveV3Ethereum_SGhoLaunch_20260427
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260427_AaveV3Ethereum_SGhoLaunch/AaveV3Ethereum_SGhoLaunch_20260427.t.sol -vv
 */
contract AaveV3Ethereum_SGhoLaunch_20260427_Test is ProtocolV3TestBase {
  AaveV3Ethereum_SGhoLaunch_20260427 internal proposal;

  IsGho private sgho;
  IsGhoSteward private sghoSteward;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25029360);
    proposal = new AaveV3Ethereum_SGhoLaunch_20260427();

    sgho = IsGho(proposal.SGHO());
    sghoSteward = IsGhoSteward(proposal.SGHO_STEWARD());
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_SGhoLaunch_20260427', AaveV3Ethereum.POOL, address(proposal));
  }

  function test_initialization() public {
    assertEq(sgho.targetRate(), 0);
    assertEq(sgho.supplyCap(), 0);
    assertEq(sgho.GHO(), GhoEthereum.GHO_TOKEN);
    assertEq(ERC4626(proposal.SGHO()).asset(), GhoEthereum.GHO_TOKEN);

    assertEq(sghoSteward.sGHO(), proposal.SGHO());

    IsGhoSteward.RateConfig memory rateConfig = sghoSteward.getRateConfig();

    assertEq(rateConfig.amplification, 0);
    assertEq(rateConfig.floatRate, 0);
    assertEq(rateConfig.fixedRate, 0);

    executePayload(vm, address(proposal));

    assertEq(sgho.targetRate(), proposal.FIXED_RATE());
    assertEq(sgho.supplyCap(), proposal.SUPPLY_CAP());

    rateConfig = sghoSteward.getRateConfig();

    assertEq(rateConfig.amplification, 0);
    assertEq(rateConfig.floatRate, 0);
    assertEq(rateConfig.fixedRate, proposal.FIXED_RATE());
  }

  function test_supplyCapIsReached() public {
    ERC4626 _sgho = ERC4626(proposal.SGHO());

    vm.expectRevert(
      abi.encodeWithSelector(ERC4626.ERC4626ExceededMaxDeposit.selector, address(this), 1, 0)
    );
    _sgho.deposit(1, address(this));

    executePayload(vm, address(proposal));

    deal(GhoEthereum.GHO_TOKEN, address(this), proposal.SUPPLY_CAP());
    IERC20(GhoEthereum.GHO_TOKEN).approve(proposal.SGHO(), proposal.SUPPLY_CAP());

    _sgho.deposit(proposal.SUPPLY_CAP(), address(this));

    vm.expectRevert(
      abi.encodeWithSelector(ERC4626.ERC4626ExceededMaxDeposit.selector, address(this), 1, 0)
    );
    _sgho.deposit(1, address(this));
  }

  function test_sghoApr() public {
    executePayload(vm, address(proposal));

    ERC4626 _sgho = ERC4626(proposal.SGHO());
    uint256 depositAmount = 1_000_000 ether;

    deal(GhoEthereum.GHO_TOKEN, address(this), depositAmount);

    // Fund sGho with extra GHO for rewards
    deal(GhoEthereum.GHO_TOKEN, proposal.SGHO(), depositAmount * 2);
    IERC20(GhoEthereum.GHO_TOKEN).approve(proposal.SGHO(), depositAmount);

    uint256 shares = _sgho.deposit(depositAmount, address(this));

    vm.warp(block.timestamp + 365 days);

    uint256 expectedAssets = 1_042_500 ether;

    uint256 assets = _sgho.redeem(shares, address(this), address(this));

    assertApproxEqAbs(assets, expectedAssets, 0.0001 ether);
  }

  function test_access() public {
    assertFalse(
      AccessControl(proposal.SGHO()).hasRole(
        sgho.PAUSE_GUARDIAN_ROLE(),
        MiscEthereum.PROTOCOL_GUARDIAN
      )
    );

    vm.prank(MiscEthereum.PROTOCOL_GUARDIAN);
    vm.expectRevert();
    sgho.pause();

    assertFalse(
      AccessControl(proposal.SGHO()).hasRole(
        sgho.TOKEN_RESCUER_ROLE(),
        GovernanceV3Ethereum.EXECUTOR_LVL_1
      )
    );

    assertFalse(
      AccessControl(proposal.SGHO()).hasRole(sgho.YIELD_MANAGER_ROLE(), proposal.SGHO_STEWARD())
    );

    assertFalse(
      AccessControl(proposal.SGHO_STEWARD()).hasRole(
        sghoSteward.FIXED_RATE_MANAGER_ROLE(),
        GovernanceV3Ethereum.EXECUTOR_LVL_1
      )
    );
    assertFalse(
      AccessControl(proposal.SGHO_STEWARD()).hasRole(
        sghoSteward.SUPPLY_CAP_MANAGER_ROLE(),
        GovernanceV3Ethereum.EXECUTOR_LVL_1
      )
    );

    executePayload(vm, address(proposal));

    assertTrue(
      AccessControl(proposal.SGHO()).hasRole(
        sgho.PAUSE_GUARDIAN_ROLE(),
        MiscEthereum.PROTOCOL_GUARDIAN
      )
    );

    vm.prank(MiscEthereum.PROTOCOL_GUARDIAN);
    sgho.pause();

    assertTrue(
      AccessControl(proposal.SGHO()).hasRole(
        sgho.TOKEN_RESCUER_ROLE(),
        GovernanceV3Ethereum.EXECUTOR_LVL_1
      )
    );

    assertTrue(
      AccessControl(proposal.SGHO()).hasRole(sgho.YIELD_MANAGER_ROLE(), proposal.SGHO_STEWARD())
    );

    assertTrue(
      AccessControl(proposal.SGHO_STEWARD()).hasRole(
        sghoSteward.FIXED_RATE_MANAGER_ROLE(),
        GovernanceV3Ethereum.EXECUTOR_LVL_1
      )
    );
    assertTrue(
      AccessControl(proposal.SGHO_STEWARD()).hasRole(
        sghoSteward.SUPPLY_CAP_MANAGER_ROLE(),
        GovernanceV3Ethereum.EXECUTOR_LVL_1
      )
    );
  }

  function test_governanceIsDefaultAdmin() public {
    // governance already has this role from deployment
    assertTrue(
      AccessControl(proposal.SGHO_STEWARD()).hasRole(
        AccessControl(proposal.SGHO_STEWARD()).DEFAULT_ADMIN_ROLE(),
        GovernanceV3Ethereum.EXECUTOR_LVL_1
      )
    );

    executePayload(vm, address(proposal));

    assertTrue(
      AccessControl(proposal.SGHO_STEWARD()).hasRole(
        AccessControl(proposal.SGHO_STEWARD()).DEFAULT_ADMIN_ROLE(),
        GovernanceV3Ethereum.EXECUTOR_LVL_1
      )
    );
  }

  function test_rolesSGhoSteward() public {
    // RiskCouncil already has these roles from deployment
    assertTrue(
      AccessControl(proposal.SGHO_STEWARD()).hasRole(
        sghoSteward.AMPLIFICATION_MANAGER_ROLE(),
        GhoEthereum.RISK_COUNCIL
      )
    );
    assertTrue(
      AccessControl(proposal.SGHO_STEWARD()).hasRole(
        sghoSteward.FLOAT_RATE_MANAGER_ROLE(),
        GhoEthereum.RISK_COUNCIL
      )
    );
    assertTrue(
      AccessControl(proposal.SGHO_STEWARD()).hasRole(
        sghoSteward.FIXED_RATE_MANAGER_ROLE(),
        GhoEthereum.RISK_COUNCIL
      )
    );
    assertTrue(
      AccessControl(proposal.SGHO_STEWARD()).hasRole(
        sghoSteward.SUPPLY_CAP_MANAGER_ROLE(),
        GhoEthereum.RISK_COUNCIL
      )
    );

    executePayload(vm, address(proposal));

    assertTrue(
      AccessControl(proposal.SGHO_STEWARD()).hasRole(
        sghoSteward.AMPLIFICATION_MANAGER_ROLE(),
        GhoEthereum.RISK_COUNCIL
      )
    );
    assertTrue(
      AccessControl(proposal.SGHO_STEWARD()).hasRole(
        sghoSteward.FLOAT_RATE_MANAGER_ROLE(),
        GhoEthereum.RISK_COUNCIL
      )
    );
    assertTrue(
      AccessControl(proposal.SGHO_STEWARD()).hasRole(
        sghoSteward.FIXED_RATE_MANAGER_ROLE(),
        GhoEthereum.RISK_COUNCIL
      )
    );
    assertTrue(
      AccessControl(proposal.SGHO_STEWARD()).hasRole(
        sghoSteward.SUPPLY_CAP_MANAGER_ROLE(),
        GhoEthereum.RISK_COUNCIL
      )
    );
  }

  function test_allowance() public {
    assertEq(
      IERC20(GhoEthereum.GHO_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        MiscEthereum.AFC_SAFE
      ),
      0
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(GhoEthereum.GHO_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        MiscEthereum.AFC_SAFE
      ),
      proposal.GHO_ALLOWANCE()
    );

    deal(GhoEthereum.GHO_TOKEN, address(AaveV3Ethereum.COLLECTOR), proposal.GHO_ALLOWANCE());

    uint256 balanceBefore = IERC20(GhoEthereum.GHO_TOKEN).balanceOf(proposal.SGHO());
    uint256 transferAmount = proposal.GHO_ALLOWANCE();

    vm.startPrank(MiscEthereum.AFC_SAFE);
    // Trying to move more than allowance reverts
    vm.expectRevert();
    IERC20(GhoEthereum.GHO_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      address(sgho),
      transferAmount + 1
    );

    // Transfer allowance is ok!
    IERC20(GhoEthereum.GHO_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      address(sgho),
      transferAmount
    );
    vm.stopPrank();

    assertEq(
      IERC20(GhoEthereum.GHO_TOKEN).balanceOf(proposal.SGHO()),
      balanceBefore + transferAmount
    );
  }
}
