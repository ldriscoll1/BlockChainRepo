// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

//Holds the location on a snail and the address of the owner
//Whenever the ownership changes the snails location is increased by 1
//If the snail reaches a certain location it will be considered a winner
contract SnailContract {
    //Each Snail has a set of qualities
    /* 
    * Location, an int that holds the position the snail is at in the race(similar to how many meters it has moved since the start)
    * Owner, the address of the current owner of the snail
    * possibleOwners, a array of size a size which holds the two possible addresses that can become owners of the snail
    * isWinner, a boolean that states if the snail is a winner or not
    * startingTimeStamp, the time stamp of when the snail was created
    * endingTimeStamp, the time stamp of when the snail reached the finish line
    */
    struct Snail {
        uint location;
        address currentOwner;
        address[2] possibleOwners;
        bool isWinner;
        uint256 startingTimeStamp;
        uint256 endingTimeStamp;
        uint256 raceTime;
    }
    //Constant to represent how long the race is
    uint256 private RACE_LENGTH = 5;
    //Array of Snails that are in play
    Snail[] public snails;
    //Constructor that creates the game according to the specified snail count
    constructor(uint _snailCount, address[] memory _playerAddresses) {
        require(_snailCount > 0, "Snail count must be greater than 0");
        require(_playerAddresses.length % 2 == 0, "Player count needs to be even");
        require(_playerAddresses.length != 0, "Player count needs to greater than 0");
        //Create Snails
        //Adds the owners in the order they are given so the first snail gets the first two addresses and so on
        uint addrPointer = 0;
        for (uint i = 0; i < _snailCount; i++) {
            Snail memory snail = Snail(0, _playerAddresses[addrPointer], [_playerAddresses[addrPointer],_playerAddresses[addrPointer+1]], false, getTimeStamp(), 0, 0);
            snails.push(snail);
            addrPointer += 2;
        }
    }
    //Returns the snail at the specified index
    function getSnail(uint _snailId) public view returns (uint, address,address,address,bool,uint256,uint256,uint256) {
        Snail memory snail = snails[_snailId];
        return (snail.location, snail.currentOwner, snail.possibleOwners[0], snail.possibleOwners[1], snail.isWinner, snail.startingTimeStamp, snail.endingTimeStamp, snail.raceTime);
    }
    //Returns the current owner of the snail
    function getSnailOwner(uint _snailId) public view returns (address){
        Snail memory snail = snails[_snailId];
        return snail.currentOwner;
    }
    //Transfers the snail to the specified address incrementing the location by 1
    function transferSnail(uint _snailId) public {
        Snail storage snail = snails[_snailId];
        //Checks if the addresses are valid
        require(snail.currentOwner != msg.sender, "You currently own this snail");
        require((snail.possibleOwners[0] == msg.sender || snail.possibleOwners[1] == msg.sender), "You need to be a possible owner this snail");
        require(!isWinner(_snailId), "This snail has already won");
        //Performs the transfer
        snail.currentOwner = msg.sender;
        snail.location++;
        //If the snail reaches the end it will be marked as a winner and the times will be given
        if(isWinner(_snailId)) {
            snail.endingTimeStamp = getTimeStamp();
            snail.raceTime = snail.endingTimeStamp - snail.startingTimeStamp;
            snail.isWinner = true;
        }
    }
    //Function that checks if the snail is a winner
    function isWinner(uint _snailId) private view returns (bool) {
        Snail memory snail = snails[_snailId];
        return snail.location >= RACE_LENGTH;
    }
    //Function that returns the current time stamp
    function getTimeStamp() private view returns (uint256){
        return block.timestamp;
    }

}