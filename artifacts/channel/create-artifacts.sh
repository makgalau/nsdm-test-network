
# chmod -R 0755 ./crypto-config
# # Delete existing artifacts
rm -rf ./crypto-config
rm genesis.block nsdm.tx
# rm -rf ../../channel-artifacts/*

#Generate Crypto artifactes for organizations
cryptogen generate --config=./crypto-config.yaml --output=./crypto-config/



# System channel
SYS_CHANNEL="sys-channel"

# channel name defaults to "mychannel"
CHANNEL_NAME="nsdm"

echo $CHANNEL_NAME

# Generate System Genesis block
configtxgen -profile OrdererGenesis -configPath . -channelID $SYS_CHANNEL  -outputBlock ./genesis.block


# Generate channel configuration block
configtxgen -profile BasicChannel -configPath . -outputCreateChannelTx ./nsdm.tx -channelID $CHANNEL_NAME

echo "#######    Generating anchor peer update for GeologiMSP  ##########"
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./GeologiMSPanchors.tx -channelID $CHANNEL_NAME -asOrg GeologiMSP

echo "#######    Generating anchor peer update for MinerbaMSP  ##########"
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./MinerbaMSPanchors.tx -channelID $CHANNEL_NAME -asOrg MinerbaMSP

echo "#######    Generating anchor peer update for BadanUsaha1MSP  ##########"
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./BadanUsaha1MSPanchors.tx -channelID $CHANNEL_NAME -asOrg BadanUsaha1MSP

echo "#######    Generating anchor peer update for BadanUsaha2MSP  ##########"
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./BadanUsaha2MSPanchors.tx -channelID $CHANNEL_NAME -asOrg BadanUsaha2MSP

echo "#######    Generating anchor peer update for ThirdPartyMSP  ##########"
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./ThirdPartyMSPanchors.tx -channelID $CHANNEL_NAME -asOrg ThirdPartyMSP