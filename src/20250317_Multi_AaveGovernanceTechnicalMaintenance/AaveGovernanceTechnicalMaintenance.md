---
title: "Gov v3 VotingMachine / VotingPortal maintenance"
author: "BGD Labs @bgdlabs"
discussions: https://governance.aave.com/t/technical-maintenance-proposals/15274/71
---

## Simple Summary

Proposal to make minor improvements on the Governance v3 VotingMachine smart contracts.

## Motivation

After more than 1 year of working in production without changes, the Aave governance v3 Voting Machine smart contracts (Ethereum, Polygon, Avalanche) require minor maintenance to move them to an up-to-date state with the rest of the system, more precisely the a.DI (Aave Delivery Infrastructure) directly connected.

As they are not upgradeable, it is necessary to deploy new DataWarehouse contracts, new VotingStrategy contracts and new VotingPortals.

## Specification

The governance proposal will call `approveSenders()` on the CrossChainController contract on every voting network (Ethereum, Polygon, Avalanche) to register the new VotingMachine contracts.
Additionally, `addVotingPortals()` will be called on the core Governance contract on Ethereum, with the new Voting Portals addresses, so that the Aave Governance can communicate with the new Voting Machines.

**Voting Machines:**
| Network | VotingMachine |
| ------- | ------------- |
| Ethereum | [0x06a1795a88b82700896583e123F46BE43877bFb6](https://etherscan.io/address/0x06a1795a88b82700896583e123F46BE43877bFb6) |
| Polygon | [0x44c8b753229006A8047A05b90379A7e92185E97C](https://polygonscan.com/address/0x44c8b753229006A8047A05b90379A7e92185E97C) |
| Avalanche | [0x4D1863d22D0ED8579f8999388BCC833CB057C2d6](https://snowscan.xyz/address/0x4D1863d22D0ED8579f8999388BCC833CB057C2d6) |

**Voting Portals:**
| Network Path | VotingPortals |
| ------- | ------------- |
| Ethereum - Ethereum | [0x6ACe1Bf22D57a33863161bFDC851316Fb0442690](https://etherscan.io/address/0x6ACe1Bf22D57a33863161bFDC851316Fb0442690) |
| Ethereum - Polygon | [0xFe4683C18aaad791B6AFDF0a8e1Ed5C6e2c9ecD6](https://etherscan.io/address/0xFe4683C18aaad791B6AFDF0a8e1Ed5C6e2c9ecD6) |
| Ethereum - Avalanche | [0x9Ded9406f088C10621BE628EEFf40c1DF396c172](https://etherscan.io/address/0x9Ded9406f088C10621BE628EEFf40c1DF396c172) |

## References

- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/71)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
