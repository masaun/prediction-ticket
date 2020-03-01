const StakingByAToken = artifacts.require("./StakingByAToken.sol");


module.exports = function(deployer, network) {
    deployer.deploy(StakingByAToken);
};
