// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_JuneFundingUpdate_20250613} from './AaveV3Ethereum_JuneFundingUpdate_20250613.sol';

/**
 * @dev Test for AaveV3Ethereum_JuneFundingUpdate_20250613
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250613_AaveV3Ethereum_JuneFundingUpdate/AaveV3Ethereum_JuneFundingUpdate_20250613.t.sol -vv
 */
contract AaveV3Ethereum_JuneFundingUpdate_20250613_Test is ProtocolV3TestBase {
  AaveV3Ethereum_JuneFundingUpdate_20250613 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22697434);
    proposal = new AaveV3Ethereum_JuneFundingUpdate_20250613();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_JuneFundingUpdate_20250613',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_approvals() public {
    uint256 allowanceAEthUSDTBefore = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AFC_SAFE()
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.AFC_SAFE()
      ),
      0
    );

    executePayload(vm, address(proposal));

    uint256 allowanceAEthUSDTAfter = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AFC_SAFE()
    );

    assertEq(allowanceAEthUSDTAfter, allowanceAEthUSDTBefore + proposal.AFC_USDT_ALLOWANCE());

    vm.startPrank(proposal.AFC_SAFE());
    IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AFC_SAFE(),
      proposal.AFC_USDT_ALLOWANCE()
    );
    vm.stopPrank();
  }
}
