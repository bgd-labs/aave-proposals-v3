# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# deps
update:; forge update

# Build & test
build  :; forge build --sizes
test   :; forge test -vvv

test-contract :; forge test --match-contract ${filter} -vv

# Deploys payload. `make deploy-payload`
deploy-payload :; 
	FOUNDRY_PROFILE=${chain} forge script src/${payload}/${payload}.s.sol:DeployEthereum \
		--rpc-url ${chain} --account ${account} --slow --gas-estimate-multiplier 150 -vv \
		--chain ${chain} --verifier-url ${verifier_url} \
		--sig "run()" \
		$(if ${dry},, --broadcast --verify) \

# Utilities
download :; cast etherscan-source --chain ${chain} -d src/etherscan/${chain}_${address} ${address}
git-diff :
	@mkdir -p diffs
	@npx prettier ${before} ${after} --write
	@printf '%s\n%s\n%s\n' "\`\`\`diff" "$$(git diff --no-index --diff-algorithm=patience --ignore-space-at-eol ${before} ${after})" "\`\`\`" > diffs/${out}.md
