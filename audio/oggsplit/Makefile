# Created by: Pav Lucistnik <pav@FreeBSD.org>
# $FreeBSD$

PORTNAME=	oggsplit
PORTVERSION=	0.1.0
PORTREVISION=	5
CATEGORIES=	audio
MASTER_SITES=	http://homepage.ntlworld.com/jfe1205/OggVorbis/

MAINTAINER=	ports@FreeBSD.org
COMMENT=	Split multiplexed (grouped or chained) Ogg files into separate streams

LIB_DEPENDS=	libogg.so:${PORTSDIR}/audio/libogg

USES=		gmake
NO_STAGE=	yes
USE_BZIP2=	yes
USE_AUTOTOOLS=	automake autoconf
AUTOMAKE_ARGS=	--add-missing
CONFIGURE_ARGS=	--with-ogg=${LOCALBASE}

MAN1=		oggsplit.1
PLIST_FILES=	bin/oggsplit

pre-configure:
	@(cd ${CONFIGURE_WRKSRC} && ${SETENV} ${AUTOTOOLS_ENV} ${ACLOCAL})

.include <bsd.port.mk>
