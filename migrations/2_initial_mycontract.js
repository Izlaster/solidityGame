const MyContract = artifacts.require("MyContract");
const TokenOBT = artifacts.require("TokenOBT");

module.exports = function(deployer) {
  deployer.deploy(TokenOBT)
    .then((Token) => {
      return deployer.deploy(MyContract, Token.address);
    });
};
