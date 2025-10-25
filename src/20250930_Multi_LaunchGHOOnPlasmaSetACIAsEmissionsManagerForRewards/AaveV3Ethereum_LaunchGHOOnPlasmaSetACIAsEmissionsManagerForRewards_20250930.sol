// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IERC4626} from 'openzeppelin-contracts/contracts/interfaces/IERC4626.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';

import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGsm} from 'src/interfaces/IGsm.sol';
import {IGsmRegistry} from 'src/interfaces/IGsmRegistry.sol';
import {IAaveCLRobotOperator} from 'src/interfaces/IAaveCLRobotOperator.sol';
import {CCIPChainSelectors} from '../helpers/gho-launch/constants/CCIPChainSelectors.sol';

interface IGhoReserve {
  function addEntity(address entity) external;
  function setLimit(address entity, uint256 limit) external;
}

interface IOwnableFacilitator {
  function mint(address to, uint256 amount) external;
}

interface IAaveGhoCcipBridge {
  function send(uint64 chainSelector, uint256 amount, address feeToken) external returns (bytes32);
  function quoteBridge(
    uint64 chainSelector,
    uint256 amount,
    address feeToken
  ) external view returns (uint256);
}

/**
 * @title Add GHO and deploy GSM on Plasma. Migrate to new GSM on Ethereum
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xeb3572580924976867073ad9c8012cb9e52093c76dafebd7d3aebf318f2576fb
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-plasma-set-aci-as-emissions-manager-for-rewards/22994/6
 */
contract AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930 is
  IProposalGenericExecutor
{
  using SafeERC20 for IERC20;
  using CollectorUtils for ICollector;

  // OwnableFacilitator Constants
  address public constant OWNABLE_FACILITATOR = 0x616AEe98F73C79FE59548Cfe7631c0baDBdA3165;
  string public constant OWNABLE_FACILITATOR_NAME = 'OwnableFacilitator Gho GSMs';
  uint128 public constant OWNABLE_FACILITATOR_CAPACITY = 100_000_000 ether;

  // GhoReserve
  // https://etherscan.io/address/0x0b0C0d8346F69EE94D29405f5630fc883A1052ab
  address public constant GHO_RESERVE = 0x0b0C0d8346F69EE94D29405f5630fc883A1052ab;

  // Plasma Bridge Constants
  // https://etherscan.io/address/0x7f2f96fcdc3a29be75938d2ac3d92e7006919fe6
  address public constant CCIP_BRIDGE = 0x7F2f96fcdC3A29Be75938d2aC3D92E7006919fe6;

  // https://plasmascan.to/address/0x035Dec9dBE6DC0230ac05A760D9B6A70E7514243
  address public constant CCIP_BRIDGE_PLASMA = 0x035Dec9dBE6DC0230ac05A760D9B6A70E7514243;
  uint256 public constant PLASMA_BRIDGE_AMOUNT = 50_000_000 ether;

  // Existing GSM
  uint128 public constant USDC_CAPACITY = 5_000_000 ether;
  uint128 public constant USDT_CAPACITY = 25_000_000 ether;

  // https://etherscan.io/address/0x99f3460A84f63a5039F926DB6904b65C30f20927
  address public constant NEW_GSM_USDC = 0x99f3460A84f63a5039F926DB6904b65C30f20927;

  // https://etherscan.io/address/0x1de76e3d0f1a3Bf2dD64e676008727927beF0C40
  address public constant USDC_ORACLE_SWAP_FREEZER = 0x1de76e3d0f1a3Bf2dD64e676008727927beF0C40;

  // https://etherscan.io/address/0x59f7742C910D5150d284b44a56bf4A8B31588252
  address public constant NEW_GSM_USDT = 0x59f7742C910D5150d284b44a56bf4A8B31588252;

  // https://etherscan.io/address/0x10C053eBcD738C88fA74903Ef2EB24166b770931
  address public constant USDT_ORACLE_SWAP_FREEZER = 0x10C053eBcD738C88fA74903Ef2EB24166b770931;

  // https://etherscan.io/address/0x06fbDE909B43f01202E3C6207De1D27cC208AcC1
  address public constant FEE_STRATEGY = 0x06fbDE909B43f01202E3C6207De1D27cC208AcC1;

  // https://etherscan.io/address/0x1cDF8879eC8bE012bA959EB515b11008E0cb6323
  address public constant ROBOT_OPERATOR = 0x1cDF8879eC8bE012bA959EB515b11008E0cb6323;
  uint96 public constant LINK_AMOUNT_ORACLE_FREEZER_KEEPER = 80 ether;
  uint96 public constant TOTAL_LINK_AMOUNT_KEEPERS = LINK_AMOUNT_ORACLE_FREEZER_KEEPER * 2; // 2 GSMs
  uint32 public constant KEEPER_GAS_LIMIT = 150_000;

  uint256 public constant EXISTING_ORACLE_SWAP_FREEZER_USDC =
    85153843967789017760384794934034524869526055173666527804449435339462659418687;
  uint256 public constant EXISTING_ORACLE_SWAP_FREEZER_USDT =
    113117985912495124427864354142901529291134634735835568280477108198234580494999;

  bytes32 public immutable LIQUIDATOR_ROLE = IGsm(GhoEthereum.GSM_USDC).LIQUIDATOR_ROLE();
  bytes32 public immutable SWAP_FREEZER_ROLE = IGsm(GhoEthereum.GSM_USDC).SWAP_FREEZER_ROLE();

  function execute() external {
    uint256 balanceUsdc = IERC20(AaveV3EthereumAssets.USDC_STATA_TOKEN).balanceOf(
      GhoEthereum.GSM_USDC
    );
    uint256 balanceUsdt = IERC20(AaveV3EthereumAssets.USDT_STATA_TOKEN).balanceOf(
      GhoEthereum.GSM_USDT
    );

    _seize();
    _grantAccess();
    _updateFeeStrategy();
    _registerOracles();
    _fund(balanceUsdc, balanceUsdt);
    _revokeAccess();

    _bridgeToPlasma();
  }

  function _bridgeToPlasma() internal {
    IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).addFacilitator(
      OWNABLE_FACILITATOR,
      OWNABLE_FACILITATOR_NAME,
      OWNABLE_FACILITATOR_CAPACITY
    );

    IOwnableFacilitator(OWNABLE_FACILITATOR).mint(CCIP_BRIDGE, PLASMA_BRIDGE_AMOUNT);

    uint256 fee = IAaveGhoCcipBridge(CCIP_BRIDGE).quoteBridge(
      CCIPChainSelectors.PLASMA,
      PLASMA_BRIDGE_AMOUNT,
      AaveV3EthereumAssets.GHO_UNDERLYING
    );

    IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).safeTransfer(CCIP_BRIDGE, fee);
    IAaveGhoCcipBridge(CCIP_BRIDGE).send(
      CCIPChainSelectors.PLASMA,
      PLASMA_BRIDGE_AMOUNT,
      AaveV3EthereumAssets.GHO_UNDERLYING
    );
  }

  function _seize() internal {
    IGsm(GhoEthereum.GSM_USDC).grantRole(LIQUIDATOR_ROLE, GovernanceV3Ethereum.EXECUTOR_LVL_1);
    IGsm(GhoEthereum.GSM_USDT).grantRole(LIQUIDATOR_ROLE, GovernanceV3Ethereum.EXECUTOR_LVL_1);

    IGsm(GhoEthereum.GSM_USDC).seize();
    IGsm(GhoEthereum.GSM_USDT).seize();
  }

  function _grantAccess() internal {
    // Enroll GSMs as entities and set limit
    IGhoReserve(GHO_RESERVE).addEntity(NEW_GSM_USDC);
    IGhoReserve(GHO_RESERVE).addEntity(NEW_GSM_USDT);

    IGhoReserve(GHO_RESERVE).setLimit(NEW_GSM_USDC, USDC_CAPACITY);
    IGhoReserve(GHO_RESERVE).setLimit(NEW_GSM_USDT, USDT_CAPACITY);

    // Allow risk council to control the bucket capacity
    address[] memory vaults = new address[](2);
    vaults[0] = NEW_GSM_USDC;
    vaults[1] = NEW_GSM_USDT;
    IGhoBucketSteward(GhoEthereum.GHO_BUCKET_STEWARD).setControlledFacilitator(vaults, true);

    // Add GSM Swap Freezer role to OracleSwapFreezers
    IGsm(NEW_GSM_USDC).grantRole(SWAP_FREEZER_ROLE, USDC_ORACLE_SWAP_FREEZER);
    IGsm(NEW_GSM_USDT).grantRole(SWAP_FREEZER_ROLE, USDT_ORACLE_SWAP_FREEZER);
    IGsm(NEW_GSM_USDC).grantRole(SWAP_FREEZER_ROLE, GovernanceV3Ethereum.EXECUTOR_LVL_1);
    IGsm(NEW_GSM_USDT).grantRole(SWAP_FREEZER_ROLE, GovernanceV3Ethereum.EXECUTOR_LVL_1);

    // Add GSMs to GSM Registry
    IGsmRegistry(GhoEthereum.GSM_REGISTRY).addGsm(NEW_GSM_USDC);
    IGsmRegistry(GhoEthereum.GSM_REGISTRY).addGsm(NEW_GSM_USDT);

    // GHO GSM Steward
    IGsm(NEW_GSM_USDC).grantRole(
      IGsm(NEW_GSM_USDC).CONFIGURATOR_ROLE(),
      GhoEthereum.GHO_GSM_STEWARD
    );
    IGsm(NEW_GSM_USDT).grantRole(
      IGsm(NEW_GSM_USDT).CONFIGURATOR_ROLE(),
      GhoEthereum.GHO_GSM_STEWARD
    );
  }

  function _updateFeeStrategy() internal {
    IGsm(NEW_GSM_USDC).updateFeeStrategy(FEE_STRATEGY);
    IGsm(NEW_GSM_USDT).updateFeeStrategy(FEE_STRATEGY);
  }

  function _registerOracles() internal {
    AaveV3Ethereum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.LINK_UNDERLYING,
        amount: TOTAL_LINK_AMOUNT_KEEPERS
      }),
      address(this)
    );
    IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).forceApprove(
      MiscEthereum.AAVE_CL_ROBOT_OPERATOR,
      TOTAL_LINK_AMOUNT_KEEPERS
    );

    IAaveCLRobotOperator(MiscEthereum.AAVE_CL_ROBOT_OPERATOR).register(
      'GHO GSM 4626 stataUSDC OracleSwapFreezer',
      USDC_ORACLE_SWAP_FREEZER,
      '',
      KEEPER_GAS_LIMIT,
      LINK_AMOUNT_ORACLE_FREEZER_KEEPER,
      0,
      ''
    );
    IAaveCLRobotOperator(MiscEthereum.AAVE_CL_ROBOT_OPERATOR).register(
      'GHO GSM 4626 stataUSDT OracleSwapFreezer',
      USDT_ORACLE_SWAP_FREEZER,
      '',
      KEEPER_GAS_LIMIT,
      LINK_AMOUNT_ORACLE_FREEZER_KEEPER,
      0,
      ''
    );
  }

  function _fund(uint256 balanceUsdc, uint256 balanceUsdt) internal {
    IOwnableFacilitator(OWNABLE_FACILITATOR).mint(GHO_RESERVE, USDC_CAPACITY + USDT_CAPACITY);

    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.USDC_STATA_TOKEN),
      address(this),
      balanceUsdc
    );
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.USDT_STATA_TOKEN),
      address(this),
      balanceUsdt
    );

    IERC20(AaveV3EthereumAssets.USDC_STATA_TOKEN).forceApprove(NEW_GSM_USDC, balanceUsdc);
    IERC20(AaveV3EthereumAssets.USDT_STATA_TOKEN).forceApprove(NEW_GSM_USDT, balanceUsdt);

    (, uint256 amountGhoUsdc) = IGsm(NEW_GSM_USDC).sellAsset(balanceUsdc, address(this));
    (, uint256 amountGhoUsdt) = IGsm(NEW_GSM_USDT).sellAsset(balanceUsdt, address(this));

    (, uint256 ghoUsdcNeeded) = IGhoToken(GhoEthereum.GHO_TOKEN).getFacilitatorBucket(
      GhoEthereum.GSM_USDC
    );
    (, uint256 ghoUsdtNeeded) = IGhoToken(GhoEthereum.GHO_TOKEN).getFacilitatorBucket(
      GhoEthereum.GSM_USDT
    );

    uint256 difference = ghoUsdcNeeded + ghoUsdtNeeded - amountGhoUsdc - amountGhoUsdt;
    if (difference > 0) {
      AaveV3Ethereum.COLLECTOR.transfer(IERC20(GhoEthereum.GHO_TOKEN), address(this), difference);
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
    IGhoBucketSteward(GhoEthereum.GHO_BUCKET_STEWARD).setControlledFacilitator(
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

    IGsm(GhoEthereum.GSM_USDC).revokeRole(LIQUIDATOR_ROLE, GovernanceV3Ethereum.EXECUTOR_LVL_1);
    IGsm(GhoEthereum.GSM_USDT).revokeRole(LIQUIDATOR_ROLE, GovernanceV3Ethereum.EXECUTOR_LVL_1);

    // GHO GSM Steward
    IGsm(GhoEthereum.GSM_USDC).revokeRole(
      IGsm(GhoEthereum.GSM_USDC).CONFIGURATOR_ROLE(),
      GhoEthereum.GHO_GSM_STEWARD
    );
    IGsm(GhoEthereum.GSM_USDT).revokeRole(
      IGsm(GhoEthereum.GSM_USDT).CONFIGURATOR_ROLE(),
      GhoEthereum.GHO_GSM_STEWARD
    );

    // Cancel existing keepers
    IAaveCLRobotOperator(MiscEthereum.AAVE_CL_ROBOT_OPERATOR).cancel(
      EXISTING_ORACLE_SWAP_FREEZER_USDC
    );
    IAaveCLRobotOperator(MiscEthereum.AAVE_CL_ROBOT_OPERATOR).cancel(
      EXISTING_ORACLE_SWAP_FREEZER_USDT
    );

    // Manually withdraw LINK from existing keepers permissionesly ~20 blocks after cancel
  }
}
