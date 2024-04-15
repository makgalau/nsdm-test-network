import {forge} from 'node-forge';

export class IbeService {
    private readonly id: string;
    private readonly issuerPrivateKey: forge.pki.PrivateKey;
    private readonly issuerPublicKey: forge.pki.PublicKey;

    constructor(id: string, issuerPrivateKey: forge.pki.PrivateKey, issuerPublicKey: forge.pki.PublicKey){
        this.id = id;
        this.issuerPrivateKey = issuerPrivateKey;
        this.issuerPublicKey = issuerPublicKey;
    }
}