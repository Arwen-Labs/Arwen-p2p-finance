// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface DaiToken {
    function transfer(address dst, uint wad) external returns (bool);
    function transferFrom(address src, address dst, uint wad) external returns (bool);
    function balanceOf(address guy) external view returns (uint);
}

struct buyerData{
    uint amount;
    uint price;
    address tradeWith;
    bool conflict;
}
struct sellerData{
    uint amount;
    uint price;
    address tradeWith;
    bool isWithdrawable;
    bool conflict;
}
struct userOrder{
    bool isOldUser;
    uint orderId;
    uint numberOfBuyOrders;
    uint numberOfSellOrders;
    uint userFund;
}

contract Arwen {

    mapping (address => buyerData) public buyOrders;
    mapping (address => sellerData) public sellOrders;
    mapping (address => userOrder) private order;

    constructor() {
        //owner = msg.sender; // 'msg.sender' is contract deployer for a constructor
    }

    function placeSellOrder( uint _amount ,uint _price) public{
        if( sellOrders[msg.sender].isOldUser == true ){
            sellerData memory tradeData;
            tradeData.amount = _amount
            tradeData.price = _price;
            tradeData.isWithdrawable = true;
            tradeData.conflict = false;
            sellOrders[msg.sender] = tradeData;
        }else{
            sellerData memory tradeData;
            tradeData.amount = _amount;
            tradeData.isWithdrawable = true;
            tradeData.conflict = false;
            sellOrders[msg.sender] = tradeData;
        }
    }

    function placeBuyOrder( uint _amount ,uint _price) public{
        buyerData memory tradeData;
        tradeData.amount = _amount;
        tradeData.price = _price;
        tradeData.conflict = false;
        buyOrders[msg.sender] = tradeData;
    }

    function showOrderBalance() public view returns(uint, uint){
        buyerData memory buyOrderData = buyOrders[msg.sender];
        sellerData memory sellOrderData = sellOrders[msg.sender];
        return (buyOrderData.amount, sellOrderData.amount, );
    }
}
