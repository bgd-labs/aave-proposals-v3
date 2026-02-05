// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {SafeCast} from 'openzeppelin-contracts/contracts/utils/math/SafeCast.sol';
import {ICollector, CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';

import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';
import {IAgentHub, IAgentConfigurator} from '../interfaces/IAgentHub.sol';
import {IRangeValidationModule} from '../interfaces/IRangeValidationModule.sol';

/**
 * @title Activate Capo Risk Agent and expand Rates Agent on more networks
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x66aa6904f140d56ada880f45c911994c5c6cc20109b55081f508ccdd6417066d
 * - Discussion: https://governance.aave.com/t/arfc-dynamic-calibration-of-capo-parameters-via-risk-oracles/22601
 */
contract AaveV3Avalanche_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130 is
  IProposalGenericExecutor
{
  using CollectorUtils for ICollector;
  using SafeERC20 for IERC20;
  using SafeCast for uint256;

  address public constant RATES_AGENT = 0x72b89100DB6f0Bde118Ebb34E71FA95A6DC59038;
  uint96 public constant LINK_AMOUNT = 50 ether;

  function execute() external {
    // 1. register agent on the agent-hub
    uint256 agentId = IAgentHub(MiscAvalanche.AGENT_HUB).registerAgent(
      IAgentConfigurator.AgentRegistrationInput({
        admin: GovernanceV3Avalanche.EXECUTOR_LVL_1,
        riskOracle: AaveV3Avalanche.EDGE_RISK_ORACLE,
        isAgentEnabled: true,
        isAgentPermissioned: false,
        isMarketsFromAgentEnabled: false,
        agentAddress: RATES_AGENT,
        expirationPeriod: 8 hours,
        minimumDelay: 8 hours,
        updateType: 'RateStrategyUpdate',
        agentContext: abi.encode(AaveV3Avalanche.CONFIG_ENGINE),
        allowedMarkets: getAssetsToEnableForRatesAgent(),
        restrictedMarkets: new address[](0), // default
        permissionedSenders: new address[](0) // default
      })
    );

    // 2. configure range on the range-validation-module
    IRangeValidationModule(MiscAvalanche.RANGE_VALIDATION_MODULE).setDefaultRangeConfig(
      MiscAvalanche.AGENT_HUB,
      agentId,
      'VariableRateSlope2',
      IRangeValidationModule.RangeConfig({
        maxIncrease: 4_00, // 4% increase
        maxDecrease: 4_00, // 4% decrease
        isIncreaseRelative: false,
        isDecreaseRelative: false
      })
    );

    // 3. give permissions to new agent contracts
    AaveV3Avalanche.ACL_MANAGER.addRiskAdmin(RATES_AGENT);

    // 4. register new automation for the chaos-agents
    uint256 linkAmount = AaveV3Avalanche.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Avalanche.POOL),
        underlying: AaveV3AvalancheAssets.LINKe_UNDERLYING,
        amount: LINK_AMOUNT
      }),
      address(this)
    );
    IERC20(AaveV3AvalancheAssets.LINKe_UNDERLYING).forceApprove(
      MiscAvalanche.AAVE_CL_ROBOT_OPERATOR,
      linkAmount
    );
    IAaveCLRobotOperator(MiscAvalanche.AAVE_CL_ROBOT_OPERATOR).register(
      'Interest Rate Agent', // name
      MiscAvalanche.AGENT_HUB_AUTOMATION, // upkeepContract
      _encodeAgentIdToBytes(agentId), // upkeepCheckData
      5_000_000, // gasLimit
      linkAmount.toUint96(), // amountToFund
      0, // triggerType
      '' // triggerConfig
    );
  }

  function getAssetsToEnableForRatesAgent() public pure returns (address[] memory) {
    address[] memory markets = new address[](3);
    markets[0] = AaveV3AvalancheAssets.USDC_UNDERLYING;
    markets[1] = AaveV3AvalancheAssets.USDt_UNDERLYING;
    markets[2] = AaveV3AvalancheAssets.WETHe_UNDERLYING;

    return markets;
  }

  function _encodeAgentIdToBytes(uint256 agentId) internal pure returns (bytes memory) {
    uint256[] memory agentIds = new uint256[](1);
    agentIds[0] = agentId;
    return abi.encode(agentIds);
  }
}
