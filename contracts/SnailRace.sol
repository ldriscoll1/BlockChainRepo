// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
//IMport SnailContract
import "contracts/SnailContract.sol";

contract SnailRace{
    //SnailRace has a set of snails
    SnailContract[] snails;
    uint256 leaderboardCount;
    //SnailRace Creates X amount of snails
    constructor(uint256 _snailCount, uint256 _leaderboardCount, uint256 _raceLength) {
        //Create Snails
        for (uint256 i = 0; i < _snailCount; i++) {
            SnailContract snail = new SnailContract(_raceLength);
            snails.push(snail);
        }
        leaderboardCount = _leaderboardCount;
    }
    //SnailRace has a function to be assigned a snail
    function assignPlayers(address _playerOne, address _playerTwo, uint256 _snailID) public {
        snails[_snailID].setPossibleOwners(_playerOne, _playerTwo);
        playerSnail[_playerOne] = _snailID;
        playerSnail[_playerTwo] = _snailID;
        snails[_snailID].setStartTime();
    }
    //If a snail is assigned to a player, the player can't be assigned another snail(address->snail mapping)
    mapping(address => uint256) public playerSnail;
    //SnailRace has a method to reset a snail
    function resetSnail(uint256 _snailID) public {
        //Remove players from the mapping

        address[2] memory owners = snails[_snailID].getPossibleOwners();
        delete playerSnail[owners[0]];
        delete playerSnail[owners[1]];
        
        snails[_snailID].resetSnail();
    }
    //SnailRace has a run function which transfers the snail
    function run(uint256 _snailID) public {
        snails[_snailID].transferSnail(msg.sender);
        if(snails[_snailID].getSnailDone() == true){
            //If done add to the leaderboard and reset the snail
            addToLeaderboard(snails[_snailID]);
            resetSnail(_snailID);
        }
    }
    //SnailRace has a run function which transfers the snail
    function run(uint256 _snailID,address _userAddress) public {
        snails[_snailID].transferSnail(_userAddress);
        if(snails[_snailID].getSnailDone() == true){
            //If done add to the leaderboard and reset the snail
            addToLeaderboard(snails[_snailID]);
            resetSnail(_snailID);
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
    function addToLeaderboard(SnailContract snail) private{
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
    function getLeaderboardEntry(uint256 _entryID) public view returns(LeaderboardEntry memory){
        return leaderboard[_entryID];
    }
    
    //SnailRace has a function to get each Snail
    function getSnail(uint256 _snailID) public view returns(uint, address,address,address,bool,uint256,uint256,uint256){
        return snails[_snailID].getSnail();
    }
    //SnailRace has a function to get the leaderboard length
    function getLeaderboardLength() public view returns(uint256){
        return leaderboard.length;
    }
}