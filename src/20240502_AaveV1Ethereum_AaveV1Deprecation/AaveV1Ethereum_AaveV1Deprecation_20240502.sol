// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV1} from 'aave-address-book/AaveV1.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

interface ILendingPoolCore {
  function getReserves() external view returns (address[] memory);

  function getReserveInterestRateStrategyAddress(address) external view returns (address);

  function getReserveATokenAddress(address) external view returns (address);

  function getReserveLiquidityCumulativeIndex(address) external view returns (uint256);

  function getReserveVariableBorrowsCumulativeIndex(address) external view returns (uint256);

  function getReserveCurrentLiquidityRate(address) external view returns (uint256);

  function getReserveCurrentVariableBorrowRate(address) external view returns (uint256);

  function getReserveCurrentStableBorrowRate(address) external view returns (uint256);
}

interface ILendingPoolAddressesProvider {
  function getLendingPoolCore() external view returns (address);

  function setLendingPoolCoreImpl(address _core) external;

  function getLendingPool() external view returns (address);

  function setLendingPoolImpl(address _pool) external;

  function getLendingPoolLiquidationManager() external view returns (address);

  function setLendingPoolLiquidationManager(address _manager) external;
}

interface IPoolConfigurator {
  function setReserveInterestRateStrategyAddress(
    address _reserve,
    address _rateStrategyAddress
  ) external;
}

interface IAaveOracle {
  function setAssetSources(address[] calldata _assets, address[] calldata _sources) external;

  function getAssetPrice(address asset) external returns (uint256);
}

interface IWETH {
  function withdraw(uint256) external;
}

/**
 * @title Aave V1 Deprecation
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x7451f00809986c7cb8cce7ef4587efdfedad06089ebf2851d64122d00b035d9c
 * - Discussion: https://governance.aave.com/t/temp-check-bgd-further-aave-v1-deprecation-strategy/15893/7
 */
contract AaveV1Ethereum_AaveV1Deprecation_20240502 is IProposalGenericExecutor {
  ILendingPoolAddressesProvider public constant ADDRESSES_PROVIDER =
    ILendingPoolAddressesProvider(AaveV1.ADDRESSES_PROVIDER);
  IPoolConfigurator public constant CONFIGURATOR =
    IPoolConfigurator(0x4965f6FA20fE9728deCf5165016fc338a5a85aBF);
  ILendingPoolCore public constant CORE =
    ILendingPoolCore(0x3dfd23A6c5E8BbcFc9581d2E864a68feb6a076d3);
  IAaveOracle public constant ORACLE = IAaveOracle(0x76B47460d7F7c5222cFb6b6A75615ab10895DDe4);

  address public constant CORE_IMPL = address(0x0E26E0bf83b4ec2cb0dcbC037bb01dA5BB352eAE);
  address public constant ZERO_IR = address(0xB20E27A199404bf9BCD56e37B6dE07DC906581Db);
  address public constant LIQUIDATION_MANAGER_IMPL =
    address(0xB67347196F551d1f85B7a07e64e0E47E6c9c254a);
  address public constant POOL_IMPL = address(0x588790f64ac1424862081A56b8329Decae206249);

  function execute() external {
    // 1. upgrade core to update irs one last time
    ADDRESSES_PROVIDER.setLendingPoolCoreImpl(CORE_IMPL);
    // 2. upgrade irs to be zero & deactivate reserve
    address[] memory reserves = CORE.getReserves();
    for (uint256 i = 0; i < reserves.length; i++) {
      CONFIGURATOR.setReserveInterestRateStrategyAddress(reserves[i], ZERO_IR);
    }
    // 3. upgrade liquidationManager
    ADDRESSES_PROVIDER.setLendingPoolLiquidationManager(LIQUIDATION_MANAGER_IMPL);
    // 4. upgrade lending pool
    ADDRESSES_PROVIDER.setLendingPoolImpl(POOL_IMPL);
    // 5. upgrade stablecoin oracles
    address[] memory assets = new address[](6);
    address[] memory sources = new address[](6);
    assets[0] = AaveV2EthereumAssets.BUSD_UNDERLYING;
    sources[0] = AaveV2EthereumAssets.BUSD_ORACLE;
    assets[1] = AaveV2EthereumAssets.DAI_UNDERLYING;
    sources[1] = AaveV2EthereumAssets.DAI_ORACLE;
    assets[2] = AaveV2EthereumAssets.USDC_UNDERLYING;
    sources[2] = AaveV2EthereumAssets.USDC_ORACLE;
    assets[3] = AaveV2EthereumAssets.TUSD_UNDERLYING;
    sources[3] = AaveV2EthereumAssets.TUSD_ORACLE;
    assets[4] = AaveV2EthereumAssets.sUSD_UNDERLYING;
    sources[4] = AaveV2EthereumAssets.sUSD_ORACLE;
    assets[5] = AaveV2EthereumAssets.USDT_UNDERLYING;
    sources[5] = AaveV2EthereumAssets.USDT_ORACLE;
    ORACLE.setAssetSources(assets, sources);
  }
}
