// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IAaveEcosystemReserveController} from 'aave-address-book/common/IAaveEcosystemReserveController.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Ethereum_AmendSafetyModuleAAVEEmissions_20231104} from './AaveV3Ethereum_AmendSafetyModuleAAVEEmissions_20231104.sol';

library HelperStructs {
  struct AssetConfigInput {
    uint128 emissionPerSecond;
    uint256 totalStaked;
    address underlyingAsset;
  }

  struct UserStakeInput {
    address underlyingAsset;
    uint256 stakedByUser;
    uint256 totalStaked;
  }

  struct AssetResponse {
    uint128 emissionPerSecond;
    uint128 lastUpdateTimestamp;
    uint256 index;
  }
}

interface IAaveDistributionManager {
  function configureAssets(HelperStructs.AssetConfigInput[] calldata assetsConfigInput) external;

  function STAKED_TOKEN() external returns (address);

  function totalSupply() external returns (uint256);

  function assets(address asset) external returns (HelperStructs.AssetResponse memory);
}

interface IStkAAVE is IERC20 {
  function getTotalRewardsBalance(address user) external view returns (uint256);

  function claimRewards(address to, uint256 amount) external;
}

/**
 * @dev Test for AaveV3Ethereum_AmendSafetyModuleAAVEEmissions_20231104
 * command: make test-contract filter=AaveV3Ethereum_AmendSafetyModuleAAVEEmissions_20231104
 */
contract AaveV3Ethereum_AmendSafetyModuleAAVEEmissions_20231104_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AmendSafetyModuleAAVEEmissions_20231104 internal proposal;

  address public constant ACI = 0x57ab7ee15cE5ECacB1aB84EE42D5A9d0d8112922;
  address public constant AAVE = AaveV3EthereumAssets.AAVE_UNDERLYING;
  IERC20 aaveToken = IERC20(AAVE);

  address public constant STKAAVE = AaveSafetyModule.STK_AAVE;
  address public constant STKABPT = AaveSafetyModule.STK_ABPT;

  address public constant ECOSYSTEM_RESERVE = MiscEthereum.ECOSYSTEM_RESERVE;

  IAaveEcosystemReserveController public constant ECOSYSTEM_RESERVE_CONTROLLER =
    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER;

  uint256 public constant DAILY_EMISSIONS = 385 ether;

  // Total cycle emission (90 days)
  uint256 public constant CYCLE_EMISSIONS = DAILY_EMISSIONS * 90;

  // Daily emission to seconds; 1 day * 24h * 3600 s = 86400
  uint128 public constant EMISSIONS_PER_SECOND = uint128(DAILY_EMISSIONS / 86400);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18535736);
    proposal = new AaveV3Ethereum_AmendSafetyModuleAAVEEmissions_20231104();
  }

  /**
   * changing emission should not retroactively change rewards
   */
  function test_rewardsEmission() public {
    IStkAAVE stkAAVE = IStkAAVE(STKAAVE);

    // Check and log ACI's claimable amount from StkAAVE before execution
    uint256 claimableBefore = stkAAVE.getTotalRewardsBalance(ACI);

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    // Check and log ACI's claimable amount from StkAAVE after execution
    uint256 claimableAfter = stkAAVE.getTotalRewardsBalance(ACI);

    // Assert both claimable amounts are equal
    assertEq(claimableBefore, claimableAfter, 'CLAIMABLE_SHOULD_NOT_CHANGE');

    // Simulate the claim from ACI and assert balance in AAVE is higher after than before claim
    uint256 aaveBalanceBefore = aaveToken.balanceOf(ACI);

    // Impersonate ACI and simulate the claim
    vm.startPrank(ACI);
    stkAAVE.claimRewards(ACI, claimableAfter);
    vm.stopPrank();

    uint256 aaveBalanceAfter = aaveToken.balanceOf(ACI);

    // Assert that the AAVE balance is higher after the claim
    assertEq(aaveBalanceAfter, aaveBalanceBefore + claimableBefore);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    IAaveDistributionManager aaveManager = IAaveDistributionManager(STKAAVE);
    IAaveDistributionManager bptManager = IAaveDistributionManager(STKABPT);

    HelperStructs.AssetResponse memory aaveResBefore = aaveManager.assets(STKAAVE);
    HelperStructs.AssetResponse memory bptResBefore = bptManager.assets(STKABPT);

    vm.startPrank(MiscEthereum.ECOSYSTEM_RESERVE);
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(address(proposal));
    // create proposal
    uint256 proposalId = GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20231104_AaveV3Ethereum_AmendSafetyModuleAAVEEmissions/AmendSafetyModuleAAVEEmissions.md'
      )
    );
    GovHelpers.passVoteAndExecute(vm, proposalId);

    /*
      Check emission changes, the value should be 385 ether * 86400 seconds in a day
    */
    HelperStructs.AssetResponse memory aaveResAfter = aaveManager.assets(STKAAVE);
    assertEq(aaveResAfter.emissionPerSecond, EMISSIONS_PER_SECOND);
    assertLt(aaveResAfter.emissionPerSecond, aaveResBefore.emissionPerSecond);

    HelperStructs.AssetResponse memory bptResAfter = bptManager.assets(STKABPT);
    assertEq(bptResAfter.emissionPerSecond, EMISSIONS_PER_SECOND);
    assertLt(bptResAfter.emissionPerSecond, bptResBefore.emissionPerSecond);

    assertEq(aaveResAfter.emissionPerSecond, bptResAfter.emissionPerSecond);
    /*
      Check cycles changes, the allowance should be 385 ether * 90 * 4 as described on the proposal
    */
    assertEq(
      IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(ECOSYSTEM_RESERVE, STKAAVE),
      CYCLE_EMISSIONS * 4
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(ECOSYSTEM_RESERVE, STKABPT),
      CYCLE_EMISSIONS * 4
    );
  }
}
