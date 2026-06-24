// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAaveOracle} from 'aave-v3-origin/contracts/interfaces/IAaveOracle.sol';
import {ProtocolV3HorizonTestBase} from 'tests/utils/ProtocolV3HorizonTestBase.sol';
import {AaveV3EthereumHorizon} from 'aave-address-book-latest/AaveV3EthereumHorizon.sol';
import {AaveV3EthereumHorizonCustom} from 'src/utils/AaveV3EthereumHorizonCustom.sol';
import {AaveHorizonGovV3Helpers} from 'src/utils/AaveHorizonGovV3Helpers.sol';

/**
 * @dev Test for the mGLOBAL price feed update to the LlamaGuard-bounded feed via the emergency multisig.
 * command: FOUNDRY_PROFILE=test forge test --match-contract AaveV3Horizon_mGLOBALPriceFeed_20260623 -vv
 */
contract AaveV3Horizon_mGLOBALPriceFeed_20260623 is ProtocolV3HorizonTestBase {
  address internal constant EMERGENCY_TARGET = address(AaveV3EthereumHorizon.ORACLE);
  // from Safe UI
  bytes internal constant EMERGENCY_DATA =
    hex'abfd53100000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000010000000000000000000000007433806912eae67919e66aea853d46fa0aef98a80000000000000000000000000000000000000000000000000000000000000001000000000000000000000000e034de753a3d855b6dad1a4984de75a5c443e939';
  uint256 internal constant EMERGENCY_NONCE = 11;

  address internal constant MGLOBAL = AaveV3EthereumHorizonCustom.MGLOBAL_UNDERLYING;

  // https://etherscan.io/address/0xe034De753a3d855B6daD1A4984de75a5c443E939
  address internal constant BOUNDED_PRICE_FEED = 0xe034De753a3d855B6daD1A4984de75a5c443E939;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25386805);
  }

  /**
   * @dev Full test suite: snapshots, state diff, validations, e2e.
   */
  function test_defaultProposalExecution() public {
    defaultTest_v3_3(
      'AaveV3Horizon_mGLOBALPriceFeed_20260623',
      _pool(),
      _executeMGLOBALPriceFeedUpdate
    );
  }

  /**
   * @dev Custom before/after assertions for the mGLOBAL price feed change.
   */
  function test_mglobalPriceFeedChange() public {
    IAaveOracle oracle = AaveV3EthereumHorizon.ORACLE;

    assertEq(
      oracle.getSourceOfAsset(MGLOBAL),
      AaveV3EthereumHorizonCustom.MGLOBAL_PRICE_FEED,
      'price feed before'
    );

    _executeMGLOBALPriceFeedUpdate();

    assertEq(oracle.getSourceOfAsset(MGLOBAL), BOUNDED_PRICE_FEED, 'price feed after');
  }

  /**
   * @dev The bounded feed should report the same price as the unbounded feed while within bounds
   *      (i.e. no cap is applied), so the reported mGLOBAL price is unchanged by the swap.
   */
  function test_mglobalPriceUnchanged() public {
    IAaveOracle oracle = AaveV3EthereumHorizon.ORACLE;

    uint256 priceBefore = oracle.getAssetPrice(MGLOBAL);

    _executeMGLOBALPriceFeedUpdate();

    assertEq(oracle.getAssetPrice(MGLOBAL), priceBefore, 'price changed after feed swap');
  }

  function test_calldata() public pure {
    address[] memory assets = new address[](1);
    assets[0] = MGLOBAL;
    address[] memory sources = new address[](1);
    sources[0] = BOUNDED_PRICE_FEED;

    AaveHorizonGovV3Helpers.Action memory action = AaveHorizonGovV3Helpers.Action({
      to: address(AaveV3EthereumHorizon.ORACLE),
      data: abi.encodeCall(IAaveOracle.setAssetSources, (assets, sources))
    });
    (address to, bytes memory data, uint8 operation) = AaveHorizonGovV3Helpers
      .createEmergencyMultisigCalldata(action);
    assertEq(to, EMERGENCY_TARGET, 'emergency target mismatch');
    assertEq(data, EMERGENCY_DATA, 'emergency calldata mismatch');
    assertEq(operation, 0, 'emergency operation mismatch');
  }

  /// @dev The bounded feed is the expected mGLOBAL price source after this change.
  function _expectedPriceFeed(address underlying) internal pure override returns (address) {
    if (underlying == MGLOBAL) {
      return BOUNDED_PRICE_FEED;
    }
    return super._expectedPriceFeed(underlying);
  }

  function _executeMGLOBALPriceFeedUpdate() internal {
    _executeEmergencyMultisigTx({
      to: EMERGENCY_TARGET,
      data: EMERGENCY_DATA,
      operation: 0,
      nonce: EMERGENCY_NONCE
    });
  }
}
