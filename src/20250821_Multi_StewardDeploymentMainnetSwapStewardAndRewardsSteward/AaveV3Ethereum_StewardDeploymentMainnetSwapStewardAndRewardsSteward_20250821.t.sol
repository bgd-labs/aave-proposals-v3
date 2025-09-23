// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {EmissionManager} from 'aave-v3-origin/contracts/rewards/EmissionManager.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {IRewardsController} from 'aave-v3-origin/contracts/rewards/interfaces/IRewardsController.sol';

import {AaveV3Ethereum_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821} from './AaveV3Ethereum_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.sol';

interface IRewardsSteward {
  function claimAllRewards(address[] calldata assets) external;
}

interface IMainnetSwapSteward {
  function swapApprovedToken(address from, address to) external view returns (bool);
  function priceOracle(address fromToken) external view returns (address);
  function tokenBudget(address token) external view returns (uint256);
}

/**
 * @dev Test for AaveV3Ethereum_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250821_Multi_StewardDeploymentMainnetSwapStewardAndRewardsSteward/AaveV3Ethereum_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.t.sol -vv
 */
contract AaveV3Ethereum_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821 internal proposal;
  address[] assets = new address[](1);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23341175);
    proposal = new AaveV3Ethereum_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821();
    assets[0] = AaveV3EthereumAssets.WETH_A_TOKEN;
  }

  function test_claimerIsSetCorrectly() public {
    assertEq(
      IRewardsController(AaveV3Ethereum.DEFAULT_INCENTIVES_CONTROLLER).getClaimer(
        address(AaveV3Ethereum.COLLECTOR)
      ),
      address(0)
    );

    executePayload(vm, address(proposal));

    assertEq(
      IRewardsController(AaveV3Ethereum.DEFAULT_INCENTIVES_CONTROLLER).getClaimer(
        address(AaveV3Ethereum.COLLECTOR)
      ),
      proposal.REWARDS_STEWARD()
    );
  }

  function test_canClaimRewards() public {
    address steward = proposal.REWARDS_STEWARD();
    vm.expectRevert('CLAIMER_UNAUTHORIZED');
    IRewardsSteward(steward).claimAllRewards(assets);

    executePayload(vm, address(proposal));

    IRewardsSteward(steward).claimAllRewards(assets);
  }

  function test_accessGranted() public {
    assertFalse(
      IAccessControl(address(AaveV3Ethereum.COLLECTOR)).hasRole(
        'FUNDS_ADMIN',
        proposal.SWAP_STEWARD()
      )
    );

    executePayload(vm, address(proposal));

    assertTrue(
      IAccessControl(address(AaveV3Ethereum.COLLECTOR)).hasRole(
        'FUNDS_ADMIN',
        proposal.SWAP_STEWARD()
      )
    );
  }

  function test_swap_budgets() public {
    IMainnetSwapSteward steward = IMainnetSwapSteward(proposal.SWAP_STEWARD());

    assertEq(steward.tokenBudget(AaveV3EthereumAssets.USDC_UNDERLYING), 0);
    assertEq(steward.tokenBudget(AaveV3EthereumAssets.USDT_UNDERLYING), 0);
    assertEq(steward.tokenBudget(AaveV3EthereumAssets.USDe_UNDERLYING), 0);
    assertEq(steward.tokenBudget(AaveV3EthereumAssets.USDS_UNDERLYING), 0);
    assertEq(steward.tokenBudget(AaveV3EthereumAssets.DAI_UNDERLYING), 0);
    assertEq(steward.tokenBudget(AaveV3EthereumAssets.RLUSD_UNDERLYING), 0);
    assertEq(steward.tokenBudget(AaveV3EthereumAssets.LUSD_UNDERLYING), 0);
    assertEq(steward.tokenBudget(AaveV3EthereumAssets.FRAX_UNDERLYING), 0);
    assertEq(steward.tokenBudget(AaveV3EthereumAssets.PYUSD_UNDERLYING), 0);
    assertEq(steward.tokenBudget(AaveV3EthereumAssets.UNI_UNDERLYING), 0);
    assertEq(steward.tokenBudget(AaveV3EthereumAssets.MKR_UNDERLYING), 0);
    assertEq(steward.tokenBudget(AaveV3EthereumAssets.ONE_INCH_UNDERLYING), 0);
    assertEq(steward.tokenBudget(AaveV3EthereumAssets.ENS_UNDERLYING), 0);
    assertEq(steward.tokenBudget(AaveV3EthereumAssets.SNX_UNDERLYING), 0);

    executePayload(vm, address(proposal));

    assertEq(
      steward.tokenBudget(AaveV3EthereumAssets.USDC_UNDERLYING),
      proposal.USD_STABLE_BUDGET() * 10 ** AaveV3EthereumAssets.USDC_DECIMALS
    );
    assertEq(
      steward.tokenBudget(AaveV3EthereumAssets.USDT_UNDERLYING),
      proposal.USD_STABLE_BUDGET() * 10 ** AaveV3EthereumAssets.USDT_DECIMALS
    );
    assertEq(
      steward.tokenBudget(AaveV3EthereumAssets.USDe_UNDERLYING),
      proposal.USD_STABLE_BUDGET() * 10 ** AaveV3EthereumAssets.USDe_DECIMALS
    );
    assertEq(
      steward.tokenBudget(AaveV3EthereumAssets.USDS_UNDERLYING),
      proposal.USD_STABLE_BUDGET() * 10 ** AaveV3EthereumAssets.USDS_DECIMALS
    );
    assertEq(steward.tokenBudget(AaveV3EthereumAssets.DAI_UNDERLYING), proposal.DAI_BUDGET());
    assertEq(steward.tokenBudget(AaveV3EthereumAssets.RLUSD_UNDERLYING), proposal.RLUSD_BUDGET());
    assertEq(steward.tokenBudget(AaveV3EthereumAssets.LUSD_UNDERLYING), proposal.LUSD_BUDGET());
    assertEq(steward.tokenBudget(AaveV3EthereumAssets.FRAX_UNDERLYING), proposal.FRAX_BUDGET());
    assertEq(steward.tokenBudget(AaveV3EthereumAssets.PYUSD_UNDERLYING), proposal.PYUSD_BUDGET());
    assertEq(steward.tokenBudget(AaveV3EthereumAssets.UNI_UNDERLYING), proposal.UNI_BUDGET());
    assertEq(steward.tokenBudget(AaveV3EthereumAssets.MKR_UNDERLYING), proposal.MKR_BUDGET());
    assertEq(
      steward.tokenBudget(AaveV3EthereumAssets.ONE_INCH_UNDERLYING),
      proposal.ONEINCH_BUDGET()
    );
    assertEq(steward.tokenBudget(AaveV3EthereumAssets.ENS_UNDERLYING), proposal.ENS_BUDGET());
    assertEq(steward.tokenBudget(AaveV3EthereumAssets.SNX_UNDERLYING), proposal.SNX_BUDGET());
  }

  function test_swap_pairs() public {
    IMainnetSwapSteward steward = IMainnetSwapSteward(proposal.SWAP_STEWARD());

    // GHO
    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDC_UNDERLYING,
        AaveV3EthereumAssets.GHO_UNDERLYING
      )
    );
    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDT_UNDERLYING,
        AaveV3EthereumAssets.GHO_UNDERLYING
      )
    );
    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDe_UNDERLYING,
        AaveV3EthereumAssets.GHO_UNDERLYING
      )
    );
    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDS_UNDERLYING,
        AaveV3EthereumAssets.GHO_UNDERLYING
      )
    );
    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.DAI_UNDERLYING,
        AaveV3EthereumAssets.GHO_UNDERLYING
      )
    );

    // USDC
    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDe_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );
    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDS_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );
    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.DAI_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );
    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.RLUSD_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );
    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.LUSD_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );
    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.FRAX_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );
    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.PYUSD_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );
    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.UNI_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );
    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.MKR_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );
    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.ONE_INCH_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );
    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.ENS_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );
    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.SNX_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );

    executePayload(vm, address(proposal));

    // GHO
    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDC_UNDERLYING,
        AaveV3EthereumAssets.GHO_UNDERLYING
      )
    );
    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDT_UNDERLYING,
        AaveV3EthereumAssets.GHO_UNDERLYING
      )
    );
    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDe_UNDERLYING,
        AaveV3EthereumAssets.GHO_UNDERLYING
      )
    );
    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDS_UNDERLYING,
        AaveV3EthereumAssets.GHO_UNDERLYING
      )
    );
    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.DAI_UNDERLYING,
        AaveV3EthereumAssets.GHO_UNDERLYING
      )
    );

    // USDC
    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDe_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );
    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDS_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );
    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.DAI_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );
    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.RLUSD_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );
    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.LUSD_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );
    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.FRAX_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );
    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.PYUSD_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );
    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.UNI_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );
    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.MKR_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );
    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.ONE_INCH_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );
    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.ENS_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );
    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.SNX_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );
  }

  function test_swap_oracles() public {
    IMainnetSwapSteward steward = IMainnetSwapSteward(proposal.SWAP_STEWARD());

    assertEq(steward.priceOracle(AaveV3EthereumAssets.GHO_UNDERLYING), address(0));
    assertEq(steward.priceOracle(AaveV3EthereumAssets.USDC_UNDERLYING), address(0));
    assertEq(steward.priceOracle(AaveV3EthereumAssets.USDT_UNDERLYING), address(0));
    assertEq(steward.priceOracle(AaveV3EthereumAssets.USDe_UNDERLYING), address(0));
    assertEq(steward.priceOracle(AaveV3EthereumAssets.USDS_UNDERLYING), address(0));
    assertEq(steward.priceOracle(AaveV3EthereumAssets.DAI_UNDERLYING), address(0));
    assertEq(steward.priceOracle(AaveV3EthereumAssets.RLUSD_UNDERLYING), address(0));
    assertEq(steward.priceOracle(AaveV3EthereumAssets.LUSD_UNDERLYING), address(0));
    assertEq(steward.priceOracle(AaveV3EthereumAssets.FRAX_UNDERLYING), address(0));
    assertEq(steward.priceOracle(AaveV3EthereumAssets.PYUSD_UNDERLYING), address(0));
    assertEq(steward.priceOracle(AaveV3EthereumAssets.UNI_UNDERLYING), address(0));
    assertEq(steward.priceOracle(AaveV3EthereumAssets.MKR_UNDERLYING), address(0));
    assertEq(steward.priceOracle(AaveV3EthereumAssets.ONE_INCH_UNDERLYING), address(0));
    assertEq(steward.priceOracle(AaveV3EthereumAssets.ENS_UNDERLYING), address(0));
    assertEq(steward.priceOracle(AaveV3EthereumAssets.SNX_UNDERLYING), address(0));

    executePayload(vm, address(proposal));

    assertEq(steward.priceOracle(AaveV3EthereumAssets.GHO_UNDERLYING), proposal.GHO_USD_FEED());
    assertEq(
      steward.priceOracle(AaveV3EthereumAssets.USDC_UNDERLYING),
      AaveV3EthereumAssets.USDC_ORACLE
    );
    assertEq(
      steward.priceOracle(AaveV3EthereumAssets.USDT_UNDERLYING),
      AaveV3EthereumAssets.USDT_ORACLE
    );
    assertEq(
      steward.priceOracle(AaveV3EthereumAssets.USDe_UNDERLYING),
      AaveV3EthereumAssets.USDe_ORACLE
    );
    assertEq(
      steward.priceOracle(AaveV3EthereumAssets.USDS_UNDERLYING),
      AaveV3EthereumAssets.USDS_ORACLE
    );
    assertEq(
      steward.priceOracle(AaveV3EthereumAssets.DAI_UNDERLYING),
      AaveV3EthereumAssets.DAI_ORACLE
    );
    assertEq(
      steward.priceOracle(AaveV3EthereumAssets.RLUSD_UNDERLYING),
      AaveV3EthereumAssets.RLUSD_ORACLE
    );
    assertEq(
      steward.priceOracle(AaveV3EthereumAssets.LUSD_UNDERLYING),
      AaveV3EthereumAssets.LUSD_ORACLE
    );
    assertEq(
      steward.priceOracle(AaveV3EthereumAssets.FRAX_UNDERLYING),
      AaveV3EthereumAssets.FRAX_ORACLE
    );
    assertEq(
      steward.priceOracle(AaveV3EthereumAssets.PYUSD_UNDERLYING),
      AaveV3EthereumAssets.PYUSD_ORACLE
    );
    assertEq(
      steward.priceOracle(AaveV3EthereumAssets.UNI_UNDERLYING),
      AaveV3EthereumAssets.UNI_ORACLE
    );
    assertEq(
      steward.priceOracle(AaveV3EthereumAssets.MKR_UNDERLYING),
      AaveV3EthereumAssets.MKR_ORACLE
    );
    assertEq(
      steward.priceOracle(AaveV3EthereumAssets.ONE_INCH_UNDERLYING),
      AaveV3EthereumAssets.ONE_INCH_ORACLE
    );
    assertEq(
      steward.priceOracle(AaveV3EthereumAssets.ENS_UNDERLYING),
      AaveV3EthereumAssets.ENS_ORACLE
    );
    assertEq(
      steward.priceOracle(AaveV3EthereumAssets.SNX_UNDERLYING),
      AaveV3EthereumAssets.SNX_ORACLE
    );
  }
}
