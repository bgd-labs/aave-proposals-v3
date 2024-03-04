import fs from "fs";

const readMdTable = () => {
  let table = fs.readFileSync("./table.md", { encoding: "utf-8" });
  let lines = table.split("\n");

  let returnData = {
    tickers: [],
    underlyings: [],
    rfs: [],
  };

  for (let i = 0; i < lines.length; i++) {
    /// | BAL  | 99.00% | 99.99% |
    let line = lines[i];

    /// ['', ' BAL  ', ' 99.00% ', ' 99.99% ']
    let split = line.split("|");

    /// 'BAL'
    let ticker = split[1].trim();

    /// 'BAL_UNDERLYING'
    let underlying = `${ticker}_UNDERLYING`;

    /// ['99', '99']
    let rfsplit = split[3].trim().replace("%", "").split(".");

    /// '99_99'
    let rf = `${rfsplit[0]}_${rfsplit[1]}`;

    returnData.tickers.push(ticker);
    returnData.underlyings.push(underlying);
    returnData.rfs.push(rf);
  }

  return returnData;
};

const payload = () => {
  let { tickers, underlyings, rfs } = readMdTable();
  let solCode = "";
  for (let i = 0; i < underlyings.length; i++) {
    solCode += `uint256 public constant ${tickers[i]}_RF = ${rfs[i]};\n`;
  }
  solCode += "\n";

  for (let i = 0; i < underlyings.length; i++) {
    solCode += `POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.${underlyings[i]}, ${tickers[i]}_RF);\n`;
  }
  fs.writeFileSync("./payload_generated.txt", solCode, { encoding: "utf-8" });
};

const tests = () => {
  let { tickers, underlyings } = readMdTable();
  let numChanges = tickers.length;
  let solCode = `address[] memory assetsChanged = new address[](${numChanges});\n`;
  for (let i = 0; i < underlyings.length; i++) {
    solCode += `assetsChanged[${i}] = AaveV2EthereumAssets.${underlyings[i]};\n`;
  }

  solCode += `\nChanges[] memory assetChanges = new Changes[](${numChanges});\n`;

  for (let i = 0; i < underlyings.length; i++) {
    solCode += `assetChanges[${i}] = Changes({ asset: AaveV2EthereumAssets.${underlyings[i]}, reserveFactor: proposal.${tickers[i]}_RF()});\n`;
  }
  fs.writeFileSync("./tests_generated.txt", solCode, { encoding: "utf-8" });
};

const main = () => {
  process.argv.shift();
  process.argv.shift();

  switch (process.argv.join(" ")) {
    case "tests":
      tests();
      break;
    case "payload":
      payload();
      break;
    default:
      console.log("unrecognized command");
  }
};

main();
