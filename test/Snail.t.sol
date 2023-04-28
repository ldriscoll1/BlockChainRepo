// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "forge-std/Test.sol";
import "contracts/Snail.sol";

contract ContractTest is Test {
    function testTransfer() public {
        Snail snail = new Snail(2);
        snail.setPossibleOwners(address(1), address(2));
        address[2] memory owners = snail.getPossibleOwners();
        assertEq(owners[0], address(1));
        assertEq(owners[1], address(2));
        snail.transferSnail(address(2));
        snail.transferSnail(address(1));
        assertEq(snail.getSnailDone(), true);
    }
    function testReset() public {
        Snail snail = new Snail(2);
        snail.setPossibleOwners(address(1), address(2));
        address[2] memory owners = snail.getPossibleOwners();
        //Check to make sure the owners are set
        assertEq(owners[0], address(1));
        assertEq(owners[1], address(2));
        snail.transferSnail(address(2));
        snail.transferSnail(address(1));
        //Check to make sure the snail is done
        assertEq(snail.getSnailDone(), true);
        snail.resetSnail();


        //Check to make sure the snail is reset
        assertEq(snail.getSnailDone(), false);
        owners = snail.getPossibleOwners();
        //Check to make sure the owners reset
        assertEq(owners[0], address(0));
        assertEq(owners[1], address(1));
        //Check to make sure the distance reset
        assertEq(snail.getSnailLocation(), 0);

    }
    
}
