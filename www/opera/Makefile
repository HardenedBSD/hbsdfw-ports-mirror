# $FreeBSD$

PORTNAME=	opera
PORTVERSION=	${OPERA_VER}
CATEGORIES=	www ipv6
MASTER_SITES=	ftp://ftp.opera.com/pub/opera/${MASTER_SITES_VER_PATH}/ \
		ftp://opera.inode.at/${MASTER_SITES_VER_PATH}/ \
		http://gd.tuwien.ac.at/infosys/browsers/opera/${MASTER_SITES_VER_PATH}/ \
		ftp://opera.ftp.fu-berlin.de/${MASTER_SITES_VER_PATH}/ \
		http://ftp.ntua.gr/pub/www/Opera/${MASTER_SITES_VER_PATH}/ \
		http://mirrors.dedipower.com/opera/${MASTER_SITES_VER_PATH}/ \
		ftp://ftp.tiscali.nl/pub/mirrors/opera/${MASTER_SITES_VER_PATH}/ \
		${MASTER_SITE_RINGSERVER:S,%SUBDIR%,net/www/opera/${MASTER_SITES_VER_PATH}&,}/
DISTNAME=	${PORTNAME}-${OPERA_VER}-${OPERA_BUILD}.${ARCH}.freebsd

MAINTAINER=	dinoex@FreeBSD.org
COMMENT=	Blazingly fast, full-featured, standards-compliant browser

LIB_DEPENDS=	libfreetype.so:${PORTSDIR}/print/freetype2 \
		libfontconfig.so:${PORTSDIR}/x11-fonts/fontconfig
BUILD_DEPENDS=	${LOCALBASE}/bin/update-mime-database:${PORTSDIR}/misc/shared-mime-info
RUN_DEPENDS=	${LOCALBASE}/bin/update-mime-database:${PORTSDIR}/misc/shared-mime-info

NO_STAGE=	yes

OPERA_VER?=	12.16
OPERA_BUILD?=	1860
MASTER_SITES_VER_PATH=	unix/${OPERA_VER:S/.//}

USES=		desktop-file-utils
USE_XZ=		yes
USE_XORG=	x11 xext sm ice xft xrender
INSTALLS_ICONS=	yes

MAN1=		opera.1
MANCOMPRESSED=	yes

NO_BUILD=	yes
EXPLICIT_PACKAGE_DEPENDS=	yes

OPTIONS_DEFINE=	CUPS VIDEO GTK2 KDE4 COMPAT9
OPTIONS_DEFAULT=	CUPS VIDEO
NO_OPTIONS_SORT=yes

CUPS_DESC=	support for printing (requires CUPS)
VIDEO_DESC=	support for HTML5 video (requires GStreamer)
COMPAT9_DESC=	use libstdc++.so.6 from compat9x instead of gcc46

CUPS_LIB_DEPENDS=	libcups.so:${PORTSDIR}/print/cups-client

.include <bsd.port.options.mk>

.if defined(FETCH_ALL)
# distfiles for both arch
.if ${ARCH} == i386
DISTFILES=	${PORTNAME}-${OPERA_VER}-${OPERA_BUILD}.amd64.freebsd${EXTRACT_SUFX} \
		${DISTNAME}${EXTRACT_SUFX}
.else
DISTFILES=	${DISTNAME}${EXTRACT_SUFX} \
		${PORTNAME}-${OPERA_VER}-${OPERA_BUILD}.i386.freebsd${EXTRACT_SUFX}
.endif
.endif

.if ${PORT_OPTIONS:MVIDEO}
USE_GSTREAMER+=	vorbis ogg theora vp8 good
.endif

.if ${PORT_OPTIONS:MGTK2}
USE_GNOME+=	gtk20
.endif

.if ${PORT_OPTIONS:MKDE4}
USE_KDE4+=	kdelibs
.endif

.include <bsd.port.pre.mk>

ONLY_FOR_ARCHS=	i386 amd64

OPERA_ARCH=	${ARCH:S,i386,intel,}

.if ${OSVERSION} < 700000
IGNORE=		only for FreeBSD 7.x and higher
.endif

.if ${OSVERSION} >= 1000054
.if ${PORT_OPTIONS:MCOMPAT9}
RUN_DEPENDS+=	${LOCALBASE}/lib/compat/libstdc++.so.6:${PORTSDIR}/misc/compat9x
.else
RUN_DEPENDS+=	${LOCALBASE}/lib/gcc46/libstdc++.so.6:${PORTSDIR}/lang/gcc46
.endif
.endif

post-extract:
	@${MV} ${WRKSRC}/share/man ${WRKSRC}/man

do-install:
	@${INSTALL_MAN} ${WRKSRC}/man/man1/${PORTNAME}.1.gz ${MANPREFIX}/man/man1/
	@${REINPLACE_CMD} -e 's|/usr/local|${PREFIX}|g' ${WRKSRC}/install
	@${REINPLACE_CMD} -e 's|share/man|man|g' ${WRKSRC}/install
	@(cd ${WRKSRC} && ./install --text --system --unattended)
	@${REINPLACE_CMD} -e 's|/usr/X11R6/lib/browser_plugins|${LOCALBASE}/lib/browser_plugins/symlinks/opera|g' \
		${DATADIR}/defaults/pluginpath.ini
	@${RM} ${DATADIR}/defaults/pluginpath.ini.bak
	-${LOCALBASE}/bin/update-desktop-database
	-${LOCALBASE}/bin/update-mime-database ${LOCALBASE}/share/mime

# target to build distinfo for both arch
makesum-all:
	make makesum FETCH_ALL=yes

.include <bsd.port.post.mk>
