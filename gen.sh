#!/bin/bash
sh gen_cfg.sh
sleep 1
echo "--------------------"
echo "gen_cfg.sh complete!"
sh gen_mig.sh
sleep 1
echo "--------------------"
echo "gen_mig.sh complete!"
sh gen_chk.sh
sleep 1
echo "--------------------"
echo "gen_chk.sh complete!"
