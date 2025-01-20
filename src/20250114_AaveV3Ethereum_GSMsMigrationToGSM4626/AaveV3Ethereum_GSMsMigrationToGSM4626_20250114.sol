// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

import {IERC4626StataToken} from './IStata.sol';
import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGsm} from 'src/interfaces/IGsm.sol';

/**
 * @title GSMs Migration to GSM4626
 * @author TokenLogic
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Ethereum_GSMsMigrationToGSM4626_20250114 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  bytes32 public constant LIQUIDATOR_ROLE =
    0x5e17fc5225d4a099df75359ce1f405503ca79498a8dc46a7d583235a0ee45c16; // keccak256('LIQUIDATOR_ROLE')
  uint128 public constant USDC_CAPACITY = 0;
  uint128 public constant USDT_CAPACITY = 0;
  address public constant NEW_GSM_USDC = address(0);
  address public constant NEW_GSM_USDT = address(0);
  address public constant FEE_STRATEGY = 0x83896a35db4519BD8CcBAF5cF86CCA61b5cfb938;

  function execute() external {
    uint256 balanceUsdc = IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceUsdt = IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    _seize();
    _grantAccess();
    _fund(balanceUsdc, balanceUsdt);
    _revokeAccess();
    // gsm registry
  }

  function _fund(uint256 balanceUsdc, uint256 balanceUsdt) internal {
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      address(this),
      balanceUsdc
    );
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      address(this),
      balanceUsdt
    );

    IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).forceApprove(
      AaveV3EthereumAssets.USDC_STATA_TOKEN,
      balanceUsdc
    );
    IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).forceApprove(
      AaveV3EthereumAssets.USDT_STATA_TOKEN,
      balanceUsdt
    );

    uint256 sharesUsdc = IERC4626StataToken(AaveV3EthereumAssets.USDC_STATA_TOKEN).deposit(
      balanceUsdc,
      address(this)
    );
    uint256 sharesUsdt = IERC4626StataToken(AaveV3EthereumAssets.USDT_STATA_TOKEN).deposit(
      balanceUsdt,
      address(this)
    );

    IERC20(AaveV3EthereumAssets.USDC_STATA_TOKEN).forceApprove(NEW_GSM_USDC, sharesUsdc);
    IERC20(AaveV3EthereumAssets.USDT_STATA_TOKEN).forceApprove(NEW_GSM_USDT, sharesUsdt);

    (, uint256 amountGhoUsdc) = IGsm(NEW_GSM_USDC).sellAsset(sharesUsdc, address(this));
    (, uint256 amountGhoUsdt) = IGsm(NEW_GSM_USDT).sellAsset(sharesUsdt, address(this));

    (, uint256 ghoUsdcNeeded) = IGhoToken(GhoEthereum.GHO_TOKEN).getFacilitatorBucket(
      GhoEthereum.GSM_USDC
    );
    (, uint256 ghoUsdtNeeded) = IGhoToken(GhoEthereum.GHO_TOKEN).getFacilitatorBucket(
      GhoEthereum.GSM_USDT
    );

    uint256 difference = ghoUsdcNeeded + ghoUsdtNeeded - amountGhoUsdc - amountGhoUsdt;
    if (difference > 0) {
      AaveV3Ethereum.COLLECTOR.transfer(GhoEthereum.GHO_TOKEN, address(this), difference);
    }

    IERC20(GhoEthereum.GSM_USDC).forceApprove(GhoEthereum.GSM_USDC, ghoUsdcNeeded);
    IERC20(GhoEthereum.GSM_USDT).forceApprove(GhoEthereum.GSM_USDT, ghoUsdtNeeded);

    IGsm(GhoEthereum.GSM_USDC).burnAfterSeize(ghoUsdcNeeded);
    IGsm(GhoEthereum.GSM_USDT).burnAfterSeize(ghoUsdtNeeded);
  }

  function _seize() internal {
    IGsm(GhoEthereum.GSM_USDC).grantRole(LIQUIDATOR_ROLE, address(this));
    IGsm(GhoEthereum.GSM_USDT).grantRole(LIQUIDATOR_ROLE, address(this));

    IGsm(GhoEthereum.GSM_USDC).seize();
    IGsm(GhoEthereum.GSM_USDT).seize();
  }

  function _grantAccess() internal {
    IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).addFacilitator(
      NEW_GSM_USDC,
      'USDC_GSM_4626',
      USDC_CAPACITY
    );
    IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).addFacilitator(
      NEW_GSM_USDC,
      'USDC_GSM_4626',
      USDC_CAPACITY
    );

    // Allow risk council to control the bucket capacity
    address[] memory vaults = new address[](2);
    vaults[0] = NEW_GSM_USDC;
    vaults[1] = NEW_GSM_USDT;
    IGhoBucketSteward(0x46Aa1063e5265b43663E81329333B47c517A5409).setControlledFacilitator(
      vaults,
      true
    );
  }

  function _revokeAccess() internal {
    IGhoToken(GhoEthereum.GHO_TOKEN).removeFacilitator(GhoEthereum.GSM_USDC);
    IGhoToken(GhoEthereum.GHO_TOKEN).removeFacilitator(GhoEthereum.GSM_USDT);

    // Revoke existing GSMs
    address[] memory revokedVaults = new address[](2);
    revokedVaults[0] = GhoEthereum.GSM_USDC;
    revokedVaults[1] = GhoEthereum.GSM_USDT;
    // https://etherscan.io/address/0x46Aa1063e5265b43663E81329333B47c517A5409
    IGhoBucketSteward(0x46Aa1063e5265b43663E81329333B47c517A5409).setControlledFacilitator(
      revokedVaults,
      false
    );
  }
}
