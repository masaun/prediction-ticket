pragma solidity ^0.5.10;

import "./opensea/TradeableERC721Token.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";

/**
 * @title NftTicket
 * NftTicket - a contract for my non-fungible tickets.
 */
contract NftTicket is TradeableERC721Token {
    constructor(address _proxyRegistryAddress) TradeableERC721Token("Ticket for watching sports", "TKT", _proxyRegistryAddress) public {  }

    function baseTokenURI() public view returns (string memory) {
        return "https://opensea-creatures-api.herokuapp.com/api/nft-ticket/";
    }


    function _mintTo(address _to) public onlyOwner {
        mintTo(_to);
    }
    
}
