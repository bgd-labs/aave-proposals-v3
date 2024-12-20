// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IWETH} from 'aave-v3-origin/contracts/helpers/interfaces/IWETH.sol';
import {IBridgehub, L2TransactionRequestDirect} from './IBridgehub.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import 'forge-std/Test.sol';

/**
 * @title Claim ZKSync airdrop
 * @author ACI
 * - Snapshot: TODO

 * - Discussion: TODO

 */
contract AaveV3Ethereum_ClaimZKSyncAirdrop_20241219 is
  IProposalGenericExecutor,
  ProtocolV3TestBase
{
  address public constant claimContractL1 = 0x303a465B659cBB0ab36eE643eA362c509EEb5213;

  address public constant finalRecipient = 0xdef1FA4CEfe67365ba046a7C630D6B885298E210; // lm.aci.eth

  uint256 public constant mintValueClaim = 786432000000000;
  uint256 public constant mintValueTransfer = 1328196266668064768;

  function execute() external {
    emit log_uint(123);
    emit log_named_address('address(this)', address(this));
    emit log_named_address('msg.sender', msg.sender);

    // Get ETH to claim and transfer ZK tokens
    getETHFromCollector(mintValueClaim + mintValueTransfer);
    // Claim ZK tokens on ZKSync chain
    claimZKTokens();
    // Transfer ZK tokens to final recipient
    transferZKTokens();
  }

  /**
    This function will call a function on a mainnet contract that will trigger a claim on the ZKSync chain
   */
  function claimZKTokens() internal {
    // Parameters have been generated using the official project: https://github.com/ZKsync-Association/zknation-data/blob/main/README.md#l1-smart-contracts-addresses
    // yarn generate-l1-contract-claim-tx 0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A --l1-gas-price 10

    address claimContractL2 = 0x66Fd4FC8FA52c9bec2AbA368047A0b27e24ecfe4;

    // l2Calldata that call the claim function on the ZKSync contract
    bytes
      memory l2Calldata = hex'ae0b51df00000000000000000000000000000000000000000000000000000000000a8a2500000000000000000000000000000000000000000006dde7dc8ab86b60ac000000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000013e1b9bd845f15b9344882d0cd617236d69651ac934ae5544c815646f0062cc23e3e454218a74f1040251614d569d5276a6de26e9783533cacacc9ba3ea4c653644fe60006efd385ee1db3eda8ea5cd66ac343506fd7717cfd3d34dbf29fa4dcdecf3468233b4a5f8975a6e1e60faba8fab4e29fa579eeeea3b0899b6909e3c28c155a010c7d01576d019fdaae164c92af5fe99904d742b5faaf486fa0ce16f5328aea28ee1c826086a23cfa83ac9433828e198d2b956ecfcc25a53590ad08640e4bd12c0ea7635141894c46f1cfdde2b8c284b5930bc466d4b039a4079b3eca60c8dc44fd7a3e51d6dbe088e3baefdf2487c139c6d945ea5877cff93ddeeb2f5089a9fd6e20363734ba73ffa25c5b6784668ea9a579978bf8e5cfacd9b7371f6db96c58d21937d1cbad3c7d0aaee32004d2735bd6e9cf1c42f44fed02a3655cf07e6965a4455a4f91fb4c58cfd9f40be2b5a9f81159826714f23081f9b1be42c489fcaa0f2b0db2b5255b2ca70890994082b6a98445650f20d621b950666a94941e9e757d528bc60fbba68ce7665fe59038c40dc55ec5df36777d64da947d4dc4d110030a106e90fe175ab3dc34ab41198e3c431998b5ce31695c166732d836aefb1a3323e6c29d0f7b6fafc04b6adb2707c206c39e31635bd0cc3320fa799152151d293f7cdc52d80e26f45e86a21d01d7bb9c7244682e397a60ed29fb3c5f75991aaccd914832e925de5ebb6198427a149e13f146be232484cd44bedc1db2ec60129e33376f24766c7de887c815c0b36a385d82de2f93a0ba2515ab1eb80588f30b9e1d3ccc867b00fd1b4c8b66dbdbec17962a94b65b7751f783ec0789ef66';

    L2TransactionRequestDirect memory request = L2TransactionRequestDirect({
      chainId: 324,
      mintValue: mintValueClaim,
      l2Contract: claimContractL2,
      l2Value: 0,
      l2Calldata: l2Calldata,
      l2GasLimit: 2097152,
      l2GasPerPubdataByteLimit: 800,
      factoryDeps: new bytes[](0),
      refundRecipient: address(this)
    });

    bytes memory data = abi.encodeWithSelector(
      IBridgehub.requestL2TransactionDirect.selector,
      request
    );
    emit log_bytes(data);

    // call
    IBridgehub(claimContractL1).requestL2TransactionDirect{value: mintValueClaim}(request);
  }

  /**
    This function will call a function on a mainnet contract that will trigger a transfer of the ZK tokens to the final recipient on the ZKSync chain
   */
  function transferZKTokens() internal {
    // Parameters have been generated using the official project: https://github.com/ZKsync-Association/zknation-data/blob/main/README.md#l1-smart-contracts-addresses
    // yarn generate-l1-contract-transfer-tx --to 0xdef1FA4CEfe67365ba046a7C630D6B885298E210 --amount 8301475000000000000 --l1-gas-price 10
    // claim amount (8301475000000000000) have been found by decoding the l2Calldata of the claim function

    address transferContractL2 = 0x5A7d6b2F92C77FAD6CCaBd7EE0624E64907Eaf3E;

    // l2Calldata to call the claim function on the ZKSync contract
    bytes
      memory l2Calldata = hex'a9059cbb000000000000000000000000def1fa4cefe67365ba046a7c630d6b885298e21000000000000000000000000000000000000000000006dde7dc8ab86b60ac0000';

    L2TransactionRequestDirect memory request = L2TransactionRequestDirect({
      chainId: 324,
      mintValue: mintValueTransfer,
      l2Contract: transferContractL2,
      l2Value: 0,
      l2Calldata: l2Calldata,
      l2GasLimit: 2097152,
      l2GasPerPubdataByteLimit: 800,
      factoryDeps: new bytes[](0),
      refundRecipient: 0x0000000000000000000000000000000000000000
    });

    // call
    IBridgehub(claimContractL1).requestL2TransactionDirect{value: mintValueTransfer}(request);
  }

  function getETHFromCollector(uint256 amount) internal {
    emit log_named_address('address(this)', address(this));
    emit log_named_address('msg.sender', msg.sender);

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.WETH_UNDERLYING,
      GovernanceV3Ethereum.EXECUTOR_LVL_1,
      amount
    );
    IWETH(AaveV3EthereumAssets.WETH_UNDERLYING).withdraw(amount);
  }
}
