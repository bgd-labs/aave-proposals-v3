// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// solhint-disable-next-line no-unused-import
import {SpokeInstance} from 'aave-v4/spoke/instances/SpokeInstance.sol';

/// @dev Isolated importer that forces the canonical `SpokeInstance` artifact to be built so the
///      spoke fork tests can read it via `vm.getDeployedCode`. It lives in its own compilation unit
///      and imports nothing else, so the via_ir/optimizer compilation restriction pinned on
///      SpokeInstance.sol (see foundry.toml, matching the aave-v4 deployment settings) does not leak
///      into the test compilation unit — which would otherwise force via_ir onto the snapshot
///      helpers and break them with a stack-too-deep error.
abstract contract CanonicalSpokeArtifact {}
