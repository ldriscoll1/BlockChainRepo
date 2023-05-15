# README
- This is the ReadMe for the Snail Race Project it will contain all the information needed to run the project.
- This Project is For CPSC 406 Algorithm Analysis and CPSC 298 Introduction to Smart Contracts
- The group members are Ryley Jue, Thomas Ogawa and Luke Driscoll
- This project is a blockchain full stack educational game to teach the user about smart contracts and the basics of blockchain. One big thing about our project is that we had to deploy it on the sepolia test net because the goerli faucet does not give enough funds to deploy the project.
- Demo Links  
  - Link to our deployed version of our [Demo Contract](https://sepolia.etherscan.io/address/0x743364668529f67bca0e2749f83b96b35f4fd3d3)
  - Link to our deployed version of our [Demo FrontEnd](https://snail-game.netlify.app)
  - Link to a demo of the project running using Etherscan and our FrontEnd [Demo Video](https://www.youtube.com/watch?v=M2O4ze4Xh0E) 
- Presentation Link
  - Link to our slides for the project [Slides](https://docs.google.com/presentation/d/1CLl9VYfL6Wm6Pr6xaaYWHRrpmnLRciOAzzWexslsfpg/edit?usp=sharing)
  - Link to our video for Intro to Smart Contracts [Video](https://youtu.be/KvUDCQxC3LU)
- Contract Link
  - Link to the final contract(Which is not connected to the frontend)[Contract](https://sepolia.etherscan.io/address/0x45fc0305e8B13F692C0937E1e55257d75099b4cc#code)

## Project Info
### CPSC 406 Algorithm Analysis
- What components does the software consist of? How do components interact?
  - Our software consists of Solidity for the smart contract, React for the frontend, and Hardhat for the backend. The frontend interacts with the backend through the use of etherscan api. We use other resources like alchemy and metamask in order to work with the testnets.
- What programming languages and APIs are used?
  - The programming languages we used is solidity for the backend and react for the frontend.
- What data structures and algorithms did you implement?
  - We used a lot of arrays and structs in our solidity code. However, we had a lot of algorithms that are important to this project like EthHash which is used to mine the blocks.
- How was the work divided between group members? Who was responsible for what?
  - Luke was responsible for the backend and mainly the code in solidity
  - Ryley was responsible for the frontend and working on the API
  - Thomas was responsible for the learning aspect and testing to make sure our project worked between the frontend and backend.
- Describe what works and what does not. Did your plans change? What is left to do?
  - For this project the user is able to deploy and verify the contract. The user is also able to deploy a frontend and link their contract to this frontend.
  - Our plans since the start since it was initially a gambling game where you gamble on snails. However, we decided to change it to a learning game where you learn about blockchain and smart contracts. Furthermore, we had plans to have writing to the contract using our frontend and show the total gas fees of the race but due to time constraints and because of our current knowledge of the blockchain and interacting with it we were not able to implement this. Also, we were not able to implement a time based refresh due to it interfering with how our frontend was architectly designed.
- Suggest directions for future development. Ideally, a list of possible extensions is described and designed, including details of how the current code base should be modified for the extension.
  - Some directions for future development in terms of extensions can be to implement new races. 
    - One example of a new race can be implementing it to end the race after a certain amount of time. So instead of having the race be how fast can the users run 10 transactions it can be how many transactions can occur in 5 minutes. This can be found by changing the `~/contracts/Snail.sol` file and changing the isWinner function to be based on time and not on the number of transactions.
    - Another example of a race is a teambased race where multiple snails can combine together to form a team and the team with the most transactions wins. This can be found by changing the `~/contracts/Snail.sol` file and changing the isWinner function to be based on the number of transactions of the team and not on the number of transactions of the snail. This will probably need another contract based on a team of snails to work.
### CPSC 298 Introduction to Smart Contracts
- Motivation and Background
  - We originally wanted to make an application to use the privacy and security of blockchain to gamble on snails. However, we instead focused on a more education idea since this class helped us learn a lot about blokchcian and we can use this knowledge to teach others about the basics of blockchain.
- References (to related work that is relevant)
  - Some related work we found was [Bloxxgame](https://link.springer.com/chapter/10.1007/978-3-030-63464-3_16) which is a web game to teach blockchain concepts.
- Instructions (how to run the code)
  - To run our code please refer to the testing the project section 
- Documentation  (of what works and what does not)
  - For this project the user is able to deploy and verify the contract. The user is also able to deploy a frontend and link their contract to this frontend.
- Future Work
 - Some directions for future development in terms of extensions can be to implement new races. 
    - One example of a new race can be implementing it to end the race after a certain amount of time. So instead of having the race be how fast can the users run 10 transactions it can be how many transactions can occur in 5 minutes. This can be found by changing the `~/contracts/Snail.sol` file and changing the isWinner function to be based on time and not on the number of transactions.
    - Another example of a race is a teambased race where multiple snails can combine together to form a team and the team with the most transactions wins. This can be found by changing the `~/contracts/Snail.sol` file and changing the isWinner function to be based on the number of transactions of the team and not on the number of transactions of the snail. This will probably need another contract based on a team of snails to work.
  
## Testing the Project
  ### Steps
  In order to test the project you will need to follow some steps:
  - Follow the Account Setup section
  - Follow the Required Steps for Testing and Deployment
  - Run `npm run compile`
  - Follow the steps in the Hardhat Tasks and Deploying the Project section
  - Follow the video tutorial to test the project using Etherscan and Metamask
  - Follow the steps in the Testing the Frontend section
  ### Test Cases
  In order to test the project you can run the following commands:
  - `npm run test` to run the unit tests, which will verify if some of the projects most important features are working



## Account Setup
  ### Metamask
  - Go to [Metamask](http://metamask.io) and download the extension
  - Create a new wallet
  - Secure the wallet and save the secret recovery phrase somewhere safe
  - Change the network to Sepolia Test Network (network select is at the top)
    - Might need to go to settings > advanced > show test networks.
  

  ### Getting Accounts for API Keys
  #### MetaMask
  - Open the MetaMask Chrome Extension and log in
  - Click on the 3 dots in the top right corner
  - Click on "Account Details"
  - Click on "Export Private Key"

  #### Etherscan
  - Go to [Etherscan](https://etherscan.io/)
  - Create an account
  - Go to [Etherscan API](https://etherscan.io/myapikey)
  - This can also be found by clicking on your username in the top right corner and then clicking on "API Keys"
  - Create a new key by hitting the add button

  #### Alchemy
  - Go to [Alchemy](https://www.alchemy.com/)
  - Create an account
  - Create a new app
  - For the chain select Ethereum
  - For the network select Sepolia
  - Open the app from dashboard
  - Click "VIEW KEY" to get the API key

  ### Getting Repo Setup
  - Clone the repo
  - Change the `.env.example` to `.env`
  
  - Fill in the .env file with the information from the previous steps
    - Configure `.env` file -> see [`.env.example`](https://github.com/alexhkurz/introduction-to-smart-contracts/blob/main/.env.example). (Go to your Metamask, follow "Goerli test network->Account details->Export private key" and enter the private key in your `.env` (for the `PRIVATE_KEY` variables); make an account with [alchemy](https://www.alchemy.com/), create a test app for the Ethereum chain on the Goerli network and fill in the value for `ALCHEMY_API_KEY`.) Note* May need to open up file in VSCode to edit .env file.
  ```
  GOERLI_PRIVATE_KEY= MetaMask Private Key
  SEPOLIA_PRIVATE_KEY= MetaMask Private Key
  BNB_TESTNET_PRIVATE_KEY= MetaMask Private Key
  BNB_MAINNET_PRIVATE_KEY= MetaMask Private Key
  MORDOR_PRIVATE_KEY= MetaMask Private Key
  ALCHEMY_API_KEY= Alchemy API Key
  ALCHEMY_BLOCK=
  ETHERSCAN_API_KEY= Etherscan API Key
  BSCSCAN_API_KEY=
  REPORT_GAS=
  REPORT_SIZE=
  ```
  

  Install Foundry -> https://book.getfoundry.sh/getting-started/installation.html
  - Run `forge install` # install project foundry modules(If running on windows use git bash)
  - Run `npm i`
  You may need to install node.js
  ->https://kinsta.com/blog/how-to-install-node-js/#1-download-macos-installer
  Configured Networks:

  - Localhost
  - Sepolia Faucet: https://sepoliafaucet.com/


## Running the Frontend
[Snail Game FrontEnd Directions](https://github.com/ldriscoll1/BlockChainRepo/tree/main/snail-game)
## NPM Commands

```
npm run compile # runs hardhat compile
npm run clean # runs hardhat clean
npm run test # runs unit tests via Forge
```


## Hardhat Tasks and Deploying the Project

To deploy your contract use

```
npx hardhat --network sepolia deploy --contract SnailRace --snailcount <constructor_argument> --racelength <constructor_argument> --leaderboardlength <constructor_argument>
```
The snailcount argument takes in the number of snails you want to create. The racelength argument takes in a number which represents the number of transactions needed to complete the race. The leaderboardlength argument takes in a number which represents the number of leaderboard entries shown.
For example:
```
npx hardhat --network sepolia deploy --contract SnailRace --snailcount 3 --racelength 10 --leaderboardlength 2  
```
This example creates the snailrace with 3 snails, a length of 10 transactions for the race and a leaderboard of 2 entries. If you want to change the argument values please change the values in the `arguments.js` file to reflect the changes you want to make.

If you would like to test it simply use your first MetaMask Account and make a second account by clicking on your profile picture and then selecting +create account this will be the second address you input in the command.

If you get `Error: insufficient funds` go to [sepoliafaucet](https://sepoliafaucet.com/), use your Alchemy login, and enter the wallet address you get from your Metamask wallet. If everything worked you see in your terminal

Note* Currently you need about 0.01 eth in your first account to succesfully send a contract.


`Contract deployed to: <deployed_contract_address>    

To "verify" your contract run

```
npx hardhat --network sepolia verify --constructor-args arguments.js <deployed_contract_address> 
```

In order to verify your contract you will need to update `arguments.js` to reflect your input, an example of the `arguments.js` file is provided in `arguments.js`.
These arguments must be the same as the ones you used to deploy your contract.

If you get `Error [...] no API token was found` go to [Etherscan](https://etherscan.io/), create an account, get an API-key and add it to your `.env` 

Now you should be able to interact via your Metamask wallet with your contract on the testnetwork.


## Troubleshooting

If you get an error similar to this:
```
[Error: ENOENT: no such file or directory, open 'C:\Users\<USER>\src\introduction-to-smart-contracts\artifacts\build-info\02c99f9d2dcfd295a0c0fe2cc9481c42.json'] {
  errno: -4058,
  code: 'ENOENT',
  syscall: 'open',
  path: 'C:\\Users\\<USER>\\src\\introduction-to-smart-contracts\\artifacts\\build-info\\02c99f9d2dcfd295a0c0fe2cc9481c42.json'
}
```
Then run: `npm run clean`
## Code Documentation
With Help From Chat GPT 
## SnailRace Contract
This contract is the main contract that runs the application. It holds the snails that will be raced, a leaderboard and a player->snail hashmap.
### Constructor
The constructor function takes in three parameters: _snailCount is the number of snails to create, _leaderboardCount is the maximum number of entries in the leaderboard, and _raceLength is the length of the race. The constructor then sets up the contract creating the snails specified by the snailcount and the leaderboard.
### Methods
#### AssignPlayers
This function allows players to be assigned a snail. It takes in three parameters: _playerOne and _playerTwo are the addresses of the players to assign, and _snailID is the ID of the snail to assign them to. The function checks that the caller is the owner of the contract and that neither player is already assigned to a snail. If those conditions are met, it sets the possible owners of the snail to be the two players and records the snail ID in the playerSnail mapping for each player.
#### RunTransaction
This function allows the player to run the transaction of taking ownership of the snail. There is two versions of this method the original version, which does not take in any parameters, and the overloaded version, which takes in an address. The original version uses the user's address when interacting with the contract. The second version of this method is for unit testing to allow for a different address to run the transaction that the user. This function checks if the owner does not have a snail and then proceeds to transfer the ownership of the snail by changing the current owner to the user. If the snail completes the race by hitting the number of transactions needed, it is then added to the leaderboard, and the snail is reset back to its default settings.
### Leaderboard
The leaderboard consists of a sorted array of Leaderboard entries. Where these entries consist of the two addresses of the snail and the time it took for the snail to complete the race. In order to access the leaderboard, the user can use the getLeaderboardEntry method, which, when the entry id is entered, returns that specific information for the entry in the leaderboard.


