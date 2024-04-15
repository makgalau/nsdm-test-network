const { Gateway, Wallets, TxEventHandler, GatewayOptions, DefaultEventHandlerStrategies, TxEventHandlerFactory } = require('fabric-network');
const fs = require('fs');
const path = require("path")
const log4js = require('log4js');
const logger = log4js.getLogger('BasicNetwork');
const util = require('util')

const helper = require('./helper')

// const invokeTransaction = async (channelName, chaincodeName, fcn, args, username, org_name, transientData) => {
const invokeTransaction = async (channelName, chaincodeName, fcn, args, username, org_name) => {
    try {
        logger.debug(util.format('\n============ invoke transaction on channel %s ============\n', channelName));

        // load the network configuration
        // const ccpPath =path.resolve(__dirname, '..', 'config', 'connection-org1.json');
        // const ccpJSON = fs.readFileSync(ccpPath, 'utf8')
        const ccp = await helper.getCCP(org_name) //JSON.parse(ccpJSON);

        // Create a new file system based wallet for managing identities.
        const walletPath = await helper.getWalletPath(org_name) //path.join(process.cwd(), 'wallet');
        const wallet = await Wallets.newFileSystemWallet(walletPath);
        console.log(`Wallet path: ${walletPath}`);

        // Check to see if we've already enrolled the user.
        let identity = await wallet.get(username);
        console.log(identity);
        if (!identity) {
            console.log(`An identity for the user ${username} does not exist in the wallet, so registering user`);
            await helper.getRegisteredUser(username, org_name, true)
            identity = await wallet.get(username);
            console.log('Run the registerUser.js application before retrying');
            return;
        }

        

        const connectOptions = {
            wallet, identity: username, discovery: { enabled: true, asLocalhost: true } //,  coba disable options dibawah
            // eventHandlerOptions: {
            //     commitTimeout: 100,
            //     strategy: DefaultEventHandlerStrategies.NETWORK_SCOPE_ALLFORTX
            // }
            // transaction: {
            //     strategy: createTransactionEventhandler()
            // }
        }

        console.log("tes connectionOptions");
        console.log(connectOptions);
        // Create a new gateway for connecting to our peer node.
        const gateway = new Gateway();
        console.log(gateway);
        await gateway.connect(ccp, connectOptions);         //error disini kyknya
        console.log("mencari error");
        // Get the network (channel) our contract is deployed to.
        const network = await gateway.getNetwork(channelName);
        console.log(network);
        const contract = network.getContract(chaincodeName);
        console.log(contract);
        let result
        let message;
        console.log("sampe sini")

        //=================diganti pke fungsi di nsdm_cc ==========================
        if (fcn === "CreateAsset" || fcn === "UpdateAsset"){
            result = await contract.submitTransaction(fcn, args[0], args[1], args[2], args[3], args[4],args[5],args[6],args[7],args[8],args[9],args[10],
                args[11],args[12],args[13],args[14],args[15],args[16],args[17],args[18],args[19],args[20],args[21],args[22],args[23],args[24],args[25],
                args[26],args[27],args[28],args[29],args[30]);    
            message = `Successfully added/updated asset with IDLogam ${args[0]}`
        } else if (fcn == "DeleteAsset"){
            result = await contract.submitTransaction(fcn, args[0])
            message = `Successfully deleted asset with IDLogam ${args[0]}`
        } else {
            message = "Error function is not recognized"
        }
        await gateway.disconnect();

        result = JSON.parse(result.toString());

        let response = {
            message: message,
            result
        }

        return response;


    } catch (error ) {
        
        let erMssg = "exceptional";
        if (error instanceof Error) {
            erMssg  = error.message;
          }
        console.log(`Getting error: ${error}`)
        return erMssg

    }
}

exports.invokeTransaction = invokeTransaction;