// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV4Avalanche} from 'aave-address-book/AaveV4Avalanche.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {IRiskStewardV4} from 'src/interfaces/IRiskStewardV4.sol';

/**
 * @title AaveV4RiskStewardsActivation
 * @author Aave Labs
 * - Snapshot: Direct-to-AIP
 * - Discussion: TODO
 */
contract AaveV4Avalanche_AaveV4RiskStewardsActivation_20260807 is IProposalGenericExecutor {
  // https://snowscan.xyz/address/0xd8d7AbC42c1c938BdEC94fF8da1b3cd5b7e3b107
  address public constant RISK_STEWARD = 0xd8d7AbC42c1c938BdEC94fF8da1b3cd5b7e3b107;

  function execute() external override {
    _grantConfiguratorRoles();
    IRiskStewardV4(RISK_STEWARD).setConfig(_riskStewardConfig());
  }

  function _grantConfiguratorRoles() internal {
    AaveV4Avalanche.ACCESS_MANAGER.grantRole({
      roleId: Roles.HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE,
      account: RISK_STEWARD,
      executionDelay: 0
    });
    AaveV4Avalanche.ACCESS_MANAGER.grantRole({
      roleId: Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE,
      account: RISK_STEWARD,
      executionDelay: 0
    });
  }

  function _riskStewardConfig() internal pure returns (IRiskStewardV4.Config memory) {
    return
      IRiskStewardV4.Config({
        hub: IRiskStewardV4.HubConfig({
          configurator: AaveV4Avalanche.HUB_CONFIGURATOR,
          rate: IRiskStewardV4.HubRateConfig({
            optimalUsageRatio: IRiskStewardV4.RiskParamConfig({
              minDelay: 36 hours,
              maxPercentChange: 3_00,
              isChangeRelative: false
            }),
            baseDrawnRate: IRiskStewardV4.RiskParamConfig({
              minDelay: 36 hours,
              maxPercentChange: 3_00,
              isChangeRelative: false
            }),
            rateGrowthBeforeOptimal: IRiskStewardV4.RiskParamConfig({
              minDelay: 36 hours,
              maxPercentChange: 3_00,
              isChangeRelative: false
            }),
            rateGrowthAfterOptimal: IRiskStewardV4.RiskParamConfig({
              minDelay: 36 hours,
              maxPercentChange: 20_00,
              isChangeRelative: false
            })
          }),
          cap: IRiskStewardV4.HubCapConfig({
            addCap: IRiskStewardV4.RiskParamConfig({
              minDelay: 36 hours,
              maxPercentChange: 100_00,
              isChangeRelative: true
            }),
            drawCap: IRiskStewardV4.RiskParamConfig({
              minDelay: 36 hours,
              maxPercentChange: 100_00,
              isChangeRelative: true
            })
          })
        }),
        spoke: IRiskStewardV4.SpokeConfig({
          configurator: AaveV4Avalanche.SPOKE_CONFIGURATOR,
          collateralRisk: IRiskStewardV4.RiskParamConfig({
            minDelay: 36 hours,
            maxPercentChange: 300_00,
            isChangeRelative: false
          }),
          dynamicUpdate: IRiskStewardV4.SpokeDynamicConfig({
            collateralFactor: IRiskStewardV4.RiskParamConfig({
              minDelay: 72 hours,
              maxPercentChange: 50,
              isChangeRelative: false
            }),
            maxLiquidationBonus: IRiskStewardV4.RiskParamConfig({
              minDelay: 72 hours,
              maxPercentChange: 50,
              isChangeRelative: false
            })
          }),
          dynamicAdd: IRiskStewardV4.SpokeDynamicConfig({
            collateralFactor: IRiskStewardV4.RiskParamConfig({
              minDelay: 72 hours,
              maxPercentChange: 100_00,
              isChangeRelative: false
            }),
            maxLiquidationBonus: IRiskStewardV4.RiskParamConfig({
              minDelay: 72 hours,
              maxPercentChange: 50,
              isChangeRelative: false
            })
          }),
          liquidation: IRiskStewardV4.SpokeLiquidationConfig({
            targetHealthFactor: IRiskStewardV4.RiskParamConfig({
              minDelay: 72 hours,
              maxPercentChange: 5_00,
              isChangeRelative: true
            }),
            healthFactorForMaxBonus: IRiskStewardV4.RiskParamConfig({
              minDelay: 72 hours,
              maxPercentChange: 5_00,
              isChangeRelative: true
            }),
            liquidationBonusFactor: IRiskStewardV4.RiskParamConfig({
              minDelay: 72 hours,
              maxPercentChange: 5_00,
              isChangeRelative: false
            })
          })
        }),
        oracle: IRiskStewardV4.OracleConfig({
          priceCapLst: IRiskStewardV4.RiskParamConfig({
            minDelay: 72 hours,
            maxPercentChange: 5_00,
            isChangeRelative: true
          }),
          priceCapStable: IRiskStewardV4.RiskParamConfig({
            minDelay: 72 hours,
            maxPercentChange: 50,
            isChangeRelative: true
          }),
          discountRatePendle: IRiskStewardV4.RiskParamConfig({
            minDelay: 48 hours,
            maxPercentChange: 0.025e18,
            isChangeRelative: false
          })
        })
      });
  }
}
