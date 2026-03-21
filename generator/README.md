# Proposal Generator Guide

## Quick Start

```bash
# Install dependencies
npm install

# Run the generator
npm run generate
```

The generator will interactively prompt for:

1. Target chains (select from multiple networks)
2. Proposal metadata (title, author, forum/snapshot links)
3. Features to implement (caps, rates, listing, etc.)
4. Parameters for each feature

**Result**: Generates `.sol`, `.t.sol`, `.s.sol`, and `.md` files in `src/YYYYMMDD_*/`

## Command-Line Options

```bash
npm run generate -- [options]

Options:
  -p, --pools <pools...>           Target chains (AaveV3Ethereum, AaveV3Arbitrum, etc.)
  -t, --title <string>             Short proposal title (used in contract names)
  -a, --author <string>            Proposal author
  -d, --discussion <string>        Governance forum link
  -s, --snapshot <string>          Snapshot vote link
  -v, --votingNetwork <network>    Network where voting takes place (default: Avalanche)
  -c, --configFile <string>        Path to config.ts file (for reproducibility)
  -u, --update                     Update block numbers when used with -c
  -f, --force                      Overwrite existing files
  -h, --help                       Display help
```

**Example**:

```bash
npm run generate -- \
  --pools AaveV3Ethereum AaveV3Arbitrum \
  --title "Increase WETH Supply Cap" \
  --author "Risk DAO"
```

## Interactive Mode

After running `npm run generate`, an interactive mode will be opened. Select required options from the list in 3 following steps: chain selection, metadata entry, and feature selection.

**Note**: Cannot mix whitelabel pools with regular pools (step 1).

## Feature Modules

After feature selection (step 3), the generator prompts for parameters specific to each selected feature.

**Example** (Caps Updates): Select assets → Enter new supply cap → Enter new borrow cap

**Available features**:

- Asset Listing
- Caps Updates
- Interest Rate Updates
- Collateral Updates
- Borrow Updates
- E-Mode Updates
- Price Feed Updates
- Emission Updates
- Flash Borrower
- Freeze Updates
- Custom Implementation

### 11. Custom Implementation

**Use Case**: Changes not supported by config engine.

**Generated**: Placeholder function with comment `// custom code goes here`

You must manually implement the logic.

## Generated File Structure

```
src/YYYYMMDD_<Chain>_<Title>/
├── <Chain>_<Title>_YYYYMMDD.sol        # Payload contract
├── <Chain>_<Title>_YYYYMMDD.t.sol      # Tests
├── <Title>_YYYYMMDD.s.sol              # Deployment script
├── <Title>.md                          # AIP documentation
└── config.ts                           # Config file for reproducibility
```

**Naming**: Date (YYYYMMDD) + Chain (AaveV3Arbitrum) + PascalCase title

## Config File Mode

The generator automatically creates a `config.ts` file in each proposal directory that captures all your inputs (chains, metadata, features, parameters). This enables reproducibility and iteration.

**Regenerate from existing config**:

```bash
# Use existing config to regenerate files
npm run generate -- -c src/YYYYMMDD_Chain_Title/config.ts

# Update block numbers for fresh fork tests
npm run generate -- -c src/YYYYMMDD_Chain_Title/config.ts --update
```

## Related Documentation

- [README.md](../README.md) - Repository overview and architecture
- [TESTING_GUIDE.md](../docs/TESTING_GUIDE.md) - Testing proposals
- [GLOSSARY.md](../docs/GLOSSARY.md) - Repository terminology
