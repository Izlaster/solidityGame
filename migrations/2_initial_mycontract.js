const MyContract = artifacts.require("MyContract");
const TokenPRNHB = artifacts.require("TokenPRNHB");

module.exports = function(deployer) {
  deployer.deploy(TokenPRNHB)
    .then((Token) => {
      return deployer.deploy(MyContract, Token.address);
    });
};
