var { Gateway, Wallets } = require('fabric-network');
const path = require('path');
const FabricCAServices = require('fabric-ca-client');
const fs = require('fs');

const util = require('util');

// const getCCP = async (org) => {
//     let ccpPath;
//     if (org == "Org1") {
//         ccpPath = path.resolve(__dirname, '../..', 'config', 'connection-org1.json');

//     } else if (org == "Org2") {
//         ccpPath = path.resolve(__dirname, '../..', 'config', 'connection-org2.json');
//     } else
//         return null
//     const ccpJSON = fs.readFileSync(ccpPath, 'utf8')
//     const ccp = JSON.parse(ccpJSON);
//     return ccp
// }

// const getCaUrl = async (org, ccp) => {
//     let caURL;
//     if (org == "Org1") {
//         caURL = ccp.certificateAuthorities['ca.org1.example.com'].url;

//     } else if (org == "Org2") {
//         caURL = ccp.certificateAuthorities['ca.org2.example.com'].url;
//     } else
//         return null
//     return caURL

// }

// const getWalletPath = async (org) => {
//     let walletPath;
//     if (org == "Org1") {
//         walletPath = path.join(process.cwd(), 'org1-wallet');

//     } else if (org == "Org2") {
//         walletPath = path.join(process.cwd(), 'org2-wallet');
//     } else
//         return null
//     return walletPath

// }


// const getAffiliation = async (org) => {
//     return org == "Org1" ? 'org1.department1' : 'org2.department1'
// }


const getCCP = async (org) => {         //CCP Command Connection Profile
    let ccpPath;
    if (org == "Geologi") {
        ccpPath = path.resolve(__dirname, '../..', 'config', 'connection-geologi.json');

    } else if (org == "Minerba") {
        ccpPath = path.resolve(__dirname, '../..', 'config', 'connection-minerba.json');
    
    } else if (org == "BadanUsaha1") {
        ccpPath = path.resolve(__dirname, '../..', 'config', 'connection-bu1.json');
    
    } else if (org == "BadanUsaha2") {
        ccpPath = path.resolve(__dirname, '../..', 'config', 'connection-bu2.json');
    
    } else if (org == "ThirdParty") {
        ccpPath = path.resolve(__dirname, '../..', 'config', 'connection-thirdparty.json');
    
    } else
        return null
    const ccpJSON = fs.readFileSync(ccpPath, 'utf8')
    const ccp = JSON.parse(ccpJSON);
    console.log('======================getCCP==================');
    console.log(ccp)
    return ccp
}



const getCaUrl = async (org, ccp) => {
    let caURL;
    if (org == "Geologi") {
        caURL = ccp.certificateAuthorities['ca.geologi.esdm.go.id'].url;

    } else if (org == "Minerba") {
        caURL = ccp.certificateAuthorities['ca.minerba.esdm.go.id'].url;

    } else if (org == "BadanUsaha1") {
        caURL = ccp.certificateAuthorities['ca.bu1.example.com'].url;
        
    } else if (org == "BadanUsaha2") {
        caURL = ccp.certificateAuthorities['ca.bu2.example.com'].url;

    } else if (org == "ThirdParty") {
        caURL = ccp.certificateAuthorities['ca.thirdparty.example.com'].url;

    } else
        return null

    console.log('===========getCaUrl===============');
    console.log(caURL);
    return caURL

}

const getWalletPath = async (org) => {
    let walletPath;
    if (org == "Geologi") {
        walletPath = path.join(process.cwd(), 'geologi-wallet');

    } else if (org == "Minerba") {
        walletPath = path.join(process.cwd(), 'minerba-wallet');
    
    } else if (org == "BadanUsaha1") {
        walletPath = path.join(process.cwd(), 'bu1-wallet');
    
    } else if (org == "BadanUsaha2") {
        walletPath = path.join(process.cwd(), 'bu2-wallet');
    
    } else if (org == "ThirdParty") {
        walletPath = path.join(process.cwd(), 'thirdparty-wallet');
    
    } else
        return null

    console.log('========================get Wallet======================')
    console.log(walletPath);
    return walletPath

}

const getAffiliation = async (org: string) => {
    if (org === "Geologi") {
        return 'geologi.department1';
    } else if (org == "Minerba") {
        return 'minerba.department1';
    } else if (org == "BadanUsaha1") {
        return 'bu1.department1';
    } else if (org == "BadanUsaha2") {
        return 'bu2.department1';
    } else {
        return 'thirdparty.department1';
    }

}

const getRegisteredUser = async (username, userOrg, isJson) => {
    console.log(userOrg);
    console.log(username);
    let ccp = await getCCP(userOrg)

    const caURL = await getCaUrl(userOrg, ccp)
    const ca = new FabricCAServices(caURL);

    const walletPath = await getWalletPath(userOrg)
    const wallet = await Wallets.newFileSystemWallet(walletPath);
    console.log(`Wallet path: ${walletPath}`);

    const userIdentity = await wallet.get(username);
    if (userIdentity) {
        console.log(`An identity for the user ${username} already exists in the wallet`);
        var response = {
            success: true,
            message: username + ' enrolled Successfully',
        };
        return response
    }

    // Check to see if we've already enrolled the admin user.
    let adminIdentity = await wallet.get('admin');
    if (!adminIdentity) {
        console.log('An identity for the admin user "admin" does not exist in the wallet');
        await enrollAdmin(userOrg, ccp);
        adminIdentity = await wallet.get('admin');
        console.log("Admin Enrolled Successfully")
    }

    console.log(adminIdentity);
    // build a user object for authenticating with the CA
    const provider = wallet.getProviderRegistry().getProvider(adminIdentity.type);
    const adminUser = await provider.getUserContext(adminIdentity, 'admin');
    let secret;

    console.log(provider, adminUser);
    try {
        // Register the user, enroll the user, and import the new identity into the wallet.
        secret = await ca.register({ enrollmentID: username,  role: 'client', enrollmentSecret:'',  affiliation: await getAffiliation(userOrg) }, adminUser);
        // const secret = await ca.register({ affiliation: 'org1.department1', enrollmentID: username, role: 'client', attrs: [{ name: 'role', value: 'approver', ecert: true }] }, adminUser);

    } catch (error : any) {
        return error.message
    }

    const enrollment = await ca.enroll({ enrollmentID: username, enrollmentSecret: secret });
    // const enrollment = await ca.enroll({ enrollmentID: username, enrollmentSecret: secret, attr_reqs: [{ name: 'role', optional: false }] });

    let x509Identity;
    if (userOrg == "Geologi") {
        x509Identity = {
            credentials: {
                certificate: enrollment.certificate,
                privateKey: enrollment.key.toBytes(),
            },
            mspId: 'GeologiMSP',
            type: 'X.509',
        };
    } else if (userOrg == "Minerba") {
        x509Identity = {
            credentials: {
                certificate: enrollment.certificate,
                privateKey: enrollment.key.toBytes(),
            },
            mspId: 'MinerbaMSP',
            type: 'X.509',
        };
    } else if (userOrg == "BadanUsaha1") {
        x509Identity = {
            credentials: {
                certificate: enrollment.certificate,
                privateKey: enrollment.key.toBytes(),
            },
            mspId: 'BadanUsaha1MSP',
            type: 'X.509',
        };
    } else if (userOrg == "BadanUsaha2") {
        x509Identity = {
            credentials: {
                certificate: enrollment.certificate,
                privateKey: enrollment.key.toBytes(),
            },
            mspId: 'BadanUsaha2MSP',
            type: 'X.509',
        };
    } else if (userOrg == "ThirdParty") {
        x509Identity = {
            credentials: {
                certificate: enrollment.certificate,
                privateKey: enrollment.key.toBytes(),
            },
            mspId: 'ThirdPartyMSP',
            type: 'X.509',
        };
    }

    // let x509Identity;
    // if (userOrg == "Org1") {
    //     x509Identity = {
    //         credentials: {
    //             certificate: enrollment.certificate,
    //             privateKey: enrollment.key.toBytes(),
    //         },
    //         mspId: 'Org1MSP',
    //         type: 'X.509',
    //     };
    // } else if (userOrg == "Org2") {
    //     x509Identity = {
    //         credentials: {
    //             certificate: enrollment.certificate,
    //             privateKey: enrollment.key.toBytes(),
    //         },
    //         mspId: 'Org2MSP',
    //         type: 'X.509',
    //     };
    // }


    await wallet.put(username, x509Identity);
    console.log(`Successfully registered and enrolled admin user ${username} and imported it into the wallet`);

    var response = {
        success: true,
        message: username + ' enrolled Successfully',
    };
    return response
}

const isUserRegistered = async (username, userOrg) => {
    const walletPath = await getWalletPath(userOrg)
    const wallet = await Wallets.newFileSystemWallet(walletPath);
    console.log(`Wallet path: ${walletPath}`);

    const userIdentity = await wallet.get(username);
    if (userIdentity) {
        console.log(`An identity for the user ${username} exists in the wallet`);
        return true
    }
    return false
}

const getCaInfo = async (org, ccp) => {
    let caInfo
    if (org == "Geologi") {
        caInfo = ccp.certificateAuthorities['ca.geologi.esdm.go.id'];

    } else if (org == "Minerba") {
        caInfo = ccp.certificateAuthorities['ca.minerba.esdm.go.id'];
    } else if (org == "BadanUsaha1") {
        caInfo = ccp.certificateAuthorities['ca.bu1.example.com'];
    } else if (org == "BadanUsaha2") {
        caInfo = ccp.certificateAuthorities['ca.bu2.example.com'];
    } else if (org == "ThirdParty") {
        caInfo = ccp.certificateAuthorities['ca.thirdparty.example.com'];
    } else
        return null
    return caInfo

}

// const getCaInfo = async (org, ccp) => {
//     let caInfo
//     if (org == "Org1") {
//         caInfo = ccp.certificateAuthorities['ca.org1.example.com'];

//     } else if (org == "Org2") {
//         caInfo = ccp.certificateAuthorities['ca.org2.example.com'];
//     } else
//         return null
//     return caInfo

// }


const enrollAdmin = async (org, ccp) => {

    console.log('calling enroll Admin method')

    try {

        const caInfo = await getCaInfo(org, ccp) //ccp.certificateAuthorities['ca.org'];
        const caTLSCACerts = caInfo.tlsCACerts.pem;
        const ca = new FabricCAServices(caInfo.url, { trustedRoots: caTLSCACerts, verify: false }, caInfo.caName);

        // Create a new file system based wallet for managing identities.
        const walletPath = await getWalletPath(org) //path.join(process.cwd(), 'wallet');
        const wallet = await Wallets.newFileSystemWallet(walletPath);
        console.log(`Wallet path (enroll admin): ${walletPath}`);

        // Check to see if we've already enrolled the admin user.
        const identity = await wallet.get('admin');
        if (identity) {
            console.log('An identity for the admin user "admin" already exists in the wallet');
            return;
        }

        // Enroll the admin user, and import the new identity into the wallet.
        const enrollment = await ca.enroll({ enrollmentID: 'admin', enrollmentSecret: 'adminpw' });
        let x509Identity;
        if (org == "Geologi") {
            x509Identity = {
                credentials: {
                    certificate: enrollment.certificate,
                    privateKey: enrollment.key.toBytes(),
                },
                mspId: 'GeologiMSP',
                type: 'X.509',
            };
        } else if (org == "Minerba") {
            x509Identity = {
                credentials: {
                    certificate: enrollment.certificate,
                    privateKey: enrollment.key.toBytes(),
                },
                mspId: 'MinerbaMSP',
                type: 'X.509',
            };
        } else if (org == "BadanUsaha1") {
            x509Identity = {
                credentials: {
                    certificate: enrollment.certificate,
                    privateKey: enrollment.key.toBytes(),
                },
                mspId: 'BadanUsaha1MSP',
                type: 'X.509',
            };
        } else if (org == "BadanUsaha2") {
            x509Identity = {
                credentials: {
                    certificate: enrollment.certificate,
                    privateKey: enrollment.key.toBytes(),
                },
                mspId: 'BadanUsaha2MSP',
                type: 'X.509',
            };
        } else if (org == "ThirdParty") {
            x509Identity = {
                credentials: {
                    certificate: enrollment.certificate,
                    privateKey: enrollment.key.toBytes(),
                },
                mspId: 'ThirdPartyMSP',
                type: 'X.509',
            };
        }

        // let x509Identity;
        // if (org == "Org1") {
        //     x509Identity = {
        //         credentials: {
        //             certificate: enrollment.certificate,
        //             privateKey: enrollment.key.toBytes(),
        //         },
        //         mspId: 'Org1MSP',
        //         type: 'X.509',
        //     };
        // } else if (org == "Org2") {
        //     x509Identity = {
        //         credentials: {
        //             certificate: enrollment.certificate,
        //             privateKey: enrollment.key.toBytes(),
        //         },
        //         mspId: 'Org2MSP',
        //         type: 'X.509',
        //     };
        // }

        await wallet.put('admin', x509Identity);
        console.log('Successfully enrolled admin user "admin" and imported it into the wallet');
        return
    } catch (error) {
        console.error(`Failed to enroll admin user "admin": ${error}`);
    }
}

const registerAndGetSecret = async (username, userOrg) => {
    let ccp = await getCCP(userOrg)

    const caURL = await getCaUrl(userOrg, ccp)
    const ca = new FabricCAServices(caURL);

    const walletPath = await getWalletPath(userOrg)
    const wallet = await Wallets.newFileSystemWallet(walletPath);
    console.log(`Wallet path: ${walletPath}`);

    const userIdentity = await wallet.get(username);
    if (userIdentity) {
        console.log(`An identity for the user ${username} already exists in the wallet`);
        var response = {
            success: true,
            message: username + ' enrolled Successfully',
        };
        return response
    }

    // Check to see if we've already enrolled the admin user.
    let adminIdentity = await wallet.get('admin');
    if (!adminIdentity) {
        console.log('An identity for the admin user "admin" does not exist in the wallet');
        await enrollAdmin(userOrg, ccp);
        adminIdentity = await wallet.get('admin');
        console.log("Admin Enrolled Successfully")
    }

    // build a user object for authenticating with the CA
    const provider = wallet.getProviderRegistry().getProvider(adminIdentity.type);
    const adminUser = await provider.getUserContext(adminIdentity, 'admin');
    let secret;
    try {
        // Register the user, enroll the user, and import the new identity into the wallet.
        secret = await ca.register({ affiliation: await getAffiliation(userOrg), enrollmentID: username, role: 'client' }, adminUser);
        // const secret = await ca.register({ affiliation: 'org1.department1', enrollmentID: username, role: 'client', attrs: [{ name: 'role', value: 'approver', ecert: true }] }, adminUser);

    } catch (error :any) {
        return error.message
    }

    var responseSec = {
        success: true,
        message: username + ' enrolled Successfully',
        secret: secret
    };
    return responseSec

}

exports.getRegisteredUser = getRegisteredUser

module.exports = {
    getCCP: getCCP,
    getWalletPath: getWalletPath,
    getRegisteredUser: getRegisteredUser,
    isUserRegistered: isUserRegistered,
    registerAndGerSecret: registerAndGetSecret

}