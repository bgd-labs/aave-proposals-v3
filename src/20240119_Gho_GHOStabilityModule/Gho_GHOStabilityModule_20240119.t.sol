// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV3EthereumAssets, AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {IPoolConfigurator} from 'aave-address-book/AaveV3.sol';
import {Gho_GHOStabilityModule_20240119} from './Gho_GHOStabilityModule_20240119.sol';

interface IGhoToken {
  struct Facilitator {
    uint128 bucketCapacity;
    uint128 bucketLevel;
    string label;
  }

  function getFacilitator(address facilitator) external view returns (Facilitator memory);

  function getFacilitatorsList() external view returns (address[] memory);
}

interface IGsm {
  function hasRole(bytes32 role, address account) external view returns (bool);

  function getFeeStrategy() external view returns (address);

  function getAvailableUnderlyingExposure() external view returns (uint256);

  function getIsFrozen() external view returns (bool);

  function getIsSeized() external view returns (bool);

  function UNDERLYING_ASSET() external view returns (address);

  function CONFIGURATOR_ROLE() external pure returns (bytes32);

  function TOKEN_RESCUER_ROLE() external pure returns (bytes32);

  function SWAP_FREEZER_ROLE() external view returns (bytes32);

  function LIQUIDATOR_ROLE() external pure returns (bytes32);
}

interface IFeeStrategy {
  function getBuyFee(uint256 grossAmount) external view returns (uint256);

  function getSellFee(uint256 grossAmount) external view returns (uint256);
}

interface IOracleSwapFreezer {
  function getCanUnfreeze() external view returns (bool);

  function getFreezeBound() external view returns (uint128, uint128);

  function getUnfreezeBound() external view returns (uint128, uint128);

  function checkUpkeep(bytes calldata) external view returns (bool, bytes memory);

  function performUpkeep(bytes calldata) external;
}

interface IPriceOracle {
  function getAssetPrice(address asset) external view returns (uint256);
}

/**
 * @dev Test for Gho_GHOStabilityModule_20240119
 * command: make test-contract filter=Gho_GHOStabilityModule_20240119
 */
contract Gho_GHOStabilityModule_20240119_Test is ProtocolV3TestBase {
  Gho_GHOStabilityModule_20240119 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19075310);
    proposal = new Gho_GHOStabilityModule_20240119();
  }

  function test_defaultProposalExecution() public {
    defaultTest('Gho_GHOStabilityModule_20240119', AaveV3Ethereum.POOL, address(proposal));
  }

  function test_checkConfig() public {
    uint256 facilitatorListLengthBefore = IGhoToken(MiscEthereum.GHO_TOKEN)
      .getFacilitatorsList()
      .length;

    executePayload(vm, address(proposal));

    assertTrue(
      IGhoToken(MiscEthereum.GHO_TOKEN).getFacilitatorsList().length ==
        facilitatorListLengthBefore + 2
    );
    IGhoToken.Facilitator memory gsmUsdc = IGhoToken(MiscEthereum.GHO_TOKEN).getFacilitator(
      proposal.GSM_USDC()
    );
    assertEq(gsmUsdc.label, proposal.GSM_USDC_FACILITATOR_LABEL());
    assertEq(gsmUsdc.bucketCapacity, proposal.GSM_USDC_BUCKET_CAPACITY());
    assertEq(gsmUsdc.bucketLevel, 0);

    IGhoToken.Facilitator memory gsmUsdt = IGhoToken(MiscEthereum.GHO_TOKEN).getFacilitator(
      proposal.GSM_USDT()
    );
    assertEq(gsmUsdt.label, proposal.GSM_USDT_FACILITATOR_LABEL());
    assertEq(gsmUsdt.bucketCapacity, proposal.GSM_USDT_BUCKET_CAPACITY());
    assertEq(gsmUsdt.bucketLevel, 0);

    // GSM USDC
    GsmConfig memory gsmUsdcConfig = GsmConfig({
      sellFee: 0.0020e4, // 0.2%
      buyFee: 0.0020e4, // 0.2%
      exposureCap: 500_000e6,
      isFrozen: false,
      isSeized: false,
      freezerCanUnfreeze: true,
      freezeLowerBound: 0.99e8,
      freezeUpperBound: 1.01e8,
      unfreezeLowerBound: 0.995e8,
      unfreezeUpperBound: 1.005e8
    });
    _checkGsmConfig(
      IGsm(proposal.GSM_USDC()),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      IOracleSwapFreezer(proposal.GSM_USDC_ORACLE_SWAP_FREEZER()),
      gsmUsdcConfig
    );

    // GSM USDT
    GsmConfig memory gsmUsdtConfig = GsmConfig({
      sellFee: 0.0020e4, // 0.2%
      buyFee: 0.0020e4, // 0.2%
      exposureCap: 500_000e6,
      isFrozen: false,
      isSeized: false,
      freezerCanUnfreeze: true,
      freezeLowerBound: 0.99e8,
      freezeUpperBound: 1.01e8,
      unfreezeLowerBound: 0.995e8,
      unfreezeUpperBound: 1.005e8
    });
    _checkGsmConfig(
      IGsm(proposal.GSM_USDT()),
      AaveV3EthereumAssets.USDT_UNDERLYING,
      IOracleSwapFreezer(proposal.GSM_USDT_ORACLE_SWAP_FREEZER()),
      gsmUsdtConfig
    );
  }

  function test_oracleSwapFreezers() public {
    // OracleSwapFreezers are not authorized
    assertEq(
      IGsm(proposal.GSM_USDC()).hasRole(
        IGsm(proposal.GSM_USDC()).SWAP_FREEZER_ROLE(),
        proposal.GSM_USDC_ORACLE_SWAP_FREEZER()
      ),
      false
    );
    assertEq(
      IGsm(proposal.GSM_USDT()).hasRole(
        IGsm(proposal.GSM_USDT()).SWAP_FREEZER_ROLE(),
        proposal.GSM_USDT_ORACLE_SWAP_FREEZER()
      ),
      false
    );

    IOracleSwapFreezer usdcFreezer = IOracleSwapFreezer(proposal.GSM_USDC_ORACLE_SWAP_FREEZER());
    IOracleSwapFreezer usdtFreezer = IOracleSwapFreezer(proposal.GSM_USDT_ORACLE_SWAP_FREEZER());
    (uint128 usdcFreezeLowerBound, ) = usdcFreezer.getFreezeBound();
    (uint128 usdcUnfreezeLowerBound, ) = usdcFreezer.getUnfreezeBound();
    (uint128 usdtFreezeLowerBound, ) = usdtFreezer.getFreezeBound();
    (uint128 usdtUnfreezeLowerBound, ) = usdtFreezer.getUnfreezeBound();

    // Price outside the price range
    // Freezers cannot execute freeze without authorization
    _mockAssetPrice(
      address(AaveV3Ethereum.ORACLE),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      usdcFreezeLowerBound - 1
    );
    _mockAssetPrice(
      address(AaveV3Ethereum.ORACLE),
      AaveV3EthereumAssets.USDT_UNDERLYING,
      usdtFreezeLowerBound - 1
    );

    (bool canPerformUpkeep, ) = usdcFreezer.checkUpkeep(bytes(''));
    assertEq(canPerformUpkeep, false);
    usdcFreezer.performUpkeep(bytes(''));
    assertEq(IGsm(proposal.GSM_USDC()).getIsFrozen(), false);

    (canPerformUpkeep, ) = usdtFreezer.checkUpkeep(bytes(''));
    assertEq(canPerformUpkeep, false);
    usdtFreezer.performUpkeep(bytes(''));
    assertEq(IGsm(proposal.GSM_USDT()).getIsFrozen(), false);

    // Payload execution
    executePayload(vm, address(proposal));

    // Freezers are authorized now
    assertEq(
      IGsm(proposal.GSM_USDC()).hasRole(
        IGsm(proposal.GSM_USDC()).SWAP_FREEZER_ROLE(),
        proposal.GSM_USDC_ORACLE_SWAP_FREEZER()
      ),
      true
    );
    assertEq(
      IGsm(proposal.GSM_USDT()).hasRole(
        IGsm(proposal.GSM_USDT()).SWAP_FREEZER_ROLE(),
        proposal.GSM_USDT_ORACLE_SWAP_FREEZER()
      ),
      true
    );

    // Freezers freeze GSM contracts
    (canPerformUpkeep, ) = usdcFreezer.checkUpkeep(bytes(''));
    assertEq(canPerformUpkeep, true);
    usdcFreezer.performUpkeep(bytes(''));
    assertEq(IGsm(proposal.GSM_USDC()).getIsFrozen(), true);

    (canPerformUpkeep, ) = usdtFreezer.checkUpkeep(bytes(''));
    assertEq(canPerformUpkeep, true);
    usdtFreezer.performUpkeep(bytes(''));
    assertEq(IGsm(proposal.GSM_USDT()).getIsFrozen(), true);

    // Price back to normal
    _mockAssetPrice(
      address(AaveV3Ethereum.ORACLE),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      usdcUnfreezeLowerBound + 1
    );
    _mockAssetPrice(
      address(AaveV3Ethereum.ORACLE),
      AaveV3EthereumAssets.USDT_UNDERLYING,
      usdtUnfreezeLowerBound + 1
    );

    (canPerformUpkeep, ) = usdcFreezer.checkUpkeep(bytes(''));
    assertEq(canPerformUpkeep, true);
    usdcFreezer.performUpkeep(bytes(''));
    assertEq(IGsm(proposal.GSM_USDC()).getIsFrozen(), false);

    (canPerformUpkeep, ) = usdtFreezer.checkUpkeep(bytes(''));
    assertEq(canPerformUpkeep, true);
    usdtFreezer.performUpkeep(bytes(''));
    assertEq(IGsm(proposal.GSM_USDT()).getIsFrozen(), false);
  }

  function test_checkRoles() public {
    executePayload(vm, address(proposal));

    _checkRolesConfig(IGsm(proposal.GSM_USDC()));
    _checkRolesConfig(IGsm(proposal.GSM_USDT()));
  }

  function _checkRolesConfig(IGsm gsm) internal {
    // DAO permissions
    assertTrue(
      gsm.hasRole(bytes32(0), GovernanceV3Ethereum.EXECUTOR_LVL_1),
      'Executor is not admin'
    );
    assertTrue(
      gsm.hasRole(gsm.SWAP_FREEZER_ROLE(), GovernanceV3Ethereum.EXECUTOR_LVL_1),
      'Executor is not swap freezer'
    );
    assertTrue(
      gsm.hasRole(gsm.CONFIGURATOR_ROLE(), GovernanceV3Ethereum.EXECUTOR_LVL_1),
      'Executor is not configurator'
    );
    // No need to be liquidator or token rescuer at the beginning
    assertFalse(gsm.hasRole(gsm.LIQUIDATOR_ROLE(), GovernanceV3Ethereum.EXECUTOR_LVL_1));
    assertFalse(gsm.hasRole(gsm.TOKEN_RESCUER_ROLE(), GovernanceV3Ethereum.EXECUTOR_LVL_1));

    // Deployer does not have permissions
    address deployer = 0x99C7A4A4Ab99882C422eF777b182eBda204D5B02;
    assertFalse(gsm.hasRole(bytes32(0), deployer), 'Deployer cannot be admin');
    assertFalse(gsm.hasRole(gsm.SWAP_FREEZER_ROLE(), deployer), 'Deployer cannot be swap freezer');
    assertFalse(gsm.hasRole(gsm.CONFIGURATOR_ROLE(), deployer), 'Deployer cannot be configurator');
    assertFalse(gsm.hasRole(gsm.LIQUIDATOR_ROLE(), deployer), 'Deployer cannot be liquidator');
    assertFalse(
      gsm.hasRole(gsm.TOKEN_RESCUER_ROLE(), deployer),
      'Deployer cannot be token rescuer'
    );
  }

  function _mockAssetPrice(address priceOracle, address asset, uint256 price) internal {
    vm.mockCall(
      priceOracle,
      abi.encodeWithSelector(IPriceOracle.getAssetPrice.selector, asset),
      abi.encode(price)
    );
  }

  struct GsmConfig {
    uint256 sellFee;
    uint256 buyFee;
    uint256 exposureCap;
    bool isFrozen;
    bool isSeized;
    bool freezerCanUnfreeze;
    uint256 freezeLowerBound;
    uint256 freezeUpperBound;
    uint256 unfreezeLowerBound;
    uint256 unfreezeUpperBound;
  }

  function _checkGsmConfig(
    IGsm gsm,
    address underlying,
    IOracleSwapFreezer freezer,
    GsmConfig memory config
  ) internal {
    assertEq(gsm.UNDERLYING_ASSET(), underlying, 'wrong underlying asset');
    assertEq(gsm.getAvailableUnderlyingExposure(), config.exposureCap, 'wrong exposure cap');
    assertEq(gsm.getIsFrozen(), config.isFrozen, 'wrong freeze state');
    assertEq(gsm.getIsSeized(), config.isSeized, 'wrong seized state');

    IFeeStrategy feeStrategy = IFeeStrategy(gsm.getFeeStrategy());
    assertEq(feeStrategy.getSellFee(10000), config.sellFee, 'wrong sell fee');
    assertEq(feeStrategy.getBuyFee(10000), config.buyFee, 'wrong buy fee');

    // Oracle freezer
    assertEq(freezer.getCanUnfreeze(), config.freezerCanUnfreeze, 'wrong freezer config');
    (uint256 lowerBound, uint256 upperBound) = freezer.getFreezeBound();
    assertEq(lowerBound, config.freezeLowerBound, 'wrong freeze lower bound');
    assertEq(upperBound, config.freezeUpperBound, 'wrong freeze upper bound');
    (lowerBound, upperBound) = freezer.getUnfreezeBound();
    assertEq(lowerBound, config.unfreezeLowerBound, 'wrong unfreeze lower bound');
    assertEq(upperBound, config.unfreezeUpperBound, 'wrong unfreeze upper bound');
  }
}
