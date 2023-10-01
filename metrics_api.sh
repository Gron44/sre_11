#!/usr/bin/env bash

# vars
app_url="http://api.open-notify.org/iss-now.json"


# availability

availability=$(curl -fs "$app_url" -o /dev/null && echo 1 || echo 0 )

response=$(curl -fs "$app_url")

availability_json=$(echo $response | if [ "$(jq -r .message)" == "success" ]; then echo 1; else echo 0; fi)


# iss_position
if [ "$availability_json" -ne 0 ]; then
    iss_position_longitude=$(echo $response | jq -r .iss_position.longitude )
else
    iss_position_longitude=0
fi

if [ "$availability_json" -ne 0 ]; then
    iss_position_latitude=$(echo $response | jq -r .iss_position.latitude )
else
    iss_position_latitude=0
fi


# Prometheus like output
echo '# HELP availability The flag of availability'
echo '# TYPE availability gauge'
echo 'availability' ${availability}
echo 'availability_json' ${availability_json}
echo
echo '# HELP iss_position_longitude The current iss position by longitude'
echo '# TYPE iss_position_longitude gauge'
echo "iss_position_longitude ${iss_position_longitude}"
echo
echo '# HELP iss_position_latitude The current iss position by longitude'
echo '# TYPE iss_position_latitude gauge'
echo "iss_position_latitude ${iss_position_latitude}"
