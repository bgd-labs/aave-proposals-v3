# old
cast etherscan-source --chain 42161 -d etherscan/ArbitrumPriceOracleSentinel 0xF876d26041a4Fdc7A787d209DC3D2795dDc74f1e
cast etherscan-source --chain 10 -d etherscan/OptimismPriceOracleSentinel 0xB1ba0787Ca0A45f086F8CA03c97E7593636E47D5
cast etherscan-source --chain 8453 -d etherscan/BasePriceOracleSentinel 0xe34949A48cd2E6f5CD41753e449bd2d43993C9AC
cast etherscan-source --chain 1088 -d etherscan/MetisPriceOracleSentinel 0xE2566C39db9559D318fB3a00D7B5992CBeeA8567

# new
cast etherscan-source --chain 42161 -d etherscan/ArbitrumPriceOracleSentinelNew 0x7A9ff54A6eE4a21223036890bB8c4ea2D62c686b
cast etherscan-source --chain 10 -d etherscan/OptimismPriceOracleSentinelNew 0xE229d5DE4BD5beEAf12d427B5B57BFe66abD2c3b
cast etherscan-source --chain 8453 -d etherscan/BasePriceOracleSentinelNew 0x943AcD0c93d7a8Bee7dA5Fd0DC3d0028237074d6
cast etherscan-source --chain 1088 -d etherscan/MetisPriceOracleSentinelNew 0x2B5EA1604BAbb7B730120950Cb13951f3525828A

make git-diff before=etherscan/ArbitrumPriceOracleSentinel/PriceOracleSentinel/@aave/core-v3/contracts/protocol/configuration/PriceOracleSentinel.sol after=etherscan/ArbitrumPriceOracleSentinelNew/PriceOracleSentinel/src/core/contracts/protocol/configuration/PriceOracleSentinel.sol out=ArbitrumPriceOracleSentinel
make git-diff before=etherscan/OptimismPriceOracleSentinel/PriceOracleSentinel/@aave/core-v3/contracts/protocol/configuration/PriceOracleSentinel.sol after=etherscan/OptimismPriceOracleSentinelNew/PriceOracleSentinel/src/core/contracts/protocol/configuration/PriceOracleSentinel.sol out=OptimismPriceOracleSentinel
make git-diff before=etherscan/BasePriceOracleSentinel/PriceOracleSentinel/src/core/contracts/protocol/configuration/PriceOracleSentinel.sol after=etherscan/BasePriceOracleSentinelNew/PriceOracleSentinel/src/core/contracts/protocol/configuration/PriceOracleSentinel.sol out=BasePriceOracleSentinel
make git-diff before=etherscan/MetisPriceOracleSentinel/PriceOracleSentinel/@aave/core-v3/contracts/protocol/configuration/PriceOracleSentinel.sol after=etherscan/MetisPriceOracleSentinelNew/PriceOracleSentinel/src/core/contracts/protocol/configuration/PriceOracleSentinel.sol out=MetisPriceOracleSentinel
