// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

import {IERC4626StataToken} from './IStata.sol';
import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGsm} from 'src/interfaces/IGsm.sol';
import {IGsmRegistry} from './IGsmRegistry.sol';
import {IAaveCLRobotOperator} from './IAaveCLRobotOperator.sol';

/**
 * @title GSMs Migration to GSM4626
 * @author TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x82d3ad8b8d43b12d3c08344c9b3aadfa6da03b358aa92915d0046f19344a7faa
 * - Discussion: https://governance.aave.com/t/arfc-deploy-statausdc-and-statausdt-gsms-on-ethereum/20682
 */
contract AaveV3Ethereum_GSMsMigrationToGSM4626_20250114 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  bytes32 public constant LIQUIDATOR_ROLE =
    0x5e17fc5225d4a099df75359ce1f405503ca79498a8dc46a7d583235a0ee45c16; // keccak256('LIQUIDATOR_ROLE')
  bytes32 public constant SWAP_FREEZER_ROLE =
    0x6dac4cc0544e34aa1a4ed2862f6de78290e3f18f00fe77179ee8ef34de9dfa24; // keccak245('SWAP_FREEZER_ROLE')
  uint128 public constant USDC_CAPACITY = 8_000_000 ether;
  uint128 public constant USDT_CAPACITY = 16_000_000 ether;

  // https://etherscan.io/address/0xFeeb6FE430B7523fEF2a38327241eE7153779535
  address public constant NEW_GSM_USDC = 0xFeeb6FE430B7523fEF2a38327241eE7153779535;
  string public constant GSM_USDC_NAME = 'GSM 4626 stataUSDC';

  // https://etherscan.io/address/0x5f614E8f948fe5eE4F20F7eD517aea5C911BFb85
  address public constant USDC_ORACLE_SWAP_FREEZER = 0x5f614E8f948fe5eE4F20F7eD517aea5C911BFb85;

  // https://etherscan.io/address/0x535b2f7C20B9C83d70e519cf9991578eF9816B7B
  address public constant NEW_GSM_USDT = 0x535b2f7C20B9C83d70e519cf9991578eF9816B7B;
  string public constant GSM_USDT_NAME = 'GSM 4626 stataUSDT';

  // https://etherscan.io/address/0xca5792C238FA1A6B7805448b3507193Ab160228E
  address public constant USDT_ORACLE_SWAP_FREEZER = 0xca5792C238FA1A6B7805448b3507193Ab160228E;

  // https://etherscan.io/address/0x83896a35db4519BD8CcBAF5cF86CCA61b5cfb938
  address public constant FEE_STRATEGY = 0x83896a35db4519BD8CcBAF5cF86CCA61b5cfb938;

  // https://etherscan.io/address/0x020E452b463568f55BAc6Dc5aFC8F0B62Ea5f0f3
  address public constant ROBOT_OPERATOR = 0x020E452b463568f55BAc6Dc5aFC8F0B62Ea5f0f3;
  uint96 public constant LINK_AMOUNT_ORACLE_FREEZER_KEEPER = 80 ether;
  uint96 public constant TOTAL_LINK_AMOUNT_KEEPERS = LINK_AMOUNT_ORACLE_FREEZER_KEEPER * 2; // 2 GSMs
  uint32 public constant KEEPER_GAS_LIMIT = 150_000;

  uint256 public constant EXISTING_ORACLE_SWAP_FREEZER_USDC =
    27746244780147594627138196730124243558900438379060566825820479909082807342202;
  uint256 public constant EXISTING_ORACLE_SWAP_FREEZER_USDT =
    29419557335377754353590946220126755014551271053492007946914462953700619858182;

  function execute() external {
    uint256 balanceUsdc = IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(
      GhoEthereum.GSM_USDC
    );
    uint256 balanceUsdt = IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
      GhoEthereum.GSM_USDT
    );

    _seize();
    _grantAccess();
    _updateFeeStrategy();
    // _registerOracles();
    _fund(balanceUsdc, balanceUsdt);
    _revokeAccess();
  }

  function _seize() internal {
    IGsm(GhoEthereum.GSM_USDC).grantRole(LIQUIDATOR_ROLE, GovernanceV3Ethereum.EXECUTOR_LVL_1);
    IGsm(GhoEthereum.GSM_USDT).grantRole(LIQUIDATOR_ROLE, GovernanceV3Ethereum.EXECUTOR_LVL_1);

    IGsm(GhoEthereum.GSM_USDC).seize();
    IGsm(GhoEthereum.GSM_USDT).seize();
  }

  function _grantAccess() internal {
    // Enroll GSMs as GHO Facilitators
    IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).addFacilitator(
      NEW_GSM_USDC,
      GSM_USDC_NAME,
      USDC_CAPACITY
    );
    IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).addFacilitator(
      NEW_GSM_USDT,
      GSM_USDT_NAME,
      USDT_CAPACITY
    );

    // Allow risk council to control the bucket capacity
    address[] memory vaults = new address[](2);
    vaults[0] = NEW_GSM_USDC;
    vaults[1] = NEW_GSM_USDT;
    IGhoBucketSteward(0x46Aa1063e5265b43663E81329333B47c517A5409).setControlledFacilitator(
      vaults,
      true
    );

    // Add GSM Swap Freezer role to OracleSwapFreezers
    IGsm(NEW_GSM_USDC).grantRole(SWAP_FREEZER_ROLE, USDC_ORACLE_SWAP_FREEZER);
    IGsm(NEW_GSM_USDT).grantRole(SWAP_FREEZER_ROLE, USDT_ORACLE_SWAP_FREEZER);
    IGsm(NEW_GSM_USDC).grantRole(SWAP_FREEZER_ROLE, GovernanceV3Ethereum.EXECUTOR_LVL_1);
    IGsm(NEW_GSM_USDT).grantRole(SWAP_FREEZER_ROLE, GovernanceV3Ethereum.EXECUTOR_LVL_1);

    // Add GSMs to GSM Registry
    IGsmRegistry(GhoEthereum.GSM_REGISTRY).addGsm(NEW_GSM_USDC);
    IGsmRegistry(GhoEthereum.GSM_REGISTRY).addGsm(NEW_GSM_USDT);
  }

  function _updateFeeStrategy() internal {
    IGsm(NEW_GSM_USDC).updateFeeStrategy(FEE_STRATEGY);
    IGsm(NEW_GSM_USDT).updateFeeStrategy(FEE_STRATEGY);
  }

  function _registerOracles() internal {
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.LINK_UNDERLYING,
      address(this),
      TOTAL_LINK_AMOUNT_KEEPERS
    );
    IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).forceApprove(
      ROBOT_OPERATOR,
      TOTAL_LINK_AMOUNT_KEEPERS
    );

    IAaveCLRobotOperator(MiscEthereum.AAVE_CL_ROBOT_OPERATOR).register(
      'GHO GSM 4626 stataUSDC OracleSwapFreezer',
      USDC_ORACLE_SWAP_FREEZER,
      KEEPER_GAS_LIMIT,
      LINK_AMOUNT_ORACLE_FREEZER_KEEPER
    );
    IAaveCLRobotOperator(MiscEthereum.AAVE_CL_ROBOT_OPERATOR).register(
      'GHO GSM 4626 stataUSDT OracleSwapFreezer',
      USDT_ORACLE_SWAP_FREEZER,
      KEEPER_GAS_LIMIT,
      LINK_AMOUNT_ORACLE_FREEZER_KEEPER
    );
  }

  function _fund(uint256 balanceUsdc, uint256 balanceUsdt) internal {
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      address(this),
      balanceUsdc
    );
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      address(this),
      balanceUsdt
    );

    IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).forceApprove(
      AaveV3EthereumAssets.USDC_STATA_TOKEN,
      balanceUsdc
    );
    IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).forceApprove(
      AaveV3EthereumAssets.USDT_STATA_TOKEN,
      balanceUsdt
    );

    uint256 sharesUsdc = IERC4626StataToken(AaveV3EthereumAssets.USDC_STATA_TOKEN).deposit(
      balanceUsdc,
      address(this)
    );
    uint256 sharesUsdt = IERC4626StataToken(AaveV3EthereumAssets.USDT_STATA_TOKEN).deposit(
      balanceUsdt,
      address(this)
    );

    IERC20(AaveV3EthereumAssets.USDC_STATA_TOKEN).forceApprove(NEW_GSM_USDC, sharesUsdc);
    IERC20(AaveV3EthereumAssets.USDT_STATA_TOKEN).forceApprove(NEW_GSM_USDT, sharesUsdt);

    (, uint256 amountGhoUsdc) = IGsm(NEW_GSM_USDC).sellAsset(sharesUsdc, address(this));
    (, uint256 amountGhoUsdt) = IGsm(NEW_GSM_USDT).sellAsset(sharesUsdt, address(this));

    (, uint256 ghoUsdcNeeded) = IGhoToken(GhoEthereum.GHO_TOKEN).getFacilitatorBucket(
      GhoEthereum.GSM_USDC
    );
    (, uint256 ghoUsdtNeeded) = IGhoToken(GhoEthereum.GHO_TOKEN).getFacilitatorBucket(
      GhoEthereum.GSM_USDT
    );

    uint256 difference = ghoUsdcNeeded + ghoUsdtNeeded - amountGhoUsdc - amountGhoUsdt;
    if (difference > 0) {
      AaveV3Ethereum.COLLECTOR.transfer(GhoEthereum.GHO_TOKEN, address(this), difference);
    }

    IERC20(GhoEthereum.GHO_TOKEN).forceApprove(GhoEthereum.GSM_USDC, ghoUsdcNeeded);
    IERC20(GhoEthereum.GHO_TOKEN).forceApprove(GhoEthereum.GSM_USDT, ghoUsdtNeeded);

    IGsm(GhoEthereum.GSM_USDC).burnAfterSeize(ghoUsdcNeeded);
    IGsm(GhoEthereum.GSM_USDT).burnAfterSeize(ghoUsdtNeeded);

    IGsm(GhoEthereum.GSM_USDC).distributeFeesToTreasury();
    IGsm(GhoEthereum.GSM_USDT).distributeFeesToTreasury();
  }

  function _revokeAccess() internal {
    // Remove existing GSMs as GHO Facilitators
    IGhoToken(GhoEthereum.GHO_TOKEN).removeFacilitator(GhoEthereum.GSM_USDC);
    IGhoToken(GhoEthereum.GHO_TOKEN).removeFacilitator(GhoEthereum.GSM_USDT);

    // Revoke existing GSMs
    address[] memory revokedVaults = new address[](2);
    revokedVaults[0] = GhoEthereum.GSM_USDC;
    revokedVaults[1] = GhoEthereum.GSM_USDT;
    // https://etherscan.io/address/0x46Aa1063e5265b43663E81329333B47c517A5409
    IGhoBucketSteward(0x46Aa1063e5265b43663E81329333B47c517A5409).setControlledFacilitator(
      revokedVaults,
      false
    );

    // Remove existing GSMs from Registry
    IGsmRegistry(GhoEthereum.GSM_REGISTRY).removeGsm(GhoEthereum.GSM_USDC);
    IGsmRegistry(GhoEthereum.GSM_REGISTRY).removeGsm(GhoEthereum.GSM_USDT);

    // Revoke Roles
    IGsm(GhoEthereum.GSM_USDC).revokeRole(
      SWAP_FREEZER_ROLE,
      GhoEthereum.GSM_USDC_ORACLE_SWAP_FREEZER
    );
    IGsm(GhoEthereum.GSM_USDT).revokeRole(
      SWAP_FREEZER_ROLE,
      GhoEthereum.GSM_USDT_ORACLE_SWAP_FREEZER
    );
    IGsm(GhoEthereum.GSM_USDC).revokeRole(SWAP_FREEZER_ROLE, GovernanceV3Ethereum.EXECUTOR_LVL_1);
    IGsm(GhoEthereum.GSM_USDT).revokeRole(SWAP_FREEZER_ROLE, GovernanceV3Ethereum.EXECUTOR_LVL_1);

    // // Cancel existing keepers
    // IAaveCLRobotOperator(ROBOT_OPERATOR).cancel(EXISTING_ORACLE_SWAP_FREEZER_USDC);
    // IAaveCLRobotOperator(ROBOT_OPERATOR).cancel(EXISTING_ORACLE_SWAP_FREEZER_USDT);

    // // Withdraw LINK from existing keepers
    // IAaveCLRobotOperator(ROBOT_OPERATOR).withdrawLink(EXISTING_ORACLE_SWAP_FREEZER_USDC);
    // IAaveCLRobotOperator(ROBOT_OPERATOR).withdrawLink(EXISTING_ORACLE_SWAP_FREEZER_USDT);
  }
}
