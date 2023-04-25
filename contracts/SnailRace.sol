// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
//IMport SnailContract
import "contracts/SnailContract.sol";

contract SnailRace{
    //SnailRace has a set of snails
    SnailContract[] snails;
    //SnailRace Creates X amount of snails
    constructor(uint256 _snailCount, uint256 _raceLength) {
        //Create Snails
        for (uint256 i = 0; i < _snailCount; i++) {
            SnailContract snail = new SnailContract(_raceLength);
            snails.push(snail);
        }
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
        snails[_snailID].resetSnail();
    }
    //SnailRace has a run function which transfers the snail
    function run(uint256 _snailID) public {
        snails[_snailID].transferSnail();
        if(snails[_snailID].getSnailDone() == true){
            //If done add to the leaderboard and reset the snail
            resetSnail(_snailID);
        }
    }

    struct LeaderboardEntry{
        address ownerOne;
        address ownerTwo;
        uint256 raceTime;
    }
    //SnailRace has a leaderboard of the 10 fastest entries and their owners
    LeaderboardEntry[] public leaderboard;
    //SnailRace has a function to add an entry to the leaderboard
    function addToLeaderboard(SnailContract snail) private{
        //If the leaderboard is not full, add the entry
        if(leaderboard.length < 10){
            address[2] memory owners = snail.getPossibleOwners();
            leaderboard.push(LeaderboardEntry(owners[0], owners[1], snail.getSnailRaceTime()));
            sortLeaderboard();
        }
        else if(leaderboard.length >= 10){
            //If the leaderboard is full, remove the lowest entry and add the new entry and sort
            sortLeaderboard();
            leaderboard.pop();
            address[2] memory owners = snail.getPossibleOwners();
            leaderboard.push(LeaderboardEntry(owners[0], owners[1], snail.getSnailRaceTime()));
            sortLeaderboard();
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



}