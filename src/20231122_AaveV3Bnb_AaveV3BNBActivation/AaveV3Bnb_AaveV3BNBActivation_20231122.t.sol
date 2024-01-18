// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';
import {MiscBNB} from 'aave-address-book/MiscBNB.sol';
import {GovernanceV3BNB} from 'aave-address-book/GovernanceV3BNB.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Bnb_AaveV3BNBActivation_20231122} from './AaveV3Bnb_AaveV3BNBActivation_20231122.sol';

/**
 * @dev Test for AaveV3Bnb_AaveV3BNBActivation_20231122
 * command: make test-contract filter=AaveV3Bnb_AaveV3BNBActivation_20231122
 */
contract AaveV3Bnb_AaveV3BNBActivation_20231122_Test is ProtocolV3TestBase {
  AaveV3Bnb_AaveV3BNBActivation_20231122 internal proposal;
  address constant NULL_ADDRESS = 0x000000000000000000000000000000000000dEaD;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('bnb'), 35351361);
    proposal = new AaveV3Bnb_AaveV3BNBActivation_20231122();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Bnb_AaveV3BNBActivation_20231122', AaveV3BNB.POOL, address(proposal), true);
  }

  function test_AdminPermissions() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertTrue(AaveV3BNB.ACL_MANAGER.isRiskAdmin(AaveV3BNB.CAPS_PLUS_RISK_STEWARD));
    assertTrue(AaveV3BNB.ACL_MANAGER.isRiskAdmin(AaveV3BNB.FREEZING_STEWARD));
    assertTrue(AaveV3BNB.ACL_MANAGER.isPoolAdmin(MiscBNB.PROTOCOL_GUARDIAN));
  }

  function test_SeedCakeFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3BNB.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.CAKE()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(NULL_ADDRESS), proposal.CAKE_SEED_AMOUNT());
  }

  function test_SeedWBNBFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3BNB.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.WBNB()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(NULL_ADDRESS), proposal.WBNB_SEED_AMOUNT());
  }

  function test_SeedBTCBFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3BNB.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.BTCB()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(NULL_ADDRESS), proposal.BTCB_SEED_AMOUNT());
  }

  function test_SeedETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3BNB.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.ETH()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(NULL_ADDRESS), proposal.ETH_SEED_AMOUNT());
  }

  function test_SeedUSDCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3BNB.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.USDC()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(NULL_ADDRESS), proposal.USDC_SEED_AMOUNT());
  }

  function test_SeedUSDTFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3BNB.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.USDT()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(NULL_ADDRESS), proposal.USDT_SEED_AMOUNT());
  }

  function test_poolImplUpdate() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(IPool(address(AaveV3BNB.POOL)).POOL_REVISION(), 3);
  }
}

interface IPool {
  function POOL_REVISION() external view returns (uint256);
}
