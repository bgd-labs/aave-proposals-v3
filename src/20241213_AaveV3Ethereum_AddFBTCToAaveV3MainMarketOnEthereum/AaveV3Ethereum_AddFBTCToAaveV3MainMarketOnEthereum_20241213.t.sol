// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AddFBTCToAaveV3MainMarketOnEthereum_20241213} from './AaveV3Ethereum_AddFBTCToAaveV3MainMarketOnEthereum_20241213.sol';

/**
 * @dev Test for AaveV3Ethereum_AddFBTCToAaveV3MainMarketOnEthereum_20241213
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241213_AaveV3Ethereum_AddFBTCToAaveV3MainMarketOnEthereum/AaveV3Ethereum_AddFBTCToAaveV3MainMarketOnEthereum_20241213.t.sol -vv
 */
contract AaveV3Ethereum_AddFBTCToAaveV3MainMarketOnEthereum_20241213_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AddFBTCToAaveV3MainMarketOnEthereum_20241213 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22568883);
    proposal = new AaveV3Ethereum_AddFBTCToAaveV3MainMarketOnEthereum_20241213();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  /// forge-config: default.evm_version = 'cancun'
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AddFBTCToAaveV3MainMarketOnEthereum_20241213',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasFBTCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Ethereum.POOL.getReserveAToken(proposal.FBTC());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.DUST_BIN)), 10 ** 5);
  }

  function test_FBTCAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aFBTC = AaveV3Ethereum.POOL.getReserveAToken(proposal.FBTC());
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(proposal.FBTC()),
      proposal.FBTC_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(aFBTC),
      proposal.FBTC_LM_ADMIN()
    );
  }
}
