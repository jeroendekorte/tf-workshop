sudo cat > /etc/yum.repos.d/MariaDB.repo <<'EOP'
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.0/centos6-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1

EOP

sudo yum install MariaDB-server MariaDB-client
sudo /etc/init.d/mysql start