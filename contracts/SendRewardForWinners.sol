// Original: https://github.com/aave/aave-protocol/blob/master/contracts/flashloan/base/FlashLoanReceiverBase.sol

pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";

// AAVE
import "./aave/tokenization/AToken.sol";
import "./aave/EthAddressLib.sol";


contract SendRewardForWinners {

    using SafeERC20 for IERC20;
    using SafeMath for uint256;

    AToken public aTokenInstance;

    constructor() public {
        address aDAI = 0xcB1Fe6F440c49E9290c3eb7f158534c2dC374201;  // @param - aDAI address is on Ropsten 

        /// Instantiation of the AToken address
        aTokenInstance = AToken(aDAI);      
    }


    function redeemFromATokenToERC20() public returns (bool) {
        /// Input variables
        uint256 amount = 100 * 1e18;

        /// redeem method call
        aTokenInstance.redeem(amount);
    }


    function transfer() public returns (bool) {
        // In progress
    }
    

}
