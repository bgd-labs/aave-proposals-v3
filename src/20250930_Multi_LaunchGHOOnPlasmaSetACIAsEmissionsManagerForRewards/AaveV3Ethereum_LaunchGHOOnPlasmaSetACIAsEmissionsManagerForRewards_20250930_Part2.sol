// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {CCIPChainSelectors} from '../helpers/gho-launch/constants/CCIPChainSelectors.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {IUpgradeableLockReleaseTokenPool, IRateLimiter} from 'src/interfaces/ccip/IUpgradeableLockReleaseTokenPool.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IAaveGhoCcipBridge} from 'aave-helpers/src/bridges/ccip/interfaces/IAaveGhoCcipBridge.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IOwnableFacilitator} from 'src/interfaces/IOwnableFacilitator.sol';

/**
 * @title Add GHO and deploy GSM on Plasma. Migrate to new GSM on Ethereum
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xeb3572580924976867073ad9c8012cb9e52093c76dafebd7d3aebf318f2576fb
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-plasma-set-aci-as-emissions-manager-for-rewards/22994/6
 */
contract AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part2 is
  IProposalGenericExecutor
{
  using SafeERC20 for IERC20;

  // OwnableFacilitator Constants
  // https://etherscan.io/address/0x023eb65d5098bfb44e71bf0d3affe2a9b87e743d
  address public constant OWNABLE_FACILITATOR = 0x023eb65d5098bfB44E71bf0D3AFfe2A9B87e743d;
  string public constant OWNABLE_FACILITATOR_NAME = 'OwnableFacilitator GHO On Plasma';
  uint128 public constant OWNABLE_FACILITATOR_CAPACITY = 50_000_000 ether;

  // https://etherscan.io/address/0x7f2f96fcdc3a29be75938d2ac3d92e7006919fe6
  address public constant CCIP_BRIDGE = 0x7F2f96fcdC3A29Be75938d2aC3D92E7006919fe6;

  uint128 public constant DEFAULT_RATE_LIMITER_CAPACITY = 1_500_000e18;
  uint128 public constant DEFAULT_RATE_LIMITER_RATE = 300e18;
  uint256 public constant PLASMA_BRIDGE_AMOUNT = 50_000_000 ether;

  function execute() external {
    IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).addFacilitator(
      OWNABLE_FACILITATOR,
      OWNABLE_FACILITATOR_NAME,
      OWNABLE_FACILITATOR_CAPACITY
    );

    IOwnableFacilitator(OWNABLE_FACILITATOR).mint(address(this), PLASMA_BRIDGE_AMOUNT);

    IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).approve(CCIP_BRIDGE, PLASMA_BRIDGE_AMOUNT);

    // Bridge already has LINK to bridge, no need to send for fee
    IAaveGhoCcipBridge(CCIP_BRIDGE).send(
      CCIPChainSelectors.PLASMA,
      PLASMA_BRIDGE_AMOUNT,
      AaveV3EthereumAssets.LINK_UNDERLYING
    );

    // Restore bridge limit
    IUpgradeableLockReleaseTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL).setChainRateLimiterConfig(
      CCIPChainSelectors.PLASMA,
      IRateLimiter.Config({
        isEnabled: true,
        capacity: DEFAULT_RATE_LIMITER_CAPACITY,
        rate: DEFAULT_RATE_LIMITER_RATE
      }),
      IRateLimiter.Config({
        isEnabled: true,
        capacity: DEFAULT_RATE_LIMITER_CAPACITY,
        rate: DEFAULT_RATE_LIMITER_RATE
      })
    );
  }
}
