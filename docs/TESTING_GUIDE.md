# Testing Guide

## Testing Workflows

1. [Fork Testing](#fork-testing) - Set up fork testing environment.
2. [Default Test Suite](#default-test-suite) - Run comprehensive validation.
3. [Review Snapshot Diffs](#snapshot-diffs) - Verify state changes.

## Testing Stack

**Framework**: [Foundry](https://book.getfoundry.sh/) (Forge)

**Key Features**:

- **Fork Testing**: Test against live network state
- **Snapshot Diffing**: Automated before/after state comparison
- **Gas Reporting**: Track execution costs

**Dependencies**: `forge-std`, `aave-helpers`, `aave-address-book`

## Running Tests

```bash
# Run all tests
forge test

# Test specific contract
make test-contract filter=ProposalName
```

See [Foundry Book](https://book.getfoundry.sh/) for detailed forge commands.

## Fork Testing

**Steps**:

1. [Selecting Fork Block](#selecting-fork-block) - Choose recent block
2. [RPC Configuration](#rpc-configuration) - Configure endpoints in .env

### Selecting Fork Block

Get recent block number:

```bash
cast block-number --rpc-url $RPC_AVALANCHE
```

### RPC Configuration

Configure RPC endpoints in `.env`. Format example:

```bash
RPC_MAINNET=https://eth-mainnet.g.alchemy.com/v2/YOUR_KEY
RPC_AVALANCHE=https://avax-mainnet.g.alchemy.com/v2/YOUR_KEY
RPC_ARBITRUM=https://arb-mainnet.g.alchemy.com/v2/YOUR_KEY
```

## Default Test Suite

### `defaultTest()` Function

The `defaultTest()` helper (from `ProtocolV3TestBase`) captures before/after state, executes the proposal, generates snapshot diffs, and validates parameters.

## Snapshot Diffs

After running tests, review generated diffs in `diffs/` directory to verify state changes match proposal specifications.

## See Also

- [README.md](../README.md) - Repository overview and architecture
- [Generator Guide](../generator/README.md) - Creating proposals
- [GLOSSARY.md](./GLOSSARY.md) - Repository terminology
- [Foundry Book](https://book.getfoundry.sh/) - Foundry documentation
