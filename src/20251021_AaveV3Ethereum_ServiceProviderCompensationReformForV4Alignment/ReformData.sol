// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library ReformData {
  struct ReformDataStructure {
    address recipient;
    uint256 toCancel; // stream to cancel on old controller
    uint256 amount;
  }

  // stream information
  uint256 public constant STREAM_DURATION = 365 days;

  // grant is 980 AAVE
  uint256 public constant GRANT_AMOUNT = 950 ether;

  // stream receivers
  address public constant ACI = 0x55Ac902cb75cC15288D473ed8E3E185a75b3f330;
  address public constant LLAMA_RISK = 0x9eE16dBDE572886342fc1e2Db8525DEFB007b27c;
  address public constant TOKEN_LOGIC = 0xAA088dfF3dcF619664094945028d44E779F19894;
  address public constant CHAOS_LABS = 0xbC540e0729B732fb14afA240aA5A047aE9ba7dF0;

  function getReformData() internal pure returns (ReformDataStructure[] memory) {
    ReformDataStructure[] memory reformData = new ReformDataStructure[](4);
    reformData[0] = ReformDataStructure({
      recipient: ACI,
      toCancel: 100062,
      amount: 3_000_000 ether
    });
    reformData[1] = ReformDataStructure({
      recipient: LLAMA_RISK,
      toCancel: 100061,
      amount: 1_000_000 ether
    });
    reformData[2] = ReformDataStructure({
      recipient: TOKEN_LOGIC,
      toCancel: 100064,
      amount: 2_500_000 ether
    });
    reformData[3] = ReformDataStructure({
      recipient: CHAOS_LABS,
      toCancel: 100065,
      amount: 2_550_000 ether
    });

    return reformData;
  }

  function getReformDataAAVE() internal pure returns (ReformDataStructure memory) {
    return ReformDataStructure({recipient: CHAOS_LABS, toCancel: 100014, amount: 17_000 ether});
  }
}
