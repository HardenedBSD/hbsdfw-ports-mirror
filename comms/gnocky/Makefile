# Created by: Alexey Dokuchaev <danfe@FreeBSD.org>
# $FreeBSD$

PORTNAME=	gnocky
PORTVERSION=	0.0.7
PORTREVISION=	2
CATEGORIES=	comms
MASTER_SITES=	http://www.gnokii.org/download/gnocky/

MAINTAINER=	ports@FreeBSD.org
COMMENT=	Graphical (GTK+2) frontend for gnokii

LIB_DEPENDS=	libgnokii.so:${PORTSDIR}/comms/gnokii

USES=		pkgconfig
USE_BZIP2=	yes
USE_GNOME=	gtk20 libglade2
GNU_CONFIGURE=	yes
CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib

OPTIONS_DEFINE=	NLS

NO_STAGE=	yes
.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MNLS}
USES+=		gettext
PLIST_SUB+=	NLS=""
.else
CONFIGURE_ARGS+=	--disable-nls
PLIST_SUB+=	NLS="@comment "
.endif

.include <bsd.port.mk>
