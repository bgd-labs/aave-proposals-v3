import { AaveV2Ethereum } from "@bgd-labs/aave-address-book";
import chaos from "./chaos.json" assert { type: "json" };

const processedUsers = chaos
  .filter((f) => Math.floor(f.USDC_Per_User) !== 0)
  .reduce((acc, f) => {
    acc[f.Wallet] = { aAmplCompensation: Math.floor(f.USDC_Per_User) };
    return acc;
  }, {});

const totalAmount = chaos.reduce((acc, i) => {
  return acc + Math.floor(i.USDC_Per_User);
}, 0);

const angleJSON = {
  rewardToken: AaveV2Ethereum.ASSETS.USDC.UNDERLYING,
  rewards: processedUsers,
};

// console.log(totalAmount);
console.log(JSON.stringify(angleJSON, null, 2));
