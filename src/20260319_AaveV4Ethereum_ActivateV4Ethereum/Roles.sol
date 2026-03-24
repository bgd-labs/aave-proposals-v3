// SPDX-License-Identifier: UNLICENSED
// Copyright (c) 2025 Aave Labs
pragma solidity ^0.8.0;

/// @title Roles library
/// @author Aave Labs
/// @notice Defines the different roles used by the protocol.
///
/// Role IDs are namespaced by domain:
///   - AccessManager:     0 (default admin)
///   - Hub:               100-199
///   - HubConfigurator:   200-299
///   - Spoke:             300-399
///   - SpokeConfigurator: 400-499
library Roles {
  // AccessManager roles
  uint64 public constant ACCESS_MANAGER_ADMIN_ROLE = 0;

  // Hub roles
  uint64 public constant HUB_DOMAIN_ADMIN_ROLE = 100;
  uint64 public constant HUB_CONFIGURATOR_ROLE = 101;
  uint64 public constant HUB_FEE_MINTER_ROLE = 102;
  uint64 public constant HUB_DEFICIT_ELIMINATOR_ROLE = 103;

  // HubConfigurator roles
  uint64 public constant HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE = 200;

  // Spoke roles
  uint64 public constant SPOKE_DOMAIN_ADMIN_ROLE = 300;
  uint64 public constant SPOKE_CONFIGURATOR_ROLE = 301;
  uint64 public constant SPOKE_USER_POSITION_UPDATER_ROLE = 302;

  // SpokeConfigurator roles
  uint64 public constant SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE = 400;
}
