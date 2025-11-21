// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Linea} from 'aave-address-book/AaveV3Linea.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Linea_AddMetaMaskMUSDToAaveV3EthereumLinea_20251120} from './AaveV3Linea_AddMetaMaskMUSDToAaveV3EthereumLinea_20251120.sol';

/**
 * @dev Test for AaveV3Linea_AddMetaMaskMUSDToAaveV3EthereumLinea_20251120
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251120_Multi_AddMetaMaskMUSDToAaveV3EthereumLinea/AaveV3Linea_AddMetaMaskMUSDToAaveV3EthereumLinea_20251120.t.sol -vv
 */
contract AaveV3Linea_AddMetaMaskMUSDToAaveV3EthereumLinea_20251120_Test is ProtocolV3TestBase {
  AaveV3Linea_AddMetaMaskMUSDToAaveV3EthereumLinea_20251120 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('linea'), 25848289);
    proposal = new AaveV3Linea_AddMetaMaskMUSDToAaveV3EthereumLinea_20251120();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Linea_AddMetaMaskMUSDToAaveV3EthereumLinea_20251120',
      AaveV3Linea.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasmUSDFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Linea.POOL.getReserveAToken(proposal.mUSD());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Linea.DUST_BIN)), 10 ** 6);
  }
}
