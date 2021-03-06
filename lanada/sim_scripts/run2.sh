#!/bin/bash

SR=0 # Decide whether SR simulation runs or not
LR=1 # For LR case
TRAFFIC=0 # 0 = periodic, 1 = poisson
VAR_PERIOD=(30 60 90)
VAR_ARRIVAL=(60)
VAR_TOPOLOGY=("16linear" "36grid" "50random")
VAR_LR_RANGE=("2X")
VAR_LR_WEIGHT=("2")
VAR_LSA_R=0
VAR_STROBE_CNT=1
VAR_ALPHA=(1)
VAR_PARENT_REDUCTION=0
VAR_REDUCTION_RATIO=0
VAR_DATA_ACK=1
DATE="0630"
LSA_MAC=1

# SR_RANGE simulation

if [ $SR -eq 1 ]
then
    if [ $TRAFFIC -eq 0 ]
    then
	for period in "${VAR_PERIOD[@]}"
	do
	    for topology in "${VAR_TOPOLOGY[@]}"
	    do
		for alpha in "${VAR_ALPHA[@]}"
		do
		./sr_run.sh $topology $TRAFFIC $period  0 $alpha $VAR_STROBE_CNT "${DATE}" $VAR_DATA_ACK
		done
	    done
	done
    else
	for arrival in "${VAR_ARRIVAL[@]}"
	do
	    for topology in "${VAR_TOPOLOGY[@]}"
	    do
		for alpha in "${VAR_ALPHA[@]}"
		do
		./sr_run.sh $topology $TRAFFIC 0 $arrival $alpha $VAR_STROBE_CNT "${DATE}" $VAR_DATA_ACK
		done
	    done
	done
    fi
fi

# LR_RANGE simulation
if [ $LR -eq 1 ]
then
    if [ $TRAFFIC -eq 0 ]
    then
	for period in $VAR_PERIOD
	do
	    for topology in "${VAR_TOPOLOGY[@]}"
	    do
		for range in "${VAR_LR_RANGE[@]}"
		do
		    for weight in "${VAR_LR_WEIGHT[@]}"
		    do
			for ratio in $VAR_REDUCTION_RATIO
			do
			    for alpha in "${VAR_ALPHA[@]}"
			    do
			./lr_run.sh $topology $TRAFFIC $period 0 $alpha $VAR_STROBE_CNT $weight $VAR_LSA_R $range $VAR_PARENT_REDUCTION $ratio "${DATE}" $VAR_DATA_ACK $LSA_MAC
			    done
			done
		    done
		done
	    done
	done
    else
	for arrival in $VAR_ARRIVAL
	do
	    for topology in "${VAR_TOPOLOGY[@]}"
	    do
		for range in "${VAR_LR_RANGE[@]}"
		do
		    for weight in "${VAR_LR_WEIGHT[@]}"
		    do
			for ratio in $VAR_REDUCTION_RATIO
			do
			    for alpha in "${VAR_ALPHA[@]}"
			    do
			./lr_run.sh $topology $TRAFFIC 0 $arrival $alpha $VAR_STROBE_CNT $weight $VAR_LSA_R $range $VAR_PARENT_REDUCTION $ratio "${DATE}" $VAR_DATA_ACK $LSA_MAC
			    done
			done
		    done
		done
	    done
	done
    fi
fi
