# GHO Launch abstraction

Guide on how to use the GHO Launch abstraction to launch GHO on a new chain. Let's say we have a chain called "Foo" and we want to launch GHO on it.

## 1. Add the new chain to the CCIP constants

Add the new chain corresponding values to the `CCIPChainRouters`, `CCIPChainSelectors`, `CCIPChainTokenAdminRegistries`, and `GhoCCIPChains` constant libraries.

Do not forget to add the new chain to the `GhoCCIPChains`'s `getAllChains` function.

```solidity
/**
 * @notice Returns all supported ChainInfo constants
 * @return An array with all the ChainInfo constants supported
 */
function getAllChains() public pure returns (ChainInfo[] memory) {
  ChainInfo[] memory allChains = new ChainInfo[](7);
  allChains[0] = ETHEREUM();
  allChains[1] = ARBITRUM();
  allChains[2] = BASE();
  allChains[3] = AVALANCHE();
  allChains[4] = GNOSIS();
  allChains[5] = INK();
  allChains[6] = FOO(); // <-- The new chain
  return allChains;
}
```

## 2. Add remote lanes to existing CCIP pools

To add a new remote lane between an existing CCIP pool and the pool on the new chain, you need to create a file inheriting from the `AaveV3GHOLane` base contract.

For example, the proposal file to add a lane between the Ethereum CCIP pool and the Foo CCIP pool will look like this:

```solidity
contract Ethereum_Foo_AaveV3GHOLane_YYYYMMDD is AaveV3GHOLane {
  constructor() AaveV3GHOLane(GhoCCIPChains.ETHEREUM()) {}

  function lanesToAdd()
    public
    pure
    override
    returns (IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[] memory)
  {
    return
      _asArray(_asChainUpdateWithDefaultRateLimiterConfig(GhoCCIPChains.FOO()));
  }
}
```

You can override the `_defaultRateLimiterConfig` if a different rate limiter config is desired, or simply pass a different custom rate limiter config like this:

```solidity
contract Ethereum_Foo_AaveV3GHOLane_YYYYMMDD is AaveV3GHOLane {
  constructor() AaveV3GHOLane(GhoCCIPChains.ETHEREUM()) {}

  function lanesToAdd()
    public
    pure
    override
    returns (IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[] memory)
  {
    return
      _asArray(
        _asChainUpdate(
          GhoCCIPChains.FOO(),
          IRateLimiter.Config({
            isEnabled: true,
            capacity: 1_000_000e18,
            rate: 500
          }),
          IRateLimiter.Config({
            isEnabled: true,
            capacity: 500_000e18,
            rate: 300
          })
        )
      );
  }
}
```

### Testing of Remote GHO Lanes

You can inherit `AaveV3GHORemoteLaneTest_PreExecution` and `AaveV3GHORemoteLaneTest_PostExecution` for pre and post proposal execution tests respectively, then override the required functions.

For the case of the Ethereum remote lane, you need to inherit `AaveV3GHOEthereumRemoteLaneTest_PreExecution` and `AaveV3GHOEthereumRemoteLaneTest_PostExecution` instead, as they have special test cases for the Ethereum chain.

For the case of the Arbitrum remote lane, you will need to override the `_assertAgainstSupportedChain` function and make a special case when asserting against the Ethereum chain, given that it has two pools for the Ethereum chain selector:

```solidity
function _assertAgainstSupportedChain(
  GhoCCIPChains.ChainInfo memory supportedChain
) internal virtual override {
  if (supportedChain.chainSelector == GhoCCIPChains.ETHEREUM().chainSelector) {
    assertEq(
      LOCAL_TOKEN_POOL.getRemoteToken(supportedChain.chainSelector),
      abi.encode(supportedChain.ghoToken),
      "Remote token mismatch for supported chain"
    );

    assertEq(
      LOCAL_TOKEN_POOL.getRemotePools(supportedChain.chainSelector)[1],
      abi.encode(supportedChain.ghoCCIPTokenPool),
      "Remote pool mismatch for supported chain"
    );
  } else {
    super._assertAgainstSupportedChain(supportedChain);
  }
}
```

## 3. Launch GHO on the new chain

To launch GHO on the new chain, you need to create a file inheriting from the `AaveV3GHOLaunch` base contract.

This will automatically add a new local lane between the new chain pool and CCIP pools of each chain defined by `GhoCCIPChains`'s `getAllChains` function.

This is how the file will look like for our new Foo chain:

```solidity
contract AaveV3Foo_GHOFooLaunch_YYYYMMDD is AaveV3GHOLaunch {
  constructor() AaveV3GHOLaunch(GhoCCIPChains.FOO()) {}
}
```

If the local lanes to add should be different, you can override the `lanesToAdd` function and set your custom lanes to add.

In addition, `AaveV3GHOLaunch` has each step defined as an internal function that can be overridden to either skip some step or modify it to have some custom logic.

For example, if you want to skip setting up the GHO Bucket Steward as Bucket Manager in the GHO Token, you can achieve it like this:

```solidity
contract AaveV3Foo_GHOFooLaunch_YYYYMMDD is AaveV3GHOLaunch {
  constructor() AaveV3GHOLaunch(GhoCCIPChains.FOO()) {}

  function _setupGhoBucketStewardAsBucketManagerInGhoToken() internal virtual {
    // Do not setup Bucket Manager role in GHO Token for this proposal for X and Y reasons.
  }
}
```

### Testing of GHO Launch

You can inherit `AaveV3GHOLaunchTest_PreExecution` and `AaveV3GHOLaunchTest_PostExecution` for pre and post proposal execution tests respectively, then override the required functions.

## 4. List GHO on the new chain

This abstraction is already done by the AaveV3Payload base contracts. You can inherit the one for the new chain from the `aave-helpers` repository, for example `AaveV3PayloadFoo`, and then inherit the `newListings` function in order to list GHO on the new chain. The `_preExecute` and `_postExecute` hooks can be overridden to include some extra custom logic. For example, it is common to override the `_postExecute` hook to set up the Emissions Admin in the Emissions Manager.
