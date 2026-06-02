// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GuardianEnabledFlag} from './GuardianEnabledFlag.sol';
import {LiquidateRsETHConstants} from '../LiquidateRsETHConstants.sol';
import {EthereumScript, ArbitrumScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';

// make deploy-account contract=src/20260423_Multi_LiquidateRsETHPositions/setup/guardian-enabled-flag/GuardianEnabledFlag.s.sol:DeployGuardianEnabledFlagEthereum chain=mainnet
contract DeployGuardianEnabledFlagEthereum is EthereumScript {
  function run() external broadcast {
    new GuardianEnabledFlag(LiquidateRsETHConstants.ETH_RECOVERY_GUARDIAN);
  }
}

// make deploy-account contract=src/20260423_Multi_LiquidateRsETHPositions/setup/guardian-enabled-flag/GuardianEnabledFlag.s.sol:DeployGuardianEnabledFlagArbitrum chain=arbitrum
contract DeployGuardianEnabledFlagArbitrum is ArbitrumScript {
  function run() external broadcast {
    new GuardianEnabledFlag(LiquidateRsETHConstants.ARB_RECOVERY_GUARDIAN);
  }
}
