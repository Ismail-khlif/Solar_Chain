const Web3 = require('web3');
const HDWalletProvider = require('@truffle/hdwallet-provider');
const compiledCampaign = require('./build/Campaign.json');

const mnemonic = 'canoe sauce prosper dinosaur enforce stadium witness loyal bridge suggest confirm spy';
const infuraUrl = 'https://sepolia.infura.io/v3/4ab3beb30ddc4ed2b6cc9ee9280f30b6';

const provider = new HDWalletProvider(mnemonic, infuraUrl);
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
