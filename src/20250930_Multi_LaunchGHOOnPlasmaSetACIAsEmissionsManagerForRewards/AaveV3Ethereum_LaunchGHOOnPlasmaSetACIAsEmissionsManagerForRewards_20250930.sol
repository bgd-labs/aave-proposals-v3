// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {CCIPChainSelectors} from '../helpers/gho-launch/constants/CCIPChainSelectors.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

interface IOwnableFacilitator {
  function mint(address to, uint256 amount) external;
}

interface IAaveGhoCcipBridge {
  function send(uint64 chainSelector, uint256 amount, address feeToken) external returns (bytes32);

  function setDestinationChain(
    uint64 chainSelector,
    bytes calldata destination,
    bytes calldata extraArgs,
    uint32 gasLimit
  ) external;

  function quoteBridge(
    uint64 chainSelector,
    uint256 amount,
    address feeToken
  ) external view returns (uint256);
}

/**
 * @title Launch GHO on Plasma & Set ACI as Emissions Manager for Rewards
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xeb3572580924976867073ad9c8012cb9e52093c76dafebd7d3aebf318f2576fb
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-plasma-set-aci-as-emissions-manager-for-rewards/22994
 */
contract AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930 is
  IProposalGenericExecutor
{
  // OwnableFacilitator Constants
  address public constant OWNABLE_FACILITATOR = address(0);
  string public constant OWNABLE_FACILITATOR_NAME = 'OwnableFacilitator GHO L2 Bridging';
  uint128 public constant OWNABLE_FACILITATOR_CAPACITY = 100_000_000 ether;

  // Plasma Bridge Constants
  address public constant CCIP_BRIDGE = address(0);
  uint256 public constant PLASMA_BRIDGE_AMOUNT = 0;

  function execute() external {
    IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).addFacilitator(
      OWNABLE_FACILITATOR,
      OWNABLE_FACILITATOR_NAME,
      OWNABLE_FACILITATOR_CAPACITY
    );

    IOwnableFacilitator(OWNABLE_FACILITATOR).mint(CCIP_BRIDGE, PLASMA_BRIDGE_AMOUNT);

    uint256 fee = IAaveGhoCcipBridge(CCIP_BRIDGE).quoteBridge(
      CCIPChainSelectors.PLASMA_SELECTOR,
      PLASMA_BRIDGE_AMOUNT,
      AaveV3EthereumAssets.GHO_UNDERLYING
    );
  }
}
