// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title PYUSD Reserve Configuration Update & Incentive Campaign
 * @author karpatkey_TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xcd73f17361c7757cd94ec758b4d9f160b7cecefa7f4cb23b0b4ee49b5eb1b8b2
 * - Discussion: https://governance.aave.com/t/arfc-pyusd-reserve-configuration-update-incentive-campaign/19573
 */
contract AaveV3Ethereum_PYUSDReserveConfigurationUpdateIncentiveCampaign_20241031 is
  AaveV3PayloadEthereum
{
  address public constant ALC_SAFE = 0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b;
  address public constant ACI_TREASURY = 0xac140648435d03f784879cd789130F22Ef588Fcd;
  uint256 public constant GHO_AMOUNT = 300_000 ether;

  function _postExecute() internal override {
    AaveV3Ethereum.COLLECTOR.approve(AaveV3EthereumAssets.GHO_UNDERLYING, ALC_SAFE, GHO_AMOUNT);

    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(
      AaveV3EthereumAssets.PYUSD_UNDERLYING,
      ACI_TREASURY
    );
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(
      AaveV3EthereumAssets.PYUSD_A_TOKEN,
      ACI_TREASURY
    );
  }

  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](1);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.PYUSD_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 15_000_000
    });

    return capsUpdate;
  }

  function collateralsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[]
      memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](1);

    collateralUpdate[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3EthereumAssets.PYUSD_UNDERLYING,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 7_50,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: 10_00
    });

    return collateralUpdate;
  }
}
