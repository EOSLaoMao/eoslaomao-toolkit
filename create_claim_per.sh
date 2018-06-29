#!/bin/bash
account= 
publicKey=
url=http://localhost:8888

usage()
{
    echo "usage: ./create_claim_per.sh --account PRODUCERACC --publicKey EOSXXXXXXXXXXXXXX"
}

while [ "$1" != "" ]; do
    case $1 in
        -a | --account )        shift
                                account=$1
                                ;;
        -p | --publicKey )      shift
                                publicKey=$1
                                ;;
        -u | --url )            shift
                                url=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

echo $account
echo $publicKey

docker exec full-node cleos -u $url set account permission $account claimer '{"threshold":1,"keys":[{"key":'\"$publicKey\"',"weight":1}]}' "active" -p $account@active
sleep 1
docker exec full-node cleos -u $url set action permission $account eosio claimrewards claimer -p $account@active
