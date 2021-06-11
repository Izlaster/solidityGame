pragma solidity >=0.4.25 <0.6.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/MyContract.sol";
import "../contracts/TokenPRNHB.sol";

contract TestMyContract {
  function testInitialBalanceUsingDeployedContract() public {
    TokenPRNHB token = TokenPRNHB(DeployedAddresses.TokenPRNHB());

    uint expected = 100000;

    Assert.equal(token.balanceOf(tx.origin), expected, "Owner should have 100000 MetaCoin initially");
  }
}
