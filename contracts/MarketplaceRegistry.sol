pragma solidity ^0.5.10;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";

// Storage
import "./storage/CfStorage.sol";
import "./storage/CfConstants.sol";


/***
 * @notice - This contract is that ...
 */
contract MarketplaceRegistry is Ownable, CfStorage, CfConstants {


    constructor() public {}

    function testFunc() public returns (bool) {
        return CfConstants.CONFIRMED;
    }   

}
