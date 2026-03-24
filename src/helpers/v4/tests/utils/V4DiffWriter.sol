// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Vm} from 'forge-std/Vm.sol';
import {Types} from './Types.sol';

/// @title V4DiffWriter
/// @notice Internal library for V4 JSON serialization and markdown diff generation.
///         Using an internal library means functions are inlined via delegatecall context,
///         keeping cheatcodes working while avoiding stack-too-deep in the inheritance chain.
library V4DiffWriter {
  Vm private constant vm = Vm(address(uint160(uint256(keccak256('hevm cheat code')))));

  function writeSnapshotJson(string memory reportName, Types.V4Snapshot memory snapshot) internal {
    string memory path = string.concat('./reports/', reportName, '.json');
    vm.writeFile(
      path,
      '{ "spokeReserves": {}, "spokeLiquidationConfigs": {}, "hubAssets": {}, "hubSpokeCaps": {}, "raw": {} }'
    );
    vm.serializeUint('root', 'chainId', block.chainid);

    _writeSpokeReserves(path, snapshot.spokeReserves);
    _writeSpokeLiqConfigs(path, snapshot.spokeLiquidationConfigs);
    _writeHubAssets(path, snapshot.hubAssets);
    _writeHubSpokeCaps(path, snapshot.hubSpokeCaps);
  }

  function _writeSpokeReserves(
    string memory path,
    Types.SpokeReserveSnapshot[] memory reserves
  ) private {
    string memory sectionKey = 'spokeReserves';
    string memory content = '{}';
    vm.serializeJson(sectionKey, '{}');

    for (uint256 i; i < reserves.length; i++) {
      string memory obj = _serReserve(reserves[i]);

      string memory spokeKey = string.concat('spoke_', vm.toString(reserves[i].spokeAddress));
      if (reserves[i].reserveId == 0) vm.serializeJson(spokeKey, '{}');
      string memory spokeObj = vm.serializeString(
        spokeKey,
        vm.toString(reserves[i].reserveId),
        obj
      );

      if (_isLastForSpoke(reserves, i)) {
        content = vm.serializeString(sectionKey, vm.toString(reserves[i].spokeAddress), spokeObj);
      }
    }
    vm.writeJson(vm.serializeString('root', 'spokeReserves', content), path);
  }

  function _isLastForSpoke(
    Types.SpokeReserveSnapshot[] memory arr,
    uint256 idx
  ) private pure returns (bool) {
    for (uint256 j = idx + 1; j < arr.length; j++) {
      if (arr[j].spokeAddress == arr[idx].spokeAddress) return false;
    }
    return true;
  }

  function _serReserve(Types.SpokeReserveSnapshot memory r) private returns (string memory) {
    string memory k = string.concat(vm.toString(r.spokeAddress), '_', vm.toString(r.reserveId));
    vm.serializeJson(k, '{}');
    vm.serializeString(k, 'symbol', r.symbol);
    vm.serializeAddress(k, 'underlying', r.underlying);
    vm.serializeAddress(k, 'hub', r.hub);
    vm.serializeUint(k, 'assetId', r.assetId);
    vm.serializeUint(k, 'decimals', r.decimals);
    vm.serializeUint(k, 'collateralRisk', r.collateralRisk);
    vm.serializeBool(k, 'paused', r.paused);
    vm.serializeBool(k, 'frozen', r.frozen);
    vm.serializeBool(k, 'borrowable', r.borrowable);
    vm.serializeBool(k, 'receiveSharesEnabled', r.receiveSharesEnabled);
    vm.serializeUint(k, 'dynamicConfigKey', r.dynamicConfigKey);
    vm.serializeUint(k, 'collateralFactor', r.collateralFactor);
    vm.serializeUint(k, 'maxLiquidationBonus', r.maxLiquidationBonus);
    vm.serializeUint(k, 'liquidationFee', r.liquidationFee);
    vm.serializeAddress(k, 'oracleAddress', r.oracleAddress);
    vm.serializeAddress(k, 'priceSource', r.priceSource);
    return vm.serializeString(k, 'oraclePrice', vm.toString(r.oraclePrice));
  }

  function _writeSpokeLiqConfigs(
    string memory path,
    Types.SpokeLiquidationSnapshot[] memory configs
  ) private {
    string memory sectionKey = 'spokeLiqConfigs';
    string memory content = '{}';
    vm.serializeJson(sectionKey, '{}');

    for (uint256 i; i < configs.length; i++) {
      string memory k = string.concat('liq_', vm.toString(configs[i].spokeAddress));
      vm.serializeJson(k, '{}');
      vm.serializeString(k, 'targetHealthFactor', vm.toString(configs[i].targetHealthFactor));
      vm.serializeString(
        k,
        'healthFactorForMaxBonus',
        vm.toString(configs[i].healthFactorForMaxBonus)
      );
      vm.serializeUint(k, 'liquidationBonusFactor', configs[i].liquidationBonusFactor);
      string memory obj = vm.serializeUint(
        k,
        'maxUserReservesLimit',
        configs[i].maxUserReservesLimit
      );
      content = vm.serializeString(sectionKey, vm.toString(configs[i].spokeAddress), obj);
    }
    vm.writeJson(vm.serializeString('root', 'spokeLiquidationConfigs', content), path);
  }

  function _writeHubAssets(string memory path, Types.HubAssetSnapshot[] memory assets) private {
    string memory sectionKey = 'hubAssets';
    string memory content = '{}';
    vm.serializeJson(sectionKey, '{}');

    for (uint256 i; i < assets.length; i++) {
      string memory obj = _serHubAsset(assets[i]);

      string memory hubKey = string.concat('hub_', vm.toString(assets[i].hubAddress));
      if (assets[i].assetId == 0) vm.serializeJson(hubKey, '{}');
      string memory hubObj = vm.serializeString(hubKey, vm.toString(assets[i].assetId), obj);

      if (_isLastForHub(assets, i)) {
        content = vm.serializeString(sectionKey, vm.toString(assets[i].hubAddress), hubObj);
      }
    }
    vm.writeJson(vm.serializeString('root', 'hubAssets', content), path);
  }

  function _isLastForHub(
    Types.HubAssetSnapshot[] memory arr,
    uint256 idx
  ) private pure returns (bool) {
    for (uint256 j = idx + 1; j < arr.length; j++) {
      if (arr[j].hubAddress == arr[idx].hubAddress) return false;
    }
    return true;
  }

  function _serHubAsset(Types.HubAssetSnapshot memory a) private returns (string memory) {
    string memory k = string.concat(vm.toString(a.hubAddress), '_', vm.toString(a.assetId));
    vm.serializeJson(k, '{}');
    vm.serializeString(k, 'symbol', a.symbol);
    vm.serializeAddress(k, 'underlying', a.underlying);
    vm.serializeUint(k, 'decimals', a.decimals);
    vm.serializeUint(k, 'liquidityFee', a.liquidityFee);
    vm.serializeAddress(k, 'irStrategy', a.irStrategy);
    vm.serializeAddress(k, 'feeReceiver', a.feeReceiver);
    vm.serializeAddress(k, 'reinvestmentController', a.reinvestmentController);
    vm.serializeUint(k, 'optimalUsageRatio', a.optimalUsageRatio);
    vm.serializeUint(k, 'baseDrawnRate', a.baseDrawnRate);
    vm.serializeUint(k, 'rateGrowthBeforeOptimal', a.rateGrowthBeforeOptimal);
    vm.serializeUint(k, 'rateGrowthAfterOptimal', a.rateGrowthAfterOptimal);
    return vm.serializeString(k, 'maxDrawnRate', vm.toString(a.maxDrawnRate));
  }

  function _writeHubSpokeCaps(string memory path, Types.HubSpokeCapSnapshot[] memory caps) private {
    string memory sectionKey = 'hubSpokeCaps';
    string memory content = '{}';
    vm.serializeJson(sectionKey, '{}');

    for (uint256 i; i < caps.length; i++) {
      string memory k = string.concat(
        vm.toString(caps[i].hubAddress),
        '_',
        vm.toString(caps[i].assetId),
        '_',
        vm.toString(caps[i].spokeAddress)
      );
      vm.serializeJson(k, '{}');
      vm.serializeString(k, 'assetSymbol', caps[i].assetSymbol);
      vm.serializeString(k, 'addCap', vm.toString(uint256(caps[i].addCap)));
      vm.serializeString(k, 'drawCap', vm.toString(uint256(caps[i].drawCap)));
      vm.serializeUint(k, 'riskPremiumThreshold', caps[i].riskPremiumThreshold);
      vm.serializeBool(k, 'active', caps[i].active);
      string memory obj = vm.serializeBool(k, 'halted', caps[i].halted);
      content = vm.serializeString(sectionKey, k, obj);
    }
    vm.writeJson(vm.serializeString('root', 'hubSpokeCaps', content), path);
  }

  function writeDiff(
    string memory reportName,
    Types.V4Snapshot memory snapBefore,
    Types.V4Snapshot memory snapAfter
  ) internal {
    string memory md = '';
    md = string.concat(md, _diffSpokeReserves(snapBefore.spokeReserves, snapAfter.spokeReserves));
    md = string.concat(md, _diffHubAssets(snapBefore.hubAssets, snapAfter.hubAssets));
    md = string.concat(md, _diffHubSpokeCaps(snapBefore.hubSpokeCaps, snapAfter.hubSpokeCaps));
    md = string.concat(
      md,
      _diffSpokeLiq(snapBefore.spokeLiquidationConfigs, snapAfter.spokeLiquidationConfigs)
    );

    if (bytes(md).length == 0) md = 'No configuration changes detected.\n';

    vm.writeFile(string.concat('./diffs/', reportName, '_before_', reportName, '_after.md'), md);
  }

  function _diffSpokeReserves(
    Types.SpokeReserveSnapshot[] memory arrB,
    Types.SpokeReserveSnapshot[] memory arrA
  ) private pure returns (string memory section) {
    string memory body = '';
    for (uint256 i; i < arrA.length; i++) {
      (bool found, uint256 bi) = _findRes(arrB, arrA[i].spokeAddress, arrA[i].reserveId);
      if (found) {
        string memory rows = _cmpRes(arrB[bi], arrA[i]);
        if (bytes(rows).length > 0) {
          body = string.concat(body, _resHdr(arrA[i]), _header(), rows, '\n');
        }
      } else {
        body = string.concat(body, _newRes(arrA[i]));
      }
    }
    for (uint256 i; i < arrB.length; i++) {
      (bool f, ) = _findRes(arrA, arrB[i].spokeAddress, arrB[i].reserveId);
      if (!f) body = string.concat(body, _resHdr(arrB[i]), '**REMOVED**\n\n');
    }
    if (bytes(body).length > 0) section = string.concat('## Spoke Reserve Changes\n\n', body);
  }

  function _resHdr(Types.SpokeReserveSnapshot memory r) private pure returns (string memory) {
    return
      string.concat(
        '### ',
        r.symbol,
        ' (',
        vm.toString(r.underlying),
        ') on Spoke ',
        vm.toString(r.spokeAddress),
        ' [reserveId: ',
        vm.toString(r.reserveId),
        ']\n\n'
      );
  }

  function _cmpRes(
    Types.SpokeReserveSnapshot memory b,
    Types.SpokeReserveSnapshot memory a
  ) private pure returns (string memory rows) {
    rows = string.concat(
      _dU('collateralRisk', b.collateralRisk, a.collateralRisk),
      _dB('paused', b.paused, a.paused),
      _dB('frozen', b.frozen, a.frozen),
      _dB('borrowable', b.borrowable, a.borrowable),
      _dB('receiveSharesEnabled', b.receiveSharesEnabled, a.receiveSharesEnabled),
      _dU('dynamicConfigKey', b.dynamicConfigKey, a.dynamicConfigKey)
    );
    rows = string.concat(
      rows,
      _dP('collateralFactor', b.collateralFactor, a.collateralFactor),
      _dU('maxLiquidationBonus', b.maxLiquidationBonus, a.maxLiquidationBonus),
      _dP('liquidationFee', b.liquidationFee, a.liquidationFee),
      _dA('priceSource', b.priceSource, a.priceSource),
      _dU('oraclePrice', b.oraclePrice, a.oraclePrice)
    );
  }

  function _newRes(Types.SpokeReserveSnapshot memory r) private pure returns (string memory) {
    string memory p1 = string.concat(
      _resHdr(r),
      '**NEW RESERVE**\n\n',
      _header(),
      _row('collateralRisk', vm.toString(uint256(r.collateralRisk))),
      _row('paused', _bs(r.paused)),
      _row('frozen', _bs(r.frozen)),
      _row('borrowable', _bs(r.borrowable)),
      _row('receiveSharesEnabled', _bs(r.receiveSharesEnabled))
    );
    return
      string.concat(
        p1,
        _row('collateralFactor', _ps(r.collateralFactor)),
        _row('maxLiquidationBonus', vm.toString(uint256(r.maxLiquidationBonus))),
        _row('liquidationFee', _ps(r.liquidationFee)),
        _row('priceSource', vm.toString(r.priceSource)),
        _row('oraclePrice', vm.toString(r.oraclePrice)),
        '\n'
      );
  }

  function _findRes(
    Types.SpokeReserveSnapshot[] memory a,
    address s,
    uint256 id
  ) private pure returns (bool, uint256) {
    for (uint256 i; i < a.length; i++) {
      if (a[i].spokeAddress == s && a[i].reserveId == id) return (true, i);
    }
    return (false, 0);
  }

  function _diffHubAssets(
    Types.HubAssetSnapshot[] memory arrB,
    Types.HubAssetSnapshot[] memory arrA
  ) private pure returns (string memory section) {
    string memory body = '';
    for (uint256 i; i < arrA.length; i++) {
      (bool found, uint256 bi) = _findHA(arrB, arrA[i].hubAddress, arrA[i].assetId);
      if (found) {
        string memory rows = _cmpHA(arrB[bi], arrA[i]);
        if (bytes(rows).length > 0) {
          body = string.concat(body, _haHdr(arrA[i]), _header(), rows, '\n');
        }
      } else {
        body = string.concat(body, _newHA(arrA[i]));
      }
    }
    for (uint256 i; i < arrB.length; i++) {
      (bool f, ) = _findHA(arrA, arrB[i].hubAddress, arrB[i].assetId);
      if (!f) body = string.concat(body, _haHdr(arrB[i]), '**REMOVED**\n\n');
    }
    if (bytes(body).length > 0) section = string.concat('## Hub Asset Changes\n\n', body);
  }

  function _haHdr(Types.HubAssetSnapshot memory a) private pure returns (string memory) {
    return
      string.concat(
        '### ',
        a.symbol,
        ' (assetId: ',
        vm.toString(a.assetId),
        ') on Hub ',
        vm.toString(a.hubAddress),
        '\n\n'
      );
  }

  function _cmpHA(
    Types.HubAssetSnapshot memory b,
    Types.HubAssetSnapshot memory a
  ) private pure returns (string memory rows) {
    rows = string.concat(
      _dP('liquidityFee', b.liquidityFee, a.liquidityFee),
      _dA('irStrategy', b.irStrategy, a.irStrategy),
      _dA('feeReceiver', b.feeReceiver, a.feeReceiver),
      _dA('reinvestmentController', b.reinvestmentController, a.reinvestmentController),
      _dP('optimalUsageRatio', b.optimalUsageRatio, a.optimalUsageRatio)
    );
    rows = string.concat(
      rows,
      _dP('baseDrawnRate', uint256(b.baseDrawnRate), uint256(a.baseDrawnRate)),
      _dP(
        'rateGrowthBeforeOptimal',
        uint256(b.rateGrowthBeforeOptimal),
        uint256(a.rateGrowthBeforeOptimal)
      ),
      _dP(
        'rateGrowthAfterOptimal',
        uint256(b.rateGrowthAfterOptimal),
        uint256(a.rateGrowthAfterOptimal)
      ),
      _dP('maxDrawnRate', b.maxDrawnRate, a.maxDrawnRate)
    );
  }

  function _newHA(Types.HubAssetSnapshot memory a) private pure returns (string memory) {
    string memory p1 = string.concat(
      _haHdr(a),
      '**NEW ASSET**\n\n',
      _header(),
      _row('liquidityFee', _ps(a.liquidityFee)),
      _row('irStrategy', vm.toString(a.irStrategy)),
      _row('feeReceiver', vm.toString(a.feeReceiver)),
      _row('reinvestmentController', vm.toString(a.reinvestmentController))
    );
    return
      string.concat(
        p1,
        _row('optimalUsageRatio', _ps(a.optimalUsageRatio)),
        _row('baseDrawnRate', _ps(uint256(a.baseDrawnRate))),
        _row('rateGrowthBeforeOptimal', _ps(uint256(a.rateGrowthBeforeOptimal))),
        _row('rateGrowthAfterOptimal', _ps(uint256(a.rateGrowthAfterOptimal))),
        _row('maxDrawnRate', _ps(a.maxDrawnRate)),
        '\n'
      );
  }

  function _findHA(
    Types.HubAssetSnapshot[] memory a,
    address h,
    uint256 id
  ) private pure returns (bool, uint256) {
    for (uint256 i; i < a.length; i++) {
      if (a[i].hubAddress == h && a[i].assetId == id) return (true, i);
    }
    return (false, 0);
  }

  // --- hub spoke caps diff ---

  function _diffHubSpokeCaps(
    Types.HubSpokeCapSnapshot[] memory arrB,
    Types.HubSpokeCapSnapshot[] memory arrA
  ) private pure returns (string memory section) {
    string memory body = '';
    for (uint256 i; i < arrA.length; i++) {
      (bool found, uint256 bi) = _findSC(
        arrB,
        arrA[i].hubAddress,
        arrA[i].assetId,
        arrA[i].spokeAddress
      );
      if (found) {
        string memory rows = _cmpSC(arrB[bi], arrA[i]);
        if (bytes(rows).length > 0) {
          body = string.concat(body, _scHdr(arrA[i]), _header(), rows, '\n');
        }
      } else {
        body = string.concat(body, _newSC(arrA[i]));
      }
    }
    for (uint256 i; i < arrB.length; i++) {
      (bool f, ) = _findSC(arrA, arrB[i].hubAddress, arrB[i].assetId, arrB[i].spokeAddress);
      if (!f) body = string.concat(body, _scHdr(arrB[i]), '**REMOVED**\n\n');
    }
    if (bytes(body).length > 0) section = string.concat('## Hub Spoke Cap Changes\n\n', body);
  }

  function _scHdr(Types.HubSpokeCapSnapshot memory c) private pure returns (string memory) {
    return
      string.concat(
        '### ',
        c.assetSymbol,
        ' (assetId: ',
        vm.toString(c.assetId),
        ') on Hub ',
        vm.toString(c.hubAddress),
        ' / Spoke ',
        vm.toString(c.spokeAddress),
        '\n\n'
      );
  }

  function _cmpSC(
    Types.HubSpokeCapSnapshot memory b,
    Types.HubSpokeCapSnapshot memory a
  ) private pure returns (string memory) {
    return
      string.concat(
        _dU('addCap', uint256(b.addCap), uint256(a.addCap)),
        _dU('drawCap', uint256(b.drawCap), uint256(a.drawCap)),
        _dU(
          'riskPremiumThreshold',
          uint256(b.riskPremiumThreshold),
          uint256(a.riskPremiumThreshold)
        ),
        _dB('active', b.active, a.active),
        _dB('halted', b.halted, a.halted)
      );
  }

  function _newSC(Types.HubSpokeCapSnapshot memory c) private pure returns (string memory) {
    return
      string.concat(
        _scHdr(c),
        '**NEW SPOKE**\n\n',
        _header(),
        _row('addCap', vm.toString(uint256(c.addCap))),
        _row('drawCap', vm.toString(uint256(c.drawCap))),
        _row('riskPremiumThreshold', vm.toString(uint256(c.riskPremiumThreshold))),
        _row('active', _bs(c.active)),
        _row('halted', _bs(c.halted)),
        '\n'
      );
  }

  function _findSC(
    Types.HubSpokeCapSnapshot[] memory a,
    address h,
    uint256 id,
    address s
  ) private pure returns (bool, uint256) {
    for (uint256 i; i < a.length; i++) {
      if (a[i].hubAddress == h && a[i].assetId == id && a[i].spokeAddress == s) return (true, i);
    }
    return (false, 0);
  }

  function _diffSpokeLiq(
    Types.SpokeLiquidationSnapshot[] memory arrB,
    Types.SpokeLiquidationSnapshot[] memory arrA
  ) private pure returns (string memory section) {
    string memory body = '';
    for (uint256 i; i < arrA.length; i++) {
      (bool found, uint256 bi) = _findSL(arrB, arrA[i].spokeAddress);
      if (found) {
        string memory rows = _cmpSL(arrB[bi], arrA[i]);
        if (bytes(rows).length > 0) {
          body = string.concat(
            body,
            '### Spoke ',
            vm.toString(arrA[i].spokeAddress),
            '\n\n',
            _header(),
            rows,
            '\n'
          );
        }
      } else {
        body = string.concat(
          body,
          '### Spoke ',
          vm.toString(arrA[i].spokeAddress),
          ' **NEW**\n\n',
          _header(),
          _row('targetHealthFactor', vm.toString(uint256(arrA[i].targetHealthFactor))),
          _row('healthFactorForMaxBonus', vm.toString(uint256(arrA[i].healthFactorForMaxBonus))),
          _row('liquidationBonusFactor', vm.toString(uint256(arrA[i].liquidationBonusFactor))),
          _row('maxUserReservesLimit', vm.toString(uint256(arrA[i].maxUserReservesLimit))),
          '\n'
        );
      }
    }
    if (bytes(body).length > 0) {
      section = string.concat('## Spoke Liquidation Config Changes\n\n', body);
    }
  }

  function _cmpSL(
    Types.SpokeLiquidationSnapshot memory b,
    Types.SpokeLiquidationSnapshot memory a
  ) private pure returns (string memory) {
    return
      string.concat(
        _dU('targetHealthFactor', uint256(b.targetHealthFactor), uint256(a.targetHealthFactor)),
        _dU(
          'healthFactorForMaxBonus',
          uint256(b.healthFactorForMaxBonus),
          uint256(a.healthFactorForMaxBonus)
        ),
        _dU(
          'liquidationBonusFactor',
          uint256(b.liquidationBonusFactor),
          uint256(a.liquidationBonusFactor)
        ),
        _dU(
          'maxUserReservesLimit',
          uint256(b.maxUserReservesLimit),
          uint256(a.maxUserReservesLimit)
        )
      );
  }

  function _findSL(
    Types.SpokeLiquidationSnapshot[] memory a,
    address s
  ) private pure returns (bool, uint256) {
    for (uint256 i; i < a.length; i++) {
      if (a[i].spokeAddress == s) return (true, i);
    }
    return (false, 0);
  }

  function _header() private pure returns (string memory) {
    return '| description | value before | value after |\n| --- | --- | --- |\n';
  }

  function _row(string memory n, string memory v) private pure returns (string memory) {
    return string.concat('| ', n, ' | - | ', v, ' |\n');
  }

  function _dU(string memory n, uint256 b, uint256 a) private pure returns (string memory) {
    if (b == a) return '';
    return string.concat('| ', n, ' | ', vm.toString(b), ' | ', vm.toString(a), ' |\n');
  }

  function _dP(string memory n, uint256 b, uint256 a) private pure returns (string memory) {
    if (b == a) return '';
    return string.concat('| ', n, ' | ', _ps(b), ' | ', _ps(a), ' |\n');
  }

  function _dB(string memory n, bool b, bool a) private pure returns (string memory) {
    if (b == a) return '';
    return string.concat('| ', n, ' | ', _bs(b), ' | ', _bs(a), ' |\n');
  }

  function _dA(string memory n, address b, address a) private pure returns (string memory) {
    if (b == a) return '';
    return string.concat('| ', n, ' | ', vm.toString(b), ' | ', vm.toString(a), ' |\n');
  }

  function _bs(bool v) private pure returns (string memory) {
    return v ? 'true' : 'false';
  }

  function _ps(uint256 bps) private pure returns (string memory) {
    uint256 w = bps / 100;
    uint256 f = bps % 100;
    string memory fs = f < 10 ? string.concat('0', vm.toString(f)) : vm.toString(f);
    return string.concat(vm.toString(w), '.', fs, ' % [', vm.toString(bps), ']');
  }
}
