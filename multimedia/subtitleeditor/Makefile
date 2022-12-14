# Created by: Andrew Pantyukhin <infofarmer@FreeBSD.org>
# $FreeBSD$

PORTNAME=	subtitleeditor
PORTVERSION=	0.41.0
CATEGORIES=	multimedia
MASTER_SITES=	http://download.gna.org/${PORTNAME}/${PORTVERSION:C/\.[0-9]*$//}/ \
		CRITICAL

MAINTAINER=	ehaupt@FreeBSD.org
COMMENT=	Subtitle editor

LICENSE=	GPLv3

BUILD_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/iso-codes.pc:${PORTSDIR}/misc/iso-codes
RUN_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/iso-codes.pc:${PORTSDIR}/misc/iso-codes
LIB_DEPENDS=	gtkmm-2.4.1:${PORTSDIR}/x11-toolkits/gtkmm24 \
		glademm-2.4.1:${PORTSDIR}/devel/libglademm24 \
		gstreamermm-0.10.2:${PORTSDIR}/multimedia/gstreamermm \
		enchant:${PORTSDIR}/textproc/enchant \
		pcre:${PORTSDIR}/devel/pcre

USES=		gmake pkgconfig
USE_GCC=	yes
USE_GNOME=	gtk20
USE_GSTREAMER=	good
INSTALLS_ICONS=	yes
GNU_CONFIGURE=	yes

CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib

PLIST_SUB=	DESKTOPDIR="${DESKTOPDIR:S,^${PREFIX}/,,}"

OPTIONS_DEFINE=	NLS

.include <bsd.port.options.mk>

.if ${OPSYS} == FreeBSD && ${OSVERSION} >= 1000000
BROKEN=		Does not compile on FreeBSD 10.0 and later
.endif

.if ${PORT_OPTIONS:MNLS}
USES+=		gettext
PLIST_SUB+=	NLS=""
.else
CONFIGURE_ARGS+=--disable-nls
PLIST_SUB+=	NLS="@comment "
.endif

post-patch:
	@${REINPLACE_CMD} -e '/test/s|==|=|g' ${WRKSRC}/configure
	@${REINPLACE_CMD} -e 's|strtoll|strtoq|g' ${WRKSRC}/plugins/subtitleformats/advancedsubstationalpha/advancedsubstationalpha.cc

.include <bsd.port.mk>
