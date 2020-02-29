pragma solidity ^0.5.11;

import "./CfObjects.sol";
import "./CfEvents.sol";


// shared storage
contract CfStorage is CfObjects, CfEvents {

    //PlayersList[] public players;
    mapping (uint256 => mapping (address => PlayersList)) players;

    PlayersAddressList[] playersAddresses;

    mapping (uint256 => Ticket) tickets;

}

