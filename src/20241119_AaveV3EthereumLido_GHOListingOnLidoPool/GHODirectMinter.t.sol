// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IGhoToken} from '../interfaces/IGhoToken.sol';
import {ITransparentProxyFactory, ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/interfaces/ITransparentProxyFactory.sol';

import 'forge-std/Test.sol';
import {GHODirectMinter} from './GHODirectMinter.sol';

contract GHODirectMinter_Test is Test {
  GHODirectMinter internal minter;
  uint128 public constant GHO_MINT_AMOUNT = 10_000_000e18;

  function setUp() external {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21265036);

    GHODirectMinter minterImpl = new GHODirectMinter(
      AaveV3EthereumLido.POOL,
      address(AaveV3EthereumLido.COLLECTOR),
      AaveV3EthereumAssets.GHO_UNDERLYING
    );

    minter = GHODirectMinter(
      ITransparentProxyFactory(MiscEthereum.TRANSPARENT_PROXY_FACTORY).create(
        address(minterImpl),
        ProxyAdmin(MiscEthereum.PROXY_ADMIN),
        abi.encodeWithSelector(
          GHODirectMinter.initialize.selector,
          GovernanceV3Ethereum.EXECUTOR_LVL_1
        )
      )
    );

    vm.startPrank(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).addFacilitator(
      address(minter),
      'LidoGHODirectMinter',
      GHO_MINT_AMOUNT
    );
    vm.stopPrank();
  }

  function test_mintAndSupply() external {}
}
