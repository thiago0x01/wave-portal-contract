const main = async () => {
  const Token = await ethers.getContractFactory('WavePortal');
  const portal = await Token.deploy();

  console.log('WavePortal address:', portal.address);
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
