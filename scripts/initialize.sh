#!/usr/bin/bash
opt_file="smn_options.json"
locations_json="locations.json"
#weather_data=$(cat test.json)
weather_data=$(./smn -w)


gen_location_json(){
    mapfile -t provinces < <(echo $weather_data | jq '.[].province'|sort|uniq)
    json_cities='['
    for province in "${provinces[@]}"; do
        #echo "${province}"
        names=$(echo $weather_data | jq '.[] | select(.province=="Buenos Aires")|.name'| sort | tr '\n' ',' )
        json_city_array='{"province":'"${province}"',"cities":['"${names%?}"']}'
        json_cities="${json_cities}${json_city_array}"','
    done
    json_cities="${json_cities%?}"']'
    echo "${json_cities}">$locations_json
}



gen_location_json
#create_opt_json (){
#    #generates the option .json with null variables
#    jo -a \
#        $(jo id=weather options=$(jo locations="${location_json}")>$opt_file
#}



#if ! [ -e "${opt_file}" ]; then
#    echo "creating smn_options.json"
#    create_opt_json
#fi
#
#echo "updating smn_options.json"


#weather=$(./smn -w|jq -r)

