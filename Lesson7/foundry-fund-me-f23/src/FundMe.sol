// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

error FundMe__NotOwner();

// constant, immutable
// 800,087
// 779,720 constant
contract FundMe {
    using PriceConverter for uint256;

    address[] private s_funders;
    mapping(address funder => uint256 amountFunder) private s_addressToAmount;
    uint256 public constant MINIMUM_USD = 5e18; // $5
    address private immutable i_owner;

    AggregatorV3Interface private s_priceFeed;

    constructor(address priceFeed) {
        i_owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(priceFeed);
    }

    modifier onlyOwner() {
        // require (msg.sender == i_owner, "You're not the owner");
        // require (msg.sender == i_owner, NotOwner());
        if (msg.sender != i_owner) {
            revert FundMe__NotOwner();
        }
        _;
    }

    function fund() public payable {
        // msg.value.getConversionRate();
        require(msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD, "Didn't send enough ETH"); // 1e18 = 1 ETH = 1000000000000000000 = 1 * 10 ** 18
        s_funders.push(msg.sender);
        s_addressToAmount[msg.sender] = s_addressToAmount[msg.sender] + msg.value;
    }

    function cheaperWithdraw() public onlyOwner {
        uint256 fundersLength = s_funders.length;
        for (uint256 funderIndex = 0; funderIndex < fundersLength; funderIndex++) {
            address funder = s_funders[funderIndex];
            s_addressToAmount[funder] = 0;
        }
        s_funders = new address[](0);
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");
    }

    function withdraw() public onlyOwner {
        // require (msg.sender == i_owner, "You're not the owner"); // onlyOnwer modifier
        // for loop
        // [1, 2, 3, 4] elements
        //  0  1  2  3 indexes
        for (uint256 funderIndex = 0; funderIndex < s_funders.length; funderIndex++) {
            address funder = s_funders[funderIndex];
            s_addressToAmount[funder] = 0;
        }
        // reset the array
        s_funders = new address[](0);

        // withdraw the funds: transfer, send, call.
        // transfer
        // payable(msg.sender).transfer(address(this).balance);

        // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require (sendSuccess, "Send Failed");

        // call
        // (bool callSuccess, byte memory dataReturned) = payable(msg.sender).call{ value: address(this).balance }("");
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");
    }

    function getVersion() public view returns (uint256) {
        return s_priceFeed.version();
    }

    // receive
    receive() external payable {
        fund();
    }

    // fallback
    fallback() external payable {
        fund();
    }

    /**
     * View / Pure functions (getters)    *
     */

    function getAddressToAmountFunded(address fundingAddress) external view returns (uint256) {
        return s_addressToAmount[fundingAddress];
    }

    function getFunders(uint256 index) external view returns (address) {
        return s_funders[index];
    }

    function getOwner() external view returns (address) {
        return i_owner;
    }
}
