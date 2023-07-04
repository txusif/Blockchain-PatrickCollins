// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract SimpleStorage {
    uint256 myFavouriteNumber; // 0

    struct Person {
        uint256 favouriteNumber;
        string name;
    }

    // Person public pat = Person(7, "pat");
    // Person public pat = Person({favouriteNumber: 7, name: "pat"});
    Person[] public listOfPeoples;

    mapping(string => uint256) public nameToFavouriteNumber;

    function store(uint256 _favouriteNumber) public {
        myFavouriteNumber = _favouriteNumber;
    }

    // view, pure
    function retrieve() public view returns (uint256) {
        return myFavouriteNumber;
    }

    // calldata(cannot be modified), memory(modified) -> tempoarry
    // storage -> permanent, can be modified
    function addPerson(string memory _name, uint256 _favouriteNumber) public {
        // Person memory newPerson = Person(_favouriteNumber, _name);
        // listOfPeoples.push(newPerson);
        listOfPeoples.push(Person(_favouriteNumber, _name));
        nameToFavouriteNumber[_name] = _favouriteNumber;
    }
}
