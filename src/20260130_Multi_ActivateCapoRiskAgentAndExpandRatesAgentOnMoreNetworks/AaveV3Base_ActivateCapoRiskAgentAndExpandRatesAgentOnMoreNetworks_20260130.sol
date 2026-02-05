// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {GovernanceV3Base} from 'aave-address-book/GovernanceV3Base.sol';
import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {MiscBase} from 'aave-address-book/MiscBase.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';
import {IAgentHub, IAgentConfigurator} from '../interfaces/IAgentHub.sol';
import {IRangeValidationModule} from '../interfaces/IRangeValidationModule.sol';

/**
 * @title Activate Capo Risk Agent and expand Rates Agent on more networks
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x66aa6904f140d56ada880f45c911994c5c6cc20109b55081f508ccdd6417066d
 * - Discussion: https://governance.aave.com/t/arfc-dynamic-calibration-of-capo-parameters-via-risk-oracles/22601
 */
contract AaveV3Base_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130 is
  IProposalGenericExecutor
{
  using SafeERC20 for IERC20;

  address public constant RATES_AGENT = 0xAD83c71619368390c4C4fd1Aa472235FD4Ea3F32;
  address public constant LINK_TOKEN = 0x88Fb150BDc53A65fe94Dea0c9BA0a6dAf8C6e196;
  uint96 public constant LINK_AMOUNT = 30 ether;

  function execute() external {
    // 1. register agent on the agent-hub
    uint256 agentId = IAgentHub(MiscBase.AGENT_HUB).registerAgent(
      IAgentConfigurator.AgentRegistrationInput({
        admin: GovernanceV3Base.EXECUTOR_LVL_1,
        riskOracle: AaveV3Base.EDGE_RISK_ORACLE,
        isAgentEnabled: true,
        isAgentPermissioned: false,
        isMarketsFromAgentEnabled: false,
        agentAddress: RATES_AGENT,
        expirationPeriod: 8 hours,
        minimumDelay: 8 hours,
        updateType: 'RateStrategyUpdate',
        agentContext: abi.encode(AaveV3Base.CONFIG_ENGINE),
        allowedMarkets: getAssetsToEnableForRatesAgent(),
        restrictedMarkets: new address[](0), // default
        permissionedSenders: new address[](0) // default
      })
    );

    // 2. configure range on the range-validation-module
    IRangeValidationModule(MiscBase.RANGE_VALIDATION_MODULE).setDefaultRangeConfig(
      MiscBase.AGENT_HUB,
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
    AaveV3Base.ACL_MANAGER.addRiskAdmin(RATES_AGENT);

    // 4. register new automation for the chaos-agents
    IERC20(LINK_TOKEN).forceApprove(MiscBase.AAVE_CL_ROBOT_OPERATOR, LINK_AMOUNT);
    IAaveCLRobotOperator(MiscBase.AAVE_CL_ROBOT_OPERATOR).register(
      'Interest Rate Agent', // name
      MiscBase.AGENT_HUB_AUTOMATION, // upkeepContract
      _encodeAgentIdToBytes(agentId), // upkeepCheckData
      5_000_000, // gasLimit
      LINK_AMOUNT, // amountToFund
      0, // triggerType
      '' // triggerConfig
    );
  }

  function getAssetsToEnableForRatesAgent() public pure returns (address[] memory) {
    address[] memory markets = new address[](2);
    markets[0] = AaveV3BaseAssets.USDC_UNDERLYING;
    markets[1] = AaveV3BaseAssets.WETH_UNDERLYING;

    return markets;
  }

  function _encodeAgentIdToBytes(uint256 agentId) internal pure returns (bytes memory) {
    uint256[] memory agentIds = new uint256[](1);
    agentIds[0] = agentId;
    return abi.encode(agentIds);
  }
}
