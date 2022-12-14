# Created by: trevor
# $FreeBSD$

PORTNAME=	celestia
PORTVERSION=	1.6.1
PORTREVISION=	3
CATEGORIES=	astro
MASTER_SITES=	SF/${PORTNAME}/Celestia-source/${PORTVERSION}
PKGNAMESUFFIX=	-${CELESTIA_UI}

MAINTAINER=	danfe@FreeBSD.org
COMMENT=	Scriptable space flight simulator for X11

LICENSE=	GPLv2

LIB_DEPENDS=	libjpeg.so:${PORTSDIR}/graphics/jpeg \
		libpng15.so:${PORTSDIR}/graphics/png

NO_STAGE=	yes
USES=		gettext gmake pkgconfig
USE_AUTOTOOLS=	libtool
USE_GL=		gl
USE_LUA=	5.0+	# should be optional, but the build fails without it
WANT_GNOME=	yes

CXXFLAGS+=	-fsigned-char	# fix text rendering (see Gentoo bug 316573)
CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib -pthread

UI_LIST=	glut gtk gnome
CELESTIA_UI?=	glut
CONFLICTS=	${UI_LIST:S|${CELESTIA_UI}||:S|^|celestia-|:S|$|-[0-9]*|}

# Celestia provides different UI frontends; you should pick one that suits
# you best by setting CELESTIA_UI variable.  Possible values are:
#
# glut	Bare-boned minimal GLUT-based core with no toolbar or menu (this is
#	the default one);
# gtk	Full interface with minimal dependencies: adds menu, configuration
#	dialog, some other utilities;
# gnome	Full GTK interface plus a few GNOME integration goodies, such as
#	preference saving in GConf (this looks and works very much like
#	the Windows interface).
#
.if ${CELESTIA_UI} == "glut"
CONFIGURE_ARGS+=	--with-glut
USE_GL+=	glut
.elif ${CELESTIA_UI} == "gtk"
CONFIGURE_ARGS+=	--with-gtk
USE_GNOME+=	gtk20
.elif ${CELESTIA_UI} == "gnome"
CATEGORIES+=	gnome
CONFIGURE_ARGS+=	--with-gnome
USE_GNOME+=	libgnomeui
GCONF_SCHEMAS=	celestia.schemas
.else
IGNORE=		requires one of the <${UI_LIST}> values for CELESTIA_UI
.endif

.if ${CELESTIA_UI} == "gtk" || ${CELESTIA_UI} == "gnome"
USE_GNOME+=	gnomehack
LIB_DEPENDS+=	libgtkglext-x11-1.so:${PORTSDIR}/x11-toolkits/gtkglext \
		theora:${PORTSDIR}/multimedia/libtheora
STARTUP_NOTIFY=	true
PLIST_FILES+=	share/celestia/celestia-logo.png share/celestia/celestiaui.xml
.else
STARTUP_NOTIFY=	false
.endif

PORTDOCS=	AUTHORS ChangeLog README

DESKTOP_ENTRIES="Celestia" "Explore the space" \
		"${PREFIX}/share/pixmaps/celestia.png" "celestia" \
		"Astronomy;Education;Science;" ${STARTUP_NOTIFY}

OPTIONS_DEFINE=	DOCS

.include <bsd.port.options.mk>

post-patch:
# Fix Lua discovery pkg-config(1) calls
	@${REINPLACE_CMD} -E 's|lua5\.?|lua-5.|' ${WRKSRC}/configure
# Remove controversial compiler options (respect our C[XX]FLAGS)
.for o in O2 ffast-math fexpensive-optimizations fomit-frame-pointer
	@${REINPLACE_CMD} -e 's|-${o}||g' ${WRKSRC}/configure
.endfor
# Allow add-ons to be placed inside user's home directory
	@${REINPLACE_CMD} -e '/^#/!s|"extras"|& "~/.celestia"|' \
		${WRKSRC}/celestia.cfg
# Inhibit installation of copies of GPL (lots of them; use LICENSE framework
# instead) and remove bogus argument from mv(1)
	@${REINPLACE_CMD} -e 's|COPYING||g ; s| -b|| ' ${WRKSRC}/Makefile.in
	@${REINPLACE_CMD} -e 's|=.*COPYING_\*)|=| ; \
		/KDE_DIST/s|COPYING_[^ ]* ||g' ${WRKSRC}/locale/Makefile.in
	@${REINPLACE_CMD} -e 's|kde_libs_htmldir|kde_htmldir|' \
		${WRKSRC}/src/celestia/kde/doc/celestia/Makefile.in

post-install:
# Technically, we should only install icon explicitly for GLUT UI, since
# correct icons are properly installed for other cases, but doing it here
# does not hurt and simplifies PLIST handling
	${INSTALL_DATA} ${WRKSRC}/src/celestia/gtk/data/celestia.png \
		${PREFIX}/share/pixmaps
.if ${PORT_OPTIONS:MDOCS}
	@${MKDIR} ${DOCSDIR}
	${INSTALL_DATA} ${PORTDOCS:S|^|${WRKSRC}/|} ${DOCSDIR}
.endif

.include <bsd.port.mk>
