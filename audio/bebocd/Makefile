# Created by: Adam Weinberger <adamw@FreeBSD.org>
# $FreeBSD$

PORTNAME=	bebocd
PORTVERSION=	0.4
PORTREVISION=	12
CATEGORIES=	audio
MASTER_SITES=	SF/${PORTNAME}/${PORTNAME}/${PORTNAME}-${PORTVERSION}

MAINTAINER=	ports@FreeBSD.org
COMMENT=	GTK2 CD Player

LIB_DEPENDS=	libcdaudio.so:${PORTSDIR}/audio/libcdaudio

USE_XORG=	x11
USES=		gmake pathfix pkgconfig
USE_GNOME=	gtk20
GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	CPPFLAGS="-I${LOCALBASE}/include" \
		LDFLAGS="-L${LOCALBASE}/lib"

post-patch:
.if defined(CDROM) && exists(${CDROM})
	@${REINPLACE_CMD} -e "s|/dev/cdrom|${CDROM}|" ${WRKSRC}/src/main.h
.else
	@${ECHO_MSG} ""
	@${ECHO_MSG} "You can specify the default CD-ROM device by defining CDROM."
	@${ECHO_MSG} "For example, CDROM=\"/dev/acd0c\" make"
	@${ECHO_MSG} ""
.endif
	@${REINPLACE_CMD} -e "s|gpointer	data|gpointer	arg|" ${WRKSRC}/src/callbacks.c

.include <bsd.port.mk>
