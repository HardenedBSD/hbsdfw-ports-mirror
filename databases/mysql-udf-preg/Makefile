# $FreeBSD$

PORTNAME=	mysql-udf-preg
PORTVERSION=	1.0.1
PORTREVISION=	2
CATEGORIES=	databases
MASTER_SITES=	http://www.mysqludf.org/lib_mysqludf_preg/
DISTNAME=	lib_mysqludf_preg-${PORTVERSION}

MAINTAINER=	ports@FreeBSD.org
COMMENT=	Library of MySQL UDFs providing access to PCRE

LIB_DEPENDS=	libpcre.so:${PORTSDIR}/devel/pcre

GNU_CONFIGURE=	yes
CONFIGURE_ARGS+=	--libdir=${PREFIX}/lib/mysql/plugin
USE_GMAKE=	yes
USE_MYSQL=	yes

USE_LDCONFIG=	yes

WRKSRC=	${WRKDIR}/lib_mysqludf_preg-${PORTVERSION}

PLIST_FILES=	lib/mysql/plugin/lib_mysqludf_preg.a \
				lib/mysql/plugin/lib_mysqludf_preg.la \
				lib/mysql/plugin/lib_mysqludf_preg.so \
				%%DATADIR%%/installdb.sql \
				%%DATADIR%%/uninstalldb.sql
PLIST_DIRS=	${DATADIR_REL} lib/mysql/plugin

NO_STAGE=	yes
post-install:
	${MKDIR} ${DATADIR}/
	${INSTALL_DATA} ${WRKSRC}/installdb.sql ${DATADIR}/
	${INSTALL_DATA} ${WRKSRC}/uninstalldb.sql ${DATADIR}/
	${CAT} ${PKGMESSAGE}

.include <bsd.port.mk>
