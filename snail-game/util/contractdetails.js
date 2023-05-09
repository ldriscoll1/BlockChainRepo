const { ethers } = require("ethers");

const contractAddress = "0x743364668529f67bCa0e2749f83B96b35f4fD3d3";
const contractABI = [
	{
	  inputs: [
		{ internalType: "uint256", name: "_snailCount", type: "uint256" },
		{ internalType: "uint256", name: "_leaderboardCount", type: "uint256" },
		{ internalType: "uint256", name: "_raceLength", type: "uint256" },
	  ],
	  stateMutability: "nonpayable",
	  type: "constructor",
	},
	{
	  inputs: [
		{ internalType: "address", name: "_playerOne", type: "address" },
		{ internalType: "address", name: "_playerTwo", type: "address" },
		{ internalType: "uint256", name: "_snailID", type: "uint256" },
	  ],
	  name: "assignPlayers",
	  outputs: [],
	  stateMutability: "nonpayable",
	  type: "function",
	},
	{
	  inputs: [{ internalType: "uint256", name: "_entryID", type: "uint256" }],
	  name: "getLeaderboardEntry",
	  outputs: [
		{
		  components: [
			{ internalType: "address", name: "ownerOne", type: "address" },
			{ internalType: "address", name: "ownerTwo", type: "address" },
			{ internalType: "uint256", name: "raceTime", type: "uint256" },
		  ],
		  internalType: "struct SnailRace.LeaderboardEntry",
		  name: "",
		  type: "tuple",
		},
	  ],
	  stateMutability: "view",
	  type: "function",
	},
	{
	  inputs: [{ internalType: "uint256", name: "_entryID", type: "uint256" }],
	  name: "getLeaderboardEntryRaceTime",
	  outputs: [{ internalType: "uint256", name: "", type: "uint256" }],
	  stateMutability: "view",
	  type: "function",
	},
	{
	  inputs: [],
	  name: "getLeaderboardLength",
	  outputs: [{ internalType: "uint256", name: "", type: "uint256" }],
	  stateMutability: "view",
	  type: "function",
	},
	{
	  inputs: [{ internalType: "uint256", name: "_snailID", type: "uint256" }],
	  name: "getSnail",
	  outputs: [
		{ internalType: "uint256", name: "", type: "uint256" },
		{ internalType: "address", name: "", type: "address" },
		{ internalType: "address", name: "", type: "address" },
		{ internalType: "address", name: "", type: "address" },
		{ internalType: "bool", name: "", type: "bool" },
		{ internalType: "uint256", name: "", type: "uint256" },
		{ internalType: "uint256", name: "", type: "uint256" },
		{ internalType: "uint256", name: "", type: "uint256" },
	  ],
	  stateMutability: "view",
	  type: "function",
	},
	{
	  inputs: [
		{ internalType: "address", name: "_userAddress", type: "address" },
	  ],
	  name: "getSnailFromAddress",
	  outputs: [{ internalType: "uint256", name: "", type: "uint256" }],
	  stateMutability: "view",
	  type: "function",
	},
	{
	  inputs: [
		{ internalType: "address", name: "_userAddress", type: "address" },
	  ],
	  name: "runTransaction",
	  outputs: [],
	  stateMutability: "nonpayable",
	  type: "function",
	},
	{
	  inputs: [],
	  name: "runTransaction",
	  outputs: [],
	  stateMutability: "nonpayable",
	  type: "function",
	},
];
  
const node = "https://rpc.sepolia.org";
const provider = new ethers.providers.JsonRpcProvider(node);

let wallet = new ethers.Wallet(process.env.NEXT_PUBLIC_METAMASK_PRIVATE_KEY, provider);

export const snail_game_contract = new ethers.Contract(
	contractAddress,
	contractABI,
	wallet
);
