const path = require("path");
const fs = require("fs-extra");
const solc = require("solc");

const buildPath = path.resolve(__dirname, 'build');
fs.removeSync(buildPath);

const campaignPath = path.resolve(__dirname, 'contracts', 'Campaign.sol');
const source = fs.readFileSync(campaignPath, "utf8");

const input = {
    language: "Solidity",
    sources: {
        "Campaign.sol": {
            content: source
        }
    },
    settings: {
        outputSelection: {
            "*": {
                "*": ["*"]
            }
        }
    }
};

const output = JSON.parse(solc.compile(JSON.stringify(input)));

if (output.errors) {
    console.error("Compilation errors:", output.errors);
} else {
    fs.ensureDirSync(buildPath);
console.log(output);
    for (let contractFileName in output.contracts) {
        const contractName = contractFileName.replace(".sol", "");
        for (let contract in output.contracts[contractFileName]) {
            const contractData = output.contracts[contractFileName][contract];
            fs.outputJSONSync(
                path.resolve(buildPath, contractName + '.json'),
                contractData
            );
        }
    }
}