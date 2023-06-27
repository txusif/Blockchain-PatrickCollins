// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

    // Basic types: boolean, uint, int, address, bytes
    // bool isNumber = true;
    // uint256 number = 1;
    // int256 positiveNumber = 70;
    // int256 NegativeNumber = 70;
    // address myAddress = 0x63aCF7f4ccff48A3378b304bdAb9CA0b98aFE70F;
    // string name = "txusif";
    // bytes1 grade = "A";
    // bytes2 grade2 = "A+";

contract SimpleStorage {
    uint myFavouriteNumber; // 0

    struct Person {
        uint256 favouriteNumber;
        string name;
    }

    // Person public pat = Person(7, "pat");
    // Person public pat = Person({favouriteNumber: 7, name: "pat"});
    Person[] public listOfPeoples;

    mapping (string => uint256) public nameToFavouriteNumber;

    function store (uint256 _favouriteNumber) public {
        myFavouriteNumber = _favouriteNumber;
    }

    // view, pure
    function retrieve () public view returns (uint256) {
        return myFavouriteNumber;
    }

    // calldata(cannot be modified), memory(modified) -> tempoarry
    // storage -> permanent, can be modified 
    function addPerson (string memory _name, uint256 _favouriteNumber) public {
        // Person memory newPerson = Person(_favouriteNumber, _name);
        // listOfPeoples.push(newPerson);
        listOfPeoples.push(Person(_favouriteNumber, _name));
        nameToFavouriteNumber[_name] = _favouriteNumber;
    }
}