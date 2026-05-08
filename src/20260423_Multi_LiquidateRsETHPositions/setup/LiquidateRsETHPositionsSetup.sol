// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IPool, IPoolConfigurator, IAaveOracle, ICollector} from 'aave-address-book/AaveV3.sol';
import {ReserveConfiguration} from 'aave-v3-origin/contracts/protocol/libraries/configuration/ReserveConfiguration.sol';
import {UserConfiguration} from 'aave-v3-origin/contracts/protocol/libraries/configuration/UserConfiguration.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';
import {WadRayMath} from 'aave-v3-origin/contracts/protocol/libraries/math/WadRayMath.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IGuardianEnabledFlag} from 'src/interfaces/IGuardianEnabledFlag.sol';

/// @notice Liquidates listed rsETH positions; per-chain payloads provide config via getters.
abstract contract LiquidateRsETHPositionsSetup is IProposalGenericExecutor {
  using SafeERC20 for IERC20;
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;
  using UserConfiguration for DataTypes.UserConfigurationMap;
  using WadRayMath for uint256;

  struct CollateralConfig {
    uint256 ltv;
    uint256 liquidationThreshold;
    uint256 liquidationBonus;
  }

  struct ExecuteState {
    address rseth;
    address weth;
    address wsteth;
    address rsethOracleBefore;
    uint256 rsethLiquidationFeeBefore;
    bool rsethWasPaused;
    bool wethWasPaused;
    bool wstethWasPaused;
    /// @dev Hardcoded (at proposal-write time) scaled WETH debt × current variable borrow index, captured
    /// at snapshot time
    uint256 staticWethDebt;
    uint256 executorRsethBefore;
    address[] userCollateralAssets;
    CollateralConfig[] collateralAssetsConfigBefore;
  }

  uint256 public constant MIN_LT_BPS = 1;
  uint256 public constant MIN_LTV_BPS = 1;
  uint256 public constant DEBT_ASSET_BUFFER = 0.01 ether;

  function execute() external override {
    require(IGuardianEnabledFlag(GUARDIAN_ENABLED_FLAG()).enabled(), 'GUARDIAN_FLAG_DISABLED');
    address user = getUser();
    ExecuteState memory s = _snapshotState(user);
    _applyNewRiskParams(s);
    _beforeLiquidations(s);
    _liquidateUser(user, s);
    _afterLiquidations(s);
    _restoreRiskParams(s);
    _sweepRemaining(s);
  }

  function POOL() public view virtual returns (IPool);

  function ORACLE() public view virtual returns (IAaveOracle);

  function POOL_CONFIGURATOR() public view virtual returns (IPoolConfigurator);

  function COLLECTOR() public view virtual returns (ICollector);

  function RSETH() public pure virtual returns (address);

  function WETH() public pure virtual returns (address);

  function WSTETH() public pure virtual returns (address);

  function FIXED_PRICE_FEED() public pure virtual returns (address);

  function RECOVERY_GUARDIAN() public pure virtual returns (address);

  function GUARDIAN_ENABLED_FLAG() public pure virtual returns (address);

  function getUser() public pure virtual returns (address);

  /// @dev Hardcoded scaled WETH variable debt captured at proposal-write time.
  /// Used to bound the Eth Umbrella offset increase. Per-user override.
  function wethScaledDebt() public pure virtual returns (uint256);

  function _applyNewRiskParams(ExecuteState memory s) internal {
    _setRsEthOracleSource(FIXED_PRICE_FEED());
    POOL_CONFIGURATOR().setLiquidationProtocolFee(s.rseth, 0);
    _updateReserveCollateralConfig(
      s.userCollateralAssets,
      _buildMinLtConfigs(s.collateralAssetsConfigBefore)
    );
    if (s.rsethWasPaused) {
      POOL_CONFIGURATOR().setReservePause({asset: s.rseth, paused: false, gracePeriod: 0});
    }
    if (s.wethWasPaused) {
      POOL_CONFIGURATOR().setReservePause({asset: s.weth, paused: false, gracePeriod: 0});
    }
    if (s.wstethWasPaused) {
      POOL_CONFIGURATOR().setReservePause({asset: s.wsteth, paused: false, gracePeriod: 0});
    }
  }

  /// @dev Pick the debt asset with the bigger USD-valued debt.
  function _liquidateUser(address user, ExecuteState memory s) internal {
    uint256 wethDebt = IERC20(POOL().getReserveData(s.weth).variableDebtTokenAddress).balanceOf(
      user
    );
    uint256 wstethDebt = IERC20(POOL().getReserveData(s.wsteth).variableDebtTokenAddress).balanceOf(
      user
    );
    require(wethDebt != 0 || wstethDebt != 0, 'NO_DEBT');

    address debtAsset = s.weth;
    if (wstethDebt * ORACLE().getAssetPrice(s.wsteth) > wethDebt * ORACLE().getAssetPrice(s.weth)) {
      debtAsset = s.wsteth;
    }

    COLLECTOR().transfer(IERC20(debtAsset), address(this), DEBT_ASSET_BUFFER);
    IERC20(debtAsset).forceApprove(address(POOL()), DEBT_ASSET_BUFFER);

    // if user is healthy, allow liquidation to revert
    POOL().liquidationCall({
      collateralAsset: s.rseth,
      debtAsset: debtAsset,
      borrower: user,
      debtToCover: type(uint256).max,
      receiveAToken: false
    });

    IERC20(debtAsset).forceApprove(address(POOL()), 0);
  }

  function _restoreRiskParams(ExecuteState memory s) internal {
    _setRsEthOracleSource(s.rsethOracleBefore);
    POOL_CONFIGURATOR().setLiquidationProtocolFee(s.rseth, s.rsethLiquidationFeeBefore);
    _updateReserveCollateralConfig(s.userCollateralAssets, s.collateralAssetsConfigBefore);
    if (s.rsethWasPaused) {
      POOL_CONFIGURATOR().setReservePause({asset: s.rseth, paused: true, gracePeriod: 0});
    }
    if (s.wethWasPaused) {
      POOL_CONFIGURATOR().setReservePause({asset: s.weth, paused: true, gracePeriod: 0});
    }
    if (s.wstethWasPaused) {
      POOL_CONFIGURATOR().setReservePause({asset: s.wsteth, paused: true, gracePeriod: 0});
    }
  }

  /// @dev Seized rsETH goes to the recovery guardian; WETH/wstETH leftovers go
  /// back to the collector (where the buffer originated).
  function _sweepRemaining(ExecuteState memory s) internal {
    uint256 rsethSeized = IERC20(s.rseth).balanceOf(address(this)) - s.executorRsethBefore;
    if (rsethSeized > 0) {
      IERC20(s.rseth).safeTransfer(RECOVERY_GUARDIAN(), rsethSeized);
    }
    uint256 wethLeft = IERC20(s.weth).balanceOf(address(this));
    if (wethLeft > 0) {
      IERC20(s.weth).safeTransfer(address(COLLECTOR()), wethLeft);
    }
    uint256 wstethLeft = IERC20(s.wsteth).balanceOf(address(this));
    if (wstethLeft > 0) {
      IERC20(s.wsteth).safeTransfer(address(COLLECTOR()), wstethLeft);
    }
  }

  function _setRsEthOracleSource(address feed) internal {
    address[] memory assets = new address[](1);
    address[] memory feeds = new address[](1);
    assets[0] = RSETH();
    feeds[0] = feed;
    ORACLE().setAssetSources({assets: assets, sources: feeds});
  }

  function _updateReserveCollateralConfig(
    address[] memory assets,
    CollateralConfig[] memory config
  ) internal {
    require(assets.length == config.length, 'LENGTH_MISMATCH');
    for (uint256 i; i < assets.length; ++i) {
      POOL_CONFIGURATOR().configureReserveAsCollateral({
        asset: assets[i],
        ltv: config[i].ltv,
        liquidationThreshold: config[i].liquidationThreshold,
        liquidationBonus: config[i].liquidationBonus
      });
    }
  }

  function _beforeLiquidations(ExecuteState memory s) internal virtual;

  function _afterLiquidations(ExecuteState memory s) internal virtual;

  function _snapshotState(address user) internal view returns (ExecuteState memory s) {
    s.rseth = RSETH();
    s.weth = WETH();
    s.wsteth = WSTETH();
    s.userCollateralAssets = _fetchCollateralAssets(user);
    s.collateralAssetsConfigBefore = _snapshotCollateralConfigs(s.userCollateralAssets);
    s.rsethOracleBefore = ORACLE().getSourceOfAsset(s.rseth);
    s.rsethLiquidationFeeBefore = POOL().getConfiguration(s.rseth).getLiquidationProtocolFee();
    s.rsethWasPaused = POOL().getConfiguration(s.rseth).getPaused();
    s.wethWasPaused = POOL().getConfiguration(s.weth).getPaused();
    s.wstethWasPaused = POOL().getConfiguration(s.wsteth).getPaused();
    s.staticWethDebt = wethScaledDebt().rayMulCeil(POOL().getReserveNormalizedVariableDebt(s.weth));
    s.executorRsethBefore = IERC20(s.rseth).balanceOf(address(this));
  }

  function _snapshotCollateralConfigs(
    address[] memory assets
  ) internal view returns (CollateralConfig[] memory configs) {
    configs = new CollateralConfig[](assets.length);
    for (uint256 i; i < assets.length; ++i) {
      DataTypes.ReserveConfigurationMap memory config = POOL().getConfiguration(assets[i]);
      configs[i] = CollateralConfig({
        ltv: config.getLtv(),
        liquidationThreshold: config.getLiquidationThreshold(),
        liquidationBonus: config.getLiquidationBonus()
      });
    }
    return configs;
  }

  function _fetchCollateralAssets(address user) internal view returns (address[] memory) {
    address[] memory reserves = POOL().getReservesList();
    DataTypes.UserConfigurationMap memory userConfig = POOL().getUserConfiguration(user);

    uint256 count;
    for (uint256 i; i < reserves.length; ++i) {
      if (userConfig.isUsingAsCollateral(i)) {
        count += 1;
      }
    }

    address[] memory collateralAssets = new address[](count);

    count = 0;
    for (uint256 i; i < reserves.length; ++i) {
      if (userConfig.isUsingAsCollateral(i)) {
        collateralAssets[count] = reserves[i];
        count += 1;
      }
    }

    return collateralAssets;
  }

  function _buildMinLtConfigs(
    CollateralConfig[] memory currentConfig
  ) internal pure returns (CollateralConfig[] memory minLtConfigs) {
    minLtConfigs = new CollateralConfig[](currentConfig.length);
    for (uint256 i; i < currentConfig.length; ++i) {
      minLtConfigs[i] = CollateralConfig({
        ltv: MIN_LTV_BPS,
        liquidationThreshold: MIN_LT_BPS,
        liquidationBonus: currentConfig[i].liquidationBonus
      });
    }

    return minLtConfigs;
  }
}
