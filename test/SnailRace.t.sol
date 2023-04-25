// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "forge-std/Test.sol";
import "contracts/SnailRace.sol";

contract ContractTest is Test {
    function testLeaderboard() public {
        SnailRace snailrace = new SnailRace(3, 2, 2);
        snailrace.assignPlayers(address(1), address(2), 0);
        snailrace.assignPlayers(address(3), address(4), 1);
        snailrace.assignPlayers(address(5), address(6), 2);
        snailrace.run(0, address(2));
        snailrace.run(1, address(4));
        snailrace.run(2, address(6));
        snailrace.run(0, address(1));
        snailrace.run(1, address(3));
        snailrace.run(2, address(5));
        //Make sure the leaderboard is full
        assertEq(snailrace.getLeaderboardLength(), 2);
        //Make sure the leaderboard is sorted
        assertLe(snailrace.getLeaderboardEntry(0).raceTime, snailrace.getLeaderboardEntry(1).raceTime);
        // //Make sure the leaderboard is sorted
        assertEq(snailrace.getLeaderboardEntry(0).ownerOne, address(1));
        assertEq(snailrace.getLeaderboardEntry(0).ownerTwo, address(2));
        assertEq(snailrace.getLeaderboardEntry(1).ownerOne, address(3));
        assertEq(snailrace.getLeaderboardEntry(1).ownerTwo, address(4));
    }
    // //Tests if the snails get reset after completing the race
    // function testReset() public{
    //     SnailRace snailrace = new SnailRace(1, 2, 1);
    //     snailrace.assignPlayers(address(1), address(2), 0);
    //     snailrace.run(0, address(2));
    //     snailrace.run(0, address(1));
    //     assertEq(snailrace.getLeaderboardLength(), 1);
    //     assertEq(snailrace.playerSnail[address(1)], 0);
    //     assertEq(snailrace.playerSnail[address(2)], 0);
    // }
    
}
