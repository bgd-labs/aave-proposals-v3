# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# deps
update:; forge update

# Build & test
build  :; forge build --sizes
test   :; forge test -vvv

test-contract :; forge test --match-contract ${filter} -vv

# Deploy
deploy-ledger-zk :; FOUNDRY_PROFILE=zksync forge script $(if $(filter zksync,${chain}),--zksync) ${contract} --rpc-url ${chain} $(if ${dry},--sender 0x73AF3bcf944a6559933396c1577B257e2054D935 -vvvv, --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv --slow --broadcast --verifier etherscan)
deploy-ledger :; forge script $(if $(filter zksync,${chain}),--zksync) ${contract} --rpc-url ${chain} $(if ${dry},--sender 0x73AF3bcf944a6559933396c1577B257e2054D935 -vvvv, --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv --slow --broadcast) $(if ${legacy}, --legacy, )
deploy-pk :; forge script $(if $(filter zksync,${chain}),--zksync) ${contract} --rpc-url ${chain} $(if ${dry},--sender 0x73AF3bcf944a6559933396c1577B257e2054D935 -vvvv, --private-key ${PRIVATE_KEY} --verify -vvvv --slow --broadcast)

# Utilities
download :; cast etherscan-source --chain ${chain} -d src/etherscan/${chain}_${address} ${address}
git-diff :
	@mkdir -p diffs
	@npx prettier ${before} ${after} --write
	@printf '%s\n%s\n%s\n' "\`\`\`diff" "$$(git diff --no-index --diff-algorithm=patience --ignore-space-at-eol ${before} ${after})" "\`\`\`" > diffs/${out}.md
