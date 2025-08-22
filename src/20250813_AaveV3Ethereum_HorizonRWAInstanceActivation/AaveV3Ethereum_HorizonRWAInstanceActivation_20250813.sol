// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {IPoolDataProvider} from 'aave-v3-origin/contracts/interfaces/IPoolDataProvider.sol';
import {IPoolConfigurator} from 'aave-v3-origin/contracts/interfaces/IPoolConfigurator.sol';
import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
import {IGhoDirectMinter} from 'src/interfaces/IGhoDirectMinter.sol';
import {IACLManager} from 'aave-address-book/AaveV3.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';

import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';

/**
 * @title Horizon RWA Instance Activation
 * @author Aave Labs
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xc69410600084e9d3d27e6569dddda08fc053182bcf402e3e612fc97cab783f24
 * - Discussion: https://governance.aave.com/t/arfc-horizon-s-rwa-instance/21898
 */
contract AaveV3Ethereum_HorizonRWAInstanceActivation_20250813 is IProposalGenericExecutor {
  // STABLES
  // https://etherscan.io/address/0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f
  IGhoToken public constant GHO_TOKEN = IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING);
  // https://etherscan.io/address/0x8292Bb45bf1Ee4d140127049757C2E0fF06317eD
  address public constant RLUSD_TOKEN = AaveV3EthereumAssets.RLUSD_UNDERLYING;
  // https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48
  address public constant USDC_TOKEN = AaveV3EthereumAssets.USDC_UNDERLYING;

  // RWA
  address public constant USTB_TOKEN = 0x43415eB6ff9DB7E26A15b704e7A3eDCe97d31C4e;
  address public constant USCC_TOKEN = 0x14d60E7FDC0D71d8611742720E4C50E7a974020c;
  address public constant USYC_TOKEN = 0x136471a34f6ef19fE571EFFC1CA711fdb8E49f2b;
  address public constant JTRSY_TOKEN = 0x8c213ee79581Ff4984583C6a801e5263418C4b86;
  address public constant JAAA_TOKEN = 0x5a0F93D040De44e78F251b03c43be9CF317Dcf64;

  // HORIZON
  address public constant EMISSION_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;
  IEmissionManager public constant EMISSION_MANAGER =
    IEmissionManager(0xC2201708289b2C6A1d461A227A7E5ee3e7fE9A2F);
  IPoolDataProvider public constant PROTOCOL_DATA_PROVIDER =
    IPoolDataProvider(0x53519c32f73fE1797d10210c4950fFeBa3b21504);
  IPoolConfigurator public constant POOL_CONFIGURATOR =
    IPoolConfigurator(0x83Cb1B4af26EEf6463aC20AFbAC9c0e2E017202F);
  IACLManager public constant ACL_MANAGER = IACLManager(0xEFD5df7b87d2dCe6DD454b4240b3e0A4db562321);
  IGhoDirectMinter public constant GHO_DIRECT_MINTER =
    IGhoDirectMinter(0xe10C78A3AC7f016eD2DE1A89c5479b1039EAB9eA);

  // https://etherscan.io/address/0x46Aa1063e5265b43663E81329333B47c517A5409
  IGhoBucketSteward public constant GHO_BUCKET_STEWARD =
    IGhoBucketSteward(GhoEthereum.GHO_BUCKET_STEWARD);
  uint128 public constant GHO_MINT_AMOUNT = 1_000_000e18;

  function execute() external {
    _activateHorizon();
    _setEmissionAdmin();
    _setGhoDirectMinter();
    _seedGhoLiquidity();
  }

  function _activateHorizon() internal {
    POOL_CONFIGURATOR.setPoolPause(false);
  }

  function _setEmissionAdmin() internal {
    // stables
    _setEmissionAdminStablecoin(address(GHO_TOKEN));
    _setEmissionAdminStablecoin(RLUSD_TOKEN);
    _setEmissionAdminStablecoin(USDC_TOKEN);
    // rwa
    EMISSION_MANAGER.setEmissionAdmin(USTB_TOKEN, EMISSION_ADMIN);
    EMISSION_MANAGER.setEmissionAdmin(USCC_TOKEN, EMISSION_ADMIN);
    EMISSION_MANAGER.setEmissionAdmin(USYC_TOKEN, EMISSION_ADMIN);
    EMISSION_MANAGER.setEmissionAdmin(JAAA_TOKEN, EMISSION_ADMIN);
    EMISSION_MANAGER.setEmissionAdmin(JTRSY_TOKEN, EMISSION_ADMIN);
  }

  function _setEmissionAdminStablecoin(address token) internal {
    (address aToken, , ) = PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(token);
    EMISSION_MANAGER.setEmissionAdmin(token, EMISSION_ADMIN);
    EMISSION_MANAGER.setEmissionAdmin(aToken, EMISSION_ADMIN);
  }

  function _setGhoDirectMinter() internal {
    ACL_MANAGER.grantRole(ACL_MANAGER.RISK_ADMIN_ROLE(), address(GHO_DIRECT_MINTER));

    GHO_TOKEN.addFacilitator(address(GHO_DIRECT_MINTER), 'HorizonGhoDirectMinter', GHO_MINT_AMOUNT);

    // allow risk council to control the bucket capacity
    address[] memory facilitators = new address[](1);
    facilitators[0] = address(GHO_DIRECT_MINTER);
    GHO_BUCKET_STEWARD.setControlledFacilitator(facilitators, true);
  }

  function _seedGhoLiquidity() internal {
    GHO_DIRECT_MINTER.mintAndSupply(GHO_MINT_AMOUNT);
  }
}
