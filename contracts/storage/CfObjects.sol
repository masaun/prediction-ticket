pragma solidity ^0.5.11;


contract CfObjects {

    struct PlayersList {
        uint256 gameId;
        address playerAddress;
        uint256 votedCount;
    }

    struct Ticket {
        uint256 gameId;
        uint256 ticketId;
        address ticketPublisher;
        bytes32 signature;
        uint ticketPrice;    // Total Ticket Price is 30
        uint stakingPrice;   // Staking Price for voting

        uint startTimeOfGame;
        address ticketOwner;
        address predictPlayer;
    }

    struct ExampleObject {
        address addr;
        uint amount;
    }
    
}
