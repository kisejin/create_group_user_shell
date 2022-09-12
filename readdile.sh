#! /bin/zsh

# file_name='creategroupuser.txt'
file_name='ms.csv'
if [[ -f $file_name || -s $file_name ]]
then 
    # Check permissions file
    if [ -r $file_name ] # add not operator
    then
        sudo chmod +r $file_name
    fi
    
    # Create a group users
    name_group='KHDL'
    sudo groupadd $name_group

    IFS=","
    cat $file_name | while read -r line
    do 
        line=$(echo $line | tr ',' ' ')
        eval "arr=($line)"
        name="sv${arr[1]}"
        psw="${arr[2]}"

        # Add user
        sudo useradd -m $name -p $psw

        sudo chown -R  $name.$name /home/$name

        # Setting home directory of new user
        sudo usermod -d / $name

        # Assign user to group
        sudo usermod -G $name_group $name

    done

else
    echo "Error trying to read file!"
fi 
