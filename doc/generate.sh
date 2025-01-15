#!/bin/bash

# A script that call other scipts :)
# use PlantUml & Pandoc

cd uml
mkdir -p out
puml
cd ..

pdc PacketManager.md
