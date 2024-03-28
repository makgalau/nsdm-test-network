export CORE_PEER_TLS_ENABLED=true
export ORDERERGEO_CA=${PWD}/artifacts/channel/crypto-config/ordererOrganizations/geologi.esdm.go.id/orderers/orderer1.geologi.esdm.go.id/msp/tlscacerts/tlsca.geologi.esdm.go.id-cert.pem
export ORDERERMIN_CA=${PWD}/artifacts/channel/crypto-config/ordererOrganizations/minerba.esdm.go.id/orderers/orderer2.minerba.esdm.go.id/msp/tlscacerts/tlsca.minerba.esdm.go.id-cert.pem
export PEER0_GEOLOGI_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/geologi.esdm.go.id/peers/peer0.geologi.esdm.go.id/tls/ca.crt
export PEER1_GEOLOGI_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/geologi.esdm.go.id/peers/peer1.geologi.esdm.go.id/tls/ca.crt
export PEER0_MINERBA_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/minerba.esdm.go.id/peers/peer0.minerba.esdm.go.id/tls/ca.crt
export PEER1_MINERBA_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/minerba.esdm.go.id/peers/peer1.minerba.esdm.go.id/tls/ca.crt
export PEER0_BADANUSAHA1_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/bu1.example.com/peers/peer0.bu1.example.com/tls/ca.crt
export PEER0_BADANUSAHA2_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/bu2.example.com/peers/peer0.bu2.example.com/tls/ca.crt
export PEER0_THIRDPARTY_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/thirdparty.example.com/peers/peer0.thirdparty.example.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/artifacts/channel/config/

# export PATH=${PWD}/bin:$PATH
export CHANNEL_NAME=nsdm

setGlobalsForOrdererGeo(){
    export CORE_PEER_LOCALMSPID="OrdererGeoMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/artifacts/channel/crypto-config/ordererOrganizations/geologi.esdm.go.id/orderers/orderer1.geologi.esdm.go.id/msp/tlscacerts/tlsca.geologi.esdm.go.id-cert.pem
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/ordererOrganizations/geologi.esdm.go.id/users/Admin@geologi.esdm.go.id/msp    
}

setGlobalsForOrdererMin(){
    export CORE_PEER_LOCALMSPID="OrdererMinMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/artifacts/channel/crypto-config/ordererOrganizations/minerba.esdm.go.id/orderers/orderer2.minerba.esdm.go.id/msp/tlscacerts/tlsca.minerba.esdm.go.id-cert.pem
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/ordererOrganizations/minerba.esdm.go.id/users/Admin@minerba.esdm.go.id/msp    
}

setGlobalsForPeer0Geologi(){
    export CORE_PEER_LOCALMSPID="GeologiMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_GEOLOGI_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/geologi.esdm.go.id/users/Admin@geologi.esdm.go.id/msp
    export CORE_PEER_ADDRESS=localhost:7051
}

setGlobalsForPeer1Geologi(){
    export CORE_PEER_LOCALMSPID="GeologiMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_GEOLOGI_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/geologi.esdm.go.id/users/Admin@geologi.esdm.go.id/msp
    export CORE_PEER_ADDRESS=localhost:7151
}

setGlobalsForPeer0Minerba(){
    export CORE_PEER_LOCALMSPID="MinerbaMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_MINERBA_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/minerba.esdm.go.id/users/Admin@minerba.esdm.go.id/msp
    export CORE_PEER_ADDRESS=localhost:8051
}

setGlobalsForPeer1Minerba(){
    export CORE_PEER_LOCALMSPID="MinerbaMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_MINERBA_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/minerba.esdm.go.id/users/Admin@minerba.esdm.go.id/msp
    export CORE_PEER_ADDRESS=localhost:8151
}

setGlobalsForPeer0BadanUsaha1(){
    export CORE_PEER_LOCALMSPID="BadanUsaha1MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_BADANUSAHA1_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/bu1.example.com/users/Admin@bu1.example.com/msp
    export CORE_PEER_ADDRESS=localhost:9051
}

setGlobalsForPeer0BadanUsaha2(){
    export CORE_PEER_LOCALMSPID="BadanUsaha2MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_BADANUSAHA2_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/bu2.example.com/users/Admin@bu2.example.com/msp
    export CORE_PEER_ADDRESS=localhost:10051
}

setGlobalsForPeer0ThirdParty(){
    export CORE_PEER_LOCALMSPID="ThirdPartyMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_THIRDPARTY_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/thirdparty.example.com/users/Admin@thirdparty.example.com/msp
    export CORE_PEER_ADDRESS=localhost:11051
}

#compile chaincode
presetup() {
    echo Vendoring Node dependencies ...
    pushd ./artifacts/src/nsdm_cc
    npm install
    popd
    echo Finished vendoring Node dependencies
}

CHANNEL_NAME="nsdm"
CC_RUNTIME_LANGUAGE="node"      #klo typescript pakenya node
VERSION="1"
CC_SRC_PATH="./artifacts/src/nsdm_cc"
CC_NAME="nsdm_cc"

# packageChaincode
packageChaincode() {
    rm -rf ${CC_NAME}.tar.gz
    setGlobalsForPeer0Geologi
    peer lifecycle chaincode package ${CC_NAME}.tar.gz \
        --path ${CC_SRC_PATH} --lang ${CC_RUNTIME_LANGUAGE} \
        --label ${CC_NAME}_${VERSION}
    echo "===================== Chaincode is packaged on peer0.geologi ===================== "
}

installChaincode() {
    setGlobalsForPeer0Geologi
    peer lifecycle chaincode install ${CC_NAME}.tar.gz
    echo "===================== Chaincode is installed on peer0.geologi ===================== "

    setGlobalsForPeer1Geologi
    peer lifecycle chaincode install ${CC_NAME}.tar.gz
    echo "===================== Chaincode is installed on peer1.geologi ===================== "

    setGlobalsForPeer0Minerba
    peer lifecycle chaincode install ${CC_NAME}.tar.gz
    echo "===================== Chaincode is installed on peer0.minerba ===================== "

    setGlobalsForPeer1Minerba
    peer lifecycle chaincode install ${CC_NAME}.tar.gz
    echo "===================== Chaincode is installed on peer1.minerba ===================== "

    setGlobalsForPeer0BadanUsaha1
    peer lifecycle chaincode install ${CC_NAME}.tar.gz
    echo "===================== Chaincode is installed on peer0.badanusaha1 ===================== "

    setGlobalsForPeer0BadanUsaha2
    peer lifecycle chaincode install ${CC_NAME}.tar.gz
    echo "===================== Chaincode is installed on peer0.badanusaha2 ===================== "
    
    setGlobalsForPeer0ThirdParty
    peer lifecycle chaincode install ${CC_NAME}.tar.gz
    echo "===================== Chaincode is installed on peer0.thirdparty ===================== "
}

queryInstalledGeo() {
    setGlobalsForPeer0Geologi
    peer lifecycle chaincode queryinstalled >&log.txt
    cat log.txt
    PACKAGE_ID=$(sed -n "/${CC_NAME}_${VERSION}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
    echo PackageID is ${PACKAGE_ID}
    echo "===================== Query installed successful on peer0.geologi on channel ===================== "
}

approveForMyGeologi() {
    setGlobalsForPeer0Geologi

    peer lifecycle chaincode approveformyorg -o localhost:7050 \
    --ordererTLSHostnameOverride orderer1.geologi.esdm.go.id --tls $CORE_PEER_TLS_ENABLED \
    --cafile $ORDERERGEO_CA --channelID $CHANNEL_NAME --name ${CC_NAME} --version ${VERSION} \
    --init-required --package-id ${PACKAGE_ID} --sequence ${VERSION}
    echo "===================== chaincode approved from geologi ===================== "

}

checkCommitReadyness() {
    setGlobalsForPeer0Geologi
    peer lifecycle chaincode checkcommitreadiness \
        --channelID $CHANNEL_NAME --name ${CC_NAME} --version ${VERSION} \
        --sequence ${VERSION} --output json --init-required
    echo "===================== checking commit readyness from Geologi ===================== "
}

queryInstalledMin() {
    setGlobalsForPeer0Minerba
    peer lifecycle chaincode queryinstalled >&log.txt
    cat log.txt
    PACKAGE_ID=$(sed -n "/${CC_NAME}_${VERSION}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
    echo PackageID is ${PACKAGE_ID}
    echo "===================== Query installed successful on peer0.minerba on channel ===================== "
}

approveForMyMinerba() {
    setGlobalsForPeer0Minerba

    peer lifecycle chaincode approveformyorg -o localhost:8050 \
    --ordererTLSHostnameOverride orderer2.minerba.esdm.go.id --tls $CORE_PEER_TLS_ENABLED \
    --cafile $ORDERERMIN_CA --channelID $CHANNEL_NAME --name ${CC_NAME} --version ${VERSION} \
    --init-required --package-id ${PACKAGE_ID} --sequence ${VERSION}
    echo "===================== chaincode approved from minerba===================== "
}

queryInstalledBU1() {
    setGlobalsForPeer0BadanUsaha1
    peer lifecycle chaincode queryinstalled >&log.txt
    cat log.txt
    PACKAGE_ID=$(sed -n "/${CC_NAME}_${VERSION}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
    echo PackageID is ${PACKAGE_ID}
    echo "===================== Query installed successful on peer0.bu1 on channel ===================== "
}

approveForMyBadanUsaha1() {
    setGlobalsForPeer0BadanUsaha1

    peer lifecycle chaincode approveformyorg -o localhost:7050 \
    --ordererTLSHostnameOverride orderer1.geologi.esdm.go.id --tls $CORE_PEER_TLS_ENABLED \
    --cafile $ORDERERGEO_CA --channelID $CHANNEL_NAME --name ${CC_NAME} --version ${VERSION} \
    --init-required --package-id ${PACKAGE_ID} --sequence ${VERSION}
    echo "===================== chaincode approved from badan usaha 1===================== "
}

queryInstalledBU2() {
    setGlobalsForPeer0BadanUsaha2
    peer lifecycle chaincode queryinstalled >&log.txt
    cat log.txt
    PACKAGE_ID=$(sed -n "/${CC_NAME}_${VERSION}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
    echo PackageID is ${PACKAGE_ID}
    echo "===================== Query installed successful on peer0.bu 2 on channel ===================== "
}

approveForMyBadanUsaha2() {
    setGlobalsForPeer0BadanUsaha2

    peer lifecycle chaincode approveformyorg -o localhost:7050 \
    --ordererTLSHostnameOverride orderer1.geologi.esdm.go.id --tls $CORE_PEER_TLS_ENABLED \
    --cafile $ORDERERGEO_CA --channelID $CHANNEL_NAME --name ${CC_NAME} --version ${VERSION} \
    --init-required --package-id ${PACKAGE_ID} --sequence ${VERSION}
    echo "===================== chaincode approved from badan usaha 2===================== "
}

queryInstalledThirdParty() {
    setGlobalsForPeer0ThirdParty
    peer lifecycle chaincode queryinstalled >&log.txt
    cat log.txt
    PACKAGE_ID=$(sed -n "/${CC_NAME}_${VERSION}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
    echo PackageID is ${PACKAGE_ID}
    echo "===================== Query installed successful on peer0.third party on channel ===================== "
}

approveForMyThirdParty() {
    setGlobalsForPeer0ThirdParty

    peer lifecycle chaincode approveformyorg -o localhost:7050 \
    --ordererTLSHostnameOverride orderer1.geologi.esdm.go.id --tls $CORE_PEER_TLS_ENABLED \
    --cafile $ORDERERGEO_CA --channelID $CHANNEL_NAME --name ${CC_NAME} --version ${VERSION} \
    --init-required --package-id ${PACKAGE_ID} --sequence ${VERSION}
 

    echo "===================== chaincode approved from thirdparty===================== "
}

commitChaincodeDefinition() {
    setGlobalsForPeer0Geologi
    peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer1.geologi.esdm.go.id \
        --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERERGEO_CA \
        --channelID $CHANNEL_NAME --name ${CC_NAME} \
        --peerAddresses localhost:7051 --tlsRootCertFiles $PEER0_GEOLOGI_CA \
        --peerAddresses localhost:8051 --tlsRootCertFiles $PEER0_MINERBA_CA \
        --peerAddresses localhost:9051 --tlsRootCertFiles $PEER0_BADANUSAHA1_CA\
        --peerAddresses localhost:10051 --tlsRootCertFiles $PEER0_BADANUSAHA2_CA \
        --peerAddresses localhost:11051 --tlsRootCertFiles $PEER0_THIRDPARTY_CA \
        --version ${VERSION} --sequence ${VERSION} --init-required

}

queryCommitted() {
    setGlobalsForPeer0Geologi
    peer lifecycle chaincode querycommitted --channelID $CHANNEL_NAME --name ${CC_NAME}

}

chaincodeInvokeInit() {
    setGlobalsForPeer0Geologi
    peer chaincode invoke -o localhost:7050 \
        --ordererTLSHostnameOverride orderer1.geologi.esdm.go.id \
        --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERERGEO_CA \
        -C $CHANNEL_NAME -n ${CC_NAME} \
        --peerAddresses localhost:7051 --tlsRootCertFiles $PEER0_GEOLOGI_CA \
        --peerAddresses localhost:8051 --tlsRootCertFiles $PEER0_MINERBA_CA \
        --peerAddresses localhost:9051 --tlsRootCertFiles $PEER0_BADANUSAHA1_CA \
        --peerAddresses localhost:10051 --tlsRootCertFiles $PEER0_BADANUSAHA2_CA \
        --peerAddresses localhost:11051 --tlsRootCertFiles $PEER0_THIRDPARTY_CA \
        --isInit -c '{"Args":[]}'

}

chaincodeInvoke() {

    setGlobalsForPeer0Geologi
    ## Init ledger
    peer chaincode invoke -o localhost:7050 \
        --ordererTLSHostnameOverride orderer1.geologi.esdm.go.id \
        --tls $CORE_PEER_TLS_ENABLED \
        --cafile $ORDERERGEO_CA \
        -C $CHANNEL_NAME -n ${CC_NAME} \
        --peerAddresses localhost:7051 --tlsRootCertFiles $PEER0_GEOLOGI_CA \
        --peerAddresses localhost:8051 --tlsRootCertFiles $PEER0_MINERBA_CA \
        --peerAddresses localhost:9051 --tlsRootCertFiles $PEER0_BADANUSAHA1_CA \
        --peerAddresses localhost:10051 --tlsRootCertFiles $PEER0_BADANUSAHA2_CA \
        --peerAddresses localhost:11051 --tlsRootCertFiles $PEER0_THIRDPARTY_CA \
        -c '{"function": "CreateAsset","Args":["269","Nikel Gunung Nuih","Nikel","Ni","Logam Besi dan Paduan Besi","Gunung Nuih","Muara Samu","Paser","Kalimantan Timur","Eksplorasi","-","0","0","0","0","0","0","0","0","1202428","11783.7944","0","0","Kadar Ni 1,69%","115.766","-2.023","-","Swasta/BUMN","Test CPI","2024","CID21ewqewqe21"]}'

}

chaincodeQuery() {
    setGlobalsForPeer0Geologi

    # Query all assets
    peer chaincode query -C $CHANNEL_NAME -n ${CC_NAME} -c '{"Args":["GetAllAssets"]}'
}

# Run this function if you add any new dependency in chaincode
presetup
packageChaincode
installChaincode
queryInstalledGeo
approveForMyGeologi
checkCommitReadyness
queryInstalledMin
approveForMyMinerba
checkCommitReadyness
queryInstalledBU1
approveForMyBadanUsaha1
checkCommitReadyness
queryInstalledBU2
approveForMyBadanUsaha2
checkCommitReadyness
queryInstalledThirdParty
approveForMyThirdParty
checkCommitReadyness
commitChaincodeDefinition
queryCommitted
chaincodeInvokeInit
sleep 5
chaincodeInvoke
sleep 3
chaincodeQuery