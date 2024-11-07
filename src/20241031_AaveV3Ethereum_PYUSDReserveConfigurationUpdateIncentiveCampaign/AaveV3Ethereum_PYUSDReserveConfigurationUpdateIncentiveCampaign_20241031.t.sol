// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_PYUSDReserveConfigurationUpdateIncentiveCampaign_20241031} from './AaveV3Ethereum_PYUSDReserveConfigurationUpdateIncentiveCampaign_20241031.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';

/**
 * @dev Test for AaveV3Ethereum_PYUSDReserveConfigurationUpdateIncentiveCampaign_20241031
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241031_AaveV3Ethereum_PYUSDReserveConfigurationUpdateIncentiveCampaign/AaveV3Ethereum_PYUSDReserveConfigurationUpdateIncentiveCampaign_20241031.t.sol -vv
 */
contract AaveV3Ethereum_PYUSDReserveConfigurationUpdateIncentiveCampaign_20241031_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_PYUSDReserveConfigurationUpdateIncentiveCampaign_20241031 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21085967);
    proposal = new AaveV3Ethereum_PYUSDReserveConfigurationUpdateIncentiveCampaign_20241031();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_PYUSDReserveConfigurationUpdateIncentiveCampaign_20241031',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_checkAllowanceAndEmissionAdmin() public {
    uint256 allowanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.ALC_SAFE()
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.ALC_SAFE()
    );

    assertEq(allowanceAfter - allowanceBefore, proposal.GHO_AMOUNT());

    address pyusdEmissionAdmin = IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(
      AaveV3EthereumAssets.PYUSD_UNDERLYING
    );
    assertEq(pyusdEmissionAdmin, proposal.ACI_TREASURY());
    address pyusdAEmissionAdmin = IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER)
      .getEmissionAdmin(AaveV3EthereumAssets.PYUSD_A_TOKEN);
    assertEq(pyusdAEmissionAdmin, proposal.ACI_TREASURY());
  }
}
