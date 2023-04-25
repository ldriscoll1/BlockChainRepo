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
        bool isDone;
        uint256 startingTimeStamp;
        uint256 endingTimeStamp;
        uint256 raceTime;
    }
    //Constant to represent how long the race is
    uint256 private RACE_LENGTH;
    //Array of Snails that are in play
    Snail public snail;
    // Constructor that creates the snail according to the race count
    constructor(uint256 _raceLength) {
        //Create Snail
        snail = Snail(0, address(0), [address(0),address(1)], false, getTimeStamp(), 0, 0);
        RACE_LENGTH = _raceLength;
    }

    //----- Getters -----//

    //Returns the snail at the specified index
    function getSnail() public view returns (uint, address,address,address,bool,uint256,uint256,uint256) {
        return (snail.location, snail.currentOwner, snail.possibleOwners[0], snail.possibleOwners[1], snail.isDone, snail.startingTimeStamp, snail.endingTimeStamp, snail.raceTime);
    }
    //Returns the current owner of the snail
    function getSnailOwner() private view returns (address){
        return snail.currentOwner;
    }
    //Returns the possible owners of the snail
    function getPossibleOwners() public view returns (address[2] memory){
        return snail.possibleOwners;
    }
    //Function that returns the current time stamp
    function getTimeStamp() private view returns (uint256){
        return block.timestamp;
    }
    //Returns the current location of the snail
    function getSnailLocation() public view returns (uint){
        return snail.location;
    }
    //Returns if the snail is done or not
    function getSnailDone() public view returns (bool){
        return snail.isDone;
    }
    //Returns the race time of the snail
    function getSnailRaceTime() public view returns (uint256){
        return snail.raceTime;
    }

    //----- Setters -----//

    //Sets the possible owners of the snail
    function setPossibleOwners(address _owner1, address _owner2) public {
        //Checks if the addresses are valid
        //Only on Default Addresses
        require((_owner1 == address(0) && _owner2 == address(1)), "You need to be a possible owner this snail");

        snail.possibleOwners[0] = _owner1;
        snail.possibleOwners[1] = _owner2;
    }
    //Sets the start time of the snail
    function setStartTime() public{
        snail.startingTimeStamp = getTimeStamp();
    }
    //----- Functions -----//

    //Transfers the snail to the specified address incrementing the location by 1
    function transferSnail() public {
        //Checks if the addresses are valid
        //No Default Addresses
        require((snail.possibleOwners[0] != address(0) || snail.possibleOwners[1] != address(1)), "You need to be a possible owner this snail");
        //Needs to be the current owner to transfer
        require(snail.currentOwner != msg.sender, "You currently own this snail");
        //Needs to be a possible owner to transfer
        require((snail.possibleOwners[0] == msg.sender || snail.possibleOwners[1] == msg.sender), "You need to be a possible owner this snail");
        //Needs to not be a winner to transfer
        require(!isWinner(), "This snail has already won");

        //Performs the transfer
        snail.currentOwner = msg.sender;
        snail.location++;

        //If the snail reaches the end it will be marked as a winner and the times will be given
        if(isWinner()) {
            snail.endingTimeStamp = getTimeStamp();
            snail.raceTime = snail.endingTimeStamp - snail.startingTimeStamp;
            snail.isDone = true;
        }
    }
    //Function that checks if the snail is a winner
    function isWinner() public view returns (bool) {
        return snail.location >= RACE_LENGTH;
    }
    //Function that resets the snail
    function resetSnail() public {
        snail = Snail(0, address(0), [address(0),address(1)], false, getTimeStamp(), 0, 0);
    }
}