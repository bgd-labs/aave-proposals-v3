// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3InkWhitelabel} from 'aave-address-book/AaveV3InkWhitelabel.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3InkWhitelabel_OnboardUSDCWeETHRsETHAndEzETHToAaveV3InkWhitelabel_20251119} from './AaveV3InkWhitelabel_OnboardUSDCWeETHRsETHAndEzETHToAaveV3InkWhitelabel_20251119.sol';

/**
 * @dev Test for AaveV3InkWhitelabel_OnboardUSDCWeETHRsETHAndEzETHToAaveV3InkWhitelabel_20251119
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251119_AaveV3InkWhitelabel_OnboardUSDCWeETHRsETHAndEzETHToAaveV3InkWhitelabel/AaveV3InkWhitelabel_OnboardUSDCWeETHRsETHAndEzETHToAaveV3InkWhitelabel_20251119.t.sol -vv
 */
contract AaveV3InkWhitelabel_OnboardUSDCWeETHRsETHAndEzETHToAaveV3InkWhitelabel_20251119_Test is
  ProtocolV3TestBase
{
  AaveV3InkWhitelabel_OnboardUSDCWeETHRsETHAndEzETHToAaveV3InkWhitelabel_20251119 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('ink'), 30068124);
    proposal = new AaveV3InkWhitelabel_OnboardUSDCWeETHRsETHAndEzETHToAaveV3InkWhitelabel_20251119();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3InkWhitelabel_OnboardUSDCWeETHRsETHAndEzETHToAaveV3InkWhitelabel_20251119',
      AaveV3InkWhitelabel.POOL,
      address(proposal),
      true,
      true
    );
  }

  function test_dustBinHasUSDCFunds() public {
    executePayload(vm, address(proposal), AaveV3InkWhitelabel.POOL);
    address aTokenAddress = AaveV3InkWhitelabel.POOL.getReserveAToken(proposal.USDC());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3InkWhitelabel.DUST_BIN)), 100 * 10 ** 6);
  }

  function test_USDCAdmin() public {
    executePayload(vm, address(proposal), AaveV3InkWhitelabel.POOL);
    address aUSDC = AaveV3InkWhitelabel.POOL.getReserveAToken(proposal.USDC());
    assertEq(
      IEmissionManager(AaveV3InkWhitelabel.EMISSION_MANAGER).getEmissionAdmin(proposal.USDC()),
      proposal.USDC_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3InkWhitelabel.EMISSION_MANAGER).getEmissionAdmin(aUSDC),
      proposal.USDC_LM_ADMIN()
    );
  }

  function test_dustBinHasweETHFunds() public {
    executePayload(vm, address(proposal), AaveV3InkWhitelabel.POOL);
    address aTokenAddress = AaveV3InkWhitelabel.POOL.getReserveAToken(proposal.weETH());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3InkWhitelabel.DUST_BIN)),
      0.03 * 10 ** 18
    );
  }

  function test_weETHAdmin() public {
    executePayload(vm, address(proposal), AaveV3InkWhitelabel.POOL);
    address aweETH = AaveV3InkWhitelabel.POOL.getReserveAToken(proposal.weETH());
    assertEq(
      IEmissionManager(AaveV3InkWhitelabel.EMISSION_MANAGER).getEmissionAdmin(proposal.weETH()),
      proposal.weETH_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3InkWhitelabel.EMISSION_MANAGER).getEmissionAdmin(aweETH),
      proposal.weETH_LM_ADMIN()
    );
  }

  function test_dustBinHasrsETHFunds() public {
    executePayload(vm, address(proposal), AaveV3InkWhitelabel.POOL);
    address aTokenAddress = AaveV3InkWhitelabel.POOL.getReserveAToken(proposal.wrsETH());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3InkWhitelabel.DUST_BIN)),
      0.03 * 10 ** 18
    );
  }

  function test_rsETHAdmin() public {
    executePayload(vm, address(proposal), AaveV3InkWhitelabel.POOL);
    address arsETH = AaveV3InkWhitelabel.POOL.getReserveAToken(proposal.rsETH());
    assertEq(
      IEmissionManager(AaveV3InkWhitelabel.EMISSION_MANAGER).getEmissionAdmin(proposal.rsETH()),
      proposal.rsETH_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3InkWhitelabel.EMISSION_MANAGER).getEmissionAdmin(arsETH),
      proposal.rsETH_LM_ADMIN()
    );
  }

  function test_dustBinHasezETHFunds() public {
    executePayload(vm, address(proposal), AaveV3InkWhitelabel.POOL);
    address aTokenAddress = AaveV3InkWhitelabel.POOL.getReserveAToken(proposal.ezETH());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3InkWhitelabel.DUST_BIN)),
      0.03 * 10 ** 18
    );
  }

  function test_ezETHAdmin() public {
    executePayload(vm, address(proposal), AaveV3InkWhitelabel.POOL);
    address aezETH = AaveV3InkWhitelabel.POOL.getReserveAToken(proposal.ezETH());
    assertEq(
      IEmissionManager(AaveV3InkWhitelabel.EMISSION_MANAGER).getEmissionAdmin(proposal.ezETH()),
      proposal.ezETH_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3InkWhitelabel.EMISSION_MANAGER).getEmissionAdmin(aezETH),
      proposal.ezETH_LM_ADMIN()
    );
  }
}
