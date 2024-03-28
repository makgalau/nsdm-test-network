/*
  SPDX-License-Identifier: Apache-2.0
*/

import {Object, Property} from 'fabric-contract-api';

@Object()
export class AssetKomoditi {

    @Property()
    public IdLogam: string;

    @Property()
    public NamaObject: string;

    @Property()
    public JenisKomoditi: string;

    @Property()
    public LambangUnsur: string;

    @Property()
    public KelompokLogam: string;

    @Property()
    public LokasiLogam: string;

    @Property()
    public Kecamatan: string;

    @Property()
    public Kabupaten: string;

    @Property()
    public Provinsi: string;

    @Property()
    public StatusPenyelidikan:string;

    @Property()
    public JenisIjin: string;

    @Property()
    public BijihHipotetik: number;

    @Property()
    public LogamHipotetik: number;

    @Property()
    public BijihTereka: number;

    @Property()
    public LogamTereka: number;

    @Property()
    public BijihTertunjuk: number;

    @Property()
    public LogamTertunjuk: number;

    @Property()
    public BijihTerukur: number;

    @Property()
    public LogamTerukur: number;

    @Property()
    public BijihTerkira: number;

    @Property()
    public LogamTerkira: number;

    @Property()
    public BijihTerbukti: number;

    @Property()
    public LogamTerbukti: number;

    @Property()
    public Keterangan: string;

    @Property()
    public Latitude: number;
    
    @Property()
    public Longitude: number;

    @Property()
    public DataAcuan: string;

    @Property()
    public InstansiSumber: string;

    @Property()
    public CompetentPerson: string;

    @Property()
    public TahunUpdate: number;

    @Property()
    public cid_rkab: string;
}
