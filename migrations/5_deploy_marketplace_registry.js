var MarketplaceRegistry = artifacts.require("MarketplaceRegistry");

var NftTicket = artifacts.require("NftTicket");
const _nftTicket = NftTicket.address;

var StakingByAToken = artifacts.require("StakingByAToken");
const _stakingByAToken = StakingByAToken.address;

var SendRewardForWinners = artifacts.require("SendRewardForWinners");
const _sendRewardForWinners = SendRewardForWinners.address;

module.exports = function(deployer) {
    deployer.deploy(MarketplaceRegistry, _nftTicket, _stakingByAToken, _sendRewardForWinners);
};
