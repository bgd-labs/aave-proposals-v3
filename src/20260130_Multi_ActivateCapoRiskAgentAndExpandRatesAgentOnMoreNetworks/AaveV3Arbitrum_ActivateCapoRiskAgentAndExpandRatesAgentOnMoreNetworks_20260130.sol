// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
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
contract AaveV3Arbitrum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130 is
  IProposalGenericExecutor
{
  using CollectorUtils for ICollector;
  using SafeERC20 for IERC20;
  using SafeCast for uint256;

  address public constant RATES_AGENT = 0xc42f40Bc50e7342867Be7F823a4358cba5089063;
  uint96 public constant LINK_AMOUNT = 50 ether;

  function execute() external {
    // 1. register agent on the agent-hub
    uint256 agentId = IAgentHub(MiscArbitrum.AGENT_HUB).registerAgent(
      IAgentConfigurator.AgentRegistrationInput({
        admin: GovernanceV3Arbitrum.EXECUTOR_LVL_1,
        riskOracle: AaveV3Arbitrum.EDGE_RISK_ORACLE,
        isAgentEnabled: true,
        isAgentPermissioned: false,
        isMarketsFromAgentEnabled: false,
        agentAddress: RATES_AGENT,
        expirationPeriod: 8 hours,
        minimumDelay: 8 hours,
        updateType: 'RateStrategyUpdate',
        agentContext: abi.encode(AaveV3Arbitrum.CONFIG_ENGINE),
        allowedMarkets: getAssetsToEnableForRatesAgent(),
        restrictedMarkets: new address[](0), // default
        permissionedSenders: new address[](0) // default
      })
    );

    // 2. configure range on the range-validation-module
    IRangeValidationModule(MiscArbitrum.RANGE_VALIDATION_MODULE).setDefaultRangeConfig(
      MiscArbitrum.AGENT_HUB,
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
    AaveV3Arbitrum.ACL_MANAGER.addRiskAdmin(RATES_AGENT);

    // 4. register new automation for the chaos-agents
    uint256 linkAmount = AaveV3Arbitrum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Arbitrum.POOL),
        underlying: AaveV3ArbitrumAssets.LINK_UNDERLYING,
        amount: LINK_AMOUNT
      }),
      address(this)
    );
    IERC20(AaveV3ArbitrumAssets.LINK_UNDERLYING).forceApprove(
      MiscArbitrum.AAVE_CL_ROBOT_OPERATOR,
      linkAmount
    );
    IAaveCLRobotOperator(MiscArbitrum.AAVE_CL_ROBOT_OPERATOR).register(
      'Interest Rate Agent', // name
      MiscArbitrum.AGENT_HUB_AUTOMATION, // upkeepContract
      _encodeAgentIdToBytes(agentId), // upkeepCheckData
      5_000_000, // gasLimit
      linkAmount.toUint96(), // amountToFund
      0, // triggerType
      '' // triggerConfig
    );
  }

  function getAssetsToEnableForRatesAgent() public pure returns (address[] memory) {
    address[] memory markets = new address[](3);
    markets[0] = AaveV3ArbitrumAssets.USDCn_UNDERLYING;
    markets[1] = AaveV3ArbitrumAssets.USDT_UNDERLYING;
    markets[2] = AaveV3ArbitrumAssets.WETH_UNDERLYING;

    return markets;
  }

  function _encodeAgentIdToBytes(uint256 agentId) internal pure returns (bytes memory) {
    uint256[] memory agentIds = new uint256[](1);
    agentIds[0] = agentId;
    return abi.encode(agentIds);
  }
}
