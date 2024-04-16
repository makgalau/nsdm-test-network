import { connect, Contract, Identity, Signer, signers } from '@hyperledger/fabric-gateway';
import * as grpc from '@grpc/grpc-js';
const { Gateway, Wallets, TxEventHandler, GatewayOptions, DefaultEventHandlerStrategies, TxEventHandlerFactory } = require('fabric-network');
const fs = require('fs');
const path = require("path");
const log4js = require('log4js');
const logger = log4js.getLogger('BasicNetwork');
const util = require('util');

const helper = require('./helper');



const invokeTransaction = async (channelName, chaincodeName, fcn, args, username, org_name) => {
    try {
        logger.debug(util.format('\n============ invoke transaction on channel %s ============\n', channelName));
        const peerEndpoint = await helper.getCCP(org_name) //JSON.parse(ccpJSON);

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
            console.log('Run the register User application before retrying');
            return;
        }

        // const client = await newGrpcConnection();
        // const gateway = connect({
        //     client,
        //     identity,
        //     signer: await newSigner(),
        //     // Default timeouts for different gRPC calls
        //     evaluateOptions: () => {
        //         return { deadline: Date.now() + 5000 }; // 5 seconds
        //     },
        //     endorseOptions: () => {
        //         return { deadline: Date.now() + 15000 }; // 15 seconds
        //     },
        //     submitOptions: () => {
        //         return { deadline: Date.now() + 5000 }; // 5 seconds
        //     },
        //     commitStatusOptions: () => {
        //         return { deadline: Date.now() + 60000 }; // 1 minute
        //     },
        // });


    } catch (error ) {
        
        let erMssg = "exceptional";
        if (error instanceof Error) {
            erMssg  = error.message;
          }
        console.log(`Getting error: ${error}`)
        return erMssg

    }
}

// async function newGrpcConnection(): Promise<grpc.Client> {
//     const tlsRootCert = await fs.readFile(tlsCertPath);
//     const tlsCredentials = grpc.credentials.createSsl(tlsRootCert);
//     return new grpc.Client(peerEndpoint, tlsCredentials, {
//         'grpc.ssl_target_name_override': peerHostAlias,
//     });
// }