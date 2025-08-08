// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AddTETHToCoreInstanceEthereum_20250801} from './AaveV3Ethereum_AddTETHToCoreInstanceEthereum_20250801.sol';

/**
 * @dev Test for AaveV3Ethereum_AddTETHToCoreInstanceEthereum_20250801
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250801_AaveV3Ethereum_AddTETHToCoreInstanceEthereum/AaveV3Ethereum_AddTETHToCoreInstanceEthereum_20250801.t.sol -vv
 */
contract AaveV3Ethereum_AddTETHToCoreInstanceEthereum_20250801_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AddTETHToCoreInstanceEthereum_20250801 internal proposal;
  address public constant EXECUTOR = 0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23098230);
    proposal = new AaveV3Ethereum_AddTETHToCoreInstanceEthereum_20250801();
    deal(AaveV3EthereumLidoAssets.tETH_UNDERLYING, EXECUTOR, 10 ** 18);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AddTETHToCoreInstanceEthereum_20250801',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_dustBinHastETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Ethereum.POOL.getReserveAToken(
      AaveV3EthereumLidoAssets.tETH_UNDERLYING
    );
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.DUST_BIN)),
      proposal.tETH_SEED_AMOUNT()
    );
  }
}
