pragma solidity ^0.4.19;

contract Casino {
    
    address owner;
    uint payment_rate = 75;
    
    event Status(string _msg, address user, uint amount);
    
    function CoinFlip() payable {
        
    }
    
    modifier onlyOwner {
		if (msg.sender != owner) {
			revert();
		} else {
			_;
		}
	}
    
    function FlipCoin() payable {
        if((block.timestamp % 2) == 0) {
            if(this.balance < ((msg.value*payment_rate)/100)) {

                Status('Congratulations, You won! There is not enough funds to pay', msg.sender, this.balance);

                msg.sender.transfer(this.balance);
            } else {
                msg.sender.transfer(msg.value * (100 + payment_rate)/100);

                Status('Congratulations, You won!', msg.sender, msg.value * (100 + payment_rate)/100);

            }
        } else {

            Status('You lose.', msg.sender, msg.value);

        }
    }
    
        
    function kill() onlyOwner {
        Status('Contracted Killed, not longer available', msg.sender, this.balance);
	    suicide(owner);
	}
}
