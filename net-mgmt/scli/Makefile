# Created by: Michael Lyngb?l <lyngbol@wheel.dk>
# $FreeBSD$

PORTNAME=	scli
PORTVERSION=	0.3.1
PORTREVISION=	1
CATEGORIES=	net-mgmt
MASTER_SITES=	ftp://ftp.ibr.cs.tu-bs.de/local/${PORTNAME}/ \
		http://matt.peterson.org/FreeBSD/ports/

MAINTAINER=	lyngbol@wheel.dk
COMMENT=	A collection of SNMP command line management tools

LIB_DEPENDS=	gsnmp:${PORTSDIR}/net-mgmt/gsnmp

GNU_CONFIGURE=	yes
USES=		gmake pkgconfig
USE_GNOME=	libxml2

MAN1=		scli.1
INFO=		scli
PLIST_FILES=	bin/scli

NO_STAGE=	yes
.include <bsd.port.mk>
