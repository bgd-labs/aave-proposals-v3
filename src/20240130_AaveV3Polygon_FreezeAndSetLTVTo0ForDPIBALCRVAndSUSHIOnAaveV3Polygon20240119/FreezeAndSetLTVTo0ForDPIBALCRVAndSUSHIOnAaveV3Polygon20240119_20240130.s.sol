// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {WithPayloads, DeployPayloadsPolygon, CreateProposal} from '../templating/DeploymentScripts.sol';
import {AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119_20240130} from './AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119_20240130.sol';

abstract contract ProposalActions is WithPayloads {
  function getActions() public pure override returns (ActionsPerChain[] memory) {
    ActionsPerChain[] memory payloads = new ActionsPerChain[](1);

    payloads[0].chainName = 'polygon';
    payloads[0].actionCode = new bytes[](1);
    payloads[0].actionCode[0] = type(
      AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119_20240130
    ).creationCode;

    return payloads;
  }
}

contract DeployPolygon is ProposalActions, DeployPayloadsPolygon {}

contract ProposalCreation is
  ProposalActions,
  CreateProposal(
    'src/20240130_AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119/FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119.md'
  )
{}
