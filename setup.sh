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

trilha "instalando openssh"
sudo apt-get install -y openssh-server openssh-client

trilha "gerando keygen"
ssh-keygen

sudo apt-get install vim -y

trilha "instalando git"

sudo apt-get install git

trilha "instalando mercurial"

sudo apt-get install mercurial

trilha "instalando JDK"

sudo apt-get install openjdk-8-jdk -y

trilha "instalando DBEAVER"
wget -O - https://dbeaver.io/debs/dbeaver.gpg.key | sudo apt-key add -
echo "deb https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
sudo apt update
sudo apt install dbeaver-ce

trilha "instalando libs da microsoft"
sudo apt-get install libxss1
sudo apt-get install libgconf-2-4
sudo apt-get install libunwind8

trilha "instalando MSSQL-SERVER"
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add –
curl https://packages.microsoft.com/config/ubuntu/18.04/mssql-server-2019.list | sudo tee /etc/apt/sources.list.d/mssql-server.list
sudo apt-get update
sudo apt-get install mssql-server

trilha "configurando MSSQL-SERVER"
sudo /opt/mssql/bin/sqlservr-setup

trilha "instalando POSTGRE"
sudo apt install postgresql postgresql-contrib

trilha "configurando POSTGRE"
trilha "criando banco de dados Dude"
sudo -u postgres psql -U postgres -d postgres -c "create database dude"
trilha "criando use pld senha pld"
sudo -u postgres psql -U postgres -d postgres -c "create user pld with encrypted password 'pld'"
trilha "dando acesso a pld para banco dude"
sudo -u postgres psql -U postgres -d postgres -c "grant all privileges on database dude to pld;"

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

trilha "reload do bashrc"
exec bash

trilha "movendo settings.xml para diretorio do M2"
mv settings.xml .m2/settings.xml

trilha "configurando classpath para workspace do eclipse"
mvn -Declipse.workspace="$HOME/workspace" eclipse:configure-workspace