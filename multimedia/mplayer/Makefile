# Created by: Thomas E. Zander with help from Vladimir Kushnir
# $FreeBSD$

PORTNAME=	mplayer
PORTVERSION=	${MPLAYER_PORT_VERSION}
PORTREVISION=	1

COMMENT=	High performance media player supporting many formats

.include "${.CURDIR}/Makefile.shared"

OPTIONS_DEFINE=	AALIB AMR_NB AMR_WB BLURAY CACA DEBUG DV \
		ENCA ESOUND FRIBIDI GIF GSM GUI IPV6 JACK \
		LADSPA LIBMNG LIRC LZO NAS OCFLAGS \
		OPENAL OPENGL OPENJPEG OPUS OTCHAIN \
		PULSEAUDIO REAL RTC RTCPU RTMP SCHROEDINGER SDL \
		SKINS SMB SVGALIB V4L VDPAU WIN32 \
		X11 X11DGA X11VM XINERAMA XVIDEO XVMC

OPTIONS_RADIO=	RGCD
OPTIONS_RADIO_RGCD=	CDIO CDPARANOIA

OPTIONS_DEFAULT=GUI IPV6 OCFLAGS OPENGL RTCPU SKINS \
		WIN32 X11 X11DGA X11VM XINERAMA XVIDEO

BLURAY_DESC?=	BluRay support
ENCA_DESC?=	Charset conversion via enca
LZO_DESC?=	External liblzo support
OCFLAGS_DESC?=	Use optimized compiler flags
OPUS_DESC?=	Opus decoding with libopus
OTCHAIN_DESC?=	Use gcc 4.6+ toolchain on legacy systems
REAL_DESC?=	Enable realplayer plugin
RTC_DESC?=	Add support for kernel real time clock
RTCPU_DESC?=	Use runtime CPU detection
SKINS_DESC?=	Install skins for GUI
WIN32_DESC?=	Install win32 binary codecs
X11DGA_DESC?=	X11 DGA video driver support
X11VM_DESC?=	X11 VidMode support

SUB_FILES=	pkg-message

CONFFILES=	example.conf input.conf menu.conf dvb-menu.conf
USES+=		pkgconfig

.include "${.CURDIR}/Makefile.optvars"
.include <bsd.port.options.mk>
.include <bsd.port.pre.mk>

CONFIGURE_ARGS+=	--disable-arts \
			--disable-directfb \
			--disable-faac \
			--disable-libdca \
			--disable-toolame \
			--disable-twolame \
			--disable-x264 \
			--disable-xvid \
			--disable-libdirac-lavc \
			--disable-mencoder \
			--disable-mpg123 \
			--disable-musepack \
			--disable-theora

.include "${.CURDIR}/Makefile.options"

.if ${PORT_OPTIONS:MGUI} && ${PORT_OPTIONS:MX11}
PLIST_SUB+=	GMPLAYER=""
DESKTOP_ENTRIES=	"MPlayer" "High performance media player" "mplayer" "gmplayer" "" false
.if ${PORT_OPTIONS:MSKINS}
RUN_DEPENDS+=	${LOCALBASE}/share/mplayer/skins:${PORTSDIR}/multimedia/mplayer-skins
.endif

USE_GNOME+=	gtk20
CONFIGURE_ARGS+=	--enable-gui

.if defined(WITH_LANG)
WITH_LANG=	""
.endif

.else
PLIST_SUB+=	GMPLAYER="@comment "
.endif #GUI && X11

.if ${PORT_OPTIONS:MX11}
USE_XORG=	x11 xscrnsaver
.if ${PORT_OPTIONS:MXVIDEO}
USE_XORG+=	xv
.else
CONFIGURE_ARGS+=--disable-xv
.endif
.if ${PORT_OPTIONS:MX11DGA}
USE_XORG+=	xxf86dga
.else
CONFIGURE_ARGS+=--disable-dga1 --disable-dga2
.endif
.if ${PORT_OPTIONS:MOPENGL}
USE_XORG+=	glproto
LIB_DEPENDS+=	libGL.so:${PORTSDIR}/graphics/libGL
.else
CONFIGURE_ARGS+=--disable-gl
.endif
.if ${PORT_OPTIONS:MXINERAMA}
USE_XORG+=	xinerama xineramaproto
.else
CONFIGURE_ARGS+=--disable-xinerama
.endif
.if ${PORT_OPTIONS:MX11VM}
USE_XORG+=	xxf86vm
.else
CONFIGURE_ARGS+=--disable-vm
.endif
.if ${PORT_OPTIONS:MXVMC}
USE_XORG+=	xvmc
CONFIGURE_ARGS+=--enable-xvmc --with-xvmclib=XvMCW
.endif
.else	#X11
CONFIGURE_ARGS+=--disable-x11 \
		--disable-fontconfig
.endif

pre-everything::
	@${ECHO_MSG} "N - O - T - E"
	@${ECHO_MSG} ""
	@${ECHO_MSG} "There are some knobs which *can* *not* be selected via the"
	@${ECHO_MSG} "OPTIONS framework. At the moment, their defaults are:"
	@${ECHO_MSG} "WITH_LANG=<LanguageCode>"
	@${ECHO_MSG} "WITH_KERN_HZ=1024"
	@${ECHO_MSG} "DEFAULT_DVD_DEVICE=/dev/cd0"
	@${ECHO_MSG} "DEFAULT_CDROM_DEVICE=/dev/cd0"

.if ${PORT_OPTIONS:MGUI} && ${PORT_OPTIONS:MX11}
	@${ECHO_MSG} "If you want to use the GUI, you can use the skins from"
	@${ECHO_MSG} "${PORTSDIR}/multimedia/mplayer-skins"
	@${ECHO_MSG} "or download them from"
	@${ECHO_MSG} "http://www.mplayerhq.hu/"
.endif

post-patch:
.if ${OSVERSION} >= 900010
	@${REINPLACE_CMD} -e \
		'/CFLAGS.*-D_LARGEFILE64_SOURCE/ s/-D_LARGEFILE64_SOURCE/-D_FILE_OFFSET_BITS=64/' \
		${CONFIGURE_WRKSRC}/${CONFIGURE_SCRIPT}
.endif
	@${REINPLACE_CMD} \
		-e 's|/dev/dvd|${DEFAULT_DVD_DEVICE}|; \
		s|/dev/cdrom|${DEFAULT_CDROM_DEVICE}|' \
		-e 's|/usr/local|${LOCALBASE}|' \
		-e 's|-lbz2|/usr/lib/libbz2.so|' \
		-e 's|-lncurses|/usr/lib/libncurses.so|' \
		${CONFIGURE_WRKSRC}/${CONFIGURE_SCRIPT}
	@${FIND} -E ${WRKSRC} -type f \
		-iregex ".*(configure|.sh|Makefile)" -print0 | \
		${XARGS} -x -0 -n 10 \
		${REINPLACE_CMD} -E \
			-e 's|[[:space:]]gcc[-[:digit:]\.]+| ${CC}|' \
			-e 's|[[:space:]]gcc| ${CC}|' \
			-e 's|\$$\(CC\)|${CC}|' \
			-e 's|/usr/X11R6|${LOCALBASE}|'
	@${FIND} ${WRKSRC}/DOCS/man -name "mplayer.1" | ${XARGS} ${REINPLACE_CMD} -E -e \
		's|/usr/\\:local/\\:etc/\\:mplayer|${DATADIR:S/\//\/\\\:/g}|g ; \
		 s|/dev/\\:(dvd[[:alnum:]]*[[:>:]])|${DEFAULT_DVD_DEVICE:S/dev\//dev\/\\\:/}|g ; \
		 s|/dev/\\:(cdrom[[:alnum:]]*[[:>:]])|${DEFAULT_CDROM_DEVICE:S/dev\//dev\/\\\:/}|g'
.if ${PORT_OPTIONS:MRTC}
	@${REINPLACE_CMD} -e \
		's|irqp = 1024|irqp = ${DEFAULT_KERN_HZ}|' \
		${WRKSRC}/mplayer.c
.endif

post-install:
	@${MKDIR} ${STAGEDIR}${DATADIR}
	@${CHMOD} 755 ${STAGEDIR}${DATADIR}
	@${MKDIR} ${STAGEDIR}${DATADIR}/examples/etc
	@${CHMOD} 755 ${STAGEDIR}${DATADIR}/examples/etc
.for conf in ${CONFFILES}
	${INSTALL_DATA} ${WRKSRC}/etc/${conf} ${STAGEDIR}${DATADIR}/examples/etc
.endfor
.if ${PORT_OPTIONS:MGUI} && ${PORT_OPTIONS:MX11}
	@${LN} -sf ${PREFIX}/bin/mplayer ${STAGEDIR}${PREFIX}/bin/gmplayer
	@(cd ${STAGEDIR}${MAN1PREFIX}/man/man1 && ${LN} -sf mplayer.1.gz gmplayer.1.gz)
	${CP} -f ${WRKSRC}/etc/mplayer256x256.png ${STAGEDIR}${PREFIX}/share/pixmaps/mplayer.png
.endif
	@${CAT} ${PKGMESSAGE}

.include <bsd.port.post.mk>
