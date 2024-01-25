// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

interface IGhoToken {
  function addFacilitator(
    address facilitatorAddress,
    string calldata facilitatorLabel,
    uint128 bucketCapacity
  ) external;
}

interface IGsm {
  function updateFeeStrategy(address feeStrategy) external;

  function SWAP_FREEZER_ROLE() external pure returns (bytes32);

  function grantRole(bytes32 role, address account) external;
}

interface IGsmRegistry {
  function addGsm(address gsmAddress) external;
}

interface IAaveCLRobotOperator {
  function register(
    string memory name,
    address upkeepContract,
    uint32 gasLimit,
    uint96 amountToFund
  ) external returns (uint256);
}

/**
 * @title GHO Stability Module
 * @author Aave labs (@aave)
 * @dev This proposal enables 2 GHO Stability Modules (USDC, USDT):
 * - Addition of USDC and USDT GSMs as GHO Facilitators
 * - Give Swap Freezer permissions to OracleSwapFreezers, one per module
 * - Give Swap Freezer permissions to the DAO Level 1 Executor
 * - Install a 0.2% fee strategy into both modules
 * - Register both GSMs in the GsmRegistry
 * - Activate OracleSwapFreezer contracts as AaveRobot Keepers
 * Relevant governance links:
 * 1. GHO Stability Module
 *  - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x98bdd30f645b2981320f82c671ae9fee31ee771766c13cd2627b66a22f0d438e
 *  - Discussion: https://governance.aave.com/t/temp-check-gho-stability-module/13927
 * 2. GHO Stability Module Update
 *  - Discussion: https://governance.aave.com/t/gho-stability-module-update/14442
 * 3. GHO Stability Module Launch
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xe9b62e197a98832da7d1231442b5960588747f184415fba4699b6325d7618842
 */
contract Gho_GHOStabilityModule_20240119 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  address public constant GSM_USDC = 0x0d8eFfC11dF3F229AA1EA0509BC9DFa632A13578;
  address public constant GSM_USDC_ORACLE_SWAP_FREEZER = 0xef6beCa8D9543eC007bceA835aF768B58F730C1f;
  address public constant GSM_USDT = 0x686F8D21520f4ecEc7ba577be08354F4d1EB8262;
  address public constant GSM_USDT_ORACLE_SWAP_FREEZER = 0x71381e6718b37C12155CB961Ca3D374A8BfFa0e5;
  address public constant GSM_REGISTRY = 0x167527DB01325408696326e3580cd8e55D99Dc1A;
  address public constant GSM_FIXED_FEE_STRATEGY = 0xD4478A76aCeA81D3768A0ACB6e38f25eEB6Eb1B5;

  string public constant GSM_USDC_FACILITATOR_LABEL = 'GSM USDC';
  uint128 public constant GSM_USDC_BUCKET_CAPACITY = 500_000e18;
  string public constant GSM_USDT_FACILITATOR_LABEL = 'GSM USDT';
  uint128 public constant GSM_USDT_BUCKET_CAPACITY = 500_000e18;

  address public constant ROBOT_OPERATOR = 0x020E452b463568f55BAc6Dc5aFC8F0B62Ea5f0f3;
  uint96 public constant LINK_AMOUNT_ORACLE_FREEZER_KEEPER = 80 ether;
  uint96 public constant TOTAL_LINK_AMOUNT_KEEPERS = LINK_AMOUNT_ORACLE_FREEZER_KEEPER * 2; // 2 GSMs
  uint32 public constant KEEPER_GAS_LIMIT = 150_000;

  function execute() external {
    // 1. Enroll GSMs as GHO Facilitators
    IGhoToken(MiscEthereum.GHO_TOKEN).addFacilitator(
      GSM_USDC,
      GSM_USDC_FACILITATOR_LABEL,
      GSM_USDC_BUCKET_CAPACITY
    );
    IGhoToken(MiscEthereum.GHO_TOKEN).addFacilitator(
      GSM_USDT,
      GSM_USDT_FACILITATOR_LABEL,
      GSM_USDT_BUCKET_CAPACITY
    );

    // 2. Add GSM Swap Freezer role to OracleSwapFreezers
    IGsm(GSM_USDC).grantRole(IGsm(GSM_USDC).SWAP_FREEZER_ROLE(), GSM_USDC_ORACLE_SWAP_FREEZER);
    IGsm(GSM_USDT).grantRole(IGsm(GSM_USDT).SWAP_FREEZER_ROLE(), GSM_USDT_ORACLE_SWAP_FREEZER);
    IGsm(GSM_USDC).grantRole(
      IGsm(GSM_USDC).SWAP_FREEZER_ROLE(),
      GovernanceV3Ethereum.EXECUTOR_LVL_1
    );
    IGsm(GSM_USDT).grantRole(
      IGsm(GSM_USDT).SWAP_FREEZER_ROLE(),
      GovernanceV3Ethereum.EXECUTOR_LVL_1
    );

    // 3. Update Fee Strategy
    IGsm(GSM_USDC).updateFeeStrategy(GSM_FIXED_FEE_STRATEGY);
    IGsm(GSM_USDT).updateFeeStrategy(GSM_FIXED_FEE_STRATEGY);

    // 4. Add GSMs to GSM Registry
    IGsmRegistry(GSM_REGISTRY).addGsm(GSM_USDC);
    IGsmRegistry(GSM_REGISTRY).addGsm(GSM_USDT);

    // 5. Register OracleSwapFreezer as keepers
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.LINK_UNDERLYING,
      address(this),
      TOTAL_LINK_AMOUNT_KEEPERS
    );
    IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).forceApprove(
      ROBOT_OPERATOR,
      TOTAL_LINK_AMOUNT_KEEPERS
    );

    IAaveCLRobotOperator(ROBOT_OPERATOR).register(
      'GHO GSM USDC OracleSwapFreezer',
      GSM_USDC_ORACLE_SWAP_FREEZER,
      KEEPER_GAS_LIMIT,
      LINK_AMOUNT_ORACLE_FREEZER_KEEPER
    );
    IAaveCLRobotOperator(ROBOT_OPERATOR).register(
      'GHO GSM USDT OracleSwapFreezer',
      GSM_USDT_ORACLE_SWAP_FREEZER,
      KEEPER_GAS_LIMIT,
      LINK_AMOUNT_ORACLE_FREEZER_KEEPER
    );
  }
}
