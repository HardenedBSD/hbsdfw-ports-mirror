# Created by: Alejandro Pulver <alejandro@varnet.biz>
# $FreeBSD$

PORTNAME=	xmms-vumeter-skins
PORTVERSION=	0.9.1
PORTREVISION=	6
CATEGORIES=	x11-themes
MASTER_SITES=	http://vumeterplugin.sourceforge.net/skins/
DISTFILES=	X-skin.tar.bz2 \
		vumeter_by.tar.bz2 \
		vumeter_classic.tar.bz2 \
		vuskin.tar.bz2
DIST_SUBDIR=	${PORTNAME}

MAINTAINER=	ports@FreeBSD.org
COMMENT=	Additional skins for the XMMS Analog VUmeter plugin

RUN_DEPENDS=	${SKINSDIR}/default/skin.cfg:${PORTSDIR}/graphics/xmms-vumeter

USE_BZIP2=	yes
NO_BUILD=	yes
NO_WRKSUBDIR=	yes

SKINSDIR=	${PREFIX}/share/xmms/VU_Meter_skins
PLIST_SUB=	SKINSDIR="${SKINSDIR:S,^${PREFIX}/,,}"

NO_STAGE=	yes
post-extract:
	@${RM} -f ${WRKSRC}/X-skin/*.psd

do-install:
.for s in X-skin by classic vuskin
	${MKDIR} ${SKINSDIR}/${s}
	${INSTALL_DATA} ${WRKSRC}/${s}/* ${SKINSDIR}/${s}
.endfor

.include <bsd.port.mk>
