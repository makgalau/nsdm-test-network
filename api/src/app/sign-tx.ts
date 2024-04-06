//    =============How to sign a transaction by an identity's private key============

// Step : 1 generate an unsigned transaction proposal with the identity's certificate

const certPem = '<PEM encoded certificate content>';
const mspId = 'GeologiMSP'; // the msp Id for this org

const transactionProposal = {
    fcn: 'move',
    args: ['a', 'b', '100'],
    chaincodeId: 'nsdm_cc',
    channelId: 'nsdm',
};


