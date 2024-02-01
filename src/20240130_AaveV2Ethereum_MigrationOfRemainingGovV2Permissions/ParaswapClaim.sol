// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// https://developers.paraswap.network/smart-contracts#fee-claimer
library ParaswapClaimer {
  IFeeClaimer public constant ETHEREUM = IFeeClaimer(0xeF13101C5bbD737cFb2bF00Bbd38c626AD6952F7);

  IFeeClaimer public constant POLYGON = IFeeClaimer(0x8b5cF413214CA9348F047D1aF402Db1b4E96c060);
}

interface IFeeClaimer {
  /**
   * @notice batch claim whole balance of fee share amount
   * @dev transfers ERC20 token balance to the caller's account
   *      the call will fail if withdrawer have zero balance in the contract
   * @param _tokens list of addresses of the ERC20 token
   * @param _recipient address of recipient
   * @return true if the withdraw was successfull
   */
  function batchWithdrawAllERC20(
    address[] calldata _tokens,
    address _recipient
  ) external returns (bool);

  /**
   * @notice returns unclaimed fee amount given the token in batch
   * @dev retrieves the balance of ERC20 token fee amount for a partner in batch
   * @param _tokens list of ERC20 token addresses
   * @param _partner account address of the partner
   * @return _fees array of the token amount
   */
  function batchGetBalance(
    address[] calldata _tokens,
    address _partner
  ) external view returns (uint256[] memory _fees);
}

/**
 * Generic contract for claiming all available rewards from paraswap to a specified address.
 */
contract ParaswapClaim {
  /**
   * @dev Batch claims the fee accrued for `aaveClaimer` on `paraswapClaimer` for all supplied tokens.
   * @param feeClaimer The paraswap fee claimer of the network. ref: https://developers.paraswap.network/smart-contracts#fee-claimer
   * @param aaveClaimer The elegible claimer of the aave protocol.
   * @param receiver The beneficiary of the claim call.
   */
  function claim(
    IFeeClaimer feeClaimer,
    address aaveClaimer,
    address receiver,
    address[] memory tokens
  ) internal {
    // paraswap errors when one of the balances is 0 so we need to filter them beforehand
    uint256[] memory balances = feeClaimer.batchGetBalance(tokens, aaveClaimer);
    uint256 count = 0;
    for (uint256 i; i < balances.length; i++) {
      if (balances[i] != 0) count += 1;
    }
    address[] memory claimableTokens = new address[](count);
    uint256 currentIndex = 0;
    for (uint256 i; i < balances.length; i++) {
      if (balances[i] != 0) {
        claimableTokens[currentIndex] = tokens[i];
        currentIndex += 1;
      }
    }
    require(currentIndex == count, 'NON_MATCHING_LENGTH');
    feeClaimer.batchWithdrawAllERC20(claimableTokens, receiver);
  }
}
