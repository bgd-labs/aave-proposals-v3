// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Monad} from 'aave-address-book/AaveV3Monad.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {GhoCCIPChains} from '../../helpers/gho-launch/constants/GhoCCIPChains.sol';
import {AaveV3GHOLane} from '../../helpers/gho-launch/AaveV3GHOLane.sol';
import {AaveV3GHOLaunchTest_PreExecution, AaveV3GHOLaunch_1_6_Test_PostExecution} from '../../helpers/gho-launch/tests/AaveV3GHOLaunchTest.sol';
import {AaveV3Monad_GhoMonadActivation_20260518} from '../AaveV3Monad_GhoMonadActivation_20260518.sol';

uint256 constant MONAD_BLOCK_NUMBER = 82996426;

/**
 * @dev Test for AaveV3Monad_GhoMonadActivation_20260518
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260518_Multi_GhoMonadActivation/tests/AaveV3Monad_GhoMonadActivation_20260518.t.sol -vv
 */
contract AaveV3Monad_GhoMonadActivation_20260518_Test is ProtocolV3TestBase {
  AaveV3Monad_GhoMonadActivation_20260518 internal proposal;
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('monad'), MONAD_BLOCK_NUMBER);
    proposal = new AaveV3Monad_GhoMonadActivation_20260518();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Monad_GhoMonadActivation_20260518',
      AaveV3Monad.POOL,
      address(proposal),
      false,
      false
    );
  }
}

contract AaveV3Monad_GhoMonadActivation_20260518_PreExecution is AaveV3GHOLaunchTest_PreExecution {
  // https://docs.chain.link/ccip/directory/mainnet/chain/monad-mainnet
  address internal constant RMN = 0x99dFCa5d88f4D9C023531F4403966b8d61562AcD;

  address internal constant RISK_COUNCIL = 0x8513e6F37dBc52De87b166980Fa3F50639694B60;

  constructor()
    AaveV3GHOLaunchTest_PreExecution(GhoCCIPChains.MONAD(), 'monad', MONAD_BLOCK_NUMBER)
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new AaveV3Monad_GhoMonadActivation_20260518();
  }

  function _validateConstants() internal view virtual override {
    assertEq(LOCAL_TOKEN_ADMIN_REGISTRY.typeAndVersion(), 'TokenAdminRegistry 1.5.0');
    assertEq(LOCAL_TOKEN_POOL.typeAndVersion(), 'BurnMintTokenPool 1.5.1');
    assertEq(LOCAL_CCIP_ROUTER.typeAndVersion(), 'Router 1.2.0');
  }

  function _localRiskCouncil() internal view virtual override returns (address) {
    return RISK_COUNCIL;
  }

  function _localRmnProxy() internal view virtual override returns (address) {
    return RMN;
  }

  function _aavePoolAddressesProvider() internal view virtual override returns (address) {
    return address(AaveV3Monad.POOL_ADDRESSES_PROVIDER);
  }

  function _aaveProtocolDataProvider() internal view virtual override returns (address) {
    return address(AaveV3Monad.AAVE_PROTOCOL_DATA_PROVIDER);
  }
}

contract AaveV3Monad_GhoMonadActivation_20260518_PostExecution is
  AaveV3GHOLaunch_1_6_Test_PostExecution
{
  constructor()
    AaveV3GHOLaunch_1_6_Test_PostExecution(GhoCCIPChains.MONAD(), 'monad', MONAD_BLOCK_NUMBER)
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new AaveV3Monad_GhoMonadActivation_20260518();
  }

  function _validateConstants() internal view virtual override {
    assertEq(LOCAL_TOKEN_ADMIN_REGISTRY.typeAndVersion(), 'TokenAdminRegistry 1.5.0');
    assertEq(LOCAL_TOKEN_POOL.typeAndVersion(), 'BurnMintTokenPool 1.5.1');
    assertEq(LOCAL_CCIP_ROUTER.typeAndVersion(), 'Router 1.2.0');
  }
}
