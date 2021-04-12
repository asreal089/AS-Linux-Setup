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
deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo apt-get update
sudo apt-get install code

trilha "instalando Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

trilha "baixando arquivos de Ambiente java AML"
curl http://mailing.amlconsulting.com.br/arquivos/arquivosPaulo.tar.gz --output ambienteJava.tar.gz

trilha "Descompactando ambienteJava"
tar xvzf ambienteJava.tar.gz -C $PWD

trilha "Descompactando Eclipse"
tar xvzf eclipse-standard-luna-R-linux-gtk-x86_64.tar.gz -C $HOME/eclipse

trilha "criando Diretorio para instalações de ambienteJava da AML"
mkdir "JAVA_AML_SETUP"

trilha "Descompactando eclipse, mvn e jdk para diretorio install"
tar xvzf eclipse-standard-luna-R-linux-gtk-x86_64.tar.gz -C "$HOME/JAVA_AML_SETUP"
tar xvzf apache-maven-3.3.3-bin.tar.gz -C "$HOME/JAVA_AML_SETUP"
tar xvzf jdk1.7.tar.gz -C "$HOME/JAVA_AML_SETUP"

trilha "configurando Variaveis de Ambiente do java"
echo  'export JAVA_HOME=$HOME/JAVA_AML_SETUP/jdk1.7.0_17' >> ~/.bashrc 
echo  'export M2_HOME=$HOME/JAVA_AML_SETUP/apache-maven-3.3.3' >> ~/.bashrc 
echo  'export MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=1024m"' >> ~/.bashrc 
echo  'export PATH="$JAVA_HOME/bin:$M2_HOME/bin:$PATH"' >> ~/.bashrc

trilha "movendo settings.xml para diretorio do M2"
mv settings.xml .m2/settings.xml
