#!/bin/bash
account= 
url=

usage()
{
    echo "usage: ./delete_claim_per.sh --account PRODUCERACC --url https://api.eoslaomao.com"
}

while [ "$1" != "" ]; do
    case $1 in
        -a | --account )        shift
                                account=$1
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

docker exec full-node cleos -u $url set account permission $account claimer NULL "active" -p $account@active
sleep 1
docker exec full-node cleos -u $url set action permission $account eosio claimrewards NULL -p $account@active

