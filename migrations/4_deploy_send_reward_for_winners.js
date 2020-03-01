const SendRewardForWinners = artifacts.require("./SendRewardForWinners.sol");


module.exports = function(deployer, network) {
    deployer.deploy(SendRewardForWinners);
};
