// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {IGhoBucketSteward} from '../interfaces/IGhoBucketSteward.sol';
import {IGhoToken} from '../interfaces/IGhoToken.sol';
import {IGhoDirectMinter} from './IGhoDirectMinter.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Deploy 10M GHO into Aave v3 Lido Instance
 * @author karpatkey_TokenLogic & BGD Labs
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x4af37d6b4a1c9029c7693c4bdfb646931a9815c4a56d9066ac1fbdbef7cd15e5
 * - Discussion: https://governance.aave.com/t/arfc-mint-deploy-10m-gho-into-aave-v3-lido-instance/19700
 */
contract AaveV3EthereumLido_Deploy10MGHOIntoAaveV3LidoInstance_20241229 is
  IProposalGenericExecutor
{
  uint128 public constant GHO_MINT_AMOUNT = 10_000_000e18;

  // https://etherscan.io/address/0x2cE01c87Fec1b71A9041c52CaED46Fc5f4807285
  address public constant FACILITATOR = 0x2cE01c87Fec1b71A9041c52CaED46Fc5f4807285;

  function execute() external {
    IAccessControl(address(AaveV3EthereumLido.ACL_MANAGER)).grantRole(
      AaveV3EthereumLido.ACL_MANAGER.RISK_ADMIN_ROLE(),
      FACILITATOR
    );
    IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).addFacilitator(
      FACILITATOR,
      'LidoGhoDirectMinter',
      GHO_MINT_AMOUNT
    );
    IGhoDirectMinter(FACILITATOR).mintAndSupply(GHO_MINT_AMOUNT);

    // Allow risk council to control the bucket capacity
    address[] memory vaults = new address[](1);
    vaults[0] = FACILITATOR;
    // https://etherscan.io/address/0x46Aa1063e5265b43663E81329333B47c517A5409
    IGhoBucketSteward(0x46Aa1063e5265b43663E81329333B47c517A5409).setControlledFacilitator(
      vaults,
      true
    );
  }
}
