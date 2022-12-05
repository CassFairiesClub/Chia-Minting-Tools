#!/bin/bash
#-------------------------------------------------------------------------------------------------------------
# 1. Upload the collection on IPFS in a single folder
# 1.1 all the jpegs, png, gif, mp4 files and the json metadata must be in a single folder, meaning under the same CID
#	1.2 the script suppose all the files are the same extension, otherwise it needs to be modified a bit if it mixes pngs and gifs for instance
# 
# 2. build the minting csv file with prepare_minting_data.sh script
# hash,uris,meta_hash,meta_uris,license_hash,license_uris,edition_number,edition_total


COLLECTION_NAME=CassXels
EXTENSION=png # png, jpeg, gif, mp4 etc...
COLLECTION_SIZE=1000
IPFS=
LICENSELINK=https://creativecommons.org/publicdomain/zero/1.0/legalcode
LICENSEHASH=f881cb565039ff9a487be6793070e7596ddd882225f2ab01d4d82e8709db8bb7
EDITION_NUMBER=1
EDITION_TOTAL=1

echo "hash,uris,meta_hash,meta_uris,license_hash,license_uris,edition_number,edition_total" > metadata_$COLLECTION_NAME.csv

for i in $(seq 1 $COLLECTION_SIZE)
do
U=$IPFS"/"$COLLECTION_NAME"_"$i"."$EXTENSION
NH=$(curl -s $U | sha256sum | cut -d ' ' -f 1)
MU=$IPFS"/"$COLLECTION_NAME"_"$i"."json
MH=$(curl -s $MU | sha256sum | cut -d ' ' -f 1)

echo "$NH,$U,$MH,$MU,$LICENSEHASH,$LICENSELINK,$EDITION_NUMBER,$EDITION_TOTAL" >> metadata_$COLLECTION_NAME.csv
echo "$i done"
done

echo "metadata_$COLLECTION_NAME.csv created"
