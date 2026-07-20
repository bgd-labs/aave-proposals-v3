// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {UmbrellaEthereum} from 'aave-address-book/UmbrellaEthereum.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';

import {IRiskSteward} from '../interfaces/IRiskSteward.sol';

/**
 * @title Risk Stewards Cooldown Reduction & Umbrella Pauser Role Reassignment
 * @author Llama Risk (implemented by Aave Labs)
 * - Snapshot: https://snapshot.org/#/aavedao.eth/proposal/0x7083921f2f549ffa2cdc294c8ff60fdc82af0becbb7b2f20f4f296c34694aaf2
 * - Discussion: https://governance.aave.com/t/arfc-risk-stewards-cooldown-reduction-umbrella-pauser-role-reassignment/25068
 */
contract AaveV3Ethereum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720 {
  uint40 public constant NEW_MIN_DELAY = 36 hours;
  bytes32 public constant PAUSE_GUARDIAN_ROLE = keccak256('PAUSE_GUARDIAN_ROLE');

  function execute() external {
    IRiskSteward riskSteward = IRiskSteward(AaveV3Ethereum.RISK_STEWARD);
    IRiskSteward.Config memory riskConfig = riskSteward.getRiskConfig();

    riskConfig.rateConfig.baseVariableBorrowRate.minDelay = NEW_MIN_DELAY;
    riskConfig.rateConfig.variableRateSlope1.minDelay = NEW_MIN_DELAY;
    riskConfig.rateConfig.variableRateSlope2.minDelay = NEW_MIN_DELAY;
    riskConfig.rateConfig.optimalUsageRatio.minDelay = NEW_MIN_DELAY;
    riskConfig.capConfig.supplyCap.minDelay = NEW_MIN_DELAY;
    riskConfig.capConfig.borrowCap.minDelay = NEW_MIN_DELAY;

    riskSteward.setRiskConfig(riskConfig);

    IAccessControl(address(UmbrellaEthereum.UMBRELLA)).grantRole(
      PAUSE_GUARDIAN_ROLE,
      MiscEthereum.PROTOCOL_GUARDIAN
    );
  }
}
