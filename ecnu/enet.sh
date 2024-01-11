
#!/bin/bash
# enet.sh
# Created: 2024-01-11 17:21:05
# Author: Bill Chen (bill.chen@live.com)

auth_setting_content=$(
    cat <<EOF
host="172.20.20.11"
campus_postfix=""
campus_url=""
acid="1"
EOF
)

auth_client_url="https://gitee.com/billchen2k/dotfiles/raw/main/ecnu/auth_client"
enet_dir="$HOME/.enet"
auth_client="$enet_dir/auth_client"
auth_command=""

echo "This script will help you setup automatic login to ECNU campus network."

function load_binary {
    echo "Downloading auth client..."

    # check wget and crontab
    expect_commands=(wget cron)
    for expect_command in "${expect_commands[@]}"; do
        if ! [ -x "$(command -v $expect_command)" ]; then
            echo "Error: $expect_command is not installed. Please install $expect_command and try again."
            exit 1
        fi
    done

    mkdir -p $enet_dir
    echo "$auth_setting_content" > $enet_dir/.auth_setting
    wget -O $auth_client $auth_client_url
    chmod +x $auth_client
    echo "Auth client saved to $auth_client."
}


function setup_crontab {
    # if current exist a crontab, remove it
    crontab -l | grep -v "$auth_client" | crontab -
    echo "Setting up crontab job..."
    crontab -l | { cat; echo "* 1-23/2 * * * $auth_command"; } | crontab -
    echo "Crontab setup done. To check crontab job, please run 'crontab -l'."
}


function setup_credential {
    echo "Please enter your ECNU username:"
    read username
    echo "Please enter your ECNU password:"
    read -s password
    echo "Checking credentials..."
    # pip all output to stdout
    auth_command="$auth_client --config $HOME/.enet/.auth_setting -u $username -p $password auth"
    $auth_command --logout
    output=$($auth_command 2>&1)
    echo $output
    if [[ $output == *"error"* ]]; then
        echo "Error occured during authentication. Please try again."
        setup_credential
    else
        echo "Authentication success."
        echo $auth_command > $enet_dir/enet
        chmod +x $enet_dir/enet
        setup_crontab
    fi
}

function setup_link {

    echo "Setting up enet command for manual login (requires root)..."
    if [ -x "$(command -v sudo)" ]; then
        if [ -f /usr/local/bin/enet ]; then
            echo "enet command already exists. Will override."
            sudo rm -f /usr/local/bin/enet
        fi
        sudo ln -s $enet_dir/enet /usr/local/bin/enet
        if [ $? -ne 0 ]; then
            echo "Error occured setting up enet command. You can manually find this log in script in ~/.enet/enet."
        fi
    else
        if [ -f /usr/local/bin/enet ]; then
            echo "enet command already exists. Will override."
            rm -f /usr/local/bin/enet
        fi
        ln -s $enet_dir/enet /usr/local/bin/enet
    fi
    echo ""
    echo "Your system will automatically log in to ECNU campus network every 2 hours."
    echo "You can also now manually login to ECNU campus network by running command 'enet'."
    echo "[Setup Complete]"
}

function uninstall {
    echo "Uninstalling..."
    rm -rdf $enet_dir
    crontab -l | grep -v "$auth_client" | crontab -
    if [ -x "$(command -v sudo)" ]; then
        sudo rm -f /usr/local/bin/enet
    else
        rm -f /usr/local/bin/enet
    fi
    echo "Uninstall done."
}



# Existing configuration

if [ -d ~/.enet ]; then
    echo "You have already setup automatic login to ECNU campus network before."
    echo "  [y] To remove current auth client & credentials and re-setup, please enter y."
    echo "  [k] To keep current auth client and reconfigure credentials only, please enter k."
    echo "  [d] To uninstall auth client, remove credentials, and unsetup cronjob, please enter d."
    echo "  [n] To abort, please enter n or any other key."
    echo -n "[y/k/d/n]? "
    read answer
    if [ "$answer" == "y" ]; then
        rm -rdf $enet_dir
        load_binary
        setup_credential
        setup_link
        exit 0
    elif [ "$answer" == "k" ]; then
        setup_credential
        setup_link
        exit 0
    elif [ "$answer" == "d" ]; then
        uninstall
        exit 0
    else
        echo "Aborted."
        exit 0
    fi
fi

load_binary
setup_credential
setup_link