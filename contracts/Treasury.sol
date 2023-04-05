// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "openzeppelin-contracts/contracts/access/Ownable.sol";


/*
  By default, the owner of an Ownable contract is the account that deployed it.
*/
contract Treasury is Ownable {
    struct Player{
        address player_address;
        bool isWinner;
        uint256 amountBet;
    }
    // Function to deposit Ether into the contract
    function deposit() external payable {
        require(
            msg.value > 0,
            "Treasury: Deposit amount should be greater than zero"
        );

        
        // The balance of the contract is automatically updated
    }
    Player[] public players;
    uint256 public constant MAX_ETH = 0.001 ether;
    //Function that only allows a certain amount to be bet for the snailRace
    function payBet() external payable {
        require(msg.value == MAX_ETH, "Only 0.001 ETH is allowed.");
        if(playerExists(msg.sender)){
            for (uint i = 0; i < players.length; i++) {
                if (players[i].player_address == msg.sender) {
                    players[i].amountBet += MAX_ETH;
                }
            }
        }
        else{
            Player memory p = Player(msg.sender,false,MAX_ETH);
            players.push(p);
        }
        
    }
    //Function that checks if the player exist
    function playerExists(address _player) internal view returns (bool){
        for (uint i = 0; i < players.length; i++) {
            if (players[i].player_address == _player) {
                return true;
            }
        }
        return false;
    }
    //Function to pay the winners which is a fraction of the amount
    function payOutWinners() external onlyOwner{
        uint256 amountOfWinners = 0;
        for (uint i = 0; i < players.length; i++) {
            if (players[i].isWinner) {
                amountOfWinners++;
            }
        }
        uint256 payout = address(this).balance / amountOfWinners;
        for (uint i = 0; i < players.length; i++) {
            if (players[i].isWinner) {
                (bool send, ) = players[i].player_address.call{value: payout}("");
                require(send, "To receiver: Failed to send Ether");
            }
        }
    }
    // Function to withdraw Ether from the contract to specified address
    function withdraw(uint256 amount, address receiver) external onlyOwner {
        require(
            address(receiver) != address(0),
            "Treasury: receiver is zero address"
        );
        require(
            address(this).balance >= amount,
            "Treasury: Not enough balance to withdraw"
        );


        (bool send, ) = receiver.call{value: amount}("");
        require(send, "To receiver: Failed to send Ether");
    }

    // Function to allow the owner to withdraw the entire balance
    function withdrawAll() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "Treasury: No balance to withdraw");


        (bool send, ) = msg.sender.call{value: balance}("");
        require(send, "To owner: Failed to send Ether");
    }


    // Function to get the contract balance
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}