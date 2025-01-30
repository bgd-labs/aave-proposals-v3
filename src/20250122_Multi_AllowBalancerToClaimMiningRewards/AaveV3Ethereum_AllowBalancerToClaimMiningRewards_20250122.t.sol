// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IERC20AaveLM} from 'aave-v3-origin/contracts/extensions/stata-token/interfaces/IERC20AaveLM.sol';
import {IRewardsController} from 'aave-v3-origin/contracts/rewards/interfaces/IRewardsController.sol';

import {AaveV3Multi_AllowBalancerToClaimMiningRewards_20250122} from './AaveV3Multi_AllowBalancerToClaimMiningRewards_20250122.sol';

/**
 * @dev Test for AaveV3Ethereum_AllowBalancerToClaimMiningRewards_20250122
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250122_Multi_AllowBalancerToClaimMiningRewards/AaveV3Ethereum_AllowBalancerToClaimMiningRewards_20250122.t.sol -vv
 */
contract AaveV3Ethereum_AllowBalancerToClaimMiningRewards_20250122_Test is ProtocolV3TestBase {
  AaveV3Multi_AllowBalancerToClaimMiningRewards_20250122 internal proposal;

  address public constant CLAIMER = 0x9ff471F9f98F42E5151C7855fD1b5aa906b1AF7e;
  address public constant BALANCER_VAULT = 0xbA1333333333a1BA1108E8412f11850A5C319bA9;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21680887);
    proposal = new AaveV3Multi_AllowBalancerToClaimMiningRewards_20250122(
      CLAIMER,
      BALANCER_VAULT,
      AaveV3Ethereum.EMISSION_MANAGER
    );
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AllowBalancerToClaimMiningRewards_20250122',
      AaveV3Ethereum.POOL,
      address(proposal)
    );

    assertEq(
      IRewardsController(AaveV3Ethereum.DEFAULT_INCENTIVES_CONTROLLER).getClaimer(
        proposal.BALANCER_VAULT()
      ),
      proposal.CLAIMER()
    );

    vm.startPrank(proposal.CLAIMER());
    address[] memory assets = new address[](1);
    assets[0] = AaveV3EthereumLidoAssets.WETH_A_TOKEN;
    IERC20AaveLM(AaveV3EthereumLidoAssets.WETH_STATA_TOKEN).claimRewardsOnBehalf(
      proposal.BALANCER_VAULT(),
      address(this),
      assets
    );

    assets[0] = AaveV3EthereumLidoAssets.wstETH_A_TOKEN;
    IERC20AaveLM(AaveV3EthereumLidoAssets.wstETH_STATA_TOKEN).claimRewardsOnBehalf(
      proposal.BALANCER_VAULT(),
      address(this),
      assets
    );

    assets[0] = AaveV3EthereumAssets.USDS_A_TOKEN;
    IERC20AaveLM(AaveV3EthereumAssets.USDS_STATA_TOKEN).claimRewardsOnBehalf(
      proposal.BALANCER_VAULT(),
      address(this),
      assets
    );

    assets[0] = AaveV3EthereumAssets.USDS_A_TOKEN;
    IERC20AaveLM(AaveV3EthereumAssets.USDS_STATA_TOKEN).claimRewardsOnBehalf(
      proposal.BALANCER_VAULT(),
      address(this),
      assets
    );
  }
}
