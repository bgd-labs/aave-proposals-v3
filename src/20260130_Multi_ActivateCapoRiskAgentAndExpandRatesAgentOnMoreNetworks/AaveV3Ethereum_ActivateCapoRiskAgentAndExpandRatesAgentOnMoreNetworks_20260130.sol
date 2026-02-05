// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ICollector, CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {SafeCast} from 'openzeppelin-contracts/contracts/utils/math/SafeCast.sol';

import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';
import {IAgentHub, IAgentConfigurator} from '../interfaces/IAgentHub.sol';
import {IRangeValidationModule} from '../interfaces/IRangeValidationModule.sol';

/**
 * @title Activate Capo Risk Agent and expand Rates Agent on more networks
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x66aa6904f140d56ada880f45c911994c5c6cc20109b55081f508ccdd6417066d
 * - Discussion: https://governance.aave.com/t/arfc-dynamic-calibration-of-capo-parameters-via-risk-oracles/22601
 */
contract AaveV3Ethereum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130 is
  IProposalGenericExecutor
{
  using CollectorUtils for ICollector;
  using SafeERC20 for IERC20;
  using SafeCast for uint256;

  address public constant CAPO_AGENT = 0xCc18Be380838956aad41FD22466085eD66aaBB46;
  uint96 public constant LINK_AMOUNT = 200 ether;

  function execute() external {
    // 1. register agent on the agent-hub
    uint256 agentId = IAgentHub(MiscEthereum.AGENT_HUB).registerAgent(
      IAgentConfigurator.AgentRegistrationInput({
        admin: GovernanceV3Ethereum.EXECUTOR_LVL_1,
        riskOracle: AaveV3Ethereum.EDGE_RISK_ORACLE,
        isAgentEnabled: true,
        isAgentPermissioned: false,
        isMarketsFromAgentEnabled: false,
        agentAddress: CAPO_AGENT,
        expirationPeriod: 3 days,
        minimumDelay: 3 days,
        updateType: 'CapoPriceCapUpdate_Core',
        agentContext: '',
        allowedMarkets: getAssetsToEnableForCapoAgent(),
        restrictedMarkets: new address[](0), // default
        permissionedSenders: new address[](0) // default
      })
    );

    // 2. configure range on the range-validation-module
    IRangeValidationModule(MiscEthereum.RANGE_VALIDATION_MODULE).setDefaultRangeConfig(
      MiscEthereum.AGENT_HUB,
      agentId,
      'CapoSnapshotRatio',
      IRangeValidationModule.RangeConfig({
        maxIncrease: 3_00, // 3%
        maxDecrease: 3_00, // 3%
        isIncreaseRelative: true,
        isDecreaseRelative: true
      })
    );
    IRangeValidationModule(MiscEthereum.RANGE_VALIDATION_MODULE).setDefaultRangeConfig(
      MiscEthereum.AGENT_HUB,
      agentId,
      'CapoMaxYearlyGrowthRatePercent',
      IRangeValidationModule.RangeConfig({
        maxIncrease: 10_00, // 10%
        maxDecrease: 10_00, // 10%
        isIncreaseRelative: true,
        isDecreaseRelative: true
      })
    );

    // 3. give permissions to new agent contracts
    AaveV3Ethereum.ACL_MANAGER.addRiskAdmin(CAPO_AGENT);
    AaveV3EthereumLido.ACL_MANAGER.addRiskAdmin(CAPO_AGENT); // as on ezETH we're using same capo on lido and core

    // 4. register new automation for the chaos-agents
    uint256 linkAmount = AaveV3Ethereum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.LINK_UNDERLYING,
        amount: LINK_AMOUNT
      }),
      address(this)
    );
    IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).forceApprove(
      MiscEthereum.AAVE_CL_ROBOT_OPERATOR,
      linkAmount
    );
    IAaveCLRobotOperator(MiscEthereum.AAVE_CL_ROBOT_OPERATOR).register(
      'Core Capo Agent', // name
      MiscEthereum.AGENT_HUB_AUTOMATION, // upkeepContract
      _encodeAgentIdToBytes(agentId), // upkeepCheckData
      5_000_000, // gasLimit
      linkAmount.toUint96(), // amountToFund
      0, // triggerType
      '' // triggerConfig
    );
  }

  function getAssetsToEnableForCapoAgent() public pure returns (address[] memory) {
    address[] memory markets = new address[](14);
    markets[0] = AaveV3EthereumAssets.wstETH_UNDERLYING;
    markets[1] = AaveV3EthereumAssets.weETH_UNDERLYING;
    markets[2] = AaveV3EthereumAssets.rsETH_UNDERLYING;
    markets[3] = AaveV3EthereumAssets.osETH_UNDERLYING;
    markets[4] = AaveV3EthereumAssets.ezETH_UNDERLYING;
    markets[5] = AaveV3EthereumAssets.cbETH_UNDERLYING;
    markets[6] = AaveV3EthereumAssets.rETH_UNDERLYING;
    markets[7] = AaveV3EthereumAssets.tETH_UNDERLYING;
    markets[8] = AaveV3EthereumAssets.ETHx_UNDERLYING;
    markets[9] = AaveV3EthereumAssets.LBTC_UNDERLYING;
    markets[10] = AaveV3EthereumAssets.eBTC_UNDERLYING;
    markets[11] = AaveV3EthereumAssets.sUSDe_UNDERLYING;
    markets[12] = AaveV3EthereumAssets.syrupUSDT_UNDERLYING;
    markets[13] = AaveV3EthereumAssets.sDAI_UNDERLYING;

    return markets;
  }

  function _encodeAgentIdToBytes(uint256 agentId) internal pure returns (bytes memory) {
    uint256[] memory agentIds = new uint256[](1);
    agentIds[0] = agentId;
    return abi.encode(agentIds);
  }
}
