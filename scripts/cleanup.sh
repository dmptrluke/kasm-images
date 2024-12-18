sudo docker rmi $(docker image ls -aq) >/dev/null 2>&1 || true
sudo rm -rf \
/usr/share/dotnet /usr/local/lib/android /opt/ghc \
/usr/local/share/powershell /usr/share/swift /usr/local/.ghcup \
/usr/lib/jvm || true
echo "some directories deleted"
sudo apt install aptitude -y >/dev/null 2>&1
sudo aptitude purge aria2 ansible azure-cli shellcheck rpm xorriso zsync \
esl-erlang firefox gfortran-8 gfortran-9 google-chrome-stable \
google-cloud-sdk imagemagick google-cloud-cli \
libmagickcore-dev libmagickwand-dev libmagic-dev ant ant-optional kubectl \
mercurial apt-transport-https mono-complete libmysqlclient \
unixodbc-dev yarn chrpath libssl-dev libxft-dev \
libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev \
snmp pollinate libpq-dev postgresql-client powershell ruby-full \
sphinxsearch subversion mongodb-org azure-cli microsoft-edge-stable \
-y -f >/dev/null 2>&1
sudo aptitude purge '~n ^mysql' -f -y >/dev/null 2>&1
sudo aptitude purge '~n ^php' -f -y >/dev/null 2>&1
sudo aptitude purge '~n ^dotnet' -f -y >/dev/null 2>&1
sudo apt-get autoremove -y >/dev/null 2>&1
sudo apt-get autoclean -y >/dev/null 2>&1
echo "some packages purged"
