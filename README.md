# README
This is the ReadMe for the Snail Race Project it will contain all the information needed to run the project.
  
## Testing the Project
  ### Steps
  In order to test the project you will need to follow some steps:
  - Follow the Account Setup section
  - Follow the Required Steps for Testing and Deployment
  - Run `npm run compile`
  - Follow the steps in the Hardhat Tasks and Deploying the Project section
  - Follow the video tutorial to test the project using Etherscan and Metamask
  ### Test Cases
  In order to test the project you can run the following commands:
  - `npm run test` to run the unit tests



## Account Setup
  ### Metamask
  - Go to metamask.io and download the extension
  - Create a new wallet
  - Secure the wallet and save the secret recovery phrase somewhere safe
  - Change the network to Goerli Test Network (network select is at the top)
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
  - Change the .env.example to .env
  - Fill in the .env file with the information from the previous steps
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
  - Run `npm i`
  You may need to install node.js
  ->https://kinsta.com/blog/how-to-install-node-js/#1-download-macos-installer
  
## Required Steps for Testing and Deployment

Install Foundry -> https://book.getfoundry.sh/getting-started/installation.html

```
npm i # install project npm modules
forge install # install project foundry modules
```

Configure `.env` file -> see [`.env.example`](https://github.com/alexhkurz/introduction-to-smart-contracts/blob/main/.env.example). (Go to your Metamask, follow "Goerli test network->Account details->Export private key" and enter the private key in your `.env` (for the `PRIVATE_KEY` variables); make an account with [alchemy](https://www.alchemy.com/), create a test app for the Ethereum chain on the Goerli network and fill in the value for `ALCHEMY_API_KEY`.) Note* May need to open up file in VSCode to edit .env file.

This framework has been written to use various testnets and mainnets. Test ETH has been encoded into the tasks for localhost deployment. For testnets, test ETH, BNB, or ETC is required which can be received from their corresponding faucets. An .env is used for running on other networks outside of localhost.

Configured Networks:

- Localhost
- Goerli. Faucet: https://goerlifaucet.com/
- Sepolia Faucet: https://sepoliafaucet.com/
- BSC Testnet. Faucet: https://testnet.bnbchain.org/faucet-smart
- BSC.
- Mordor. Faucet: https://easy.hebeswap.com/#/faucet

## NPM Commands

```
npm run compile # runs hardhat compile
npm run clean # runs hardhat clean
npm run test # runs unit tests via Forge
```


## Hardhat Tasks and Deploying the Project

To deploy your contract use

```
npx hardhat --network sepolia deploy --contract <contract_name> --snailcount <constructor_argument> --addresses <constructor_argument>
```
The snailCount argument takes in the number of snails you want to create. The addresses argument takes in the addresses for the owners of these snails. This is a comma separated list of addresses.
For example:
```
npx hardhat --network sepolia deploy --contract SnailRace --snailcount 3 --racelength 2 --leaderboardlength 2  
```
This example creates the snailrace with 3 snails, a length of 2 transactions for the race and a leaderboard of 2 entries. If you want to change the argument values please change the values in the arguments.js file to reflect the changes you want to make.

If you would like to test it simply use your first MetaMask Account and make a second account by clicking on your profile picture and then selecting +create account this will be the second address you input in the command.

If you get `Error: insufficient funds` go to [sepoliafaucet](https://sepoliafaucet.com/), use your Alchemy login, and enter the wallet address you get from your Metamask wallet. If everything worked you see in your terminal

Note* Currently you need about 0.01 eth in your first account to succesfully send a contract.


`Contract deployed to: <deployed_contract_address>    

To "verify" your contract run

```
npx hardhat --network sepolia verify --constructor-args arguments.js <deployed_contract_address> 
```

In order to verify your contract you will need to update arguments.js to reflect your input, an example of the arguments.js file is provided in arguments.js.
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

