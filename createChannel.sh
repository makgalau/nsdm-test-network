export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/artifacts/channel/crypto-config/ordererOrganizations/geologi.esdm.go.id/orderers/orderer1.geologi.esdm.go.id/msp/tlscacerts/tlsca.geologi.esdm.go.id-cert.pem
export PEER0_GEOLOGI_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/geologi.esdm.go.id/peers/peer0.geologi.esdm.go.id/tls/ca.crt
export PEER0_MINERBA_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/minerba.esdm.go.id/peers/peer0.minerba.esdm.go.id/tls/ca.crt
export PEER0_BADANUSAHA1_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/bu1.example.com/peers/peer0.bu1.example.com/tls/ca.crt
export PEER0_BADANUSAHA2_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/bu2.example.com/peers/peer0.bu2.example.com/tls/ca.crt
export PEER0_THIRDPARTY_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/thirdparty.example.com/peers/peer0.thirdparty.example.com/tls/ca.crt

export FABRIC_CFG_PATH=${PWD}/artifacts/channel/config/

export CHANNEL_NAME=nsdm

# setGlobalsForOrderer(){
#     export CORE_PEER_LOCALMSPID="OrdererMSP"
#     export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/artifacts/channel/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
#     export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp
    
# }

setGlobalsForPeer0Geologi(){
    export CORE_PEER_LOCALMSPID="GeologiMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_GEOLOGI_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/geologi.esdm.go.id/users/Admin@geologi.esdm.go.id/msp
    export CORE_PEER_ADDRESS=localhost:7051
}

setGlobalsForPeer1Geologi(){
    export CORE_PEER_LOCALMSPID="GeologiMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_GEOLOGI_CA
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
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_MINERBA_CA
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

createChannel(){
    # rm -rf ./channel-artifacts/*
    setGlobalsForPeer0Geologi
    
    peer channel create -o localhost:7050 -c $CHANNEL_NAME \
    --ordererTLSHostnameOverride orderer1.geologi.esdm.go.id \
    -f ./artifacts/channel/${CHANNEL_NAME}.tx --outputBlock ./channel-artifacts/${CHANNEL_NAME}.block \
    --tls --cafile $ORDERER_CA
}

removeOldCrypto(){
    rm -rf ./api-1.4/crypto/*
    rm -rf ./api-1.4/fabric-client-kv-org1/*
    rm -rf ./api-2.0/org1-wallet/*
    rm -rf ./api-2.0/org2-wallet/*
}


joinChannel(){
    setGlobalsForPeer0Geologi
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer1Geologi
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer0Minerba
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer1Minerba
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer0BadanUsaha1
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer0BadanUsaha2
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer0ThirdParty
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    
}

updateAnchorPeers(){
    setGlobalsForPeer0Geologi
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer1.geologi.esdm.go.id -c $CHANNEL_NAME -f ./artifacts/channel/${CORE_PEER_LOCALMSPID}anchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    
    setGlobalsForPeer0Minerba
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer1.geologi.esdm.go.id -c $CHANNEL_NAME -f ./artifacts/channel/${CORE_PEER_LOCALMSPID}anchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    
    setGlobalsForPeer0BadanUsaha1
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer1.geologi.esdm.go.id -c $CHANNEL_NAME -f ./artifacts/channel/${CORE_PEER_LOCALMSPID}anchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    
    setGlobalsForPeer0BadanUsaha2
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer1.geologi.esdm.go.id -c $CHANNEL_NAME -f ./artifacts/channel/${CORE_PEER_LOCALMSPID}anchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    
    setGlobalsForPeer0ThirdParty
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer1.geologi.esdm.go.id -c $CHANNEL_NAME -f ./artifacts/channel/${CORE_PEER_LOCALMSPID}anchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    
}

# removeOldCrypto

# createChannel
# joinChannel
updateAnchorPeers