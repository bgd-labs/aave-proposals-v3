// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IGhoAaveSteward} from 'src/interfaces/IGhoAaveSteward.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {IOwnable} from 'aave-address-book/common/IOwnable.sol';

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_ExtendGHOStewardOnAavePrimeInstance_20250129} from './AaveV3EthereumLido_ExtendGHOStewardOnAavePrimeInstance_20250129.sol';

/**
 * @dev Test for AaveV3EthereumLido_ExtendGHOStewardOnAavePrimeInstance_20250129
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250129_AaveV3EthereumLido_ExtendGHOStewardOnAavePrimeInstance/AaveV3EthereumLido_ExtendGHOStewardOnAavePrimeInstance_20250129.t.sol -vv
 */
contract AaveV3EthereumLido_ExtendGHOStewardOnAavePrimeInstance_20250129_Test is
  ProtocolV3TestBase
{
  AaveV3EthereumLido_ExtendGHOStewardOnAavePrimeInstance_20250129 internal proposal;
  IGhoAaveSteward public constant NEW_GHO_AAVE_STEWARD =
    IGhoAaveSteward(0x5C905d62B22e4DAa4967E517C4a047Ff6026C731);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21738505);
    proposal = new AaveV3EthereumLido_ExtendGHOStewardOnAavePrimeInstance_20250129();
  }

  function testValidate() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    assertTrue(
      AaveV3EthereumLido.ACL_MANAGER.hasRole(
        AaveV3EthereumLido.ACL_MANAGER.RISK_ADMIN_ROLE(),
        address(NEW_GHO_AAVE_STEWARD)
      )
    );
    assertEq(address(proposal.NEW_GHO_AAVE_STEWARD()), address(NEW_GHO_AAVE_STEWARD));
    assertEq(IOwnable(address(NEW_GHO_AAVE_STEWARD)).owner(), GovernanceV3Ethereum.EXECUTOR_LVL_1);
    assertEq(
      NEW_GHO_AAVE_STEWARD.POOL_ADDRESSES_PROVIDER(),
      address(AaveV3EthereumLido.POOL_ADDRESSES_PROVIDER)
    );
    assertEq(
      NEW_GHO_AAVE_STEWARD.POOL_DATA_PROVIDER(),
      address(AaveV3EthereumLido.AAVE_PROTOCOL_DATA_PROVIDER)
    );
    assertEq(NEW_GHO_AAVE_STEWARD.GHO_TOKEN(), AaveV3EthereumLidoAssets.GHO_UNDERLYING);
    assertEq(NEW_GHO_AAVE_STEWARD.RISK_COUNCIL(), 0x8513e6F37dBc52De87b166980Fa3F50639694B60);
    assertEq(
      NEW_GHO_AAVE_STEWARD.getBorrowRateConfig(),
      IGhoAaveSteward.BorrowRateConfig({
        optimalUsageRatioMaxChange: 5_00,
        baseVariableBorrowRateMaxChange: 5_00,
        variableRateSlope1MaxChange: 5_00,
        variableRateSlope2MaxChange: 5_00
      })
    );
  }

  function assertEq(
    IGhoAaveSteward.BorrowRateConfig memory a,
    IGhoAaveSteward.BorrowRateConfig memory b
  ) internal pure {
    assertEq(a.optimalUsageRatioMaxChange, b.optimalUsageRatioMaxChange);
    assertEq(a.baseVariableBorrowRateMaxChange, b.baseVariableBorrowRateMaxChange);
    assertEq(a.variableRateSlope1MaxChange, b.variableRateSlope1MaxChange);
    assertEq(a.variableRateSlope2MaxChange, b.variableRateSlope2MaxChange);
    assertEq(abi.encode(a), abi.encode(b)); // sanity check
  }
}
