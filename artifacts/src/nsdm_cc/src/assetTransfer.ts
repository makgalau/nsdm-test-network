/*
 * SPDX-License-Identifier: Apache-2.0
 */
// Deterministic JSON.stringify()
import {Context, Contract, Info, Returns, Transaction} from 'fabric-contract-api';
import stringify from 'json-stringify-deterministic';
import sortKeysRecursive from 'sort-keys-recursive';
import { AssetKomoditi } from './asset';

@Info({title: 'AssetTransfer', description: 'Smart contract for mineral resources assets'})
export class AssetTransferContract extends Contract {

    // CreateAsset issues a new asset to the world state with given details.
    @Transaction()
    public async CreateAsset(ctx: Context, idLogam:string, namaobj:string, jnskom:string, 
        lambang:string, kelLogam:string, lokasi:string, kec:string, kab:string, prov:string,
        tahap:string,jnsIjin:string, bjhHip:number,logHip:number, bjhTereka:number,logTereka:number,
        bjhTertunjuk:number,logTertunjuk:number,bjhTerukur:number,logTerukur:number,bjhTerkira:number,logTerkira:number,
        bjhTerbukti:number, logTerbukti:number, ket:string, lat:number,long:number,acuan:string, instansi:string,
        cpi:string,thn_update:number,cid_rkab:string): Promise<void> {
                                    
        console.log('create asset on chaincode has been invoked');
        const exists = await this.AssetExists(ctx, idLogam);
        if (exists) {
            throw new Error(`The asset ${idLogam} already exists`);
        }

        const asset: AssetKomoditi = 
            {
                IdLogam: idLogam,
                NamaObject: namaobj,
                JenisKomoditi: jnskom,
                LambangUnsur: lambang,
                KelompokLogam: kelLogam,
                LokasiLogam: lokasi,
                Kecamatan: kec,
                Kabupaten: kab,
                Provinsi: prov,
                StatusPenyelidikan: tahap,
                JenisIjin: jnsIjin,
                BijihHipotetik: bjhHip,
                LogamHipotetik: logHip,
                BijihTereka: bjhTereka,
                LogamTereka: logTereka,
                BijihTertunjuk:bjhTertunjuk,
                LogamTertunjuk:logTertunjuk,
                BijihTerukur: bjhTerukur,
                LogamTerukur:logTerukur,
                BijihTerkira:bjhTerkira,
                LogamTerkira:logTerkira,
                BijihTerbukti:bjhTerbukti,
                LogamTerbukti:logTerbukti,
                Keterangan: ket,
                Latitude: lat,
                Longitude: long,
                DataAcuan: acuan,
                InstansiSumber: instansi,
                CompetentPerson: cpi,
                TahunUpdate: thn_update,
                cid_rkab: cid_rkab
            };
            await ctx.stub.putState(idLogam, Buffer.from(stringify(sortKeysRecursive(asset))));
        }

    // ReadAsset returns the asset stored in the world state with given id.
    @Transaction(false)
    public async ReadAsset(ctx: Context, id: string): Promise<string> {
        const assetJSON = await ctx.stub.getState(id); // get the asset from chaincode state

        if (!assetJSON || assetJSON.length === 0) {
            throw new Error(`The asset ${id} does not exist`);
        }
        return assetJSON.toString();
    }

    // UpdateAsset updates an existing asset in the world state with provided parameters.
    @Transaction()
    public async UpdateAsset(ctx: Context, idLogam:string, namaobj:string, jnskom:string, 
        lambang:string, kelLogam:string, lokasi:string, kec:string, kab:string, prov:string,
        tahap:string,jnsIjin:string, bjhHip:number,logHip:number, bjhTereka:number,logTereka:number,
        bjhTertunjuk:number,logTertunjuk:number,bjhTerukur:number,logTerukur:number,bjhTerkira:number,logTerkira:number,
        bjhTerbukti:number, logTerbukti:number, ket:string, lat:number,long:number,acuan:string, instansi:string,
        cpi:string, thn_update: number, cid_rkab:string): Promise<void> {
        const exists = await this.AssetExists(ctx, idLogam);
            if (!exists) {
                throw new Error(`The asset ${idLogam} does not exist`);
            }

        // overwriting original asset with new asset
        const updatedAsset = {
            IdLogam: idLogam,
                NamaObject: namaobj,
                JenisKomoditi: jnskom,
                LambangUnsur: lambang,
                KelompokLogam: kelLogam,
                LokasiLogam: lokasi,
                Kecamatan: kec,
                Kabupaten: kab,
                Provinsi: prov,
                StatusPenyelidikan: tahap,
                JenisIjin: jnsIjin,
                BijihHipotetik: bjhHip,
                LogamHipotetik: logHip,
                BijihTereka: bjhTereka,
                LogamTereka: logTereka,
                BijihTertunjuk:bjhTertunjuk,
                LogamTertunjuk:logTertunjuk,
                BijihTerukur: bjhTerukur,
                LogamTerukur:logTerukur,
                BijihTerkira:bjhTerkira,
                LogamTerkira:logTerkira,
                BijihTerbukti:bjhTerbukti,
                LogamTerbukti:logTerbukti,
                Keterangan: ket,
                Latitude: lat,
                Longitude: long,
                DataAcuan: acuan,
                InstansiSumber: instansi,
                CompetentPerson: cpi,
                TahunUpdate: thn_update,
                cid_rkab: cid_rkab
        };

        //insert data in alphabetic order using 'json-stringify-deterministic' and 'sort-keys-recursive'
        return ctx.stub.putState(idLogam, Buffer.from(stringify(sortKeysRecursive(updatedAsset))));
    }

    // DeleteAsset deletes an given asset from the world state.
    @Transaction()
    public async DeleteAsset(ctx: Context, idLogam: string): Promise<void> {
        const exists = await this.AssetExists(ctx, idLogam);
        if (!exists) {
            throw new Error(`The asset ${idLogam} does not exist`);
        }
        return ctx.stub.deleteState(idLogam);
    }

    // AssetExists returns true when asset with given ID exists in world state.
    @Transaction(false)
    @Returns('boolean')
    public async AssetExists(ctx: Context, idLogam: string): Promise<boolean> {
        const assetJSON = await ctx.stub.getState(idLogam);
        return assetJSON && assetJSON.length > 0;
    }

    // GetAllAssets returns all assets found in the world state.
    @Transaction(false)
    @Returns('string')
    public async GetAllAssets(ctx: Context): Promise<string> {
        const allResults = [];
        //range query with empty string for startKey and endKey does an open-ended query of all assets in the chaincode namespace.
        const iterator = await ctx.stub.getStateByRange('', '');
        let result = await iterator.next();
        while (!result.done) {
            const strValue = Buffer.from(result.value.value.toString()).toString('utf8');
            let record;
            try {
                record = JSON.parse(strValue);
            } catch (err) {
                console.log(err);
                record = strValue;
            }
            allResults.push(record);
            result = await iterator.next();
        }
        return JSON.stringify(allResults);
    }

    // GetAllAssets returns all assets found in the world state.
    @Transaction(false)
    @Returns('number')
    public async GetNumOfAssets(ctx: Context): Promise<number> {
        let num =0;
        const allResults = [];
        // range query with empty string for startKey and endKey does an open-ended query of all assets in the chaincode namespace.
        const iterator = await ctx.stub.getStateByRange('', '');
        let result = await iterator.next();
        while (!result.done) {
            num++;
            result = await iterator.next();
        }
        return num;
    }

    // GetAssetHistory returns history of one asset found in the world state.
    @Transaction()
    @Returns('string')
    public async GetAssetHistory(ctx: Context, idLogam: string): Promise<string> {
        const exists = await this.AssetExists(ctx, idLogam);
        if (!exists) {
            throw new Error(`The asset ${idLogam} does not exist`);
        }
        
        const iterator = await ctx.stub.getHistoryForKey(idLogam);
        
        const history: string[] = [];
        let result = await iterator.next();
        let timestampSeconds: number;
        let temp : Date;

        while (!result.done) {
            const txInfo = result.value;
            timestampSeconds = (txInfo.timestamp.seconds as unknown as number)*1000;
            temp = new Date(timestampSeconds);
 
            const txRecord = `Transaction ID: ${txInfo.txId}; Timestamp: ${temp.toLocaleString()} ; Value: ${txInfo.value.toString()}, `;
            history.push(txRecord);

            result = await iterator.next();
        }

        return JSON.stringify(history);
    }

     // GetTimeStamps.
     @Transaction(false)
     public async getAssetTimestamp(ctx: Context, idLogam: string): Promise<string> {
        const txTimestamp = await ctx.stub.getTxTimestamp();
        return txTimestamp.seconds.low.toString();
    }


}

