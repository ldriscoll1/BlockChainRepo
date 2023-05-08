require("dotenv").config();
require("@nomiclabs/hardhat-ethers");

module.exports = {
	solidity: "0.8.18",
	defaultNetwork: "sepolia",
	networks: {
		hardhat: {},
		sepolia: {
			url: process.env.ALCHEMY_URL,
			accounts: [`0x${process.env.METAMASK_PRIVATE_KEY}`],
		},
	},
};
