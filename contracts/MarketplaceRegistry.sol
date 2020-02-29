pragma solidity ^0.5.10;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";

// Storage
import "./storage/CfStorage.sol";
import "./storage/CfConstants.sol";



/***
 * @notice - This contract is that ...
 **/
contract MarketplaceRegistry is Ownable, CfStorage, CfConstants {

    IERC20 public erc20;
    IERC721 public erc721;

    // @dev - Global id
    address ticketId;
    address gameId;

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


    constructor() public {
        _ticketPrice = 30;  // Total Ticket Price is 30
        _stakingPrice = 5;  // Staking Price for voting
    }

    function testFunc() public returns (bool) {
        return CfConstants.CONFIRMED;
    }
    

    function playersRegistry(address _playerAddress) public returns (bool) {
        PlayersAddressList storage playersAddresses = PlayersAddressList({
            playerAddress: _playerAddress
        });
        playersAddresses.push(_playerAddress);
    }
    


    /***
     * @notice - Publisher is club team only 
     * @dev - Publish ticket of today's game
     * @param _signature - Club Team's signature
     ***/
    function publishTicket(address _clubTeam, bytes32 _signature) returns (uint256, uint256) {
        address _audience = msg.sender;

        // Set current ticketId


        // create Ticket objects
        Ticket public ticket = Ticket({
            ticketId: _ticketId,
            gameId: _gameId,
            ticketPublisher: _clubTeam,
            signature: _signature,
            ticketPrice: _ticketPrice,
            stakingPrice: _stakingPrice,
            //ticketOwner: null
            //predictPlayer: null
        });

        return (ticketId, gameId);

        // Next count of tokenId
        ticketId.add(1);
    }
    


    /***
     * @dev - Buy ticket
     ***/
    function buyTicket(
        address _clubTeam, 
        address _player     // Predicted player who is selected by audience
    ) public returns (bool) {
        // This function is called by audience
        address _audience = msg.sender;

        // #1 Buy ticket
        erc20.transferFrom(_audience, _clubTeam, ticketPrice);

        // #2 ClubTeam staking instead of audience
        erc20.transferFrom(_clubTeam, poolOfFund, stakingPrice);

        // #3 Audience predict MVP player
        predictPlayerOfMVP(_gameId, _playerAddress)
    }


    /***
     * @dev - Audience predict MVP player
     ***/
    function predictPlayerOfMVP(uint256 _gameId, address _playerAddress) internal returns (bool) {
        // This function is called by audience
        address _audience = msg.sender;

        // #3 Audience predict MVP player
        playersList memory player = players[_gameId][_playerAddress];
        player.votedCount = player.votedCount + 1;
    }


    /***
     * @notice - Criteria which choose MVP is the most number of vote
     * @notice - Judgment time is 5 hours later from start time of the game. 
     * @dev - MVP is choosen. 
     ***/
    function judgementPlayerOfMVP(uint256 _ticketId, uint256 _gameId, address _playerOfMVPAddress) public returns (bool) {

        uint256 currentTime;
        Ticket memory ticket = tickets[_ticketId];
        currentTime = now;

        if (currentTime > ticket.startTimeOfGame + 5 hours) {
            // #1 Identify a player who collect the most number of vote in the game.
            for (uint i=0; i < playersAddresses.length; i++) {
                PlayersAddressList public playersAddress = playersAddresses[i]

                PlayersList memory player = players[_gameId][_playerAddress];
        
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
        distrubuteRewardForWinners = poolOfFund.div(winnerAudiences + 1);  // +1 is playerOfMVP

        // #2 - Send reward money from pool for audience of winner
        for (i=0; i<winnerAudiences.length; i++) {
            erc20.transferFrom(poolOfFund, winnerAudiences[i], distrubuteRewardForWinners);
        }

        // #3 - Send reward money as "tip" from pool for player who is choosen as MVP
        for (p=0; p<playersOfMVP.length; p++) {
            erc20.transferFrom(poolOfFund, playersOfMVP[p], distrubuteRewardForWinners);
        }
    }


}











///////////////////////////////
/// Reference below
//////////////////////////////


/**
 * See https://github.com/ethereum/EIPs/issues/20
 */
contract ERC20_Token {
    // Triggered when tokens are transferred.
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    // Triggered whenever approve(address _spender, uint256 _value) is called.
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    // Get the total token supply
    function totalSupply() public constant returns (uint256 _totalSupply);
    
    // Get the account balance of another account with address _owner
    function balanceOf(address _owner) public constant returns (uint256 balance);
    
    // Send _value amount of tokens to address _to
    function transfer(address _to, uint256 _value) public returns (bool success);
    
    // Send _value amount of tokens from address _from to address _to
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
    
    // Allow _spender to withdraw from your account, multiple times, up to the _value amount. If this function is called again it overwrites the current allowance with _value.
    function approve(address _spender, uint256 _value) public returns (bool success);
    
    // Returns the amount which _spender is still allowed to withdraw from _owner
    function allowance(address _owner, address _spender) public constant returns (uint256 remaining);
}

contract ERC20_Details {
    string tokenName;
    string tokenSymbol;
    uint8 tokenDecimals;

    function name() public view returns (string _name);
    function symbol() public view returns (string _symbol);
    function decimals() public view returns (uint8 _decimals);

    function ERC20_Details(string _name, string _symbol, uint8 _decimals) public {
        require (keccak256(_name) != keccak256(''));
        require (keccak256(_symbol) != keccak256(''));

        tokenName = _name;
        tokenSymbol = _symbol;
        tokenDecimals = _decimals;
    }
}

contract MyToken is ERC20_Token, ERC20_Details {
    mapping (address => uint256) public balances;
    mapping (address => mapping (address => uint256)) public allowance;

    uint256 supply;
    
    /**
     * Prevent an account from behing 0x0
     * @param addr Address to check
     */
    modifier No0x(address addr) { 
        if (addr == 0x0) revert();
        _; 
    }

    /**
     * A modifer to check validity of a balance for a transfer
     * from an account to another.
     * @param from  [description]
     * @param to    [description]
     * @param value [description]
     */
    modifier ValidBalance(address from, address to, uint256 value) { 
        if (balances[from] < value) revert();                 // Check if the sender has enough
        if (balances[to] + value < balances[to]) revert();  // Check for overflows
        _; 
    }
    
    /**
     * Constructor of MyToken
     * @param _totalSupply Total amount of tokens initially issued
     */
    function MyToken (uint256 _totalSupply, string _name, string _symbol, uint8 _decimals) 
        ERC20_Details(_name, _symbol, _decimals) public {
        supply = _totalSupply;
        balances[msg.sender] = _totalSupply;
    }

    /**
     * Returns the total amount of tokens
     * @return total amount
     */
    function totalSupply() public constant returns(uint256 _totalSupply) {
        return supply;
    }

    /**
     * Returns The balance of a given account
     * @param addr Address of the account
     * @return Balance
     */
    function balanceOf(address addr) public constant returns(uint256 balance) {
        return balances[addr];
    }
    
    /**
     * Returns the amount which _spender is still allowed to withdraw from _owner
     */
    function allowance(address _owner, address _spender) public constant returns (uint256 remaining) {
        return allowance[_owner][_spender];    
    }

    /**
     * Send coins
     * @param _to        The recipient of tokens
     * @param _value     Amount of tokens to send 
     */
     function transfer(address _to, uint256 _value) public No0x(_to) ValidBalance(msg.sender, _to, _value) 
     returns (bool success) {                        
        balances[msg.sender] -= _value;                      // Subtract from the sender
        balances[_to] += _value;                             // Add the same to the recipient
        Transfer(msg.sender, _to, _value);                   // Notify anyone listening that this transfer took place
        return true;
    }

    /**
     * Allow another contract to spend some tokens in your behalf
     * @param _spender     Account that can take some of your tokens
     * @param _value       Max amount of tokens the _spender account can take
     * @return {return}    Return true if the action succeeded
     */
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }  

    /**
     * A contract attempts to get the coins
     * @param _from     Address holding the tokens to transfer
     * @param _to       Account to send the coins to
     * @param _value    How many tokens     
     * @return {bool}   Whether the call was successful
     */
    function transferFrom(address _from, address _to, uint256 _value) public No0x (_to) ValidBalance(_from, _to, _value)
    returns (bool success) {
        if (_value > allowance[_from][msg.sender]) revert();     // Check allowance
        balances[_from] -= _value;                               // Subtract from the sender
        balances[_to] += _value;                                 // Add the same to the recipient
        allowance[_from][msg.sender] -= _value;
        Transfer(_from, _to, _value);
        return true;
    }

    function name() public view returns (string _name) {
        return tokenName;
    }

    function symbol() public view returns (string _symbol) {
        return tokenSymbol;
    }

    function decimals() public view returns (uint8 _decimals) {
        return tokenDecimals;
    }
}

