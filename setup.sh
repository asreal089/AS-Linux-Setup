function trilha {
    if [ -z $2 ]
    then
        info="INFO"
    else
        info=$2
    fi

    message="[$info] `date '+%d/%m/%Y %H:%M:%S'`, $1"
    echo "-------------------------------------------------------------------------------------------------------------------------------"
    echo $message
    echo "-------------------------------------------------------------------------------------------------------------------------------"
}


trilha "atualizando reposito ubuntu /apt-get udpate "
sudo apt-get update


trilha "instalando curl"
sudo apt-get install curl -y

trilha "instalando sublime-text"

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

sudo apt-get update

sudo apt-get install sublime-text

trilha "instalando vim"

sudo apt-get install vim -y

trilha "instalando git"

sudo apt-get install git

trilha "instalando mercurial"

sudo apt-get install mercurial

trilha "instalando JDK"

sudo apt-get install openjdk-8-jdk -y

trilha "instalando DBEAVER"





