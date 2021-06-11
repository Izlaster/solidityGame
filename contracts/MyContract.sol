pragma solidity >=0.4.22 <0.9.0;
import "./TokenPRNHB.sol";

contract MyContract
{
    TokenPRNHB public Token;
    uint count = 0;
    address player1;
    address player2;
    uint public numb1;
    uint public numb2;
    uint public rand;
    uint winner;
    uint256 BID = uint256(5000);

    event WhoPushed(address player);
    event ShowRandomVal(uint random);

    constructor(address tokenAddr) public
    {
        Token = TokenPRNHB(tokenAddr);
    }

    
    modifier isRegistered() {
        require(msg.sender != player1 && msg.sender != player2);
        _;
    }

    modifier isBothReg() {
        require((int(player1) != 0) && (int(player2) != 0));
        _;
    }

    function Random() public view returns(uint) { //Мы не знаем как это работает, но это рандомайзер и это работает
        return uint(keccak256(abi.encodePacked(now, block.difficulty, msg.sender))) % 10;
    }

    function RegMe() isRegistered() public {
        if (int(player1) == 0) {
            player1 = msg.sender;
        }
        else if (int(player2) == 0) {
            player2 = msg.sender;
        }
        Token.transferFrom(msg.sender, address(this), BID);
    }

    function TryNumber(uint number) isBothReg() public {
        if (msg.sender == player1) {
            numb1 = number;
            emit WhoPushed(player1);
            count++;
        } else if (msg.sender == player2) {
            numb2 = number;
            emit WhoPushed(player2);
            count++;
        }
        if (count == 2) {
            rand = Random();
            emit ShowRandomVal(rand);
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
            Token.transfer(player2, BID * 2);
        } else if (numb1 < numb2) {
            winner = 1;
            Token.transfer(player1, BID * 2);
        } else 
        {
            winner = 0;
            Token.transfer(player1, BID);
            Token.transfer(player2, BID);
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
    }

     function GetRandom() public view returns (uint random) {  
        random = rand;
    }

    function WhoAmI() public view returns (uint number) {
        if (msg.sender == player1) number = 1;
        else if (msg.sender == player2) number = 2;
    }

}