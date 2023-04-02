// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "forge-std/Test.sol";
import "contracts/SnailContract.sol";

contract ContractTest is Test {
    function testContract() public {
        address[] memory playerAddresses = new address[](2);
        playerAddresses[0] = address(1);
        playerAddresses[1] = address(2);
        SnailContract snailcontract = new SnailContract(1 , playerAddresses);
        address firstOwner = snailcontract.getSnailOwner(0);
        assertEq(firstOwner, address(1));
    }
    
}
