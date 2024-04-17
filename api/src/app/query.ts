const { Gateway, Wallets, } = require('fabric-network');
const fs = require('fs');
const path = require("path")
const log4js = require('log4js');
const logger = log4js.getLogger('BasicNetwork');
const util = require('util')


const helper = require('./helper')
const query = async (channelName, chaincodeName, args, fcn, username, org_name) => {

    try {

        // load the network configuration
        const ccp = await helper.getCCP(org_name) //JSON.parse(ccpJSON);

        // Create a new file system based wallet for managing identities.
        const walletPath = await helper.getWalletPath(org_name) //path.join(process.cwd(), 'wallet');
        const wallet = await Wallets.newFileSystemWallet(walletPath);
        console.log(`Wallet path: ${walletPath}`);

        // Check to see if we've already enrolled the user.
        let identity = await wallet.get(username);
        if (!identity) {
            console.log(`An identity for the user ${username} does not exist in the wallet, so registering user`);
            await helper.getRegisteredUser(username, org_name, true)
            identity = await wallet.get(username);
            console.log('Run the registerUser.js application before retrying');
            return;
        }

        const connectOptions = {
            identity: username,
            wallet: wallet,  
            discovery: { enabled: true, asLocalhost: true } 
        }

        // Create a new gateway for connecting to our peer node.
        const gateway = new Gateway();
        await gateway.connect(ccp, connectOptions);

        // Get the network (channel) our contract is deployed to.
        const network = await gateway.getNetwork(channelName);

        console.log("tes");
        console.log(network);
        // Get the contract from the network.
        const contract = network.getContract(chaincodeName);
        let result;

        //=================pke fungsi di nsdm_cc ==========================
        if (fcn == "ReadAsset" || fcn =="GetAssetHistory" || fcn =="getAssetTimestamp") {
            result = await contract.evaluateTransaction(fcn, args[0]);

        } else if (fcn == "GetAllAssets" || fcn == "GetNumOfAssets"){
            result = await contract.evaluateTransaction(fcn);
            // return result

        }
        console.log(result)
        console.log(`Transaction has been evaluated, result is: ${result.toString()}`);

        // result = JSON.parse(result.toString());
        return result
    } catch (error) {
        let erMssg = "exceptional";
        if (error instanceof Error) {
            erMssg  = error.message;
          }
        console.error(`Failed to evaluate transaction: ${error}`);
        return erMssg;

    }
}

exports.query = query