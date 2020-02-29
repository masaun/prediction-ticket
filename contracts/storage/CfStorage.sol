pragma solidity ^0.5.11;

import "./CfObjects.sol";
import "./CfEvents.sol";


// shared storage
contract CfStorage is CfObjects, CfEvents {

    mapping (uint256 => mapping (address => PlayersList)) playersLists;

    mapping (uint256 => Ticket) tickets;

}

