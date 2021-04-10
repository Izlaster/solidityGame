pragma solidity >=0.4.22 <0.9.0;

contract MyContract
{
    address player1;
    address player2;
    int public choose1;
    int public choose2;
    int winner;
    int[] winnerEach;


    event GameEvent(address player);
    event WinEvent(int winnerNumber);
    
        modifier isRegistered()
    {
        require(msg.sender != player1 && msg.sender != player2);
        _;
    }

    function RegMe() isRegistered() public {
        if (int(player1) == 0)
            player1 = msg.sender;
        else if (int(player2) == 0)
            player2 = msg.sender;
    }

    //     function MakeDesicion (int memory player1Number, int memory player2Number) view private returns (int win) {
        
    // }

}