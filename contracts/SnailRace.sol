// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
//IMport SnailContract
import "contracts/Snail.sol";

contract SnailRace{
    address private owner;
    //SnailRace has a set of snails
    Snail[] snails;
    uint256 leaderboardCount;
    //SnailRace Creates X amount of snails
    constructor(uint256 _snailCount, uint256 _leaderboardCount, uint256 _raceLength) {
        //Create Snails
        for (uint256 i = 0; i < _snailCount; i++) {
            Snail snail = new Snail(_raceLength);
            snails.push(snail);
        }
        leaderboardCount = _leaderboardCount;
        owner = msg.sender;
    }

    //SnailRace has a function to be assigned a snail
    function assignPlayers(address _playerOne, address _playerTwo, uint256 _snailID) public {
        //Make sure the owner is assigning the snail
        require(msg.sender == owner, "Only the owner can assign snails");
        //Make sure each player is not assigned to a snail
        require(playerSnail[_playerOne] == 0, "Player already has a snail");
        require(playerSnail[_playerTwo] == 0, "Player already has a snail");
        snails[_snailID].setPossibleOwners(_playerOne, _playerTwo);
        playerSnail[_playerOne] = _snailID + 1;
        playerSnail[_playerTwo] = _snailID + 1;
        snails[_snailID].setStartTime();
    }
    //If a snail is assigned to a player, the player can't be assigned another snail(address->snail mapping)
    mapping(address => uint256) public playerSnail;
    //SnailRace has a method to reset a snail
    function resetSnail(uint256 _snailID) public {
        //Make sure the owner is resetting the snail
        require(msg.sender == owner, "Only the owner can reset snails");
        //Remove players from the mapping
        address[2] memory owners = snails[_snailID].getPossibleOwners();
        delete playerSnail[owners[0]];
        delete playerSnail[owners[1]];
        snails[_snailID].resetSnail();
    }
    //SnailRace has a run function which transfers the snail
    function runTransaction() public {
        //Make sure the player has a snail
        require(playerSnail[msg.sender] != 0, "Player does not have a snail");
        uint256 snailID = playerSnail[msg.sender] - 1;

        snails[snailID].transferSnail(msg.sender);
        if(snails[snailID].getSnailDone() == true){
            //If done add to the leaderboard and reset the snail
            addToLeaderboard(snails[snailID]);
            resetSnail(snailID);
        }
    }
    //SnailRace has a run function which transfers the snail
    function runTransaction(address _userAddress) public {
        //Make sure the player has a snail
        require(playerSnail[_userAddress] != 0, "Player does not have a snail");
        uint256 snailID = playerSnail[_userAddress] - 1;

        snails[snailID].transferSnail(_userAddress);
        if(snails[snailID].getSnailDone() == true){
            //If done add to the leaderboard and reset the snail
            addToLeaderboard(snails[snailID]);
            resetSnail(snailID);
        }
    }

    struct LeaderboardEntry{
        address ownerOne;
        address ownerTwo;
        uint256 raceTime;
    }
    //SnailRace has a leaderboard of the 10 fastest entries and their owners
    LeaderboardEntry[] leaderboard;
    //SnailRace has a function to add an entry to the leaderboard
    function addToLeaderboard(Snail snail) private{
        //If the leaderboard is not full, add the entry
        if(leaderboard.length < leaderboardCount){
            address[2] memory owners = snail.getPossibleOwners();
            leaderboard.push(LeaderboardEntry(owners[0], owners[1], snail.getSnailRaceTime()));
            sortLeaderboard();
        }
        else if(leaderboard.length >= leaderboardCount){
            //If the leaderboard is full, remove the lowest entry and add the new entry and sort
            sortLeaderboard();
            if(leaderboard[leaderboard.length-1].raceTime > snail.getSnailRaceTime()){
                leaderboard.pop();
                address[2] memory owners = snail.getPossibleOwners();
                leaderboard.push(LeaderboardEntry(owners[0], owners[1], snail.getSnailRaceTime()));
                sortLeaderboard();
            }
        }

    }
    //SnailRace has a function to sort the leaderboard
    function sortLeaderboard() private{
        uint n = leaderboard.length;
        for (uint i = 0; i < n - 1; i++) {
            for (uint j = 0; j < n - i - 1; j++) {
                if (leaderboard[j].raceTime > leaderboard[j+1].raceTime) {
                    LeaderboardEntry memory temp = leaderboard[j];
                    leaderboard[j] = leaderboard[j+1];
                    leaderboard[j+1] = temp;
                }
            }
        }
    }
    //SnailRace has a function to get each leaderboardEntry
    function getLeaderboardEntry(uint256 _entryID) public view returns(address, address, uint256){
        //Require input to be in bounds of the leaderboard array
        require(_entryID < leaderboard.length, "Entry ID is out of bounds");
        return (leaderboard[_entryID].ownerOne, leaderboard[_entryID].ownerTwo, leaderboard[_entryID].raceTime);
    }
    
    //SnailRace has a function to get each Snail
    function getSnail(uint256 _snailID) public view returns(uint, address,address,address,bool,uint256,uint256,uint256){
        _snailID = _snailID - 1;
        return snails[_snailID].getSnail();
    }
    //SnailRace has a function to get the leaderboard length
    function getLeaderboardLength() public view returns(uint256){
        //Only allow the owner to get the leaderboard length
        require(msg.sender == owner, "Only the owner can get the leaderboard length");
        return leaderboard.length;
    }
    //SnailRace has a function to get the snail given an address
    function getSnailFromAddress(address _userAddress) public view returns(uint256){
        //Only allow the owner to get the leaderboard length
        require(msg.sender == owner, "Only the owner can get the leaderboard length");
        return playerSnail[_userAddress];
    }
    
}