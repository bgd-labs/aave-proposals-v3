// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {DataTypes} from 'aave-address-book/AaveV2.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_V2StableDebtOffboarding_20240416} from './AaveV2Ethereum_V2StableDebtOffboarding_20240416.sol';

interface IUpdatedLendingPool {
  function swapToVariable(address asset, address user) external;
}

/**
 * @dev Test for AaveV2Ethereum_V2StableDebtOffboarding_20240416
 * command: make test-contract filter=AaveV2Ethereum_V2StableDebtOffboarding_20240416
 */
contract AaveV2Ethereum_V2StableDebtOffboarding_20240416_Test is ProtocolV2TestBase {
  AaveV2Ethereum_V2StableDebtOffboarding_20240416 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19668247);
    proposal = new AaveV2Ethereum_V2StableDebtOffboarding_20240416();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Ethereum_V2StableDebtOffboarding_20240416',
      AaveV2Ethereum.POOL,
      address(proposal)
    );
  }

  function test_rateSwap() public {
    executePayload(vm, address(proposal));
    DataTypes.ReserveData memory reserveData = AaveV2Ethereum.POOL.getReserveData(
      AaveV2EthereumAssets.DAI_UNDERLYING
    );
    address[] memory users = _getsDaiUsers();
    for (uint256 i = 0; i < users.length; i++) {
      uint256 stableDebtBefore = IERC20(reserveData.stableDebtTokenAddress).balanceOf(users[i]);
      uint256 variableDebtBefore = IERC20(reserveData.variableDebtTokenAddress).balanceOf(users[i]);

      IUpdatedLendingPool(address(AaveV2Ethereum.POOL)).swapToVariable(
        AaveV2EthereumAssets.DAI_UNDERLYING,
        users[i]
      );

      uint256 stableDebtAfter = IERC20(reserveData.stableDebtTokenAddress).balanceOf(users[i]);
      uint256 variableDebtAfter = IERC20(reserveData.variableDebtTokenAddress).balanceOf(users[i]);
      assertEq(stableDebtAfter, 0);
      assertApproxEqAbs(variableDebtAfter, variableDebtBefore + stableDebtBefore, 1);
    }
  }

  function _getsDaiUsers() internal returns (address[] memory) {
    address[] memory users = new address[](5);
    users[0] = 0x1047DC58a642AEd18B1DC04C11f02C622b42cf21;
    users[1] = 0xeb7AE9d125442A5b4ed57FE7C4Cbc87512B02ADA;
    users[2] = 0xC28AC4b691cFd8d27B7e1c6fc757FE2cBa10604A;
    users[3] = 0xe59d885CEc9Fb8A79E4ee30EDabd250E470E757A;
    users[4] = 0x9CD6658537dDBB63F075ec3E92e53Ef3E723b195;

    return users;
  }
}
