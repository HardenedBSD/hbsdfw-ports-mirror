# Created by: Joe Marcus Clarke <marcus@FreeBSD.org>
# $FreeBSD$
#   $MCom: ports/net/avahi-app/Makefile,v 1.25 2012/09/01 23:02:11 mezz Exp $

PORTNAME=	avahi
PORTVERSION=	0.6.31
PORTREVISION?=	0
CATEGORIES?=	net dns
MASTER_SITES=	http://www.avahi.org/download/
PKGNAMESUFFIX?=	-app

MAINTAINER?=	gnome@FreeBSD.org
COMMENT?=	Service discovery on a local network

AVAHI_SLAVE?=	no

.if ${AVAHI_SLAVE} != header
LIB_DEPENDS?=	libexpat.so:${PORTSDIR}/textproc/expat2 \
		libdaemon.so:${PORTSDIR}/devel/libdaemon \
		libdbus-glib-1.so:${PORTSDIR}/devel/dbus-glib \
		libgdbm.so:${PORTSDIR}/databases/gdbm

USERS?=		${PORTNAME}
GROUPS?=	${USERS}

USE_GNOME+=	ltverhack glib20 intltool introspection
USES=		gettext gmake pathfix pkgconfig
USE_GNOME_SUBR=	yes
USE_AUTOTOOLS=	libtool
USE_LDCONFIG=	yes
CONFIGURE_ARGS?=--with-distro=freebsd \
		--with-dbus-system-socket=unix:path=/var/run/dbus/system_bus_socket \
		--disable-monodoc \
		--disable-doxygen-doc \
		--disable-doxygen-dot \
		--disable-qt3 \
		--localstatedir=/var \
		--enable-compat-howl
CPPFLAGS+=	-I${LOCALBASE}/include -DHAVE_KQUEUE
LDFLAGS+=	-L${LOCALBASE}/lib

.if ${AVAHI_SLAVE} == no
CONFLICTS=	howl-[0-9]*

DAEMON_CONFIG_FILES=	hosts avahi-daemon.conf
.endif

USE_RC_SUBR=yes
.endif # !avahi-header

.include <bsd.port.options.mk>

.if ${AVAHI_SLAVE} != header
.if ${AVAHI_SLAVE} == autoipd
CONFIGURE_ARGS+=--enable-autoipd
.else
CONFIGURE_ARGS+=--disable-autoipd
.endif
.if ${AVAHI_SLAVE} == gtk
CONFIGURE_ARGS+=--enable-gtk
.else
CONFIGURE_ARGS+=--disable-gtk
.endif
.if ${AVAHI_SLAVE} == gtk3
CONFIGURE_ARGS+=--enable-gtk3
.else
CONFIGURE_ARGS+=--disable-gtk3
.endif
.if ${AVAHI_SLAVE} == libdns
CONFIGURE_ARGS+=--enable-compat-libdns_sd
.else
CONFIGURE_ARGS+=--disable-compat-libdns_sd
.endif
.if ${AVAHI_SLAVE} == python
CONFIGURE_ARGS+=--enable-python
.else
CONFIGURE_ARGS+=--disable-python
.endif
.if ${AVAHI_SLAVE} == qt4
CONFIGURE_ARGS+=--enable-qt4 \
		--disable-expat \
		--disable-gdbm
.else
CONFIGURE_ARGS+=--disable-qt4
.endif
.if ${AVAHI_SLAVE} == sharp
CONFIGURE_ARGS+=--enable-mono
.else
CONFIGURE_ARGS+=--disable-mono
.endif

post-patch: avahi-post-patch

avahi-post-patch:
	@${REINPLACE_CMD} -e 's|/etc|${PREFIX}/etc|' \
		${WRKSRC}/man/*.*
	@${RM} -f ${WRKSRC}/man/*.bak
	@${REINPLACE_CMD} -e 's|-ldl||g ; s|netdev|network|g' \
		${WRKSRC}/configure \
		${WRKSRC}/avahi-client/Makefile.in \
		${WRKSRC}/avahi-daemon/Makefile.in
	@${REINPLACE_CMD} -e 's|have_inotify=yes|have_inotify=no|' \
		${WRKSRC}/configure
	@${FIND} ${WRKSRC} -name Makefile.in | ${XARGS} \
	    	${REINPLACE_CMD} -e 's|(LIBINTL)|(INTLLIBS)|g ; \
		s|(LIBICONV)|(LTLIBICONV)|g'
	@${REINPLACE_CMD} -e 's|%%RC_SUBR%%|/etc/rc.subr| ; \
	    	s|%%GNOME_SUBR%%|${GNOME_SUBR}|' \
		${WRKSRC}/initscript/freebsd/avahi-dnsconfd.sh.in \
		${WRKSRC}/initscript/freebsd/avahi-daemon.sh.in
	@${REINPLACE_CMD} -e 's|dbus_connection_disconnect|dbus_connection_close|g' \
	    	${WRKSRC}/avahi-client/client.c \
		${WRKSRC}/avahi-daemon/dbus-protocol.c
	@${REINPLACE_CMD} -e 's|^_||g' \
		${WRKSRC}/avahi-ui/*.desktop.in.in
	@${REINPLACE_CMD} -e 's|am: install-avahiincludeHEADERS|am:|g' \
			${WRKSRC}/avahi-ui/Makefile.in

post-build: avahi-post-build

avahi-post-build:
.for f in ${AVAHI_PKGCONFIG}
	@cd ${WRKSRC} && ${SETENV} ${MAKE_ENV} ${GMAKE} \
		${MAKE_FLAGS} ${MAKEFILE} ${MAKE_ARGS} ${f}
.endfor

pre-su-install: avahi-pre-su-install

avahi-pre-su-install:
.if ${AVAHI_SLAVE}=="no"
	@${MKDIR} ${STAGEDIR}${PREFIX}/lib/avahi
	@${TOUCH} -f ${STAGEDIR}${PREFIX}/lib/avahi/.keep
.endif

post-install: avahi-post-install

avahi-post-install:
.if defined(MANPAGES)
.for f in ${MANPAGES}
	${INSTALL_DATA} ${WRKSRC}/man/${f} ${STAGEDIR}${PREFIX}/man/man${f:E}/${f}
.endfor
.endif
.for f in ${AVAHI_PKGCONFIG}
	${INSTALL_DATA} ${WRKSRC}/${f} ${STAGEDIR}${PREFIX}/libdata/pkgconfig
.endfor
	${MKDIR} ${STAGEDIR}${PREFIX}/etc/avahi
.for f in ${DAEMON_CONFIG_FILES}
	${INSTALL_DATA} ${WRKSRC}/avahi-daemon/${f} \
		${STAGEDIR}${PREFIX}/etc/avahi/${f}.dist
.endfor
.if ${AVAHI_SLAVE}==no
	${INSTALL_DATA} ${FILESDIR}/org.freedesktop.Avahi.service \
		${STAGEDIR}${PREFIX}/share/dbus-1/system-services
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/lib*.so*
.elif ${AVAHI_SLAVE}==gtk3
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/libavahi-ui-gtk3.so.0
.elif ${AVAHI_SLAVE}==libdns
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/libdns_sd.so.1
.elif ${AVAHI_SLAVE}==qt4
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/libavahi-qt4.so.1
.endif
.endif # avahi-header

.include <bsd.port.mk>
