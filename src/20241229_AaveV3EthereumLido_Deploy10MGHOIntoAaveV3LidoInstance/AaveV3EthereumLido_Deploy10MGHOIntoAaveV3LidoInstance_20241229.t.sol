// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {IGhoBucketSteward} from '../interfaces/IGhoBucketSteward.sol';
import {IGhoToken} from '../interfaces/IGhoToken.sol';
import {IGhoDirectMinter} from './IGhoDirectMinter.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3EthereumLido_Deploy10MGHOIntoAaveV3LidoInstance_20241229} from './AaveV3EthereumLido_Deploy10MGHOIntoAaveV3LidoInstance_20241229.sol';

/**
 * @dev Test for AaveV3EthereumLido_Deploy10MGHOIntoAaveV3LidoInstance_20241229
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241229_AaveV3EthereumLido_Deploy10MGHOIntoAaveV3LidoInstance/AaveV3EthereumLido_Deploy10MGHOIntoAaveV3LidoInstance_20241229.t.sol -vv
 */
contract AaveV3EthereumLido_Deploy10MGHOIntoAaveV3LidoInstance_20241229_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_Deploy10MGHOIntoAaveV3LidoInstance_20241229 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21516467);
    proposal = new AaveV3EthereumLido_Deploy10MGHOIntoAaveV3LidoInstance_20241229();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_Deploy10MGHOIntoAaveV3LidoInstance_20241229',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_accessControl() public {
    assertEq(
      IAccessControl(address(AaveV3EthereumLido.ACL_MANAGER)).hasRole(
        AaveV3EthereumLido.ACL_MANAGER.RISK_ADMIN_ROLE(),
        proposal.FACILITATOR()
      ),
      false
    );

    address[] memory facilitators = IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING)
      .getFacilitatorsList();
    uint256 facilitatorsLength = facilitators.length;

    assertNotEq(proposal.FACILITATOR(), facilitators[facilitators.length - 1]);

    executePayload(vm, address(proposal));

    assertEq(
      IAccessControl(address(AaveV3EthereumLido.ACL_MANAGER)).hasRole(
        AaveV3EthereumLido.ACL_MANAGER.RISK_ADMIN_ROLE(),
        proposal.FACILITATOR()
      ),
      true
    );

    facilitators = IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).getFacilitatorsList();

    assertEq(proposal.FACILITATOR(), facilitators[facilitators.length - 1]);
    assertEq(facilitators.length, facilitatorsLength + 1);
  }

  function test_supplyIncreases() public {
    uint256 ghoBalanceBefore = IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      AaveV3EthereumLidoAssets.GHO_A_TOKEN
    );

    uint256 aGhoBalanceBefore = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
      proposal.FACILITATOR()
    );

    executePayload(vm, address(proposal));

    assertEq(
      IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
        AaveV3EthereumLidoAssets.GHO_A_TOKEN
      ),
      ghoBalanceBefore + proposal.GHO_MINT_AMOUNT()
    );

    assertEq(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(proposal.FACILITATOR()),
      aGhoBalanceBefore + proposal.GHO_MINT_AMOUNT()
    );
  }
}
