# Snail Game Frontend
## Getting Started
### Pre-requisites: 
- node.js

### Setting up the .env file
- Create a .env file in this directory of the project
- Add the following variables to the .env file:
```
NEXT_PUBLIC_METAMASK_PRIVATE_KEY=*MetaMask Private Key*
ETHERSCAN_API_KEY=*Etherscan API Key*
```

### Setting up the util/contract.js file
- If you deployed the exact contract from our repo without making modifications you do not need to change the contract ABI. Details to change the ABI can be found in the etherscan documentation.
- Change the contractaddress variable in util/contract.js to the address of your deployed contract.

### How to run the project locally
- Run the following commands in the terminal:
```
npm install
npm run dev
```

### Important Details
This is the snail game frontend folder. The current code is built to read a contract initialized with the following parameters:
3 Snails
10 Race Length
10 Leaderboard Length

To make the snail game visualization properly work with your custom contract then you will need to edit src/pages/index.js and follow the comments to set up the visualization of snail game.
