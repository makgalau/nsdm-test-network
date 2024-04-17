#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    local PP1=$(one_line_pem $6)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        -e "s#\${PEERPEM1}#$PP1#" \
        -e "s#\${P0PORT1}#$7#" \
        ./ccp-template.json
}

function json_ccp2 {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        ./ccp-template.json
}

ORG=Geologi
P0PORT=7051
CAPORT=7054
P0PORT1=7151
PEERPEM=../../artifacts/channel/crypto-config/peerOrganizations/geologi.esdm.go.id/peers/peer0.geologi.esdm.go.id/msp/tlscacerts/tlsca.geologi.esdm.go.id-cert.pem
PEERPEM1=../../artifacts/channel/crypto-config/peerOrganizations/geologi.esdm.go.id/peers/peer1.geologi.esdm.go.id/msp/tlscacerts/tlsca.geologi.esdm.go.id-cert.pem
CAPEM=../../artifacts/channel/crypto-config/peerOrganizations/geologi.esdm.go.id/msp/tlscacerts/tlsca.geologi.esdm.go.id-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $PEERPEM1 $P0PORT1)" > connection-geologi.json


ORG=Minerba
P0PORT=8051
CAPORT=8054
P0PORT1=8151
PEERPEM=../../artifacts/channel/crypto-config/peerOrganizations/minerba.esdm.go.id/peers/peer0.minerba.esdm.go.id/msp/tlscacerts/tlsca.minerba.esdm.go.id-cert.pem
PEERPEM1=../../artifacts/channel/crypto-config/peerOrganizations/minerba.esdm.go.id/peers/peer1.minerba.esdm.go.id/msp/tlscacerts/tlsca.minerba.esdm.go.id-cert.pem
CAPEM=../../artifacts/channel/crypto-config/peerOrganizations/minerba.esdm.go.id/msp/tlscacerts/tlsca.minerba.esdm.go.id-cert.pem


echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $PEERPEM1 $P0PORT1)" > connection-minerba.json


ORG=BadanUsaha1
P0PORT=9051
CAPORT=9054
PEERPEM=../../artifacts/channel/crypto-config/peerOrganizations/bu1.example.com/peers/peer0.bu1.example.com/msp/tlscacerts/tlsca.bu1.example.com-cert.pem
PEERPEM1=../../artifacts/channel/crypto-config/peerOrganizations/bu1.example.com/peers/peer1.bu1.example.com/msp/tlscacerts/tlsca.bu1.example.com-cert.pem
CAPEM=../../artifacts/channel/crypto-config/peerOrganizations/bu1.example.com/msp/tlscacerts/tlsca.bu1.example.com-cert.pem


echo "$(json_ccp2 $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-bu1.json

ORG=BadanUsaha2
P0PORT=10051
CAPORT=10054
PEERPEM=../../artifacts/channel/crypto-config/peerOrganizations/bu2.example.com/peers/peer0.bu2.example.com/msp/tlscacerts/tlsca.bu2.example.com-cert.pem
PEERPEM1=../../artifacts/channel/crypto-config/peerOrganizations/bu2.example.com/peers/peer1.bu2.example.com/msp/tlscacerts/tlsca.bu2.example.com-cert.pem
CAPEM=../../artifacts/channel/crypto-config/peerOrganizations/bu2.example.com/msp/tlscacerts/tlsca.bu2.example.com-cert.pem


echo "$(json_ccp2 $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-bu2.json

ORG=ThirdParty
P0PORT=11051
CAPORT=11054
PEERPEM=../../artifacts/channel/crypto-config/peerOrganizations/thirdparty.example.com/peers/peer0.thirdparty.example.com/msp/tlscacerts/tlsca.thirdparty.example.com-cert.pem
PEERPEM1=../../artifacts/channel/crypto-config/peerOrganizations/thirdparty.example.com/peers/peer1.thirdparty.example.com/msp/tlscacerts/tlsca.thirdparty.example.com-cert.pem
CAPEM=../../artifacts/channel/crypto-config/peerOrganizations/thirdparty.example.com/msp/tlscacerts/tlsca.thirdparty.example.com-cert.pem


echo "$(json_ccp2 $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-thirdparty.json
