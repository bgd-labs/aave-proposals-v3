// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';

import {Test, stdStorage, StdStorage} from 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import {AaveV3Arbitrum_GHOFlashMinterFacilitatorArbitrum_20240727, IGhoToken} from './AaveV3Arbitrum_GHOFlashMinterFacilitatorArbitrum_20240727.sol';

interface IFlashMinter {
  function getGhoTreasury() external view returns (address);
  function getFee() external view returns (uint256);
  function ADDRESSES_PROVIDER() external view returns (address);
  function GHO_TOKEN() external view returns (address);
  function flashLoan(
    address receiver,
    address token,
    uint256 amount,
    bytes calldata data
  ) external returns (bool);
}

contract Borrower {
  constructor(address minter) {
    IERC20(AaveV3ArbitrumAssets.GHO_UNDERLYING).approve(minter, type(uint256).max);
  }

  function onFlashLoan(
    address initiator,
    address token,
    uint256 amount,
    uint256 fee,
    bytes calldata data
  ) external returns (bytes32) {
    require(
      token == AaveV3ArbitrumAssets.GHO_UNDERLYING &&
        amount == 1000 &&
        fee == 0 &&
        keccak256(data) == keccak256('')
    );
    return keccak256('ERC3156FlashBorrower.onFlashLoan');
  }
}

/**
 * @dev Test for AaveV3Arbitrum_GHOFlashMinterFacilitatorArbitrum_20240727
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20240727_AaveV3Arbitrum_GHOFlashMinterFacilitatorArbitrum/AaveV3Arbitrum_GHOFlashMinterFacilitatorArbitrum_20240727.t.sol -vv
 */
contract AaveV3Arbitrum_GHOFlashMinterFacilitatorArbitrum_20240727_Test is ProtocolV3TestBase {
  using stdStorage for StdStorage;

  AaveV3Arbitrum_GHOFlashMinterFacilitatorArbitrum_20240727 internal proposal;
  IFlashMinter internal minter;
  address internal borrower;

  uint256 internal constant EXPECTED_FEE = 0;
  uint256 internal constant FLASHLOAN_AMOUNT = 1000;
  address internal constant GHO = AaveV3ArbitrumAssets.GHO_UNDERLYING;

  event FlashMint(
    address indexed receiver,
    address indexed initiator,
    address asset,
    uint256 indexed amount,
    uint256 fee
  );

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 236414103);
    proposal = new AaveV3Arbitrum_GHOFlashMinterFacilitatorArbitrum_20240727();
    minter = IFlashMinter(proposal.GHO_FLASH_MINTER());
    borrower = address(new Borrower(address(minter)));
  }

  function test_bucketCapacity() public {
    executePayload(vm, address(proposal));
    (uint256 bucketCapacity, ) = IGhoToken(GHO).getFacilitatorBucket(proposal.GHO_FLASH_MINTER());
    assertEq(bucketCapacity, proposal.BUCKET_CAPACITY());
  }

  function test_minterProperties() public {
    assertEq(minter.getFee(), EXPECTED_FEE);
    assertEq(minter.getGhoTreasury(), address(AaveV3Arbitrum.COLLECTOR));
    assertEq(minter.GHO_TOKEN(), GHO);
    assertEq(minter.ADDRESSES_PROVIDER(), address(AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER));
  }

  function test_flashMint() public {
    executePayload(vm, address(proposal));
    vm.expectEmit(address(minter));
    emit FlashMint(borrower, address(this), GHO, FLASHLOAN_AMOUNT, EXPECTED_FEE);
    minter.flashLoan(borrower, GHO, FLASHLOAN_AMOUNT, '');
  }
}
