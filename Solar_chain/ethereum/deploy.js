const HDWalletProvider = require('@truffle/hdwallet-provider');
const Web3 = require('web3');
//const { interface, bytecode } = require('./compile');
const compiledCampaign = require('./build/Campaign.json');

const provider = new HDWalletProvider(
  'crime cactus elbow orange quality timber label afford orange close morning pepper',
  'https://sepolia.infura.io/v3/60c503c2d6064f8aa36e43e9cf66592a'
);
const web3 = new Web3(provider);

const deploy = async () => {
  try {
      const accounts = await web3.eth.getAccounts();
      console.log('Attempting to deploy from account:', accounts[0]);

      const gasEstimate = await web3.eth.estimateGas({
          data: '0x' + compiledCampaign.evm.bytecode.object,
      });

      console.log('Estimated Gas:', gasEstimate);

      const campaign = await new web3.eth.Contract(
          compiledCampaign.abi
      )
          .deploy({
              data: '0x' + compiledCampaign.evm.bytecode.object,
          })
          .send({
              gas: gasEstimate,
              from: accounts[0],
          });

      console.log('Campaign Contract deployed to:', campaign.options.address);
  } catch (error) {
      console.error('Deployment error:', error);
  } finally {
      provider.engine.stop(); // Stop the provider to avoid hanging
  }
};

deploy();
