// SPDX-License-Identifier: LicenseRef-BUSL
pragma solidity ^0.8.0;

interface ISignatureGateway {
  struct Supply {
    address spoke;
    uint256 reserveId;
    uint256 amount;
    address onBehalfOf;
    uint256 nonce;
    uint256 deadline;
  }

  struct Withdraw {
    address spoke;
    uint256 reserveId;
    uint256 amount;
    address onBehalfOf;
    uint256 nonce;
    uint256 deadline;
  }

  struct Borrow {
    address spoke;
    uint256 reserveId;
    uint256 amount;
    address onBehalfOf;
    uint256 nonce;
    uint256 deadline;
  }

  struct Repay {
    address spoke;
    uint256 reserveId;
    uint256 amount;
    address onBehalfOf;
    uint256 nonce;
    uint256 deadline;
  }

  struct SetUsingAsCollateral {
    address spoke;
    uint256 reserveId;
    bool useAsCollateral;
    address onBehalfOf;
    uint256 nonce;
    uint256 deadline;
  }

  function supplyWithSig(
    Supply calldata params,
    bytes calldata signature
  ) external returns (uint256, uint256);
  function withdrawWithSig(
    Withdraw calldata params,
    bytes calldata signature
  ) external returns (uint256, uint256);
  function borrowWithSig(
    Borrow calldata params,
    bytes calldata signature
  ) external returns (uint256, uint256);
  function repayWithSig(
    Repay calldata params,
    bytes calldata signature
  ) external returns (uint256, uint256);
  function setUsingAsCollateralWithSig(
    SetUsingAsCollateral calldata params,
    bytes calldata signature
  ) external;

  function SUPPLY_TYPEHASH() external pure returns (bytes32);
  function WITHDRAW_TYPEHASH() external pure returns (bytes32);
  function BORROW_TYPEHASH() external pure returns (bytes32);
  function REPAY_TYPEHASH() external pure returns (bytes32);
  function SET_USING_AS_COLLATERAL_TYPEHASH() external pure returns (bytes32);
  function DOMAIN_SEPARATOR() external view returns (bytes32);
  function nonces(address user, uint192 key) external view returns (uint256);
}
