// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GHOLaunch} from '../helpers/gho-launch/AaveV3GHOLaunch.sol';
import {GhoCCIPChains} from '../helpers/gho-launch/constants/GhoCCIPChains.sol';

/**
 * @title Gho Monad Launch
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x24f105bd023c476a9b85fa87ff795bfeec769fa799ce6ada8e2724c9738049f6
 * - Discussion: https://governance.aave.com/t/arfc-deploy-aave-protocol-on-monad/24943
 */
contract AaveV3Monad_GhoMonadActivation_20260518 is AaveV3GHOLaunch {
  constructor() AaveV3GHOLaunch(GhoCCIPChains.MONAD()) {}
}
