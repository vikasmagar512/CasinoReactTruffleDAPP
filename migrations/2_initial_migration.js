var Migrations = artifacts.require("./Casino.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
