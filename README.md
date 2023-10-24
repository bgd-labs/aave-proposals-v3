# Aave proposals v3

This repository contains various proposals targeting the Aave governance.
In addition to the actual proposals this repository also contains tooling to standardize certain protocol tasks.
The tooling documentation is co-located with the relevant smart contracts.

## Tooling

### Config engine

The AaveV3ConfigEngine ([Docs](https://github.com/bgd-labs/aave-helpers/tree/master/src/v3-config-engine#how-to-use-the-engine)) is a helper smart contract to abstract good practices when doing "admin" interactions with the Aave v3 protocol, but built on top, without touching the core contracts.

A less comprehensive version of the engine also exists for [protocol v2](https://github.com/bgd-labs/aave-helpers/tree/master/src/v2-config-engine).

## Development

This project uses [Foundry](https://getfoundry.sh). See the [book](https://book.getfoundry.sh/getting-started/installation.html) for detailed instructions on how to install and use Foundry.
The template ships with sensible default so you can use default `foundry` commands without resorting to `MakeFile`.

### Setup

```sh
cp .env.example .env
forge install
yarn
```

### Create an aip

This repository includes a generator to help you bootstrap the required files for an `AIP`.
To generate a proposal you need to run: `yarn generate`

To get a full list of available commands run `yarn generate --help`

```sh
yarn generate --help
yarn run v1.22.19
$ tsx generator/cli --help
Usage: proposal-generator [options]

CLI to generate aave proposals

Options:
  -V, --version              output the version number
  -f, --force                force creation (might overwrite existing files)
  -p, --pools <pools...>      (choices: "AaveV2Ethereum", "AaveV2EthereumAMM", "AaveV2Polygon", "AaveV2Avalanche",
                             "AaveV3Ethereum", "AaveV3Polygon", "AaveV3Avalanche", "AaveV3Optimism",
                             "AaveV3Arbitrum", "AaveV3Metis", "AaveV3Base")
  -t, --title <string>       aip title
  -a, --author <string>      author
  -d, --discussion <string>  forum link
  -s, --snapshot <string>    snapshot link
  -c, --configFile <string>  path to config file
  -h, --help                 display help for command
```

If you have any feedback regarding the generator (bugs, improvements, features), don't hesitate to create an issue. We'd `<3` to see contributions.

### Test

```sh
# You can use vanilla forge to customize your test
# https://book.getfoundry.sh/reference/forge/forge-test
forge test
# We also provide a script with sensible defaults to just test a single contract matching a filter
make test-contract filter=ENS
```

### Deploy

The makefile contains some generic templates for proposal deployments.
To deploy a contract you can run `make deploy-ledger contract=pathToContract:Contract chain=chainAlias`.
The generator will inline exact instructions on the generated scripts.

## Proposal creation

To create a proposal you have to do three things:

1. deploy the payload & register it on the payloadsController
2. create an aip
3. create the mainnet proposal

While the first two steps can be performed in parallel, the final proposal creation relies on (1) and (2).
Every step can in theory be performed by a different entity.

The address creating the mainnet proposal(3) requires 80k AAVE of proposition power.

### 1. Deploy payload

The payload is always deployed on the chain it affects.
Therefore you need to adjust the relevant script accordingly.
The generated scripts include exact instrauctions on what to execute.

### 2. Create an aip

The aip can be co-located with the proposal code as a markdown file.
This repository will manage the upload to ipfs automatically once a pr is merged to `main`.

### 3. Create proposal

The proposal requires at least one `payload` and the `encodedHash`.

:tada:
