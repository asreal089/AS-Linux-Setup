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


trilha "baixando arquivos de Ambiente java AML"
curl http://mailing.amlconsulting.com.br/arquivos/arquivosPaulo.tar.gz --output ambienteJava.tar.gz

trilha "Descompactando ambienteJava"
tar xvzf ambienteJava.tar.gz -C $PWD

trila "criando Diretorio para instalações de ambienteJava da AML"
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

