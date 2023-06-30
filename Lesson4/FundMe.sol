// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import { PriceConverter } from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    // uint256 public minimumUSD = 5 * (10 **18); // $5
    // uint256 public minimumUSD = 5 * 1e18; // $5
    uint256 public minimumUSD = 5e18; // $5

    address[] public funders;
    // mapping (address => uint256) public addressToAmount;
    mapping (address funder => uint256 amountFunder) public addressToAmount;

    function fund() public payable {
        // msg.value.getConversionRate();
        require( msg.value.getConversionRate() >= minimumUSD, "Didn't send enough ETH" ); // 1e18 = 1 ETH = 1000000000000000000 = 1 * 10 ** 18
        funders.push(msg.sender);
        addressToAmount[msg.sender] = addressToAmount[msg.sender] + msg.value;
    }

    // function withdraw () public {

    // }

    // function something () public {

    // }
}
