#!/bin/bash

set -e

gtf=$1
feature_type=$2

function check_feature_type_present(){
    ft=$1
    local first_feature=$(awk '{print $3}' $gtf | grep -m 1 $ft)
    feature_status=$?
    if [ "$first_feature" == '' ]; then
        echo "Something wrong, can't find any $ft features" 1>&2
        exit 1
    else
        return $feature_status
    fi
}

function count_features(){
    ft=$1
    
    n_features=$(awk -v type=$ft '{ if ($3 == type) { print } }' $gtf | wc -l | sed 's/ //g')
    if [ "$n_features" -eq '0' ]; then
        echo "Something wrong, can't find any $ft features" 1>&2
        return 1
    else
        echo $n_features
    fi
}

# Check if the feature type is present before proceeding

ft_present=$(check_feature_type_present $feature_type)
echo $ft_present
if [ $? -eq 0 ]; then
    echo "Feature type $feature_type is present"
else
    echo "Feature type $feature_type is not present, choose another"
    exit 1
fi

# Count the features
nf=$(count_features $feature_type)
if [ "$?" -eq '0' ]; then
    echo "Got a count of $nf"
else
    echo "Failed to get a count for $feature_type features in GTF content"
fi
