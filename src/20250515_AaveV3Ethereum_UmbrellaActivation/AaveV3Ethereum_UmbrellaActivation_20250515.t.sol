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

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22517759);
    proposal = new AaveV3Ethereum_UmbrellaActivation_20250515();
  }

  function test_reserveDeficitsElimination() public {
    uint256 currentReserveDeficitUSDC = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.USDC_UNDERLYING
    );
    assertGe(currentReserveDeficitUSDC, 168401963);

    uint256 currentReserveDeficitUSDT = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.USDT_UNDERLYING
    );
    assertGe(currentReserveDeficitUSDT, 197155140);

    uint256 currentReserveDeficitWETH = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.WETH_UNDERLYING
    );
    assertGe(currentReserveDeficitWETH, 42022976677445873);

    uint256 currentReserveDeficitGHO = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.GHO_UNDERLYING
    );
    assertGe(currentReserveDeficitGHO, 132211052243180416981);

    executePayload(vm, address(proposal));

    uint256 newReserveDeficitUSDC = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.USDC_UNDERLYING
    );
    assertLe(newReserveDeficitUSDC, 1); // aToken transfer precision loss

    uint256 newReserveDeficitUSDT = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.USDT_UNDERLYING
    );
    assertLe(newReserveDeficitUSDT, 1); // aToken transfer precision loss

    uint256 newReserveDeficitWETH = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.WETH_UNDERLYING
    );
    assertLe(newReserveDeficitWETH, 1); // aToken transfer precision loss

    uint256 newReserveDeficitGHO = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.GHO_UNDERLYING
    );
    assertLe(newReserveDeficitGHO, 0);
  }

  function test_deficitOffsetClinicSteward() public {
    uint256 allowanceUsdcBefore = IDeficitOffsetClinicSteward(
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD
    ).getRemainingAllowance(AaveV3EthereumAssets.USDC_UNDERLYING);
    uint256 allowanceUsdtBefore = IDeficitOffsetClinicSteward(
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD
    ).getRemainingAllowance(AaveV3EthereumAssets.USDT_UNDERLYING);
    uint256 allowanceWethBefore = IDeficitOffsetClinicSteward(
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD
    ).getRemainingAllowance(AaveV3EthereumAssets.WETH_UNDERLYING);
    uint256 allowanceGhoBefore = IDeficitOffsetClinicSteward(
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD
    ).getRemainingAllowance(AaveV3EthereumAssets.GHO_UNDERLYING);

    assertEq(allowanceUsdcBefore, 0);
    assertEq(allowanceUsdtBefore, 0);
    assertEq(allowanceWethBefore, 0);
    assertEq(allowanceGhoBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceUsdcAfter = IDeficitOffsetClinicSteward(
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD
    ).getRemainingAllowance(AaveV3EthereumAssets.USDC_UNDERLYING);
    uint256 allowanceUsdtAfter = IDeficitOffsetClinicSteward(
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD
    ).getRemainingAllowance(AaveV3EthereumAssets.USDT_UNDERLYING);
    uint256 allowanceWethAfter = IDeficitOffsetClinicSteward(
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD
    ).getRemainingAllowance(AaveV3EthereumAssets.WETH_UNDERLYING);
    uint256 allowanceGhoAfter = IDeficitOffsetClinicSteward(
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD
    ).getRemainingAllowance(AaveV3EthereumAssets.GHO_UNDERLYING);

    assertEq(allowanceUsdcAfter, proposal.DEFICIT_OFFSET_USDC());
    assertEq(allowanceUsdtAfter, proposal.DEFICIT_OFFSET_USDT());
    assertEq(allowanceWethAfter, proposal.DEFICIT_OFFSET_WETH());
    assertEq(allowanceGhoAfter, proposal.DEFICIT_OFFSET_GHO());
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
    uint256 deficitOffsetUsdc = UmbrellaEthereum.UMBRELLA.getDeficitOffset(
      AaveV3EthereumAssets.USDC_UNDERLYING
    );
    assertEq(deficitOffsetUsdc, 0);

    uint256 deficitOffsetUsdt = UmbrellaEthereum.UMBRELLA.getDeficitOffset(
      AaveV3EthereumAssets.USDT_UNDERLYING
    );
    assertEq(deficitOffsetUsdt, 0);

    uint256 deficitOffsetWeth = UmbrellaEthereum.UMBRELLA.getDeficitOffset(
      AaveV3EthereumAssets.WETH_UNDERLYING
    );
    assertEq(deficitOffsetWeth, 0);

    uint256 deficitOffsetGho = UmbrellaEthereum.UMBRELLA.getDeficitOffset(
      AaveV3EthereumAssets.GHO_UNDERLYING
    );
    assertEq(deficitOffsetGho, 0);

    executePayload(vm, address(proposal));

    uint256 deficitOffsetUsdcAfter = UmbrellaEthereum.UMBRELLA.getDeficitOffset(
      AaveV3EthereumAssets.USDC_UNDERLYING
    );
    assertLe(deficitOffsetUsdcAfter - proposal.DEFICIT_OFFSET_USDC(), 1); // 1 wei cause of possible aToken transfer error

    (bool isSlashable, ) = UmbrellaEthereum.UMBRELLA.isReserveSlashable(
      AaveV3EthereumAssets.USDC_UNDERLYING
    );
    assert(!isSlashable);

    uint256 deficitOffsetUsdtAfter = UmbrellaEthereum.UMBRELLA.getDeficitOffset(
      AaveV3EthereumAssets.USDT_UNDERLYING
    );
    assertLe(deficitOffsetUsdtAfter - proposal.DEFICIT_OFFSET_USDT(), 1); // 1 wei cause of possible aToken transfer error

    (isSlashable, ) = UmbrellaEthereum.UMBRELLA.isReserveSlashable(
      AaveV3EthereumAssets.USDT_UNDERLYING
    );
    assert(!isSlashable);

    uint256 deficitOffsetWethAfter = UmbrellaEthereum.UMBRELLA.getDeficitOffset(
      AaveV3EthereumAssets.WETH_UNDERLYING
    );
    assertLe(deficitOffsetWethAfter - proposal.DEFICIT_OFFSET_WETH(), 1); // 1 wei cause of possible aToken transfer error

    (isSlashable, ) = UmbrellaEthereum.UMBRELLA.isReserveSlashable(
      AaveV3EthereumAssets.WETH_UNDERLYING
    );
    assert(!isSlashable);

    uint256 deficitOffsetGhoAfter = UmbrellaEthereum.UMBRELLA.getDeficitOffset(
      AaveV3EthereumAssets.GHO_UNDERLYING
    );
    assertLe(deficitOffsetGhoAfter - proposal.DEFICIT_OFFSET_GHO(), 0);

    (isSlashable, ) = UmbrellaEthereum.UMBRELLA.isReserveSlashable(
      AaveV3EthereumAssets.GHO_UNDERLYING
    );
    assert(!isSlashable);
  }

  function test_rewardsAllowance() public {
    uint256 aUsdcAllowance = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER
    );
    assertEq(aUsdcAllowance, 0);

    uint256 aUsdtAllowance = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER
    );
    assertEq(aUsdtAllowance, 0);

    uint256 aWethAllowance = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER
    );
    assertEq(aWethAllowance, 0);

    uint256 ghoAllowance = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER
    );
    assertEq(ghoAllowance, 0);

    executePayload(vm, address(proposal));

    uint256 aUsdcAllowanceAfter = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER
    );
    assertEq(aUsdcAllowanceAfter, proposal.USDC_MAX_EMISSION_PER_SECOND() * 180 days);

    uint256 aUsdtAllowanceAfter = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER
    );
    assertEq(aUsdtAllowanceAfter, proposal.USDT_MAX_EMISSION_PER_SECOND() * 180 days);

    uint256 aWethAllowanceAfter = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER
    );
    assertEq(aWethAllowanceAfter, proposal.WETH_MAX_EMISSION_PER_SECOND() * 180 days);

    uint256 ghoAllowanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER
    );
    assertEq(ghoAllowanceAfter, proposal.GHO_MAX_EMISSION_PER_SECOND() * 180 days);
  }

  function test_checkRewards() public {
    executePayload(vm, address(proposal));

    vm.startPrank(user);

    deal(AaveV3EthereumAssets.USDC_STATA_TOKEN, user, 1_000 * 1e6);
    deal(AaveV3EthereumAssets.USDT_STATA_TOKEN, user, 1_000 * 1e6);
    deal(AaveV3EthereumAssets.WETH_STATA_TOKEN, user, 1_000 * 1e18);
    deal(AaveV3EthereumAssets.GHO_UNDERLYING, user, 1_000 * 1e18);

    address[] memory stkTokens = UmbrellaEthereum.UMBRELLA.getStkTokens();

    IERC20(AaveV3EthereumAssets.USDC_STATA_TOKEN).approve(stkTokens[0], 1_000 * 1e6);
    IERC20(AaveV3EthereumAssets.USDT_STATA_TOKEN).approve(stkTokens[1], 1_000 * 1e6);
    IERC20(AaveV3EthereumAssets.WETH_STATA_TOKEN).approve(stkTokens[2], 1_000 * 1e18);
    IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).approve(stkTokens[3], 1_000 * 1e18);

    IUmbrellaStakeToken(stkTokens[0]).deposit(1_000 * 1e6, user);
    IUmbrellaStakeToken(stkTokens[1]).deposit(1_000 * 1e6, user);
    IUmbrellaStakeToken(stkTokens[2]).deposit(1_000 * 1e18, user);
    IUmbrellaStakeToken(stkTokens[3]).deposit(1_000 * 1e18, user);

    assertEq(
      IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).calculateRewardIndex(
        stkTokens[0],
        AaveV3EthereumAssets.USDC_A_TOKEN
      ),
      0
    );
    assertEq(
      IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).calculateCurrentUserReward(
        stkTokens[0],
        AaveV3EthereumAssets.USDC_A_TOKEN,
        user
      ),
      0
    );

    assertEq(
      IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).calculateRewardIndex(
        stkTokens[1],
        AaveV3EthereumAssets.USDT_A_TOKEN
      ),
      0
    );
    assertEq(
      IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).calculateCurrentUserReward(
        stkTokens[1],
        AaveV3EthereumAssets.USDT_A_TOKEN,
        user
      ),
      0
    );

    assertEq(
      IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).calculateRewardIndex(
        stkTokens[2],
        AaveV3EthereumAssets.WETH_A_TOKEN
      ),
      0
    );
    assertEq(
      IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).calculateCurrentUserReward(
        stkTokens[2],
        AaveV3EthereumAssets.WETH_A_TOKEN,
        user
      ),
      0
    );

    assertEq(
      IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).calculateRewardIndex(
        stkTokens[3],
        AaveV3EthereumAssets.GHO_UNDERLYING
      ),
      0
    );
    assertEq(
      IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).calculateCurrentUserReward(
        stkTokens[3],
        AaveV3EthereumAssets.GHO_UNDERLYING,
        user
      ),
      0
    );

    skip(1 days);

    assertGt(
      IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).calculateRewardIndex(
        stkTokens[0],
        AaveV3EthereumAssets.USDC_A_TOKEN
      ),
      0
    );
    assertGt(
      IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).calculateCurrentUserReward(
        stkTokens[0],
        AaveV3EthereumAssets.USDC_A_TOKEN,
        user
      ),
      0
    );

    assertGt(
      IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).calculateRewardIndex(
        stkTokens[1],
        AaveV3EthereumAssets.USDT_A_TOKEN
      ),
      0
    );
    assertGt(
      IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).calculateCurrentUserReward(
        stkTokens[1],
        AaveV3EthereumAssets.USDT_A_TOKEN,
        user
      ),
      0
    );

    assertGt(
      IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).calculateRewardIndex(
        stkTokens[2],
        AaveV3EthereumAssets.WETH_A_TOKEN
      ),
      0
    );
    assertGt(
      IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).calculateCurrentUserReward(
        stkTokens[2],
        AaveV3EthereumAssets.WETH_A_TOKEN,
        user
      ),
      0
    );

    assertGt(
      IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).calculateRewardIndex(
        stkTokens[3],
        AaveV3EthereumAssets.GHO_UNDERLYING
      ),
      0
    );
    assertGt(
      IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).calculateCurrentUserReward(
        stkTokens[3],
        AaveV3EthereumAssets.GHO_UNDERLYING,
        user
      ),
      0
    );

    assertEq(IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(user), 0);
    assertEq(IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(user), 0);
    assertEq(IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(user), 0);
    assertEq(IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(user), 0);

    IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).claimAllRewards(
      stkTokens[0],
      user
    );
    assertGt(IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(user), 0);

    IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).claimAllRewards(
      stkTokens[1],
      user
    );
    assertGt(IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(user), 0);

    IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).claimAllRewards(
      stkTokens[2],
      user
    );
    assertGt(IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(user), 0);

    IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).claimAllRewards(
      stkTokens[3],
      user
    );
    assertGt(IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(user), 0);
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
}
