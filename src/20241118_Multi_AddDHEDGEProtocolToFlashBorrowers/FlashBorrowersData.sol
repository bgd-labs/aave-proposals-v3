// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library FlashBorrowersDataArbitrum {
  function getFlashBorrowers() internal pure returns (address[] memory) {
    address[] memory flashBorrowers = new address[](11);
    flashBorrowers[0] = 0x27D8FDb0251B48D8EdD1Ad7bEDf553cF99AbE7B0;
    flashBorrowers[1] = 0xe3254397f5D9C0B69917EBb49B49e103367B406f;
    flashBorrowers[2] = 0xaD38255fEbd566809aE387d5bE66ECD287947cb9;
    flashBorrowers[3] = 0x40d30B13666c55B1F41eE11645B5ea3Ea2CA31f8;
    flashBorrowers[4] = 0x696f6d66C2da2AA4A400a4317EEC8da88f7A378c;
    flashBorrowers[5] = 0xF715724abba480D4D45f4cb52BEF5ce5E3513CCC;
    flashBorrowers[6] = 0xe9b5260D99d283ff887859C569bAF8aD1bd12AAc;
    flashBorrowers[7] = 0x43DA9b0aB53242c55A9Ff9c722FfC2a373D639c7;
    flashBorrowers[8] = 0x678569FC403EA2BA46B549a4D0E15E883D7cAdF5;
    flashBorrowers[9] = 0xc3198eb5102fB3335C0E911eF1DA4BC07e403Dd1;
    flashBorrowers[10] = 0xDDd6b1f34e12C0230ab23cbd4514560b24438514;

    return flashBorrowers;
  }
}

library FlashBorrowersDataBase {
  function getFlashBorrowers() internal pure returns (address[] memory) {
    address[] memory flashBorrowers = new address[](10);
    flashBorrowers[0] = 0xA672e882aCBB96486393D43E0efdab5EBEbDDC1d;
    flashBorrowers[1] = 0x15E2F06138aed58ca2A6AfB5A1333bBC5f728f80;
    flashBorrowers[2] = 0xbA5F6A0D2AC21a3feC7a6C40FACd23407AA84663;
    flashBorrowers[3] = 0xC1E02884AF4A283cA25ab63C45360d220d69DA52;
    flashBorrowers[4] = 0x1c980456751AE40315Ff73CaaC0843Be643321Be;
    flashBorrowers[5] = 0xeDE61eefa4850b459E3B09Fe6d8d371480D6fF00;
    flashBorrowers[6] = 0x53a4716a8f7DBC9543ebf9cd711952033cC64d43;
    flashBorrowers[7] = 0xd2f23773bF5e2d59F6bB925c2232F6e83f3f79e0;
    flashBorrowers[8] = 0x9e0501537723c71250307F5B1A8eE60e167D21C9;
    flashBorrowers[9] = 0xCAF08BF08D0c87e2c74dd9EBEC9C776037bD7e8E;

    return flashBorrowers;
  }
}

library FlashBorrowersDataOptimism {
  function getFlashBorrowers() internal pure returns (address[] memory) {
    address[] memory flashBorrowers = new address[](14);
    flashBorrowers[0] = 0x83d1Fa384EC44C2769A3562EDe372484f26E141B;
    flashBorrowers[1] = 0x32Ad28356EF70adC3EC051D8AAcdEEaA10135296;
    flashBorrowers[2] = 0xB03818de4992388260b62259361778CF98485dFE;
    flashBorrowers[3] = 0x11b55966527FF030ca9c7B1c548B4bE5e7EaEe6D;
    flashBorrowers[4] = 0xcACb5A722a36cFf6bAeB359e21C098a4ACbffDfa;
    flashBorrowers[5] = 0x9573c7b691cDcEbBFa9D655181f291799dfB7Cf5;
    flashBorrowers[6] = 0x32b1D1bFd4B3b0CB9FF2DcD9DAc757aA64d4cb69;
    flashBorrowers[7] = 0x7D3c9C6566375d7ad6e89169cA5C01B5Edc15364;
    flashBorrowers[8] = 0xcC7d6ED524760539311ed0Cdb41D0852b4eb77eb;
    flashBorrowers[9] = 0xB9243C495117343981EC9f8AA2ABfFEe54396Fc0;
    flashBorrowers[10] = 0x1eC50880101022C11530A069690F5446d1464592;
    flashBorrowers[11] = 0x49bF093277Bf4dDe49c48c6AA55A3bDA3eeDEF68;
    flashBorrowers[12] = 0xb2cFb909e8657C0EC44D3dD898C1053b87804755;
    flashBorrowers[13] = 0x59bAbc14Dd73761e38E5bdA171b2298DC14da92d;

    return flashBorrowers;
  }
}

library FlashBorrowersDataPolygon {
  function getFlashBorrowers() internal pure returns (address[] memory) {
    address[] memory flashBorrowers = new address[](4);
    flashBorrowers[0] = 0x86C3Dd18bAF4370495d9228b58fD959771285C55;
    flashBorrowers[1] = 0xdB88AB5b485b38EDbEEf866314F9E49d095BCe39;
    flashBorrowers[2] = 0x79D2aeFE6A21b26B024d9341A51f6b7897852499;
    flashBorrowers[3] = 0x460b60565cb73845d56564384ab84BF84c13e47D;

    return flashBorrowers;
  }
}
