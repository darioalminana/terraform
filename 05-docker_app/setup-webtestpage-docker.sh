#! /bin/bash
sudo apt-get update
sudo apt-get install -y docker.io
sudo docker pull webpagetest/server
sudo docker pull webpagetest/agent
mkdir server
mkdir agent
cat << __EOF__ > ./server/dockerfile
FROM webpagetest/server
ADD locations.ini /var/www/html/settings/
__EOF__

cat << __EOF__ > ./server/locations.ini
[locations]
1=Test_loc
[Test_loc]
1=Test
label=Test Location
group=Desktop
[Test]
browser=Chrome,Firefox
label="Test Location"
connectivity=LAN
__EOF__

sudo docker build -t local-wptserver ./server

cat << __EOF__ > ./agent/dockerfile
FROM webpagetest/agent
ADD script.sh /
ENTRYPOINT /script.sh
__EOF__

cat << __EOF__ > script.sh
#!/bin/bash
set -e
if [ -z "$SERVER_URL" ]; then
  echo >&2 'SERVER_URL not set'
  exit 1
fiif [ -z "$LOCATION" ]; then
  echo >&2 'LOCATION not set'
  exit 1
fiEXTRA_ARGS=""
if [ -n "\$NAME" ]; then
  EXTRA_ARGS="\$EXTRA_ARGS --name \$NAME"
fi
python /wptagent/wptagent.py --server $SERVER_URL --location $LOCATION $EXTRA_ARGS --xvfb --dockerized -vvvvv --shaper none
__EOF__
sudo chmod u+x ./agent/script.sh
sudo docker build -t local-wptagent ./agent

sudo docker run -d -p 4000:80 local-wptserver
sudo docker run -d -p 4001:80 --network="host" -e "SERVER_URL=http://localhost:4000/work/" -e "LOCATION=Test" local-wptagent
