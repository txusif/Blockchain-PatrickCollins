// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import { PriceConverter } from "./PriceConverter.sol";

error NotOwner();

// constant, immutable
// 800,087
// 779,720 constant
contract FundMe { 
    using PriceConverter for uint256;

    // uint256 public MINIMUM_USD = 5 * (10 **18); // $5
    // uint256 public MINIMUM_USD = 5 * 1e18; // $5
    uint256 public constant MINIMUM_USD = 5e18; // $5
    // 2446 * 15000000000 = 36690000000000 = $0.70  ->Non constant
    // 347 * 15000000000 = 5205000000000 = $0.0100 constant

    address[] public funders;
    // mapping (address => uint256) public addressToAmount;
    mapping (address funder => uint256 amountFunder) public addressToAmount;
    address public immutable i_owner;

    constructor () {
        i_owner = msg.sender;
    }
    
    modifier onlyOwner() {
        // require (msg.sender == i_owner, "You're not the owner");
        // require (msg.sender == i_owner, NotOwner());
        if (msg.sender != i_owner) {
            revert NotOwner();
        }
        _;
    }

    function fund() public payable {
        // msg.value.getConversionRate();
        require( msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough ETH" ); // 1e18 = 1 ETH = 1000000000000000000 = 1 * 10 ** 18
        funders.push(msg.sender);
        addressToAmount[msg.sender] = addressToAmount[msg.sender] + msg.value;
    }

    function withdraw () public onlyOwner {
        // require (msg.sender == i_owner, "You're not the owner"); // onlyOnwer modifier
        // for loop
        // [1, 2, 3, 4] elements
        //  0  1  2  3 indexes
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmount[funder] = 0;
        }
        // reset the array
        funders = new address[](0);

        // withdraw the funds: transfer, send, call.
        // transfer
        // payable(msg.sender).transfer(address(this).balance);

        // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require (sendSuccess, "Send Failed");

        // call
        // (bool callSuccess, byte memory dataReturned) = payable(msg.sender).call{ value: address(this).balance }("");
        (bool callSuccess, ) = payable(msg.sender).call{ value: address(this).balance }("");
        require (callSuccess, "Call Failed");
    }
    // receive
    receive() external payable {
        fund();
    }
    // fallback
    fallback() external payable {
        fund();
    }
}
