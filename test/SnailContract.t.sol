// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "forge-std/Test.sol";
import "contracts/SnailContract.sol";

contract ContractTest is Test {
    function testTransfer() public {
        SnailContract snailcontract = new SnailContract(2);
        snailcontract.setPossibleOwners(address(1), address(2));
        address[2] memory owners = snailcontract.getPossibleOwners();
        assertEq(owners[0], address(1));
        assertEq(owners[1], address(2));
        snailcontract.transferSnail(address(2));
        snailcontract.transferSnail(address(1));
        assertEq(snailcontract.getSnailDone(), true);
    }
    function testReset() public {
        SnailContract snailcontract = new SnailContract(2);
        snailcontract.setPossibleOwners(address(1), address(2));
        address[2] memory owners = snailcontract.getPossibleOwners();
        assertEq(owners[0], address(1));
        assertEq(owners[1], address(2));
        snailcontract.transferSnail(address(2));
        snailcontract.transferSnail(address(1));
        assertEq(snailcontract.getSnailDone(), true);
        snailcontract.resetSnail();
        assertEq(snailcontract.getSnailDone(), false);
        owners = snailcontract.getPossibleOwners();
        assertEq(owners[0], address(0));
        assertEq(owners[1], address(1));

    }
    
}
