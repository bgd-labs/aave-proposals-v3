import {CodeArtifact, MarketIdentifierV4} from '../../types';
import {getV4Book, spokeLibAccessor} from './marketBook';
import {accessorIdentifier, testAddressRef, wrapAddress} from './testHelpers';
import {rolesWiredTest} from './access/accessManagerTargetFunctionRoleUpdate';

/// An already-wired Spoke of the market, used by generated tests to assert a freshly
/// wired Spoke does not diverge from the canonical selector-to-role mapping.
function referenceSpoke(market: MarketIdentifierV4): string {
  return getV4Book(market).SPOKES.MAIN_SPOKE
    ? wrapAddress(spokeLibAccessor(market, 'MAIN_SPOKE'))
    : 'address(0)';
}

/// The AccessManager wiring a freshly deployed Hub or Spoke needs, as a `V4RoleWiring`
/// call. The library pins the selectors against the deployment procedures, so a payload
/// declares "wire this entity" instead of re-listing selectors that go stale whenever
/// the procedures gain or reorder one.
export function accessWiringArtifact(
  market: MarketIdentifierV4,
  entities: {hubs: string[]; spokes: string[]},
): CodeArtifact {
  const authority = `address(${market}.ACCESS_MANAGER)`;
  const arrayExprs = [
    ...entities.hubs.map((hub) => `V4RoleWiring.hubWiring(${authority}, ${wrapAddress(hub)})`),
    ...entities.spokes.map(
      (spoke) => `V4RoleWiring.spokeWiring(${authority}, ${wrapAddress(spoke)})`,
    ),
  ];
  const hubTests = entities.hubs.map((hub) =>
    rolesWiredTest(accessorIdentifier(hub), testAddressRef(hub), 'address(0)'),
  );
  const spokeTests = entities.spokes.flatMap((spoke) => [
    rolesWiredTest(accessorIdentifier(spoke), testAddressRef(spoke), referenceSpoke(market)),
    // the config engine configures a spoke but never checks this market deployed it
    `function test_spokeDeployment_${accessorIdentifier(spoke)}() public view {
        _assertSpokeDeployment(ISpoke(${testAddressRef(spoke)}));
      }`,
  ]);
  return {
    code: {
      v4Getters: {
        accessManagerTargetFunctionRoleUpdates: {
          returnType: 'IConfigEngine.TargetFunctionRoleUpdate',
          entries: [],
          arrayExprs,
          arrayMerge: 'V4RoleWiring.merge',
        },
      },
    },
    test: {fn: [...hubTests, ...spokeTests]},
  };
}
