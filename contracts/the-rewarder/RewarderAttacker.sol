// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {AccountingToken} from "./AccountingToken.sol";
import {FlashLoanerPool} from "./FlashLoanerPool.sol";
import {RewardToken} from "./RewardToken.sol";
import {DamnValuableToken} from "../DamnValuableToken.sol";
import {TheRewarderPool} from "./TheRewarderPool.sol";

contract RewarderAttacker{
    RewardToken rewardToken;
    AccountingToken accountingToken;
    FlashLoanerPool flashLoanPool;
    TheRewarderPool rewardPool;
    DamnValuableToken liquidityToken;

    constructor(address liquidityToken_, address accountingToken_, address rewardToken_, address flashLoanPool_, address rewardPool_){
        rewardToken = RewardToken(rewardToken_);
        accountingToken = AccountingToken(accountingToken_);
        rewardPool = TheRewarderPool(rewardPool_);
        flashLoanPool = FlashLoanerPool(flashLoanPool_);
        liquidityToken = DamnValuableToken(liquidityToken_);

    }

    function receiveFlashLoan(uint256) external {

    }


    function attack() external {
        uint256 amount = liquidityToken.balanceOf(address(flashLoanPool));
        flashLoanPool.flashLoan(amount);
    }
}