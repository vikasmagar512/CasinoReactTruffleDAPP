pragma solidity ^0.4.17;
//import './safeMath.sol';

import "zeppelin/contracts/math/SafeMath.sol";
//import 'zeppelin/contracts/token/ERC20.sol';
contract Casino {
    using SafeMath for uint8;

    uint public minBet;
    uint public numbers;
    uint public totalBetters;
    uint public totalMoney;
    uint public maxBidLimit;
    address owner;
    constructor(uint mBet,uint nums,uint maxBidL){
        owner = msg.sender;
        minBet = mBet;
        numbers = nums;
        maxBidLimit = maxBidL;
    }
    struct Bet{
        uint number;
        address better;
        uint amount;
    }
    mapping(uint=>Bet[]) betMapping;
    mapping(uint=>uint) numberMoneyMapping;
    modifier ownerOnly(){
        require(msg.sender == owner);
        _;
    }
    modifier maxBetterLimit(){
        require( totalBetters <= maxBidLimit);
        _;
    }
    modifier minBidLimit(uint am){
        require(am >= minBet);
        _;
    }
    function bet(uint number,uint amount) minBidLimit(amount) maxBetterLimit public  {
        require(amount >= minBet);
        betMapping[number].push(Bet(number,msg.sender,amount));
        // Bet storage b = betMapping[number].pop;
        totalBetters++;
        totalMoney += amount;
        numberMoneyMapping[number]+=amount;
        // return (b.number,b.ad,b.amount);
    }
    function endBetting(address ad,uint amount) ownerOnly maxBetterLimit public payable{
        uint256 numberGenerated = block.number % 10 + 1; // This isn't secure
        Bet[] winners = betMapping[numberGenerated];
        for(uint i=0;i<winners.length;i++){
            uint percent = winners[i].amount / (numberMoneyMapping[numberGenerated]);
            uint money = totalMoney * percent;
            winners[i].better.transfer(money);
        }
        /*
        betMapping[numberGenerated] = Bet(number,msg.sender,amount);
        Bet b = betMapping[number];
        return (b.number,b.ad,b.amount);*/
    }
}