# Created by: Tilman Linneweh <arved@FreeBSD.org>
# $FreeBSD$

PORTNAME=	xmms-ladspa
PORTVERSION=	1.1
PORTREVISION=	4
CATEGORIES=	audio
MASTER_SITES=	http://www.ecs.soton.ac.uk/~njl98r/code/ladspa/ \
		${MASTER_SITE_LOCAL}
MASTER_SITE_SUBDIR=	arved
DISTNAME=	xmms_ladspa-${PORTVERSION}

MAINTAINER=	arved@FreeBSD.org
COMMENT=	XMMS Plugin that provides LADSPA Plugins to XMMS

LICENSE=	GPLv2
LICENSE_FILE=	${WRKSRC}/COPYING

BUILD_DEPENDS=	${LOCALBASE}/include/ladspa.h:${PORTSDIR}/audio/ladspa
LIB_DEPENDS=	libxmms.so:${PORTSDIR}/multimedia/xmms

PLIST_FILES=	lib/xmms/Effect/ladspa.so

USE_GNOME=	gtk12
NO_STAGE=	yes

do-install:
	@${INSTALL_DATA} ${WRKSRC}/ladspa.so ${PREFIX}/lib/xmms/Effect/

.include <bsd.port.mk>
