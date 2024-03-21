// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {ProtocolV3TestBase, ReserveConfig, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {StataPayloads} from './V3PeripheryMaintenance_20240314.s.sol';

interface IFactory {
  function STATIC_A_TOKEN_IMPL() external returns (address);

  function getStaticATokens() external returns (address[] memory);
}

interface IStaticATokenLM {
  function asset() external returns (address);

  function decimals() external returns (uint256);

  function maxDeposit(address) external returns (uint256);

  function balanceOf(address) external returns (uint256);

  function convertToAssets(uint256) external returns (uint256);

  function deposit(uint256, address) external returns (uint256);
}

interface IUpgradePayload {
  function FACTORY() external returns (IFactory);

  function NEW_TOKEN_IMPLEMENTATION() external returns (address);

  function ADMIN() external returns (address);
}

interface ITransparentUpgradeableProxy {
  function implementation() external returns (address);
}

abstract contract UpgradePayloadTest is ProtocolV3TestBase {
  using SafeERC20 for IERC20;

  string public NETWORK;
  uint256 public immutable BLOCK_NUMBER;
  IUpgradePayload internal payload;

  constructor(string memory network, uint256 blocknumber) {
    NETWORK = network;
    BLOCK_NUMBER = blocknumber;
  }

  function setUp() public virtual {
    vm.createSelectFork(vm.rpcUrl(NETWORK), BLOCK_NUMBER);
    payload = IUpgradePayload(_getPayload());
    GovV3Helpers.executePayload(vm, address(payload));
  }

  function _getPayload() internal virtual returns (address);

  function _getFactory() internal returns (IFactory) {
    return payload.FACTORY();
  }

  function test_upgrade() external {
    address newImpl = _getFactory().STATIC_A_TOKEN_IMPL();

    // check factory is updated
    assertEq(newImpl, payload.NEW_TOKEN_IMPLEMENTATION());
    // check all tokens are updated
    address[] memory tokens = _getFactory().getStaticATokens();
    vm.startPrank(address(payload.ADMIN()));
    for (uint256 i = 0; i < tokens.length; i++) {
      assertEq(
        ITransparentUpgradeableProxy(payable(tokens[i])).implementation(),
        payload.NEW_TOKEN_IMPLEMENTATION()
      );
    }
  }

  function test_deposit() public {
    address[] memory tokens = _getFactory().getStaticATokens();
    for (uint256 i = 0; i < tokens.length; i++) {
      uint256 maxDeposit = IStaticATokenLM(tokens[i]).maxDeposit(address(this));
      if (maxDeposit == 0) continue;
      address underlying = address(IStaticATokenLM(tokens[i]).asset());
      uint256 testAmount = 10 ** IStaticATokenLM(tokens[i]).decimals();
      uint256 amount = maxDeposit < testAmount ? (maxDeposit * 99) / 100 : testAmount;
      deal2(address(underlying), address(this), amount);
      IERC20(underlying).forceApprove(address(tokens[i]), amount);
      IStaticATokenLM(tokens[i]).deposit(amount, address(this));
      uint256 shares = IStaticATokenLM(tokens[i]).balanceOf(address(this));
      assertApproxEqAbs(IStaticATokenLM(tokens[i]).convertToAssets(shares), amount, 10);
    }
  }
}

/**
 * command: make test-contract filter=UpgradeMainnetTest
 */
contract UpgradeMainnetTest is UpgradePayloadTest('mainnet', 19464108) {
  function _getPayload() internal virtual override returns (address) {
    return StataPayloads.MAINNET;
  }
}

contract UpgradePolygonTest is UpgradePayloadTest('polygon', 54815511) {
  function _getPayload() internal virtual override returns (address) {
    return StataPayloads.POLYGON;
  }
}

contract UpgradeAvalancheTest is UpgradePayloadTest('avalanche', 43073899) {
  function _getPayload() internal virtual override returns (address) {
    return StataPayloads.AVALANCHE;
  }
}

contract UpgradeArbitrumTest is UpgradePayloadTest('arbitrum', 191763863) {
  function _getPayload() internal virtual override returns (address) {
    return StataPayloads.ARBITRUM;
  }
}

contract UpgradeOptimismTest is UpgradePayloadTest('optimism', 117597816) {
  function _getPayload() internal virtual override returns (address) {
    return StataPayloads.OPTIMISM;
  }
}

contract UpgradeMetisTest is UpgradePayloadTest('metis', 15472572) {
  function _getPayload() internal virtual override returns (address) {
    return StataPayloads.METIS;
  }
}

contract UpgradeBNBTest is UpgradePayloadTest('bnb', 37086352) {
  function _getPayload() internal virtual override returns (address) {
    return StataPayloads.BNB;
  }
}

contract UpgradeScrollTest is UpgradePayloadTest('scroll', 4240928) {
  function _getPayload() internal virtual override returns (address) {
    return StataPayloads.SCROLL;
  }
}

contract UpgradeBaseTest is UpgradePayloadTest('base', 12002533) {
  function _getPayload() internal virtual override returns (address) {
    return StataPayloads.BASE;
  }
}

contract UpgradeGnosisTest is UpgradePayloadTest('gnosis', 32998007) {
  function _getPayload() internal virtual override returns (address) {
    return StataPayloads.GNOSIS;
  }
}
