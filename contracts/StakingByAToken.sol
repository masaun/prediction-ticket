// Original: https://github.com/aave/aave-protocol/blob/master/contracts/flashloan/base/FlashLoanReceiverBase.sol

pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";

// AAVE
import "./aave/ILendingPoolAddressesProvider.sol";
import "./aave/ILendingPool.sol";
import "./aave/libraries/EthAddressLib.sol";

contract StakingByAToken {

    using SafeERC20 for IERC20;
    using SafeMath for uint256;

    /// Retrieve LendingPool address
    ILendingPoolAddressesProvider public provider;
    ILendingPool public lendingPool;

    constructor() public {
        // Contract Address on Rosten
        address _LendingPoolAddressesProvider = 0x1c8756FD2B28e9426CDBDcC7E3c4d64fa9A54728;  

        provider = ILendingPoolAddressesProvider(_LendingPoolAddressesProvider);
        lendingPool = ILendingPool(provider.getLendingPool());
    }

    /// Deposit method call
    function depositToLendingPool() public returns (bool) {
        /// Input variables（For test）
        address daiAddress = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
        uint256 amount = 100 * 1e18;
        uint16 referral = 0;

        lendingPool.deposit(daiAddress, amount, referral);        
    }

}
