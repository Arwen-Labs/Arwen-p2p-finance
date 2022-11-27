// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface DaiToken {
    function transfer(address dst, uint wad) external returns (bool);
    function transferFrom(address src, address dst, uint wad) external returns (bool);
    function balanceOf(address guy) external view returns (uint);
}

struct OrderDetails{
    uint orderId;
    uint orderType;
    uint amount;
    uint price;
    address tradeWith;
    bool isWithdrawable;
    bool inConflict;
}


struct order{
    bool isOldUser;
    uint totalUserFund;
    uint totalOrders;
}

contract Arwen {

    mapping (address => order) public userToOrder;
    mapping (address => uint) public userActiveOrders;
    mapping (address => mapping (uint => uint)) public tiveOrders;
    mapping (uint => OrderDetails) public idToOrder;

    constructor() {
        //owner = msg.sender; // 'msg.sender' is contract deployer for a constructor
    }
    
    function random() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty, msg.sender))) % 100000000;
    }

    function placeSellOrder( uint _amount ,uint _price) public{

        order memory userData = userToOrder[msg.sender];

        if( userData.isOldUser ){

            order memory tradeData;
            tradeData.orderId = random();
            tradeData.orderType = 0;                //orderType is 0 if its a sell order and orderType is 1 if its buy order
            tradeData.amount = _amount;             //amount for selling
            tradeData.price = _price;               //asset price fixed by user
            tradeData.isWithdrawable = true;        //if no buyer is intrested user can withdraw fund from escrow
            tradeData.conflict = false;             //if any conflict

            userData.totalUserFund += _amount;
            userData.totalOrders += 1;
            userData.orders[userData.totalOrders] = tradeData;

            uint[] memory orders_of_users;
            orders_of_users.push(tradeData.orderId);
            userActiveOrders[msg.sender] = orders_of_users;

        }else{

            order memory tradeData;
            tradeData.orderId = random();
            tradeData.orderType = 0;                //orderType is 0 if its a sell order and orderType is 1 if its buy order
            tradeData.amount = _amount;             //amount for selling
            tradeData.price = _price;               //asset price fixed by user
            tradeData.isWithdrawable = true;        //if no buyer is intrested user can withdraw fund from escrow
            tradeData.conflict = false;             //if any conflict

            userData.totalUserFund += _amount;
            userData.totalOrders += 1;
            userData.orders[userData.totalOrders] = tradeData;
            userData.isOldUser = true;

            uint[] memory orders_of_users;
            orders_of_users.push(tradeData.orderId);
            userActiveOrders[msg.sender] = orders_of_users;
        }
    }
    /*
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
    */
}
