// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';

import {AaveV2Ethereum_RedeemCRVFromAaveV2EthereumAndTransferToGLC_20231123} from './AaveV2Ethereum_RedeemCRVFromAaveV2EthereumAndTransferToGLC_20231123.sol';

/**
 * @dev Test for AaveV2Ethereum_RedeemCRVFromAaveV2EthereumAndTransferToGLC_20231123
 * command: make test-contract filter=AaveV2Ethereum_RedeemCRVFromAaveV2EthereumAndTransferToGLC_20231123
 */
contract AaveV2Ethereum_RedeemCRVFromAaveV2EthereumAndTransferToGLC_20231123_Test is
  ProtocolV2TestBase
{
  AaveV2Ethereum_RedeemCRVFromAaveV2EthereumAndTransferToGLC_20231123 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18720612);
    proposal = new AaveV2Ethereum_RedeemCRVFromAaveV2EthereumAndTransferToGLC_20231123();
  }

  function test_execute() public {
    uint256 balanceCollectorCRVBefore = IERC20(AaveV2EthereumAssets.CRV_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceCollectorACRVBefore = IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceCollectorAEthCRVBefore = IERC20(AaveV3EthereumAssets.CRV_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 balanceProposalCRVBefore = IERC20(AaveV2EthereumAssets.CRV_UNDERLYING).balanceOf(
      address(proposal)
    );
    uint256 balanceGLCCRVBefore = IERC20(AaveV2EthereumAssets.CRV_UNDERLYING).balanceOf(
      proposal.GLC_SAFE()
    );

    assertEq(balanceProposalCRVBefore, 0);

    GovV3Helpers.executePayload(vm, address(proposal));

    assertEq(IERC20(AaveV2EthereumAssets.CRV_UNDERLYING).balanceOf(address(proposal)), 0);

    assertEq(
      IERC20(AaveV2EthereumAssets.CRV_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      0
    );
    assertLt(
      IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      350 ether
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.CRV_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );

    assertGt(
      IERC20(AaveV2EthereumAssets.CRV_UNDERLYING).balanceOf(proposal.GLC_SAFE()),
      balanceGLCCRVBefore
    );
    assertApproxEqRel(
      IERC20(AaveV2EthereumAssets.CRV_UNDERLYING).balanceOf(proposal.GLC_SAFE()),
      balanceGLCCRVBefore +
        balanceCollectorACRVBefore +
        balanceCollectorCRVBefore +
        balanceCollectorAEthCRVBefore,
      100 ether
    );
  }
}
