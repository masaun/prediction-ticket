var MarketplaceRegistry = artifacts.require("MarketplaceRegistry");

var NftTicket = artifacts.require("NftTicket");
const _nftTicket = NftTicket.address;

var StakingByAToken = artifacts.require("StakingByAToken");
const _stakingByAToken = StakingByAToken.address;

module.exports = function(deployer) {
    deployer.deploy(MarketplaceRegistry, _nftTicke, _stakingByAToken);
};
