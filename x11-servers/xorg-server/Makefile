# Created by: Eric Anholt <anholt@FreeBSD.org>
# $FreeBSD$

PORTNAME?=	xorg-server
PORTVERSION=	${XORG_VERSION}
PORTREVISION?=	${XORG_REVISION}
PORTEPOCH?=	1
CATEGORIES=	x11-servers
MASTER_SITES=	XORG
MASTER_SITE_SUBDIR=	individual/xserver
DISTNAME=	xorg-server-${PORTVERSION}

MAINTAINER=	x11@FreeBSD.org
COMMENT?=	X.Org X server and related programs

LIB_DEPENDS=	drm:${PORTSDIR}/graphics/libdrm
RUN_DEPENDS=	xkeyboard-config>=2.5:${PORTSDIR}/x11/xkeyboard-config \
		xkbcomp:${PORTSDIR}/x11/xkbcomp

XORG_CAT=	xserver
SLAVE_PORT?=	no

OPTIONS_DEFINE=	AIGLX SUID
OPTIONS_RADIO=	CONF
OPTIONS_RADIO_CONF= HAL DEVD
AIGLX_DESC=	Compile with Accelerated Indirect GLX support
SUID_DESC=	Install the Xorg server with setuid bit set
HAL_DESC=	Compile with HAL config support
DEVD_DESC=	Use devd for autoconfiguration of input devices (experimental)
OPTIONS_DEFAULT=AIGLX SUID HAL

OPTIONS_EXCLUDE_sparc64=	HAL

.include <bsd.port.options.mk>

.if defined(WITH_NEW_XORG)
XORG_VERSION=	1.12.4
XORG_REVISION=	4
PLIST_SUB+=	OLD="@comment " NEW=""
EXTRA_PATCHES+=	${FILESDIR}/extra-clang \
		${FILESDIR}/extra-configure \
		${FILESDIR}/extra-new-dix_dixfonts.c
.else
XORG_VERSION=	1.7.7
XORG_REVISION=	11
PLIST_SUB+=	OLD="" NEW="@comment "
EXTRA_PATCHES+=	${FILESDIR}/extra-Xext-xace.c \
		${FILESDIR}/extra-Xserver-os-xprintf.c \
		${FILESDIR}/extra-include_eventstr.h \
		${FILESDIR}/extra-os-utils.c \
		${FILESDIR}/extra-dix_events.c \
		${FILESDIR}/extra-Xserver-hw-xfree86-common-xf86Config.c \
		${FILESDIR}/extra-old-dix_dixfonts.c
.endif

USE_BZIP2=	yes
USES=		gmake perl5
USE_PERL5=	build
USE_GL=		gl
USE_XORG?=	xf86driproto glproto xdmcp x11 xkbfile xxf86misc xxf86vm xaw7 \
		xmu xt xpm xext randrproto renderproto fixesproto damageproto \
		dri2proto xcmiscproto xextproto xproto xtrans xf86miscproto \
		xf86vidmodeproto xf86bigfontproto scrnsaverproto bigreqsproto \
		resourceproto fontsproto inputproto xf86dgaproto \
		videoproto compositeproto trapproto recordproto xineramaproto \
		xinerama evieproto xfont fontenc xkbui pixman pciaccess

MAKE_JOBS_UNSAFE=	yes
USE_OPENSSL=	yes
CONFIGURE_ARGS?=--disable-dmx --disable-xvfb --disable-xnest \
		--without-xmlto --disable-docs --disable-devel-docs \
		--localstatedir=/var --without-dtrace --disable-xephyr \
		--enable-record=yes

.if ${SLAVE_PORT} == "no"
SUB_FILES=	pkg-install pkg-deinstall
MAN1=		Xorg.1 \
		Xserver.1 \
		cvt.1 \
		gtf.1
MAN4=		exa.4 \
		fbdevhw.4
MAN5=		xorg.conf.5

.if defined(WITH_NEW_XORG)
MAN5+=		xorg.conf.d.5
.endif
.else
# for slave ports we need to overwrite PLIST, so it doesn't overwrite
# PLIST_FILES, with the masterport plist.
PLIST=		${.CURDIR}/pkg-plist
.endif

NO_STAGE=	yes
.include <bsd.port.pre.mk>

.if defined(WITH_OPENSSL_BASE)
# The reason why I use this is cause openssl from base doesn't install a .pc file
# and configure will fail trying to find it. Setting both of those variables to
# a *non-empty* value by-passes the pkg-config check.
CONFIGURE_ENV=	SHA1_LIB="-L/usr/lib -lcrypto" SHA1_CFLAGS="-I/usr/include"
.endif

.if ${PORT_OPTIONS:MHAL}
LIB_DEPENDS+=	hal:${PORTSDIR}/sysutils/hal
CONFIGURE_ARGS+=	--enable-config-hal=yes
.else
CONFIGURE_ARGS+=	--enable-config-hal=no
.endif

.if ${PORT_OPTIONS:MDEVD}
EXTRA_PATCHES+=		${FILESDIR}/extra-config_devd.c
.endif

.if ${PORT_OPTIONS:MAIGLX}
CONFIGURE_ARGS+=	--enable-aiglx=yes
.else
CONFIGURE_ARGS+=	--enable-aiglx=no
.endif

.if ${PORT_OPTIONS:MSUID}
CONFIGURE_ARGS+=--enable-install-setuid=yes
.else
CONFIGURE_ARGS+=--enable-install-setuid=no
.endif

.if ${ARCH} == i386
.if defined(WITH_NEW_XORG)
EXTRA_PATCHES+=	${FILESDIR}/extra-new-arch-i386
.else
EXTRA_PATCHES+=	${FILESDIR}/extra-old-arch-i386
.endif
.endif

.if ${ARCH} == ia64
PLIST_SUB+=	IA64_NA="@comment "
EXTRA_PATCHES=	${.CURDIR}/files/extra-arch-ia64
.else
PLIST_SUB+=	IA64_NA=""
.endif

.if ${ARCH} == powerpc || ${ARCH} == powerpc64
PLIST_SUB+=	PPC_NA="@comment "
.if defined(WITH_NEW_XORG)
EXTRA_PATCHES=	${.CURDIR}/files/extra-new-arch-powerpc
.else
EXTRA_PATCHES=	${.CURDIR}/files/extra-old-arch-powerpc
.endif
.else
PLIST_SUB+=	PPC_NA=""
.endif

.if ${ARCH} == sparc64
PLIST_SUB+=	SPARC64=""
PLIST_SUB+=	SPARC64_NA="@comment "
.if defined(WITH_NEW_XORG)
EXTRA_PATCHES+=	${FILESDIR}/extra-new-arch-sparc64
.else
EXTRA_PATCHES+=	${FILESDIR}/extra-old-arch-sparc64
.endif
.else
PLIST_SUB+=	SPARC64="@comment "
PLIST_SUB+=	SPARC64_NA=""
.endif

.if ${ARCH} == amd64 || ${ARCH} == i386 || ${ARCH} == sparc64
PLIST_SUB+=	AMD64_I386_SPARC64=""
.else
PLIST_SUB+=	AMD64_I386_SPARC64="@comment "
.endif

.if ${PORT_OPTIONS:MSUID}
pre-everything::
	@${ECHO_MSG} "By default, the X Server installs as a set-user-id root binary. When run by"
	@${ECHO_MSG} "a normal user, it checks arguments and environment as done in the x11/wrapper"
	@${ECHO_MSG} "port before handling them normally.  If you are concerned about the security"
	@${ECHO_MSG} "of this, but still want to run an X Server (for example using xdm/kdm/gdm,"
	@${ECHO_MSG} "which will still run the server as root), you can cancel the build and set"
	@${ECHO_MSG} "xorg-server_UNSET=SUID in /etc/make.conf."
.endif

post-patch:
	@${REINPLACE_CMD} 's/test.*-traditional.*;/true;/' \
		${WRKSRC}/configure
# build libglx.so but don't install it yet. which is done in pre-install.
	@${REINPLACE_CMD} -e 's|@GLX_TRUE@GLXMODS =|@GLX_BOGUS@GLXMODS =|g' \
		-e 's|^LTLIBRARIES = |LTLIBRARIES = libglx.la |g' \
		${WRKSRC}/hw/xfree86/dixmods/Makefile.in
.if ${PORT_OPTIONS:MDEVD}
	@${ECHO_CMD} -e "\nint config_devd_init(void);\nvoid config_devd_fini(void);" \
		>> ${WRKSRC}/config/config-backends.h
.endif
 
post-configure:
.if ${PORT_OPTIONS:MDEVD}
	@${REINPLACE_CMD} -e 's|config\.c|config.c devd.c|g' \
		-e 's|config\.lo|config.lo devd.lo|g' \
		${WRKSRC}/config/Makefile
.endif

.if ${SLAVE_PORT} == "no"
pre-su-install:
# The .xorg dir because else the xorg-server might not load the correct 
# libglx module.
	${MKDIR} ${PREFIX}/lib/xorg/modules/extensions/.xorg
	${INSTALL_LIB} ${WRKSRC}/hw/xfree86/dixmods/.libs/libglx.so \
		${PREFIX}/lib/xorg/modules/extensions/.xorg/

post-install:
.if defined(WITH_NEW_XORG)
	@${MKDIR} ${PREFIX}/share/X11/xorg.conf.d
.endif
	@PKG_PREFIX=${PREFIX} ${SH} ${PKGINSTALL} ${PKGNAME} POST-INSTALL
.endif

.include <bsd.port.post.mk>
