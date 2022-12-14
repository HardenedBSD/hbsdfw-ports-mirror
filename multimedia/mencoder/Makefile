# Created by: Thomas E. Zander
# $FreeBSD$

PORTNAME=	mencoder
PORTVERSION=	${MPLAYER_PORT_VERSION}
PORTREVISION=	1

COMMENT=	Convenient video file and movie encoder

.include "${.CURDIR}/../mplayer/Makefile.shared"

OPTIONS_DEFINE=	AMR_NB AMR_WB BLURAY CDIO CDPARANOIA DEBUG DIRAC \
		DV FAAC FONTCONFIG FRIBIDI GIF GSM IPV6 JACK \
		LADSPA LIBMNG LZO MAD NAS OCFLAGS OPENAL OPENJPEG \
		OPUS OTCHAIN PULSEAUDIO REAL RTCPU RTMP SCHROEDINGER \
		SMB THEORA TWOLAME V4L VPX WIN32 X264 XVID

OPTIONS_DEFAULT=GIF IPV6 OCFLAGS RTCPU WIN32 X264 XVID

BLURAY_DESC?=	BluRay support
LZO_DESC?=	Enable external liblzo library
OCFLAGS_DESC?=	Use optimized compiler flags
OPUS_DESC?=	Opus decoding with libopus
OTCHAIN_DESC?=	Use gcc 4.6+ toolchain on legacy systems
REAL_DESC?=	Enable realplayer plugin
RTCPU_DESC?=	Use runtime CPU detection
WIN32_DESC?=	Install win32 binary codecs

RESTRICTED=	Port has restricted dependencies

PATCHDIR=	${.CURDIR}/../mplayer/files
FILESDIR=	${PATCHDIR}
DATADIR=	${PREFIX}/share/mplayer

TOOLFILES=	aconvert.sh binary_codecs.sh calcbpp.pl \
		checktree.sh countquant.pl divx2svcd.sh \
		dvd2divxscript.pl edgedetect.fp edgeenh.fp \
		emboss.fp mencvcd.sh midentify.sh \
		mpconsole.sh mphelp_check.py mplmult.sh \
		plotpsnr.pl psnr-video.sh qepdvcd.sh \
		subedit.pl subsearch.sh vobshift.py \
		w32codec_dl.pl wma2ogg.pl

USES+=		shebangfix
SHEBANG_FILES=	TOOLS/calcbpp.pl TOOLS/checktree.sh TOOLS/countquant.pl	\
		TOOLS/divx2svcd.sh TOOLS/dvd2divxscript.pl TOOLS/mencvcd.sh \
		TOOLS/mphelp_check.py TOOLS/plotpsnr.pl TOOLS/psnr-video.sh \
		TOOLS/qepdvcd.sh TOOLS/subedit.pl TOOLS/w32codec_dl.pl \
		TOOLS/wma2ogg.pl

.include "${.CURDIR}/../mplayer/Makefile.optvars"
.include <bsd.port.options.mk>
.include <bsd.port.pre.mk>

CONFIGURE_ARGS+=	--disable-mplayer \
			--disable-libdca \
			--disable-x11 \
			--disable-vdpau \
			--disable-rtc \
			--disable-arts \
			--disable-esd \
			--disable-caca \
			--disable-lirc \
			--disable-sdl \
			--disable-svga \
			--disable-aa \
			--disable-joystick \
			--disable-directfb \
			--disable-mpg123 \
			--disable-enca \
			--disable-musepack

LIB_DEPENDS+=	libmp3lame.so:${PORTSDIR}/audio/lame

ALL_TARGET=	mencoder

.include "${.CURDIR}/../mplayer/Makefile.options"

pre-everything::
	@${ECHO_MSG} "N - O - T - E"
	@${ECHO_MSG} ""
	@${ECHO_MSG} "There are some knobs which *can* *not* be selected via the"
	@${ECHO_MSG} "OPTIONS framework. At the moment, their defaults are:"
	@${ECHO_MSG} "WITH_LANG=<LanguageCode>"
	@${ECHO_MSG} "DEFAULT_DVD_DEVICE=/dev/cd0"
	@${ECHO_MSG} "DEFAULT_CDROM_DEVICE=/dev/cd0"

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

do-install:
	@${INSTALL_PROGRAM} ${WRKSRC}/mencoder ${STAGEDIR}${PREFIX}/bin

post-install:
	@${INSTALL_MAN} ${WRKSRC}/DOCS/man/en/mplayer.1 ${STAGEDIR}${MAN1PREFIX}/man/man1/mencoder.1
	@${MKDIR} ${STAGEDIR}${DATADIR}
	@${CHMOD} 755 ${STAGEDIR}${DATADIR}
	@${MKDIR} ${STAGEDIR}${DATADIR}/tools
	@${CHMOD} 755 ${STAGEDIR}${DATADIR}/tools
.for tool in ${TOOLFILES}
	@${INSTALL_SCRIPT} ${WRKSRC}/TOOLS/${tool} ${STAGEDIR}${DATADIR}/tools
.endfor

.include <bsd.port.post.mk>
