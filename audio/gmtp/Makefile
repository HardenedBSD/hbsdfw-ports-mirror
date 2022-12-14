# $FreeBSD$

PORTNAME=	gmtp
PORTVERSION=	1.3.4
PORTREVISION=	2
CATEGORIES=	audio
MASTER_SITES=	SF/${PORTNAME}/gMTP-${PORTVERSION}/
DISTNAME=	${PORTNAME}-${PORTVERSION}-i386

MAINTAINER=	freebsd-ports-local@be-well.ilk.org
COMMENT=	Media Transfer Protocol (MTP) GUI client

LICENSE=	BSD

LIB_DEPENDS=	libmtp.so:${PORTSDIR}/audio/libmtp \
		libid3tag.so:${PORTSDIR}/audio/libid3tag \
		libFLAC.so:${PORTSDIR}/audio/flac \
		libvorbis.so:${PORTSDIR}/audio/libvorbis

WRKSRC=		${WRKDIR}/gMTP

CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib
USES=		gettext gmake pkgconfig
NO_STAGE=	yes
USE_GNOME=	glib20

PORTDOCS=	*

OPTIONS_DEFINE=	DOCS
OPTIONS_RADIO=	GTK
OPTIONS_RADIO_GTK=	GTK2 GTK3
OPTIONS_DEFAULT=	GTK2

.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MGTK2}
USE_GNOME+=	gtk20 gconf2
GCONF_SCHEMAS=	gmtp.schemas
ALL_TARGET=	gtk2
INSTALL_TARGET=	register-gconf-schemas
.endif

.if ${PORT_OPTIONS:MGTK3}
USE_GNOME+=	gtk30
GLIB_SCHEMAS=	org.gnome.gmtp.gschema.xml
ALL_TARGET=	gtk3
INSTALL_TARGET=	register-gsettings-schemas
.endif

post-install:
.if ${PORT_OPTIONS:MDOCS}
	cd ${WRKSRC} && ${GMAKE} install-doc
.endif

.include <bsd.port.mk>
