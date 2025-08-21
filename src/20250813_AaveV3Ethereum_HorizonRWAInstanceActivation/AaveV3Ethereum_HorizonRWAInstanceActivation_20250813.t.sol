// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';

import {IERC20Detailed} from 'aave-v3-origin/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol';
import {IPoolAddressesProvider} from 'aave-v3-origin/contracts/interfaces/IPoolAddressesProvider.sol';
import {IWithGuardian} from 'solidity-utils/contracts/access-control/interfaces/IWithGuardian.sol';
import {IScaledBalanceToken} from 'aave-v3-origin/contracts/interfaces/IScaledBalanceToken.sol';
import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
import {IGhoDirectMinter} from 'src/interfaces/IGhoDirectMinter.sol';
import {IPool} from 'aave-v3-origin/contracts/interfaces/IPool.sol';
import {IACLManager} from 'aave-address-book/AaveV3.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IOwnable} from 'aave-address-book/common/IOwnable.sol';

import {ReserveConfiguration} from 'aave-v3-origin/contracts/protocol/libraries/configuration/ReserveConfiguration.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';

import {ProtocolV3HorizonTestBase} from './utils/ProtocolV3HorizonTestBase.sol';
import {AaveV3Ethereum_HorizonRWAInstanceActivation_20250813} from './AaveV3Ethereum_HorizonRWAInstanceActivation_20250813.sol';

/**
 * @dev Test for AaveV3Ethereum_HorizonRWAInstanceActivation_20250813
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250813_AaveV3Ethereum_HorizonRWAInstanceActivation/AaveV3Ethereum_HorizonRWAInstanceActivation_20250813.t.sol -vv
 */
contract AaveV3Ethereum_HorizonRWAInstanceActivation_20250813_Test is ProtocolV3HorizonTestBase {
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  AaveV3Ethereum_HorizonRWAInstanceActivation_20250813 internal proposal;

  address internal constant SUPERSTATE_ALLOWLIST_V2 = 0x02f1fA8B196d21c7b733EB2700B825611d8A38E5;
  uint256 internal constant SUPERSTATE_ROOT_ENTITY_ID = 1;
  address internal constant CENTRIFUGE_HOOK = 0x4737C3f62Cc265e786b280153fC666cEA2fBc0c0;
  address internal constant CENTRIFUGE_WARD = 0x09ab10a9c3E6Eac1d18270a2322B6113F4C7f5E8;
  uint8 internal constant CIRCLE_INVESTOR_SDYF_INTERNATIONAL_ROLE = 3;
  address internal constant CIRCLE_SET_USER_ROLE_AUTHORIZED_CALLER =
    0xDbE01f447040F78ccbC8Dfd101BEc1a2C21f800D;

  IPool internal constant POOL = IPool(0xAe05Cd22df81871bc7cC2a04BeCfb516bFe332C8); // horizon pool

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23133461);
    proposal = new AaveV3Ethereum_HorizonRWAInstanceActivation_20250813();
    _validateConstants();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_HorizonRWAInstanceActivation_20250813',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_defaultProposalExecution_HorizonPool() public {
    _whitelist(_testActors()); // whitelist test actors to hold RWA tokens
    defaultTest_v3_3(
      'AaveV3EthereumHorizon_HorizonRWAInstanceActivation_20250813',
      POOL,
      address(proposal)
    );
  }

  function test_activateHorizon() public {
    address[] memory reserves = POOL.getReservesList();
    for (uint256 i; i < reserves.length; ++i) {
      assertTrue(POOL.getConfiguration(reserves[i]).getPaused());
    }

    executePayload(vm, address(proposal));

    assertEq(abi.encode(POOL.getReservesList()), abi.encode(reserves));
    for (uint256 i; i < reserves.length; ++i) {
      assertFalse(POOL.getConfiguration(reserves[i]).getPaused());
    }
  }

  function test_setEmissionAdmin() public {
    _checkStableCoinEmissionAdmin(address(proposal.GHO_TOKEN()), address(0));
    _checkStableCoinEmissionAdmin(proposal.RLUSD_TOKEN(), address(0));
    _checkStableCoinEmissionAdmin(proposal.USDC_TOKEN(), address(0));

    _checkRwaEmissionAdmin(proposal.USTB_TOKEN(), address(0));
    _checkRwaEmissionAdmin(proposal.USCC_TOKEN(), address(0));
    _checkRwaEmissionAdmin(proposal.USYC_TOKEN(), address(0));
    _checkRwaEmissionAdmin(proposal.JAAA_TOKEN(), address(0));
    _checkRwaEmissionAdmin(proposal.JTRSY_TOKEN(), address(0));

    executePayload(vm, address(proposal));

    address emissionAdmin = address(proposal.EMISSION_ADMIN());
    _checkStableCoinEmissionAdmin(address(proposal.GHO_TOKEN()), emissionAdmin);
    _checkStableCoinEmissionAdmin(proposal.RLUSD_TOKEN(), emissionAdmin);
    _checkStableCoinEmissionAdmin(proposal.USDC_TOKEN(), emissionAdmin);

    _checkRwaEmissionAdmin(proposal.USTB_TOKEN(), emissionAdmin);
    _checkRwaEmissionAdmin(proposal.USCC_TOKEN(), emissionAdmin);
    _checkRwaEmissionAdmin(proposal.USYC_TOKEN(), emissionAdmin);
    _checkRwaEmissionAdmin(proposal.JAAA_TOKEN(), emissionAdmin);
    _checkRwaEmissionAdmin(proposal.JTRSY_TOKEN(), emissionAdmin);
  }

  function test_setGhoDirectMinter() public {
    IACLManager aclManager = IACLManager(proposal.ACL_MANAGER());
    address ghoDirectMinter = address(proposal.GHO_DIRECT_MINTER());
    IGhoToken ghoToken = IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING);
    IGhoBucketSteward bucketSteward = proposal.GHO_BUCKET_STEWARD();

    assertFalse(aclManager.hasRole(aclManager.RISK_ADMIN_ROLE(), ghoDirectMinter));
    assertEq(ghoToken.getFacilitator(ghoDirectMinter).bucketCapacity, 0);
    assertEq(ghoToken.getFacilitator(ghoDirectMinter).label, '');
    address[] memory facilitators = ghoToken.getFacilitatorsList();
    assertNotInList(facilitators, ghoDirectMinter);
    address[] memory controlledFacilitators = bucketSteward.getControlledFacilitators();
    assertNotInList(controlledFacilitators, ghoDirectMinter);

    executePayload(vm, address(proposal));

    assertTrue(aclManager.hasRole(aclManager.RISK_ADMIN_ROLE(), ghoDirectMinter));
    assertEq(ghoToken.getFacilitator(ghoDirectMinter).bucketCapacity, proposal.GHO_MINT_AMOUNT());
    assertEq(ghoToken.getFacilitator(ghoDirectMinter).bucketLevel, proposal.GHO_MINT_AMOUNT());
    assertEq(ghoToken.getFacilitator(ghoDirectMinter).label, 'HorizonGhoDirectMinter');
    assertEq(ghoToken.getFacilitatorsList().length, facilitators.length + 1);
    assertEq(ghoToken.getFacilitatorsList()[facilitators.length], ghoDirectMinter);
    assertEq(bucketSteward.getControlledFacilitators().length, controlledFacilitators.length + 1);
    assertEq(
      bucketSteward.getControlledFacilitators()[controlledFacilitators.length],
      ghoDirectMinter
    );
  }

  function test_seedGhoLiquidity() public {
    (address aGho, , ) = proposal.PROTOCOL_DATA_PROVIDER().getReserveTokensAddresses(
      AaveV3EthereumAssets.GHO_UNDERLYING
    );
    uint256 initialSeedLiquidity = 100e18;
    assertEq(IERC20Detailed(aGho).totalSupply(), initialSeedLiquidity);
    assertEq(IScaledBalanceToken(aGho).scaledTotalSupply(), initialSeedLiquidity);
    assertEq(POOL.getReserveNormalizedIncome(AaveV3EthereumAssets.GHO_UNDERLYING), 1e27);
    uint256 supplyCap = POOL.getConfiguration(AaveV3EthereumAssets.GHO_UNDERLYING).getSupplyCap();

    executePayload(vm, address(proposal));

    assertEq(
      IERC20Detailed(aGho).balanceOf(address(proposal.GHO_DIRECT_MINTER())),
      proposal.GHO_MINT_AMOUNT()
    );
    assertEq(IERC20Detailed(aGho).totalSupply(), initialSeedLiquidity + proposal.GHO_MINT_AMOUNT());
    assertEq(
      IScaledBalanceToken(aGho).scaledTotalSupply(),
      initialSeedLiquidity + proposal.GHO_MINT_AMOUNT()
    ); // since liq rate is 1
    assertEq(POOL.getReserveNormalizedIncome(AaveV3EthereumAssets.GHO_UNDERLYING), 1e27);
    assertEq(POOL.getConfiguration(AaveV3EthereumAssets.GHO_UNDERLYING).getSupplyCap(), supplyCap);
  }

  function assertNotInList(address[] memory list, address element) internal pure {
    for (uint256 i; i < list.length; ++i) {
      assertNotEq(list[i], element);
    }
  }

  function _checkStableCoinEmissionAdmin(address token, address admin) internal view {
    (address aToken, , ) = proposal.PROTOCOL_DATA_PROVIDER().getReserveTokensAddresses(token);
    assertEq(proposal.EMISSION_MANAGER().getEmissionAdmin(token), admin);
    assertEq(proposal.EMISSION_MANAGER().getEmissionAdmin(aToken), admin);
  }

  function _checkRwaEmissionAdmin(address token, address admin) internal view {
    assertEq(proposal.EMISSION_MANAGER().getEmissionAdmin(token), admin);
  }

  function _whitelist(address[] memory callers) internal {
    for (uint256 i; i < callers.length; ++i) {
      _whitelistSuperstateRwa(callers[i]);
      _whitelistCentrifugeRwa(callers[i]);
      _whitelistUsycRwa(callers[i]);
    }

    _whitelistSuperstateRwa(POOL.getReserveAToken(proposal.USTB_TOKEN()));
    _whitelistSuperstateRwa(POOL.getReserveAToken(proposal.USCC_TOKEN()));

    _whitelistUsycRwa(POOL.getReserveAToken(proposal.USYC_TOKEN()));
    // if `msg.sender` is not `from` in `transferFrom` then the msg.sender must be whitelisted as well
    _whitelistUsycRwa(address(POOL));

    _whitelistCentrifugeRwa(POOL.getReserveAToken(proposal.JTRSY_TOKEN()));
    _whitelistCentrifugeRwa(POOL.getReserveAToken(proposal.JAAA_TOKEN()));
  }

  function _whitelistSuperstateRwa(address addressToWhitelist) internal {
    (bool ok, bytes memory res) = SUPERSTATE_ALLOWLIST_V2.call(abi.encodeWithSignature('owner()'));
    assertTrue(ok, 'owner()');
    address owner_ = abi.decode(res, (address));

    vm.prank(owner_);
    (ok, ) = SUPERSTATE_ALLOWLIST_V2.call(
      abi.encodeWithSignature(
        'setEntityIdForAddress(uint256,address)',
        SUPERSTATE_ROOT_ENTITY_ID,
        addressToWhitelist
      )
    );
    assertTrue(ok, 'setEntityIdForAddress()');
  }

  function _whitelistCentrifugeRwa(address addressToWhitelist) internal {
    address restrictionManager = CENTRIFUGE_HOOK;

    (bool ok, bytes memory res) = restrictionManager.call(abi.encodeWithSignature('root()'));
    assertTrue(ok, 'root()');
    address root = abi.decode(res, (address));

    vm.prank(CENTRIFUGE_WARD);
    (ok, ) = root.call(abi.encodeWithSignature('endorse(address)', addressToWhitelist));
    assertTrue(ok, 'endorse()');
  }

  function _whitelistUsycRwa(address addressToWhitelist) internal {
    (bool ok, bytes memory res) = proposal.USYC_TOKEN().call(
      abi.encodeWithSignature('authority()')
    );
    assertTrue(ok, 'authority()');
    address authority = abi.decode(res, (address));

    vm.prank(CIRCLE_SET_USER_ROLE_AUTHORIZED_CALLER);
    (ok, ) = authority.call(
      abi.encodeWithSignature(
        'setUserRole(address,uint8,bool)',
        addressToWhitelist,
        CIRCLE_INVESTOR_SDYF_INTERNATIONAL_ROLE,
        true
      )
    );
    assertTrue(ok, 'setUserRole()');
  }

  function _validateConstants() internal view {
    assertEq(IERC20Detailed(address(proposal.GHO_TOKEN())).name(), 'Gho Token');
    assertEq(IERC20Detailed(proposal.RLUSD_TOKEN()).name(), 'RLUSD');
    assertEq(IERC20Detailed(proposal.USDC_TOKEN()).name(), 'USD Coin');
    assertEq(
      IERC20Detailed(proposal.USTB_TOKEN()).name(),
      'Superstate Short Duration US Government Securities Fund'
    );
    assertEq(IERC20Detailed(proposal.USCC_TOKEN()).name(), 'Superstate Crypto Carry Fund');
    assertEq(IERC20Detailed(proposal.USYC_TOKEN()).name(), 'US Yield Coin');
    assertEq(
      IERC20Detailed(proposal.JAAA_TOKEN()).name(),
      'Janus Henderson Anemoy AAA CLO Fund Token'
    );
    assertEq(IERC20Detailed(proposal.JTRSY_TOKEN()).name(), 'Janus Henderson Anemoy Treasury Fund');

    IPoolAddressesProvider addressesProvider = POOL.ADDRESSES_PROVIDER();
    assertEq(
      address(proposal.POOL_CONFIGURATOR()),
      address(addressesProvider.getPoolConfigurator())
    );
    assertEq(address(proposal.ACL_MANAGER()), address(addressesProvider.getACLManager()));
    assertEq(
      address(proposal.PROTOCOL_DATA_PROVIDER()),
      address(addressesProvider.getPoolDataProvider())
    );

    IGhoDirectMinter ghoDirectMinter = proposal.GHO_DIRECT_MINTER();
    assertEq(address(ghoDirectMinter.POOL()), address(POOL)); // horizon pool
    assertEq(
      address(ghoDirectMinter.POOL_CONFIGURATOR()),
      address(addressesProvider.getPoolConfigurator())
    );
    assertEq(address(ghoDirectMinter.COLLECTOR()), address(AaveV3Ethereum.COLLECTOR));
    assertEq(address(ghoDirectMinter.GHO()), AaveV3EthereumAssets.GHO_UNDERLYING);
    assertEq(
      ghoDirectMinter.GHO_A_TOKEN(),
      POOL.getReserveAToken(AaveV3EthereumAssets.GHO_UNDERLYING)
    );
    assertEq(IOwnable(address(ghoDirectMinter)).owner(), GovernanceV3Ethereum.EXECUTOR_LVL_1);
    assertEq(IWithGuardian(address(ghoDirectMinter)).guardian(), GhoEthereum.RISK_COUNCIL);
  }
}
