import { task, types } from 'hardhat/config';

task('deploy', 'Deploys provided contract to specified network')
  .addParam('contract', 'The name of contract', undefined, types.string)
  .addParam('snailcount', 'The number of snails', undefined)
  .addParam('addresses', 'An array of addresses', undefined)
  .setAction(async (taskArgs: { contract: string; snailcount; addresses}, hre) => {
    await hre.run('compile');
    const addresses = taskArgs.addresses.split(",");
    console.log("Deploying contract..." + taskArgs.contract + " " + taskArgs.snailcount + " " + taskArgs.addresses + " ");
    const CONTRACT = await hre.ethers.getContractFactory(taskArgs.contract);
    let contract;
    if(taskArgs.contract === "SnailContract"){
      contract = await CONTRACT.deploy(Number(taskArgs.snailcount), addresses);
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
