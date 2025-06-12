// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AccessControlUpgradeable} from 'openzeppelin-contracts-upgradeable/contracts/access/AccessControlUpgradeable.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {UmbrellaEthereum} from 'aave-address-book/UmbrellaEthereum.sol';

import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {IStataTokenV2} from 'aave-v3-origin/contracts/extensions/stata-token/interfaces/IStataTokenV2.sol';

import {IDeficitOffsetClinicSteward} from 'aave-umbrella/stewards/interfaces/IDeficitOffsetClinicSteward.sol';
import {IUmbrellaStakeToken} from 'aave-umbrella/stakeToken/interfaces/IUmbrellaStakeToken.sol';
import {IRewardsController} from 'aave-umbrella/rewards/interfaces/IRewardsController.sol';

import {AaveV3Ethereum_UmbrellaActivation_20250515} from './AaveV3Ethereum_UmbrellaActivation_20250515.sol';

/**
 * @dev Test for AaveV3Ethereum_UmbrellaActivation_20250515
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250515_AaveV3Ethereum_UmbrellaActivation/AaveV3Ethereum_UmbrellaActivation_20250515.t.sol -vv
 */
contract AaveV3Ethereum_UmbrellaActivation_20250515_Test is ProtocolV3TestBase {
  AaveV3Ethereum_UmbrellaActivation_20250515 internal proposal;

  address user = vm.addr(0xDEAD);
  uint256 snapshotState;
  uint256 snapshotStateAfterPayload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22581600);
    proposal = new AaveV3Ethereum_UmbrellaActivation_20250515();

    snapshotState = vm.snapshotState();
  }

  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_UmbrellaActivation_20250515',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_reserveDeficitsElimination() public {
    _reserveCheck(AaveV3EthereumAssets.USDC_UNDERLYING, 168401963, 1);
    _reserveCheck(AaveV3EthereumAssets.USDT_UNDERLYING, 197155140, 1);
    _reserveCheck(AaveV3EthereumAssets.WETH_UNDERLYING, 42022976677445873, 1);
    _reserveCheck(AaveV3EthereumAssets.GHO_UNDERLYING, 132211052243180416981, 0);
  }

  function test_deficitOffsetClinicSteward() public {
    _allowanceToDeficitClinicCheck(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      proposal.DEFICIT_OFFSET_USDC()
    );
    _allowanceToDeficitClinicCheck(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      proposal.DEFICIT_OFFSET_USDT()
    );
    _allowanceToDeficitClinicCheck(
      AaveV3EthereumAssets.WETH_UNDERLYING,
      proposal.DEFICIT_OFFSET_WETH()
    );
    _allowanceToDeficitClinicCheck(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      proposal.DEFICIT_OFFSET_GHO()
    );
  }

  function test_umbrellaTokenCreation() public {
    address[] memory stkTokens = UmbrellaEthereum.UMBRELLA.getStkTokens();
    assertEq(stkTokens.length, 0);

    executePayload(vm, address(proposal));

    address[] memory stkTokensAfter = UmbrellaEthereum.UMBRELLA.getStkTokens();
    assertEq(stkTokensAfter.length, 4);

    for (uint256 i; i < stkTokensAfter.length; ++i) {
      assertEq(IUmbrellaStakeToken(stkTokensAfter[i]).getCooldown(), proposal.DEFAULT_COOLDOWN());
      assertEq(
        IUmbrellaStakeToken(stkTokensAfter[i]).getUnstakeWindow(),
        proposal.DEFAULT_UNSTAKE_WINDOW()
      );
      assertGe(
        IUmbrellaStakeToken(stkTokensAfter[i]).latestAnswer(),
        1e8 // all stake tokens should worth more or equal to 1 usd, cause their underlying is wrapped
      );
    }

    assertEq(IUmbrellaStakeToken(stkTokensAfter[0]).asset(), AaveV3EthereumAssets.USDC_STATA_TOKEN);
    assertEq(IUmbrellaStakeToken(stkTokensAfter[1]).asset(), AaveV3EthereumAssets.USDT_STATA_TOKEN);
    assertEq(IUmbrellaStakeToken(stkTokensAfter[2]).asset(), AaveV3EthereumAssets.WETH_STATA_TOKEN);
    assertEq(IUmbrellaStakeToken(stkTokensAfter[3]).asset(), AaveV3EthereumAssets.GHO_UNDERLYING);

    assertEq(
      UmbrellaEthereum.UMBRELLA.getStakeTokenData(stkTokensAfter[0]).reserve,
      AaveV3EthereumAssets.USDC_UNDERLYING
    );
    assertEq(
      UmbrellaEthereum.UMBRELLA.getStakeTokenData(stkTokensAfter[0]).underlyingOracle,
      AaveV3EthereumAssets.USDC_STATA_TOKEN
    );

    assertEq(
      UmbrellaEthereum.UMBRELLA.getStakeTokenData(stkTokensAfter[1]).reserve,
      AaveV3EthereumAssets.USDT_UNDERLYING
    );
    assertEq(
      UmbrellaEthereum.UMBRELLA.getStakeTokenData(stkTokensAfter[1]).underlyingOracle,
      AaveV3EthereumAssets.USDT_STATA_TOKEN
    );

    assertEq(
      UmbrellaEthereum.UMBRELLA.getStakeTokenData(stkTokensAfter[2]).reserve,
      AaveV3EthereumAssets.WETH_UNDERLYING
    );
    assertEq(
      UmbrellaEthereum.UMBRELLA.getStakeTokenData(stkTokensAfter[2]).underlyingOracle,
      AaveV3EthereumAssets.WETH_STATA_TOKEN
    );

    assertEq(
      UmbrellaEthereum.UMBRELLA.getStakeTokenData(stkTokensAfter[3]).reserve,
      AaveV3EthereumAssets.GHO_UNDERLYING
    );
    assertEq(
      UmbrellaEthereum.UMBRELLA.getStakeTokenData(stkTokensAfter[3]).underlyingOracle,
      AaveV3EthereumAssets.GHO_ORACLE
    );

    assertEq(
      UmbrellaEthereum
        .UMBRELLA
        .getReserveSlashingConfig(AaveV3EthereumAssets.USDC_UNDERLYING, stkTokensAfter[0])
        .liquidationFee,
      0
    );

    assertEq(
      UmbrellaEthereum
        .UMBRELLA
        .getReserveSlashingConfig(AaveV3EthereumAssets.USDT_UNDERLYING, stkTokensAfter[1])
        .liquidationFee,
      0
    );

    assertEq(
      UmbrellaEthereum
        .UMBRELLA
        .getReserveSlashingConfig(AaveV3EthereumAssets.WETH_UNDERLYING, stkTokensAfter[2])
        .liquidationFee,
      0
    );

    assertEq(
      UmbrellaEthereum
        .UMBRELLA
        .getReserveSlashingConfig(AaveV3EthereumAssets.GHO_UNDERLYING, stkTokensAfter[3])
        .liquidationFee,
      0
    );
  }

  function test_deficitOffset() public {
    _deficitOffsetCheck(AaveV3EthereumAssets.USDC_UNDERLYING, proposal.DEFICIT_OFFSET_USDC(), 1);
    _deficitOffsetCheck(AaveV3EthereumAssets.USDT_UNDERLYING, proposal.DEFICIT_OFFSET_USDT(), 1);
    _deficitOffsetCheck(AaveV3EthereumAssets.WETH_UNDERLYING, proposal.DEFICIT_OFFSET_WETH(), 1);
    _deficitOffsetCheck(AaveV3EthereumAssets.GHO_UNDERLYING, proposal.DEFICIT_OFFSET_GHO(), 0);
  }

  function test_rewardsAllowance() public {
    _rewardsAllowanceCheck(
      AaveV3EthereumAssets.USDC_A_TOKEN,
      proposal.USDC_MAX_EMISSION_PER_SECOND() * 180 days
    );
    _rewardsAllowanceCheck(
      AaveV3EthereumAssets.USDT_A_TOKEN,
      proposal.USDT_MAX_EMISSION_PER_SECOND() * 180 days
    );
    _rewardsAllowanceCheck(
      AaveV3EthereumAssets.WETH_A_TOKEN,
      proposal.WETH_MAX_EMISSION_PER_SECOND() * 180 days
    );
    _rewardsAllowanceCheck(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      proposal.GHO_MAX_EMISSION_PER_SECOND() * 180 days
    );
  }

  function test_checkRewards() public {
    executePayload(vm, address(proposal));

    address[] memory stkTokens = UmbrellaEthereum.UMBRELLA.getStkTokens();

    _rewardsDistributionCheck(
      stkTokens[0],
      AaveV3EthereumAssets.USDC_STATA_TOKEN,
      AaveV3EthereumAssets.USDC_A_TOKEN,
      1_000 * 1e6
    );
    _rewardsDistributionCheck(
      stkTokens[1],
      AaveV3EthereumAssets.USDT_STATA_TOKEN,
      AaveV3EthereumAssets.USDT_A_TOKEN,
      1_000 * 1e6
    );
    _rewardsDistributionCheck(
      stkTokens[2],
      AaveV3EthereumAssets.WETH_STATA_TOKEN,
      AaveV3EthereumAssets.WETH_A_TOKEN,
      1_000 * 1e18
    );
    _rewardsDistributionCheck(
      stkTokens[3],
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      1_000 * 1e18
    );
  }

  function test_umbrellaRoles() public {
    address umbrella = AaveV3Ethereum.POOL_ADDRESSES_PROVIDER.getAddress(proposal.UMBRELLA());
    assert(umbrella == address(0));

    bool hasRolePermissionedPayloadsController = AccessControlUpgradeable(
      UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER
    ).hasRole(
        proposal.REWARDS_ADMIN_ROLE(),
        UmbrellaEthereum.PERMISSIONED_PAYLOADS_CONTROLLER_EXECUTOR
      );

    assert(!hasRolePermissionedPayloadsController);

    bool hasRoleCoverageManager = AccessControlUpgradeable(address(UmbrellaEthereum.UMBRELLA))
      .hasRole(proposal.COVERAGE_MANAGER_ROLE(), UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD);

    assert(!hasRoleCoverageManager);

    executePayload(vm, address(proposal));

    umbrella = AaveV3Ethereum.POOL_ADDRESSES_PROVIDER.getAddress(proposal.UMBRELLA());
    assert(umbrella == address(UmbrellaEthereum.UMBRELLA));

    hasRolePermissionedPayloadsController = AccessControlUpgradeable(
      UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER
    ).hasRole(
        proposal.REWARDS_ADMIN_ROLE(),
        UmbrellaEthereum.PERMISSIONED_PAYLOADS_CONTROLLER_EXECUTOR
      );

    assert(hasRolePermissionedPayloadsController);

    hasRoleCoverageManager = AccessControlUpgradeable(address(UmbrellaEthereum.UMBRELLA)).hasRole(
      proposal.COVERAGE_MANAGER_ROLE(),
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD
    );

    assert(hasRoleCoverageManager);
  }

  function test_refundForAudits() public {
    uint256 amount = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      proposal.BGD_LABS_MULTISIG()
    );

    executePayload(vm, address(proposal));

    uint256 amountAfter = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      proposal.BGD_LABS_MULTISIG()
    );

    assertEq(amountAfter, amount + proposal.TOTAL_COST_OF_AUDITS());
  }

  function _reserveCheck(
    address reserve,
    uint256 reserveDeficit,
    uint256 newMaxReserveDeficit
  ) internal {
    uint256 currentReserveDeficit = AaveV3Ethereum.POOL.getReserveDeficit(reserve);
    assertGe(currentReserveDeficit, reserveDeficit);

    executePayload(vm, address(proposal));

    uint256 newReserveDeficit = AaveV3Ethereum.POOL.getReserveDeficit(reserve);
    assertLe(newReserveDeficit, newMaxReserveDeficit);

    vm.revertToState(snapshotState);
  }

  function _allowanceToDeficitClinicCheck(address reserve, uint256 allowanceAfter) internal {
    uint256 allowanceBefore = IDeficitOffsetClinicSteward(
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD
    ).getRemainingAllowance(reserve);

    assertEq(allowanceBefore, 0);
    executePayload(vm, address(proposal));

    uint256 remainingAllowanceAfter = IDeficitOffsetClinicSteward(
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD
    ).getRemainingAllowance(reserve);

    assertEq(remainingAllowanceAfter, allowanceAfter);

    vm.revertToState(snapshotState);
  }

  function _deficitOffsetCheck(
    address reserve,
    uint256 deficitOffsetIncrease,
    uint256 precisionLoss
  ) internal {
    uint256 deficitOffset = UmbrellaEthereum.UMBRELLA.getDeficitOffset(reserve);
    assertEq(deficitOffset, 0);

    executePayload(vm, address(proposal));

    uint256 deficitOffsetAfter = UmbrellaEthereum.UMBRELLA.getDeficitOffset(reserve);
    assertLe(deficitOffsetAfter - deficitOffsetIncrease, precisionLoss); // precisionLoss could occur during aToken transfers

    (bool isSlashable, uint256 newDeficit) = UmbrellaEthereum.UMBRELLA.isReserveSlashable(reserve);

    assert(!isSlashable);
    assertEq(newDeficit, 0);

    vm.revertToState(snapshotState);
  }

  function _rewardsAllowanceCheck(address reward, uint256 allowanceAfterExecution) internal {
    uint256 allowanceBefore = IERC20(reward).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER
    );
    assertEq(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(reward).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER
    );
    assertEq(allowanceAfter, allowanceAfterExecution);

    vm.revertToState(snapshotState);
  }

  function _rewardsDistributionCheck(
    address asset,
    address underlyingAsset,
    address reward,
    uint256 dealAmount
  ) internal {
    deal(underlyingAsset, user, dealAmount);

    vm.startPrank(user);

    IERC20(underlyingAsset).approve(asset, dealAmount);
    IUmbrellaStakeToken(asset).deposit(dealAmount, user);

    assertEq(
      IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).calculateRewardIndex(
        asset,
        reward
      ),
      0
    );
    assertEq(
      IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).calculateCurrentUserReward(
        asset,
        reward,
        user
      ),
      0
    );

    skip(1 days);

    assertGt(
      IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).calculateRewardIndex(
        asset,
        reward
      ),
      0
    );
    assertGt(
      IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).calculateCurrentUserReward(
        asset,
        reward,
        user
      ),
      0
    );

    assertEq(IERC20(reward).balanceOf(user), 0);

    IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).claimAllRewards(asset, user);
    assertGt(IERC20(reward).balanceOf(user), 0);

    vm.stopPrank();
  }
}
