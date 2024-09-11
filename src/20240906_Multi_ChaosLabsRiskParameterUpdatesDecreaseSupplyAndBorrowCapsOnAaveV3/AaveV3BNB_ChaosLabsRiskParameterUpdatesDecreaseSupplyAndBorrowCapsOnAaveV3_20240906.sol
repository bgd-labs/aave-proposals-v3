// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNBAssets} from 'aave-address-book/AaveV3BNB.sol';
import {AaveV3PayloadBNB} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadBNB.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-periphery/contracts/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title Chaos Labs Risk Parameter Updates - Decrease Supply and Borrow Caps on Aave V3
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x1ea388307b70d30c040f63e8a09d49276c5c8c9ef2fd809809f253654e5f5f06
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-decrease-supply-and-borrow-caps-on-aave-v3-08-28-2024/18793
 */
contract AaveV3BNB_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906 is
  AaveV3PayloadBNB
{
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](1);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3BNBAssets.USDC_UNDERLYING,
      supplyCap: 15_000_000,
      borrowCap: 10_000_000
    });

    return capsUpdate;
  }
}
