# import key
curl -Ss 'https://s3.amazonaws.com/rightscale_key_pub/rightscale_key.pub' > /etc/pki/rpm-gpg/RPM-GPG-KEY-rightscale
gpg --quiet --with-fingerprint /etc/pki/rpm-gpg/RPM-GPG-KEY-rightscale
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-rightscale

# Install some prereqs
yum -y install git lsb dig bind-utils bash git-core

# set the cloud
mkdir -p /etc/rightscale.d && echo -n none > /etc/rightscale.d/cloud

# add RightScale-epel repo
cat >/etc/yum.repos.d/RightScale-epel.repo<<-'EOF'
[rightscale-epel]
name=RightScale Software
baseurl=http://cf-mirror.rightscale.com/rightscale_software/epel/6/x86_64/archive/latest/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rightscale
EOF

yum install -y --skip-broken rightimage-extras
rpm -iv http://mirror.rightscale.com/rightscale_rightlink/latest/centos/rightscale_5.8.13-centos_6.4-x86_64.rpm
