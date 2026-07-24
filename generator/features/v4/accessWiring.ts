import {V4TargetFunctionRoleUpdate} from '../types';

/// The 7 Spoke selectors mapped to SPOKE_CONFIGURATOR_ROLE, in the order returned by
/// Roles.getSpokeConfiguratorRoleSelectors(); used for generated wiring assertions.
const SPOKE_CONFIGURATOR_SELECTORS = [
  'ISpoke.updateLiquidationConfig.selector',
  'ISpoke.addReserve.selector',
  'ISpoke.updateReserveConfig.selector',
  'ISpoke.updateDynamicReserveConfig.selector',
  'ISpoke.addDynamicReserveConfig.selector',
  'ISpoke.updatePositionManager.selector',
  'ISpoke.updateReservePriceSource.selector',
];

/// AccessManager wiring granting SPOKE_CONFIGURATOR_ROLE the SpokeConfigurator
/// selectors on a freshly deployed Spoke, so the payload can configure it.
export function spokeConfiguratorWiring(spokeExpr: string): V4TargetFunctionRoleUpdate {
  return {
    target: spokeExpr,
    selectors: [],
    selectorsExpr: 'Roles.getSpokeConfiguratorRoleSelectors()',
    roleId: 'Roles.SPOKE_CONFIGURATOR_ROLE',
    selectorAsserts: SPOKE_CONFIGURATOR_SELECTORS,
  };
}

/// AccessManager wiring granting HUB_CONFIGURATOR_ROLE the HubConfigurator
/// selectors on a freshly deployed Hub.
export function hubConfiguratorWiring(hubExpr: string): V4TargetFunctionRoleUpdate {
  return {
    target: hubExpr,
    selectors: [],
    selectorsExpr: 'Roles.getHubConfiguratorRoleSelectors()',
    roleId: 'Roles.HUB_CONFIGURATOR_ROLE',
  };
}
