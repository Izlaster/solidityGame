const MyContract = artifacts.require("MyContract");
const TokenBTS = artifacts.require("TokenBTS");

module.exports = function(deployer) {
  deployer.deploy(TokenBTS)
    .then((Token) => {
      return deployer.deploy(MyContract, Token.address);
    });
};
