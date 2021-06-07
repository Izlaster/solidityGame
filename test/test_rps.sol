pragma solidity >=0.4.25 <0.6.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/MyContract.sol";
import "../contracts/TokenOBT.sol";


contract TestRockPaperScissors {
  function testInitialBalanceUsingDeployedContract() public {
    TokenOBT token = TokenOBT(DeployedAddresses.TokenOBT());

    uint expected = 100000;

    Assert.equal(token.balanceOf(tx.origin), expected, "Owner should have 100000 MetaCoin initially");
  }
}
