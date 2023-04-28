import { task, types } from 'hardhat/config';

task('deploy', 'Deploys provided contract to specified network')
  .addParam('contract', 'The name of contract', undefined, types.string)
  .addParam('snailcount', 'The number of snails', undefined, types.int)
  .addParam('racelength', 'The length of the race in terms of transactions', undefined, types.int)
  .addParam('leaderboardlength', 'The length of the number of entries inside of the leaderboard', undefined, types.int)
  .setAction(async (taskArgs: { contract: string; snailcount; racelength; leaderboardlength;}, hre) => {
    await hre.run('compile');
    console.log("Deploying contract..." + taskArgs.contract + " with " + taskArgs.snailcount + " snails and a length of " + taskArgs.racelength + " transactions with " + taskArgs.leaderboardlength + " total entries on the leaderboard");
    const CONTRACT = await hre.ethers.getContractFactory(taskArgs.contract);
    let contract;
    if(taskArgs.contract === "SnailRace"){
      contract = await CONTRACT.deploy(Number(taskArgs.snailcount), Number(taskArgs.racelength), Number(taskArgs.leaderboardlength));
    }
    else if(taskArgs.contract === "Treasury"){
      contract = await CONTRACT.deploy();
    }
    await contract.deployed();
    console.log('\nContract deployed to:', contract.address);
    // await hre.run("verify:verify", {
    //   address: contract.address,
    //   constructorArguments: [
    //     1,
    //     [
    //       "0x32fb216dED836aBAa8af2F6Dda2629b30b768aF3",
    //       "0x9298f815C95DDf79c9724B5e30d52DB292c96086"
    //     ],
    //   ],
    // });
  });
