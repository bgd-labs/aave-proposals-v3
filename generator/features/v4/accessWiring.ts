import {MarketIdentifierV4} from '../../types';
import {V4TargetFunctionRoleUpdate} from '../types';
import {getV4Book, spokeLibAccessor} from './marketBook';

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

/// The 2 Spoke selectors mapped to SPOKE_USER_POSITION_UPDATER_ROLE, in the order
/// returned by Roles.getSpokePositionUpdaterRoleSelectors().
const SPOKE_POSITION_UPDATER_SELECTORS = [
  'ISpoke.updateUserDynamicConfig.selector',
  'ISpoke.updateUserRiskPremium.selector',
];

/// An already-wired Spoke of the market, used by generated tests to assert a freshly
/// wired Spoke does not diverge from the canonical selector-to-role mapping.
function referenceSpoke(market: MarketIdentifierV4): string | undefined {
  return getV4Book(market).SPOKES.MAIN_SPOKE ? spokeLibAccessor(market, 'MAIN_SPOKE') : undefined;
}

/// AccessManager wiring a freshly deployed Spoke needs to be configurable by governance
/// and to let the position managers update user positions: the SpokeConfigurator
/// selectors and the user-position-updater selectors, each on its own role.
export function spokeWiring(
  market: MarketIdentifierV4,
  spokeExpr: string,
): V4TargetFunctionRoleUpdate[] {
  const referenceTarget = referenceSpoke(market);
  return [
    {
      target: spokeExpr,
      selectors: [],
      selectorsExpr: 'Roles.getSpokeConfiguratorRoleSelectors()',
      roleId: 'Roles.SPOKE_CONFIGURATOR_ROLE',
      selectorAsserts: SPOKE_CONFIGURATOR_SELECTORS,
      referenceTarget,
    },
    {
      target: spokeExpr,
      selectors: [],
      selectorsExpr: 'Roles.getSpokePositionUpdaterRoleSelectors()',
      roleId: 'Roles.SPOKE_USER_POSITION_UPDATER_ROLE',
      selectorAsserts: SPOKE_POSITION_UPDATER_SELECTORS,
      referenceTarget,
    },
  ];
}

/// The 5 Hub selectors mapped to HUB_CONFIGURATOR_ROLE, in the order returned by
/// Roles.getHubConfiguratorRoleSelectors().
const HUB_CONFIGURATOR_SELECTORS = [
  'IHub.addAsset.selector',
  'IHub.updateAssetConfig.selector',
  'IHub.addSpoke.selector',
  'IHub.updateSpokeConfig.selector',
  'IHub.setInterestRateData.selector',
];

/// AccessManager wiring a freshly deployed Hub needs: the three granular Hub roles
/// that `AaveV4HubRolesProcedure.setupHubAllRoles` maps on a deployment, so a
/// generated Hub does not diverge from the ones already deployed.
export function hubWiring(hubExpr: string): V4TargetFunctionRoleUpdate[] {
  return [
    {
      target: hubExpr,
      selectors: [],
      selectorsExpr: 'Roles.getHubConfiguratorRoleSelectors()',
      roleId: 'Roles.HUB_CONFIGURATOR_ROLE',
      selectorAsserts: HUB_CONFIGURATOR_SELECTORS,
    },
    {
      target: hubExpr,
      selectors: [],
      selectorsExpr: 'Roles.getHubFeeMinterRoleSelectors()',
      roleId: 'Roles.HUB_FEE_MINTER_ROLE',
      selectorAsserts: ['IHub.mintFeeShares.selector'],
    },
    {
      target: hubExpr,
      selectors: [],
      selectorsExpr: 'Roles.getHubDeficitEliminatorRoleSelectors()',
      roleId: 'Roles.HUB_DEFICIT_ELIMINATOR_ROLE',
      selectorAsserts: ['IHub.eliminateDeficit.selector'],
    },
  ];
}
