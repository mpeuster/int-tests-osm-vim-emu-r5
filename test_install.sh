#!/bin/bash

set -x
set -e

pwd

# cleanup
rm -f install_osm.sh

# get latest installer
wget https://osm-download.etsi.org/ftp/osm-7.0-seven/install_osm.sh
chmod +x install_osm.sh

# uninstall old OSM
./install_osm.sh --uninstall 2>&1 | tee logs/osm_uninstall.log
# uninstall vim-emu
docker stop vim-emu || true
docker rm -f vim-emu || true

# install new OSM with vim-emu
./install_osm.sh -y -r testing -R ReleaseSIX-daily -u https://osm-download.etsi.org/repository/osm/debian -t releasesix-daily --vimemu 2>&1 | tee logs/osm_install.log 

# add ELK stack
#./install_osm.sh -o elk_stack | tee logs/osm_install_elk.log
