#!/usr/bin/env bash

# vars
app_ip='127.0.0.1'
app_port='5000'
app_url="http://${app_ip}:${app_port}"


# availability
availability_port=$(timeout 1 bash -c "cat < /dev/null 2> /dev/null > /dev/tcp/${app_ip}/${app_port}" && echo 1 || echo 0 )

availability_root=$(curl -fs "$app_url" -o /dev/null && echo 1 || echo 0 )
availability_add=$(curl -fs -X POST "$app_url/add" -o /dev/null -d 'todo_item=ping' && echo 1 || echo 0 )
availability_update=$(curl -fs -X POST "$app_url/update" -o /dev/null -d '1=on' && echo 1 || echo 0 )

# latency
if [ "$availability_root" -ne 0 ]; then
    latency_root=$(curl -fs -w '%{time_total}' -o /dev/null "$app_url")
else
    latency_root=0
fi

if [ "$availability_add" -ne 0 ]; then
    latency_add=$(curl -fs -w '%{time_total}' -X POST "$app_url/add" -o /dev/null -d 'todo_item=ping')
else
    latency_add=0
fi

if [ "$availability_update" -ne 0 ]; then
    latency_update=$(curl -fs -w '%{time_total}' -X POST "$app_url/update" -o /dev/null -d '1=on')
else
    latency_update=0
fi



# Prometheus like output
echo '# HELP availability The flag of availability by url'
echo '# TYPE availability gauge'
echo 'availability_port' ${availability_port}
echo 'availability{method="GET", path="/"}' ${availability_root}
echo 'availability{method="POST", path="/add"}' ${availability_add}
echo 'availability{method="POST", path="/update"}' ${availability_update}
echo
echo '# HELP latency The current latency by url with millisecond resolution'
echo '# TYPE latency gauge'
echo 'latency{method="GET", path="/"}' ${latency_root}
echo 'latency{method="POST", path="/add"}' ${latency_add}
echo 'latency{method="POST", path="/update"}' ${latency_update}
