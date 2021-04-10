pragma solidity >=0.4.22 <0.9.0;

contract MyContract
{
    uint count = 0;
    address player1;
    address player2;
    uint public numb1;
    uint public numb2;
    uint public rand = 5;
    uint winner;

    // event GameEvent(address player);
    // event WinEvent(int winnerNumber);
    
    modifier isRegistered() {
        require(msg.sender != player1 && msg.sender != player2);
        _;
    }

    modifier isBothReg() {
        require((int(player1) != 0) && (int(player2) != 0));
        _;
    }

    function RegMe() isRegistered() public {
        if (int(player1) == 0)
            player1 = msg.sender;
        else if (int(player2) == 0)
            player2 = msg.sender;
    }

    function TryNumber(uint number) isBothReg() public {
        if (msg.sender == player1) {
            numb1 = number;
            count++;
        } else if (msg.sender == player2) {
            numb2 = number;
            count++;
        }
        if (count == 2) {
            DeadermineTheWinner();
        }
    }

    function DeadermineTheWinner() public {
        if (rand < numb1) {
            numb1 = numb1 - rand;
        } else {
            numb1 = rand - numb1;
        }
        if (rand < numb2) {
            numb2 = numb2 - rand;
        } else {
            numb2 = rand - numb2;
        }

        if (numb1 > numb2) {
            winner = 2;
        } else if (numb1 < numb2) {
            winner = 1;
        } else 
        {
            winner = 0;
        }
    }

    function ClearAllData() public {
        count = 0;
        delete player1;
        delete player2;
        delete numb1;
        delete numb2;
        winner = 0;

    }

    function GetRez() public view returns (uint w1nn3r) {
        w1nn3r = winner;
        ClearAllData();   
    }

    function WhoAmI() public view returns (uint number) {
        if (msg.sender == player1) number = 1;
        else if (msg.sender == player2) number = 2;
    }

}