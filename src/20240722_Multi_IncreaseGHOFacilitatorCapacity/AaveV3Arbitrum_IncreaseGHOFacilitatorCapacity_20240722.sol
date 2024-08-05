// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {AaveV3PayloadArbitrum} from 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/periphery/contracts/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Increase GHO Facilitator Capacity
 * @author @karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-gho-arb-increase-ccip-facilitator-capacity/18386
 */
contract AaveV3Arbitrum_IncreaseGHOFacilitatorCapacity_20240722 is AaveV3PayloadArbitrum {
  uint256 public constant NEW_SUPPLY_CAP = 5_000_000;
  uint256 public constant NEW_BORROW_CAP = 4_500_000;
  uint128 public constant NEW_LIMIT = 20_000_000 ether;

  function _postExecute() internal override {
    IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).setFacilitatorBucketCapacity(
      MiscArbitrum.GHO_CCIP_TOKEN_POOL,
      NEW_LIMIT
    );
  }

  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](1);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3ArbitrumAssets.GHO_UNDERLYING,
      supplyCap: NEW_SUPPLY_CAP,
      borrowCap: NEW_BORROW_CAP
    });

    return capsUpdate;
  }
}
