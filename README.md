# README
This is the ReadMe for the Snail Race Project it will contain all the information needed to run the project.
## Testing the Project
  
  In order to test the project you will need to follow some steps:
  - Follow the Account Setup section
  - Follow the Required Steps for Testing and Deployment
  - Run `npm run compile`
  - Follow the steps in the Hardhat Tasks and Deploying the Project section
  - Follow the video tutorial to test the project using Etherscan and Metamask

## Account Setup
  ### Metamask
  - Go to metamask.io and download the extension
  - Create a new wallet
  - Secure the wallet and save the secret recovery phrase somewhere safe
  - Change the network to Goerli Test Network (network select is at the top)

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
  - For the network select Goerli
  - Open the app from dashboard
  - Click "VIEW KEY" to get the API key

  ### Getting Repo Setup
## Required Steps for Testing and Deployment

Install Foundry -> https://book.getfoundry.sh/getting-started/installation.html

```
npm i # install project npm modules
forge install # install project foundry modules
```

Configure `.env` file -> see [`.env.example`](https://github.com/alexhkurz/introduction-to-smart-contracts/blob/main/.env.example). (Go to your Metamask, follow "Goerli test network->Account details->Export private key" and enter the private key in your `.env` (for the `PRIVATE_KEY` variables); make an account with [alchemy](https://www.alchemy.com/), create a test app for the Ethereum chain on the Goerli network and fill in the value for `ALCHEMY_API_KEY`.)

This framework has been written to use various testnets and mainnets. Test ETH has been encoded into the tasks for localhost deployment. For testnets, test ETH, BNB, or ETC is required which can be received from their corresponding faucets. An .env is used for running on other networks outside of localhost.

Configured Networks:

- Localhost
- Goerli. Faucet: https://goerlifaucet.com/
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
npx hardhat --network goerli deploy --contract <contract_name> --snailcount <constructor_argument> --addresses <constructor_argument>
```
The snailCount argument takes in the number of snails you want to create. The addresses argument takes in the addresses for the owners of these snails. This is a comma separated list of addresses.
For example:
```
npx hardhat --network goerli deploy --contract SnailContract --snailcount 1 --addresses "0x32fb216dED836aBAa8af2F6Dda2629b30b768aF3","0x9298f815C95DDf79c9724B5e30d52DB292c96086"
```
This example creates one snail that has two potential owners that have the addresses 0x32fb216dED836aBAa8af2F6Dda2629b30b768aF3 and 0x9298f815C95DDf79c9724B5e30d52DB292c96086.

If you get `Error: insufficient funds` go to [goerlifaucet](https://goerlifaucet.com/), use your Alchemy login, and enter the wallet address you get from your Metamask wallet. If everything worked you see in your terminal

`Contract deployed to: <deployed_contract_address>    

To "verify" your contract run

```
npx hardhat --network goerli verify --constructor-args arguments.js <deployed_contract_address> 
```

In order to verify your contract you will need to update arguments.js to reflect your input, an example of the arguments.js file is provided in arguments.js.
These arguments must be the same as the ones you used to deploy your contract.

If you get `Error [...] no API token was found` go to [Etherscan](https://etherscan.io/), create an account, get an API-key and add it to your `.env` 

Now you should be able to interact via your Metamask wallet with your contract on the testnetwork.

## Video Tutorial
1. In this tutorial we will be using 2 wallets on the same metamask account, this should be done between two different people, but this is for the sake of the tutorial.
2. The snails, are indexed by a SnailID which starts at 0 and goes to the snailAmount-1. This is the way how the user can access their snail. In this tutorial there will be two users 0x32, and 0x92 who both own the first snail at index 0.
3. First, we deploy the contract, and then verify it on Etherscan.
4. Then we will interact with the contract that is deployed using the Metamask wallets.
5. When the contract is deployed each snail is given a startingTime, and a starting position of 0.
6. The snail is moved between 0x32 who is the currentOwner of the snail to 0x92 which increments the position to 1.
7. The snail is then moved back to 0x32 from 0x92 which increments the position to 2.
8. This transaction is done a total of 5 times and once it reaches 5 transactions the snail gets to the 5th position meaning it has finished the race.
9. Once the snail has finished the race it cannot move anymore, and its final time is recorded to find its total time on the track.
<!-- Add in video into this section -->
[Demo Video](https://www.youtube.com/watch?v=MId7pAo-huc)

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


