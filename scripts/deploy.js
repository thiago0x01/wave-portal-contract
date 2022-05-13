const main = async () => {
  const contract = await ethers.getContractFactory('WavePortal');
  const contractDeployed = await contract.deploy({
    value: hre.ethers.utils.parseEther('0.001'),
  });

  console.log('WavePortal address:', contractDeployed.address);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
};

runMain();
