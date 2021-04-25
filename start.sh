#!/bin/bash

# cat ../../../code/prometheus_inegration/docker/set_env_vars_default.sh

function local_or_cloud_menu {
    printf '\n Where the "Prometheus" installation is planned? \n'
    PS3='Please enter your choice: #  '
    options=("with container locally # 1" "on the cloud using terraform # 2"  "Quit")
    select opt in "${options[@]}"
    do
        case $opt in
            "with container locally # 1")
                echo "you chose choice (1) container locally installation"
                default_collisions_check
                exit
                ;;            
            "on the cloud using terraform # 2")
                echo "Excuse me! this functionality is not ready yet"
                ;;
            "Quit")
                exit
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

function default_collisions_check {
    echo "default collisions check"
    source $PWD/docker/services_availability_tests.sh 
    serices_availability_check 0.0.0.0 80 433
    [ "$AVAILABILITY_STATUS" = true ] && availability_warn || echo "All services are available."
}


function availability_warn {
    cat   <<-\_several_strings_
        it looks like one or more IP or ports busy with other processes
        please take a look at the file with variables:
_several_strings_
    echo $PWD/docker/services_availability_tests.sh
    cat   <<-\_several_strings_
    you can change the value of the variables,
    but we strongly recommend that you do not change the name of the variables,
    since they are referenced by some configuration components,
    if necessary you can add your own variables
_several_strings_
    PS3='Please enter your next choice: '
    options=("Start the installation with the default values # 1" "Show the default variables # 2" "Customize the configuration and change the default values # 3" "Quit")
    select opt in "${options[@]}"
    do
        case $opt in
            "Start the installation with the default values # 1")
                echo "you chose choice the installation with the default values started"
                source $PWD/docker/make_compose_component.sh
                break                
                ;;            
            "Show the default variables # 2")
                echo "show the default variables 2"
                cat $PWD/docker/set_env_vars_default.sh
                ;;
            "Customize the configuration and change the default values # 3")
                echo "you chose choice $REPLY which is $opt"
                break
                ;;
            "Quit")
                exit
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

local_or_cloud_menu

