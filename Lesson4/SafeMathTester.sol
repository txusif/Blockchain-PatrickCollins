// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.18;

contract SafeMathTester {
    uint8 public bigNumber = 255;
    function add () public {
        bigNumber += 1;
        // unchecked {bigNumber += 1;} // same as version ^0.6.0 // 255+1=0 😭
    }
}