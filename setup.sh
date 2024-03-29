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

trilha "instalando openssh"
sudo apt-get install -y openssh-server openssh-client

trilha "gerando keygen"
ssh-keygen


trilha "instalando git"

sudo apt-get install git

trilha "instalando mercurial"

sudo apt-get install mercurial

trilha "instalando zsh"
sudo apt-get install zsh

trilha "install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

trilha "install drakula theme terminal"
sudo apt-get install dconf-cli
git clone https://github.com/dracula/gnome-terminal
./gnome-terminal/install.sh

trilha "node js npm and yarn"
sudo apt install yarn
sudo apt install nodejs
sudo apt install npm

trilha "instalando open JDK 8"
#wget -O- https://apt.corretto.aws/corretto.key | sudo apt-key add - 
#sudo add-apt-repository 'deb https://apt.corretto.aws stable main'
#sudo apt update
#sudo apt install -y java-1.8.0-amazon-corretto-jdk
sudo apt install openjdk-8-jdk

trilha "instalando DBEAVER"
wget -O - https://dbeaver.io/debs/dbeaver.gpg.key | sudo apt-key add -
echo "deb https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
sudo apt update
sudo apt install dbeaver-ce

trilha "COMEÇANDO A INSTALAÇÃO DOS BANCOS DE DADOS"
trilha "instalando libs da microsoft"
sudo apt-get install libxss1
sudo apt-get install libgconf-2-4
sudo apt-get install libunwind8

trilha "instalando MSSQL-SERVER"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/18.04/mssql-server-2019.list)"
sudo apt-get update
sudo apt-get install mssql-server

trilha "configurando MSSQL-SERVER"
sudo /opt/mssql/bin/mssql-conf setup

trilha "instalando POSTGRE"
sudo apt install postgresql postgresql-contrib

trilha "configurando POSTGRE"
trilha "criando banco de dados pld"
sudo -u postgres psql -U postgres -d postgres -c "create database pld"

trilha "criando use pld senha pld"
sudo -u postgres psql -U postgres -d postgres -c "create user pld with encrypted password 'pld'"

trilha "tornado usuario pld SUPERUSER"
sudo -u postgres psql -U postgres -d postgres -c "ALTER USER pld WITH SUPERUSER"

trilha "dando acesso a pld para banco pld"
sudo -u postgres psql -U postgres -d postgres -c "grant all privileges on database pld to pld;"

trilha "instalando mysql"
sudo apt install mysql-server
sudo mysql_secure_installation

trilha "isntalando VScode"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo apt-get update
sudo apt-get install code

trilha "instalando Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

#Instalação do ambiente lamp.

trilha "instalando php7 e suas libs"
sudo apt-get install php libapache2-mod-php php-mcrypt php-mysql php-cli php-xdebug

trilha "configurando Xdebug no PHP"
sudo -H /bin/bash
cd /etc/apt
echo '[XDebug]' >> /etc/php/7.2/apache2/php.ini 
echo 'xdebug.remote_enable = 1' >> /etc/php/7.2/apache2/php.ini 
echo 'xdebug.remote_autostart = 1' >> /etc/php/7.2/apache2/php.ini
exit

trilha "Configurando root do mysql-server"
echo "digite a senha do seu usuario mysql"

read senha
sudo mysql -e "drop user 'root'@'localhost'; create user 'root'@'localhost' identified by '$senha';grant all privileges on *.* to 'root'@'localhost' with grant option; flush privileges;"

trilha "Desabilitando modulos do mysql-server"
sudo -H /bin/bash
sed -i '/^\[mysqld\]/d' my.cnf
sed -i '/^sql_mode*/d' my.cnf
echo "[mysqld]" >>my.cnf
echo 'sql_mode = ""' >>my.cnf
exit

trilha "configurando php.ini para ambiente"
sudo -H /bin/bash
cd /etc/php/7.2/apache2
sed -i '/^short_open_tag \= Off/c\short_open_tag \= On' php.ini
sed -i '/^display_errors \= Off/c\display_errors \= On' php.ini
exit

trilha "configurando apache root directory para diretorio apache_server na sua home"
mkdir "apache_server"
printf -v var "%q\n" $HOME
echo "$var"
sudo -H /bin/bash
cd /etc/apache2
sed -i '/^\<Directory \/var\/www\/\>/c\\<Directory $var\/apache_server\/\>' apache2.conf
exit