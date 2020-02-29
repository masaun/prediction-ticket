pragma solidity ^0.5.10;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";

// Storage
import "./storage/CfStorage.sol";
import "./storage/CfConstants.sol";

import "./NftTicket.sol";



/***
 * @notice - This contract is that ...
 **/
contract MarketplaceRegistry is Ownable, CfStorage, CfConstants {
    using SafeMath for uint;

    IERC20 public erc20;
    IERC721 public erc721;

    NftTicket public nftTicket;

    // @dev - Global id
    uint256 ticketId;
    uint256 gameId;

    // @dev - WalletAddress (after I replace)
    address clubTeam;
    address player;
    address audience;
    address poolOfFund;

    uint256 _ticketPrice;
    uint256 _stakingPrice;
    uint256 _stakingPoolTotalAmount;

    // @dev - sendReward
    address[] winnerAudiences;
    address[] playersOfMVP;


    constructor(address _nftTicket) public {
        nftTicket = NftTicket(_nftTicket);

        _ticketPrice = 30;  // Total Ticket Price is 30
        _stakingPrice = 5;  // Staking Price for voting
    }

    function testFunc() public returns (bool) {
        return CfConstants.CONFIRMED;
    }
    

    function playersRegistry(address _player) public returns (bool) {
        PlayersAddressList memory playersAddress = PlayersAddressList({
            playerAddress: _player
        });
        playersAddresses.push(playersAddress);
    }
    


    /***
     * @notice - Publisher is club team only 
     * @dev - Publish ticket of today's game
     * @param _signature - Club Team's signature
     ***/
    function publishTicket(address _clubTeam, bytes32 _signature, uint256 _ticketId, uint256 _gameId) public returns (uint256, uint256) {
        address _audience = msg.sender;

        // Set current ticketId
        nftTicket.mintTo(_clubTeam);

        // create Ticket objects
        Ticket storage ticket = tickets[ticketId];
        ticket.ticketId = _ticketId;
        ticket.gameId = _gameId;
        ticket.ticketPublisher = _clubTeam;
        ticket.signature = _signature;
        ticket.ticketPrice = _ticketPrice;
        ticket.stakingPrice = _stakingPrice;
        ticket.startTimeOfGame = now;  // So far. Actually, it set starting time to be exact.
        ticket.ticketOwner = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
        ticket.predictPlayer = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

        // Next count of ticketId
        ticketId.add(1);

        return (_ticketId, _gameId);
    }
    


    /***
     * @dev - Buy ticket
     ***/
    function buyTicket(
        uint256 _gameId,
        address _clubTeam, 
        address _player     // Predicted player who is selected by audience
    ) public returns (bool) {
        // This function is called by audience
        address _audience = msg.sender;

        // #1 Buy ticket
        erc20.transferFrom(_audience, _clubTeam, _ticketPrice);

        // #2 ClubTeam staking instead of audience
        erc20.transferFrom(_clubTeam, poolOfFund, _stakingPrice);

        // #3 Audience predict MVP player
        predictPlayerOfMVP(_gameId, _player);
    }


    /***
     * @dev - Audience predict MVP player
     ***/
    function predictPlayerOfMVP(uint256 _gameId, address _player) internal returns (bool) {
        // This function is called by audience
        address _audience = msg.sender;

        // #3 Audience predict MVP player
        PlayersList memory player = players[_gameId][_player];
        player.votedCount = player.votedCount + 1;
    }


    /***
     * @notice - Criteria which choose MVP is the most number of vote
     * @notice - Judgment time is 5 hours later from start time of the game. 
     * @dev - MVP is choosen. 
     ***/
    function judgementPlayerOfMVP(uint256 _ticketId, uint256 _gameId, address _playerOfMVP) public returns (bool) {

        uint256 currentTime;
        Ticket memory ticket = tickets[_ticketId];
        currentTime = now;

        if (currentTime > ticket.startTimeOfGame + 5 hours) {
            // #1 Identify a player who collect the most number of vote in the game.
            for (uint i=0; i < playersAddresses.length; i++) {
                PlayersAddressList memory playersAddress = playersAddresses[i];
                //PlayersList memory player = players[_gameId][_player];
            }

            // #2 Identify audiences who was successful to predict MVP.

        }
    }
    


    /***
     * @dev - Reward（Distribute）for audience who is winner of prediction and player who is choosen as MVP of the game.
     ***/
    function sendRewardForWinnerAndPlayer(address poolOfFund, uint256 gameId) public returns (bool) {
        uint256 distrubuteRewardForWinners;  // per 1 winner.

        // #1 - Calculate reward 
        distrubuteRewardForWinners = _stakingPoolTotalAmount.div((winnerAudiences.length).add(1));  // +1 is playerOfMVP

        // #2 - Send reward money from pool for audience of winner
        for (uint i=0; i<winnerAudiences.length; i++) {
            erc20.transferFrom(poolOfFund, winnerAudiences[i], distrubuteRewardForWinners);
        }

        // #3 - Send reward money as "tip" from pool for player who is choosen as MVP
        for (uint p=0; p<playersOfMVP.length; p++) {
            erc20.transferFrom(poolOfFund, playersOfMVP[p], distrubuteRewardForWinners);
        }
    }


}
