// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovernanceV3InkWhitelabel} from 'aave-address-book/GovernanceV3InkWhitelabel.sol';

import {EthereumScript, PolygonScript, AvalancheScript, ArbitrumScript, OptimismScript, BaseScript, BNBScript, ScrollScript, GnosisScript, LineaScript, SonicScript, CeloScript, InkScript, PlasmaScript, MantleScript, MegaEthScript, XLayerScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {Deployments} from './Deployments.sol';
import {AaveV3Ethereum_RiskStewardsUpdate_20260331} from './AaveV3Ethereum_RiskStewardsUpdate_20260331.sol';
import {AaveV3Polygon_RiskStewardsUpdate_20260331} from './AaveV3Polygon_RiskStewardsUpdate_20260331.sol';
import {AaveV3Avalanche_RiskStewardsUpdate_20260331} from './AaveV3Avalanche_RiskStewardsUpdate_20260331.sol';
import {AaveV3Arbitrum_RiskStewardsUpdate_20260331} from './AaveV3Arbitrum_RiskStewardsUpdate_20260331.sol';
import {AaveV3Optimism_RiskStewardsUpdate_20260331} from './AaveV3Optimism_RiskStewardsUpdate_20260331.sol';
import {AaveV3Base_RiskStewardsUpdate_20260331} from './AaveV3Base_RiskStewardsUpdate_20260331.sol';
import {AaveV3BNB_RiskStewardsUpdate_20260331} from './AaveV3BNB_RiskStewardsUpdate_20260331.sol';
import {AaveV3Scroll_RiskStewardsUpdate_20260331} from './AaveV3Scroll_RiskStewardsUpdate_20260331.sol';
import {AaveV3Gnosis_RiskStewardsUpdate_20260331} from './AaveV3Gnosis_RiskStewardsUpdate_20260331.sol';
import {AaveV3Linea_RiskStewardsUpdate_20260331} from './AaveV3Linea_RiskStewardsUpdate_20260331.sol';
import {AaveV3Sonic_RiskStewardsUpdate_20260331} from './AaveV3Sonic_RiskStewardsUpdate_20260331.sol';
import {AaveV3Celo_RiskStewardsUpdate_20260331} from './AaveV3Celo_RiskStewardsUpdate_20260331.sol';
import {AaveV3Ink_RiskStewardsUpdate_20260331} from './AaveV3Ink_RiskStewardsUpdate_20260331.sol';
import {AaveV3Plasma_RiskStewardsUpdate_20260331} from './AaveV3Plasma_RiskStewardsUpdate_20260331.sol';
import {AaveV3Mantle_RiskStewardsUpdate_20260331} from './AaveV3Mantle_RiskStewardsUpdate_20260331.sol';
import {AaveV3MegaEth_RiskStewardsUpdate_20260331} from './AaveV3MegaEth_RiskStewardsUpdate_20260331.sol';
import {AaveV3XLayer_RiskStewardsUpdate_20260331} from './AaveV3XLayer_RiskStewardsUpdate_20260331.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/UpgradeAaveInstancesToV37Part2_20260331.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    address riskStewardsUpdate = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_RiskStewardsUpdate_20260331).creationCode
    );

    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](3);
    actions[0] = GovV3Helpers.buildAction(Deployments.MAINNET_LIDO);
    actions[1] = GovV3Helpers.buildAction(Deployments.MAINNET_CORE);
    actions[2] = GovV3Helpers.buildAction(riskStewardsUpdate);

    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Polygon
 * deploy-command: make deploy-ledger contract=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/UpgradeAaveInstancesToV37Part2_20260331.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    address riskStewardsUpdate = GovV3Helpers.deployDeterministic(
      type(AaveV3Polygon_RiskStewardsUpdate_20260331).creationCode
    );

    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](2);
    actions[0] = GovV3Helpers.buildAction(Deployments.POLYGON);
    actions[1] = GovV3Helpers.buildAction(riskStewardsUpdate);

    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Avalanche
 * deploy-command: make deploy-ledger contract=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/UpgradeAaveInstancesToV37Part2_20260331.s.sol:DeployAvalanche chain=avalanche
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    address riskStewardsUpdate = GovV3Helpers.deployDeterministic(
      type(AaveV3Avalanche_RiskStewardsUpdate_20260331).creationCode
    );

    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](2);
    actions[0] = GovV3Helpers.buildAction(Deployments.AVALANCHE);
    actions[1] = GovV3Helpers.buildAction(riskStewardsUpdate);

    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Arbitrum
 * deploy-command: make deploy-ledger contract=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/UpgradeAaveInstancesToV37Part2_20260331.s.sol:DeployArbitrum chain=arbitrum
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    address riskStewardsUpdate = GovV3Helpers.deployDeterministic(
      type(AaveV3Arbitrum_RiskStewardsUpdate_20260331).creationCode
    );

    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](2);
    actions[0] = GovV3Helpers.buildAction(Deployments.ARBITRUM);
    actions[1] = GovV3Helpers.buildAction(riskStewardsUpdate);

    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Optimism
 * deploy-command: make deploy-ledger contract=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/UpgradeAaveInstancesToV37Part2_20260331.s.sol:DeployOptimism chain=optimism
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    address riskStewardsUpdate = GovV3Helpers.deployDeterministic(
      type(AaveV3Optimism_RiskStewardsUpdate_20260331).creationCode
    );

    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(riskStewardsUpdate);

    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Base
 * deploy-command: make deploy-ledger contract=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/UpgradeAaveInstancesToV37Part2_20260331.s.sol:DeployBase chain=base
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    address riskStewardsUpdate = GovV3Helpers.deployDeterministic(
      type(AaveV3Base_RiskStewardsUpdate_20260331).creationCode
    );

    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](2);
    actions[0] = GovV3Helpers.buildAction(Deployments.BASE);
    actions[1] = GovV3Helpers.buildAction(riskStewardsUpdate);

    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy BNB
 * deploy-command: make deploy-ledger contract=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/UpgradeAaveInstancesToV37Part2_20260331.s.sol:DeployBNB chain=bnb
 */
contract DeployBNB is BNBScript {
  function run() external broadcast {
    address riskStewardsUpdate = GovV3Helpers.deployDeterministic(
      type(AaveV3BNB_RiskStewardsUpdate_20260331).creationCode
    );

    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](2);
    actions[0] = GovV3Helpers.buildAction(Deployments.BNB);
    actions[1] = GovV3Helpers.buildAction(riskStewardsUpdate);

    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Scroll
 * deploy-command: make deploy-ledger contract=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/UpgradeAaveInstancesToV37Part2_20260331.s.sol:DeployScroll chain=scroll
 */
contract DeployScroll is ScrollScript {
  function run() external broadcast {
    address riskStewardsUpdate = GovV3Helpers.deployDeterministic(
      type(AaveV3Scroll_RiskStewardsUpdate_20260331).creationCode
    );

    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(riskStewardsUpdate);

    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Gnosis
 * deploy-command: make deploy-ledger contract=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/UpgradeAaveInstancesToV37Part2_20260331.s.sol:DeployGnosis chain=gnosis
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    address riskStewardsUpdate = GovV3Helpers.deployDeterministic(
      type(AaveV3Gnosis_RiskStewardsUpdate_20260331).creationCode
    );

    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(riskStewardsUpdate);

    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Linea
 * deploy-command: make deploy-ledger contract=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/UpgradeAaveInstancesToV37Part2_20260331.s.sol:DeployLinea chain=linea
 */
contract DeployLinea is LineaScript {
  function run() external broadcast {
    address riskStewardsUpdate = GovV3Helpers.deployDeterministic(
      type(AaveV3Linea_RiskStewardsUpdate_20260331).creationCode
    );

    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](2);
    actions[0] = GovV3Helpers.buildAction(Deployments.LINEA);
    actions[1] = GovV3Helpers.buildAction(riskStewardsUpdate);

    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Sonic
 * deploy-command: make deploy-ledger contract=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/UpgradeAaveInstancesToV37Part2_20260331.s.sol:DeploySonic chain=sonic
 */
contract DeploySonic is SonicScript {
  function run() external broadcast {
    address riskStewardsUpdate = GovV3Helpers.deployDeterministic(
      type(AaveV3Sonic_RiskStewardsUpdate_20260331).creationCode
    );

    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(riskStewardsUpdate);

    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Celo
 * deploy-command: make deploy-ledger contract=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/UpgradeAaveInstancesToV37Part2_20260331.s.sol:DeployCelo chain=celo
 */
contract DeployCelo is CeloScript {
  function run() external broadcast {
    address riskStewardsUpdate = GovV3Helpers.deployDeterministic(
      type(AaveV3Celo_RiskStewardsUpdate_20260331).creationCode
    );

    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(riskStewardsUpdate);

    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Ink
 * deploy-command: make deploy-ledger contract=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/UpgradeAaveInstancesToV37Part2_20260331.s.sol:DeployInk chain=ink
 */
contract DeployInk is InkScript {
  function run() external broadcast {
    address riskStewardsUpdate = GovV3Helpers.deployDeterministic(
      type(AaveV3Ink_RiskStewardsUpdate_20260331).creationCode
    );

    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](2);

    actions[0] = GovV3Helpers.buildAction(Deployments.INK);
    actions[1] = GovV3Helpers.buildAction(riskStewardsUpdate);

    GovV3Helpers.createPermissionedPayloadCalldata(
      GovernanceV3InkWhitelabel.PERMISSIONED_PAYLOADS_CONTROLLER,
      actions
    );
  }
}

/**
 * @dev Deploy Plasma
 * deploy-command: make deploy-ledger contract=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/UpgradeAaveInstancesToV37Part2_20260331.s.sol:DeployPlasma chain=plasma
 */
contract DeployPlasma is PlasmaScript {
  function run() external broadcast {
    address riskStewardsUpdate = GovV3Helpers.deployDeterministic(
      type(AaveV3Plasma_RiskStewardsUpdate_20260331).creationCode
    );

    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](2);
    actions[0] = GovV3Helpers.buildAction(Deployments.PLASMA);
    actions[1] = GovV3Helpers.buildAction(riskStewardsUpdate);

    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Mantle
 * deploy-command: make deploy-ledger contract=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/UpgradeAaveInstancesToV37Part2_20260331.s.sol:DeployMantle chain=mantle
 */
contract DeployMantle is MantleScript {
  function run() external broadcast {
    address riskStewardsUpdate = GovV3Helpers.deployDeterministic(
      type(AaveV3Mantle_RiskStewardsUpdate_20260331).creationCode
    );

    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](2);
    actions[0] = GovV3Helpers.buildAction(Deployments.MANTLE);
    actions[1] = GovV3Helpers.buildAction(riskStewardsUpdate);

    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy MegaEth
 * deploy-command: make deploy-ledger contract=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/UpgradeAaveInstancesToV37Part2_20260331.s.sol:DeployMegaEth chain=megaeth
 */
contract DeployMegaEth is MegaEthScript {
  function run() external broadcast {
    address riskStewardsUpdate = GovV3Helpers.deployDeterministic(
      type(AaveV3MegaEth_RiskStewardsUpdate_20260331).creationCode
    );

    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(riskStewardsUpdate);

    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy XLayer
 * deploy-command: make deploy-ledger contract=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/UpgradeAaveInstancesToV37Part2_20260331.s.sol:DeployXLayer chain=xlayer
 */
contract DeployXLayer is XLayerScript {
  function run() external broadcast {
    address riskStewardsUpdate = GovV3Helpers.deployDeterministic(
      type(AaveV3XLayer_RiskStewardsUpdate_20260331).creationCode
    );

    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(riskStewardsUpdate);

    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/UpgradeAaveInstancesToV37Part2_20260331.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](16);

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](3);
      actionsEthereum[0] = GovV3Helpers.buildAction(Deployments.MAINNET_LIDO);
      actionsEthereum[1] = GovV3Helpers.buildAction(Deployments.MAINNET_CORE);
      actionsEthereum[2] = GovV3Helpers.buildAction(
        type(AaveV3Ethereum_RiskStewardsUpdate_20260331).creationCode
      );
      payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](2);
      actionsPolygon[0] = GovV3Helpers.buildAction(Deployments.POLYGON);
      actionsPolygon[1] = GovV3Helpers.buildAction(
        type(AaveV3Polygon_RiskStewardsUpdate_20260331).creationCode
      );
      payloads[1] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](2);
      actionsAvalanche[0] = GovV3Helpers.buildAction(Deployments.AVALANCHE);
      actionsAvalanche[1] = GovV3Helpers.buildAction(
        type(AaveV3Avalanche_RiskStewardsUpdate_20260331).creationCode
      );
      payloads[2] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](2);
      actionsArbitrum[0] = GovV3Helpers.buildAction(Deployments.ARBITRUM);
      actionsArbitrum[1] = GovV3Helpers.buildAction(
        type(AaveV3Arbitrum_RiskStewardsUpdate_20260331).creationCode
      );
      payloads[3] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsOptimism[0] = GovV3Helpers.buildAction(
        type(AaveV3Optimism_RiskStewardsUpdate_20260331).creationCode
      );
      payloads[4] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](2);
      actionsBase[0] = GovV3Helpers.buildAction(Deployments.BASE);
      actionsBase[1] = GovV3Helpers.buildAction(
        type(AaveV3Base_RiskStewardsUpdate_20260331).creationCode
      );
      payloads[5] = GovV3Helpers.buildBasePayload(vm, actionsBase);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsBNB = new IPayloadsControllerCore.ExecutionAction[](2);
      actionsBNB[0] = GovV3Helpers.buildAction(Deployments.BNB);
      actionsBNB[1] = GovV3Helpers.buildAction(
        type(AaveV3BNB_RiskStewardsUpdate_20260331).creationCode
      );
      payloads[6] = GovV3Helpers.buildBNBPayload(vm, actionsBNB);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsScroll = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsScroll[0] = GovV3Helpers.buildAction(
        type(AaveV3Scroll_RiskStewardsUpdate_20260331).creationCode
      );
      payloads[7] = GovV3Helpers.buildScrollPayload(vm, actionsScroll);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsGnosis[0] = GovV3Helpers.buildAction(
        type(AaveV3Gnosis_RiskStewardsUpdate_20260331).creationCode
      );
      payloads[8] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsLinea = new IPayloadsControllerCore.ExecutionAction[](2);
      actionsLinea[0] = GovV3Helpers.buildAction(Deployments.LINEA);
      actionsLinea[1] = GovV3Helpers.buildAction(
        type(AaveV3Linea_RiskStewardsUpdate_20260331).creationCode
      );
      payloads[9] = GovV3Helpers.buildLineaPayload(vm, actionsLinea);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsSonic = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsSonic[0] = GovV3Helpers.buildAction(
        type(AaveV3Sonic_RiskStewardsUpdate_20260331).creationCode
      );
      payloads[10] = GovV3Helpers.buildSonicPayload(vm, actionsSonic);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsCelo = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsCelo[0] = GovV3Helpers.buildAction(
        type(AaveV3Celo_RiskStewardsUpdate_20260331).creationCode
      );
      payloads[11] = GovV3Helpers.buildCeloPayload(vm, actionsCelo);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsPlasma = new IPayloadsControllerCore.ExecutionAction[](2);
      actionsPlasma[0] = GovV3Helpers.buildAction(Deployments.PLASMA);
      actionsPlasma[1] = GovV3Helpers.buildAction(
        type(AaveV3Plasma_RiskStewardsUpdate_20260331).creationCode
      );
      payloads[12] = GovV3Helpers.buildPlasmaPayload(vm, actionsPlasma);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsMantle = new IPayloadsControllerCore.ExecutionAction[](2);
      actionsMantle[0] = GovV3Helpers.buildAction(Deployments.MANTLE);
      actionsMantle[1] = GovV3Helpers.buildAction(
        type(AaveV3Mantle_RiskStewardsUpdate_20260331).creationCode
      );
      payloads[13] = GovV3Helpers.buildMantlePayload(vm, actionsMantle);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsMegaEth = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsMegaEth[0] = GovV3Helpers.buildAction(
        type(AaveV3MegaEth_RiskStewardsUpdate_20260331).creationCode
      );
      payloads[14] = GovV3Helpers.buildMegaEthPayload(vm, actionsMegaEth);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsXLayer = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsXLayer[0] = GovV3Helpers.buildAction(
        type(AaveV3XLayer_RiskStewardsUpdate_20260331).creationCode
      );
      payloads[15] = GovV3Helpers.buildXLayerPayload(vm, actionsXLayer);
    }

    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20260331_Multi_UpgradeAaveInstancesToV37Part2/UpgradeAaveInstancesToV37Part2.md'
      )
    );
  }
}
