var MarketplaceRegistry = artifacts.require("MarketplaceRegistry");


module.exports = function(deployer) {
  deployer.deploy(MarketplaceRegistry);
};
