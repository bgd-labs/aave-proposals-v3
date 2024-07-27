// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';

import {Test, stdStorage, StdStorage} from 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_GHOFlashMinterFacilitatorArbitrum_20240727, IGhoToken} from './AaveV3Arbitrum_GHOFlashMinterFacilitatorArbitrum_20240727.sol';

interface IFlashMinter {
  function ADDRESSES_PROVIDER() external returns (address);
  function GHO_TOKEN() external returns (address);
}

/**
 * @dev Test for AaveV3Arbitrum_GHOFlashMinterFacilitatorArbitrum_20240727
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20240727_AaveV3Arbitrum_GHOFlashMinterFacilitatorArbitrum/AaveV3Arbitrum_GHOFlashMinterFacilitatorArbitrum_20240727.t.sol -vv
 */
contract AaveV3Arbitrum_GHOFlashMinterFacilitatorArbitrum_20240727_Test is ProtocolV3TestBase {
  using stdStorage for StdStorage;

  AaveV3Arbitrum_GHOFlashMinterFacilitatorArbitrum_20240727 internal proposal;
  IFlashMinter internal minter;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 236414103);
    proposal = new AaveV3Arbitrum_GHOFlashMinterFacilitatorArbitrum_20240727();
    minter = IFlashMinter(proposal.GHO_FLASH_MINTER());
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    executePayload(vm, address(proposal));

    (uint256 bucketCapacity, ) = IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING)
      .getFacilitatorBucket(proposal.GHO_FLASH_MINTER());
    assertEq(bucketCapacity, proposal.BUCKET_CAPACITY());

    /// Verify that the new Flash Minter was properly deployed
    /// since _fee and _ghoTreasury are private variables we have to
    /// cheat a little in order to read them
    /// ➜  gho-core git:(main) ✗ forge inspect --pretty GhoFlashMinter storage
    /// | Name         | Type    | Slot | Offset | Bytes | Contract                                                                 |
    /// |--------------|---------|------|--------|-------|--------------------------------------------------------------------------|
    /// | _fee         | uint256 | 0    | 0      | 32    | src/contracts/facilitators/flashMinter/GhoFlashMinter.sol:GhoFlashMinter |
    /// | _ghoTreasury | address | 1    | 0      | 20    | src/contracts/facilitators/flashMinter/GhoFlashMinter.sol:GhoFlashMinter |
    bytes32 fee = vm.load(proposal.GHO_FLASH_MINTER(), bytes32(uint256(0)));
    bytes32 ghoTreasury = vm.load(proposal.GHO_FLASH_MINTER(), bytes32(uint256(1)));

    assertEq(uint256(fee), 0);
    assertEq(address(uint160(uint256(ghoTreasury))), address(AaveV3Arbitrum.COLLECTOR));
    assertEq(minter.GHO_TOKEN(), AaveV3ArbitrumAssets.GHO_UNDERLYING);
    assertEq(minter.ADDRESSES_PROVIDER(), address(AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER));
  }
}
