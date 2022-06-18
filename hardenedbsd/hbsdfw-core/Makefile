# $FreeBSD$

PORTNAME=	hbsdfw-core
PORTVERSION=	1.0
CATEGORIES=	hardenedbsd
PKGNAMEPREFIX=	${PHP_PKGNAMEPREFIX}

MAINTAINER=	shawn.webb@hardenedbsd.org
COMMENT=	HardenedBSD Firewall Core package

LICENSE=	BSD2CLAUSE

IGNORE_WITH_PHP=	80 81

OPNSENSE_PORT_REV=	1

RUN_DEPENDS=	beep>=0:audio/beep \
		ca_root_nss>=0:security/ca_root_nss \
		choparp>=0:net-mgmt/choparp \
		cpustats>=0:opnsense/cpustats \
		dhcp6c>=0:opnsense/dhcp6c \
		dhcpleases>=0:opnsense/dhcpleases \
		dnsmasq>=0:dns/dnsmasq \
		dpinger>=0:net/dpinger \
		easy-rsa>=0:security/easy-rsa \
		filterlog>=0:opnsense/filterlog \
		ifinfo>=0:opnsense/ifinfo \
		iftop>=0:net-mgmt/iftop \
		flashrom>=0:sysutils/flashrom \
		flock>=0:sysutils/flock \
		flowd>=0:net-mgmt/flowd \
		git>=0:devel/git \
		hostapd>=0:net/hostapd \
		isc-dhcp44-relay>=0:net/isc-dhcp44-relay \
		isc-dhcp44-server>=0:net/isc-dhcp44-server \
		jq>=0:textproc/jq \
		lang>=0:opnsense/lang \
		lighttpd>=0:www/lighttpd \
		monit>=0:sysutils/monit \
		mpd5>=0:net/mpd5 \
		nmap>=0:security/nmap \
		ntp>=0:net/ntp \
		openssh-portable>=0:security/openssh-portable \
		openvpn>=0:security/openvpn \
		update>=0:opnsense/update \
		pam_opnsense>=0:opnsense/pam_opnsense \
		pftop>=0:sysutils/pftop \
		radvd>=0:net/radvd \
		rate>=0:net-mgmt/rate \
		rrdtool>=0:databases/rrdtool \
		samplicator>=0:net/samplicator \
		smartmontools>=0:sysutils/smartmontools \
		squid>=0:www/squid \
		sudo>=0:security/sudo \
		syslog-ng>=0:sysutils/syslog-ng \
		unbound>=0:dns/unbound \
		vim>=0:editors/vim \
		vnstat>=0:net/vnstat \
		wpa_supplicant>=0:security/wpa_supplicant \
		zip>=0:archivers/zip \
		zsh>=0:shells/zsh \
		${PYTHON_PKGNAMEPREFIX}Jinja2>=0:devel/py-Jinja2@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}dnspython>=0:dns/py-dnspython@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}netaddr>=0:net/py-netaddr@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}requests>=0:www/py-requests@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}sqlite3>=0:databases/py-sqlite3@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}ujson>=0:devel/py-ujson@${PY_FLAVOR} \
		${PHP_PKGNAMEPREFIX}phalcon>=0:www/phalcon \
		${PHP_PKGNAMEPREFIX}pecl-radius>=0:net/pecl-radius \
		${PHP_PKGNAMEPREFIX}ctype>=0:textproc/${PHP_PKGNAMEPREFIX}ctype \
		${PHP_PKGNAMEPREFIX}curl>=0:ftp/${PHP_PKGNAMEPREFIX}curl \
		${PHP_PKGNAMEPREFIX}dom>=0:textproc/${PHP_PKGNAMEPREFIX}dom \
		${PHP_PKGNAMEPREFIX}filter>=0:security/${PHP_PKGNAMEPREFIX}filter \
		${PHP_PKGNAMEPREFIX}gettext>=0:devel/${PHP_PKGNAMEPREFIX}gettext \
		${PHP_PKGNAMEPREFIX}google-api-php-client>=0:opnsense/google-api-php-client \
		${PHP_PKGNAMEPREFIX}json>=0:devel/${PHP_PKGNAMEPREFIX}json \
		${PHP_PKGNAMEPREFIX}ldap>=0:net/${PHP_PKGNAMEPREFIX}ldap \
		${PHP_PKGNAMEPREFIX}openssl>=0:security/${PHP_PKGNAMEPREFIX}openssl \
		${PHP_PKGNAMEPREFIX}pdo>=0:databases/${PHP_PKGNAMEPREFIX}pdo \
		${PHP_PKGNAMEPREFIX}session>=0:www/${PHP_PKGNAMEPREFIX}session \
		${PHP_PKGNAMEPREFIX}simplexml>=0:textproc/${PHP_PKGNAMEPREFIX}simplexml \
		${PHP_PKGNAMEPREFIX}sockets>=0:net/${PHP_PKGNAMEPREFIX}sockets \
		${PHP_PKGNAMEPREFIX}sqlite3>=0:databases/${PHP_PKGNAMEPREFIX}sqlite3 \
		${PHP_PKGNAMEPREFIX}xml>=0:textproc/${PHP_PKGNAMEPREFIX}xml \
		${PHP_PKGNAMEPREFIX}phpseclib>=0:opnsense/phpseclib \
		${PHP_PKGNAMEPREFIX}mbstring>=0:converters/${PHP_PKGNAMEPREFIX}mbstring

USES=	python:3.8 php:flavors shebangfix
USE_PHP=	curl zlib sockets

USE_GITLAB= yes
GL_SITE=    https://git.hardenedbsd.org
GL_ACCOUNT= hbsdfw
GL_PROJECT= core
GL_COMMIT=  84ef409b028c1d5e1877d332762a3e3ea960b287

SHEBANG_FILES=	src/opnsense/scripts/systemhealth/fetchData.py \
		src/opnsense/scripts/systemhealth/activity.py \
		src/opnsense/scripts/systemhealth/flush_rrd.py \
		src/opnsense/scripts/systemhealth/listReports.py

MAKE_ENV+=	VERSION=${PORTVERSION}

do-build:
	(cd ${WRKSRC} && make install DESTDIR=${STAGEDIR} FLAVOUR=OpenSSL VERSION=${PORTVERSION})

post-install:
	${CP} ${STAGEDIR}/${LOCALBASE}/etc/config.xml.sample ${STAGEDIR}/${LOCALBASE}/etc/config.xml
	${CP} ${STAGEDIR}/${LOCALBASE}/etc/bogons.sample ${STAGEDIR}/${LOCALBASE}/etc/bogons
	${CP} ${STAGEDIR}/${LOCALBASE}/etc/bogonsv6.sample ${STAGEDIR}/${LOCALBASE}/etc/bogonsv6
	${CP} ${STAGEDIR}/${LOCALBASE}/opnsense/service/templates/OPNsense/IDS/custom.yaml.sample ${STAGEDIR}/${LOCALBASE}/opnsense/service/templates/OPNsense/IDS/custom.yaml

.include <bsd.port.mk>
