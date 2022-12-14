# $FreeBSD$

PORTNAME=	qmmp
PORTVERSION=	0.7.3
CATEGORIES=	multimedia
MASTER_SITES=	http://qmmp.ylsoftware.com/files/ \
		${MASTER_SITE_GOOGLE_CODE}

MAINTAINER=	liangtai.s16@gmail.com
COMMENT=	Qt4-based multimedia player

LICENSE=	GPLv2

USE_BZIP2=	yes
USES=		cmake:outsource pkgconfig
USE_QT4=	corelib gui network xml \
		qmake_build rcc_build uic_build moc_build linguist_build
USE_LDCONFIG=	yes

OPTIONS_SUB=	yes
OPTIONS_SINGLE=	MPLAYER
OPTIONS_SINGLE_MPLAYER=	MPLAYER1 MPLAYER2
OPTIONS_DEFINE=	ALSA ANALYZER BS2B CDIO CONVERTER COPYPASTE \
		COVER CROSSFADE CUE CURL DIR_ASSOC DOCS DOXYGEN ENCA FAAD \
		FFMPEG FILEOPS FLAC GME HAL HOTKEY JACK KDENOTIFY \
		LADSPA LYRICS MAD MMS MODPLUG MPLAYER MPRIS MUSEPACK \
		NOTIFIER NULLOUT OSS OSS4 PROJECTM PULSEAUDIO QMMP_DIALOG \
		SB SCROBBLER SKINNEDUI SNDFILE SRCONV STATICON STEREO \
		TRACKCHANGE UDISKS UDISKS2 VORBIS WAVPACK WILDMIDI
OPTIONS_DEFAULT=	ALSA ANALYZER BS2B CDIO CONVERTER COPYPASTE COVER \
		CROSSFADE CUE CURL DIR_ASSOC ENCA FAAD \
		FFMPEG FILEOPS FLAC GME HAL HOTKEY JACK KDENOTIFY \
		LADSPA LYRICS MAD MMS MODPLUG MPRIS MPLAYER MPLAYER1 MUSEPACK \
		NOTIFIER NULLOUT OSS4 PROJECTM PULSEAUDIO QMMP_DIALOG \
		SB SCROBBLER SKINNEDUI SNDFILE SRCONV STATICON STEREO \
		TRACKCHANGE UDISKS2 VORBIS WAVPACK WILDMIDI

DOXYGEN_BUILD_DEPENDS=	doxygen:${PORTSDIR}/devel/doxygen

SKINNEDUI_DESC=	Skinned GUI
SKINNEDUI_CMAKE_ON=	-DUSE_SKINNED:BOOL=TRUE
SKINNEDUI_CMAKE_OFF=	-DUSE_SKINNED:BOOL=FALSE

DIR_ASSOC_DESC=	inode/directory mime type association
DIR_ASSOC_CMAKE_ON=	-DUSE_DIR_ASSOC:BOOL=TRUE
DIR_ASSOC_CMAKE_OFF=	-DUSE_DIR_ASSOC:BOOL=FALSE

JACK_LIB_DEPENDS=	libjack.so:${PORTSDIR}/audio/jack
JACK_BUILD_DEPENDS=	jackit>=0.121.2:${PORTSDIR}/audio/jack
JACK_CMAKE_ON=	-DUSE_JACK:BOOL=TRUE
JACK_CMAKE_OFF=	-DUSE_JACK:BOOL=FALSE

ALSA_LIB_DEPENDS=	libasound.so:${PORTSDIR}/audio/alsa-lib
ALSA_CMAKE_ON=	-DUSE_ALSA:BOOL=TRUE
ALSA_CMAKE_OFF=	-DUSE_ALSA:BOOL=FALSE

BS2B_DESC=		Support the Bauer stereophonic2binaural effect
BS2B_LIB_DEPENDS=	libbs2b.so:${PORTSDIR}/audio/libbs2b
BS2B_CMAKE_ON=	-DUSE_BS2B:BOOL=TRUE
BS2B_CMAKE_OFF=	-DUSE_BS2B:BOOL=FALSE

PULSEAUDIO_LIB_DEPENDS=	libpulse.so:${PORTSDIR}/audio/pulseaudio
PULSEAUDIO_CMAKE_ON=	-DUSE_PULSE:BOOL=TRUE
PULSEAUDIO_CMAKE_OFF=	-DUSE_PULSE:BOOL=FALSE

FLAC_LIB_DEPENDS=	libFLAC.so:${PORTSDIR}/audio/flac \
		libtag.so:${PORTSDIR}/audio/taglib
FLAC_CMAKE_ON=	-DUSE_FLAC:BOOL=TRUE
FLAC_CMAKE_OFF=	-DUSE_FLAC:BOOL=FALSE

MUSEPACK_LIB_DEPENDS=	libmpcdec.so:${PORTSDIR}/audio/musepack \
		libtag.so:${PORTSDIR}/audio/taglib
MUSEPACK_CMAKE_ON=	-DUSE_MPC:BOOL=TRUE
MUSEPACK_CMAKE_OFF=	-DUSE_MPC:BOOL=FALSE

GME_DESC=		Support video game music files
GME_LIB_DEPENDS=	libgme.so:${PORTSDIR}/audio/libgme
GME_CMAKE_ON=	-DUSE_GME:BOOL=TRUE
GME_CMAKE_OFF=	-DUSE_GME:BOOL=FALSE

FFMPEG_LIB_DEPENDS=	libavcodec.so:${PORTSDIR}/multimedia/ffmpeg
FFMPEG_CMAKE_ON=	-DUSE_FFMPEG:BOOL=TRUE
FFMPEG_CMAKE_OFF=	-DUSE_FFMPEG:BOOL=FALSE

MODPLUG_LIB_DEPENDS=	libmodplug.so:${PORTSDIR}/audio/libmodplug
MODPLUG_CMAKE_ON=	-DUSE_MODPLUG:BOOL=TRUE
MODPLUG_CMAKE_OFF=	-DUSE_MODPLUG:BOOL=FALSE

FAAD_LIB_DEPENDS=	libfaad.so:${PORTSDIR}/audio/faad \
		libtag.so:${PORTSDIR}/audio/taglib
FAAD_CMAKE_ON=	-DUSE_AAC:BOOL=TRUE
FAAD_CMAKE_OFF=	-DUSE_AAC:BOOL=FALSE

CDIO_LIB_DEPENDS=	libcdio.so:${PORTSDIR}/sysutils/libcdio
CDIO_CMAKE_ON=	-DUSE_CDA:BOOL=TRUE
CDIO_CMAKE_OFF=	-DUSE_CDA:BOOL=FALSE

ENCA_DESC=		Support automatic character set detection
ENCA_LIB_DEPENDS=	libenca.so:${PORTSDIR}/converters/enca
ENCA_CMAKE_ON=	-DUSE_ENCA:BOOL=TRUE
ENCA_CMAKE_OFF=	-DUSE_ENCA:BOOL=FALSE

MPLAYER1_DESC=	mplayer-1.1.x (multimedia/mplayer)
MPLAYER2_DESC=	mplayer-2.0.x (multimedia/mplayer2)
MPLAYER1_RUN_DEPENDS=	mplayer:${PORTSDIR}/multimedia/mplayer
MPLAYER2_RUN_DEPENDS=	mplayer:${PORTSDIR}/multimedia/mplayer2
MPLAYER_CMAKE_ON=	-DUSE_MPLAYER:BOOL=TRUE
MPLAYER_CMAKE_OFF=	-DUSE_MPLAYER:BOOL=FALSE

PROJECTM_DESC=	Support the projectM music visualiser
PROJECTM_LIB_DEPENDS=	libprojectM.so.2:${PORTSDIR}/graphics/libprojectm
PROJECTM_USE=	QT4=opengl
PROJECTM_CMAKE_ON=	-DUSE_PROJECTM:BOOL=TRUE
PROJECTM_CMAKE_OFF=	-DUSE_PROJECTM:BOOL=FALSE

OSS_CMAKE_ON=	-DUSE_OSS:BOOL=TRUE
OSS_CMAKE_OFF=	-DUSE_OSS:BOOL=FALSE

OSS4_DESC=		Open Sound System (ver4) support
OSS4_BUILD_DEPENDS=	${LOCALBASE}/lib/oss/include/sys/soundcard.h:${PORTSDIR}/audio/oss
OSS4_CMAKE_ON=	-DUSE_OSS4:BOOL=TRUE
OSS4_CMAKE_OFF=	-DUSE_OSS4:BOOL=FALSE

LADSPA_RUN_DEPENDS=	analyseplugin:${PORTSDIR}/audio/ladspa
LADSPA_CMAKE_ON=	-DUSE_LADSPA:BOOL=TRUE
LADSPA_CMAKE_OFF=	-DUSE_LADSPA:BOOL=FALSE

WILDMIDI_DESC=	Support to playback MIDI files
WILDMIDI_LIB_DEPENDS=	libWildMidi.so:${PORTSDIR}/audio/wildmidi
WILDMIDI_CMAKE_ON=	-DUSE_MIDI:BOOL=TRUE
WILDMIDI_CMAKE_OFF=	-DUSE_MIDI:BOOL=FALSE

MAD_LIB_DEPENDS=	libmad.so:${PORTSDIR}/audio/libmad \
		libtag.so:${PORTSDIR}/audio/taglib
MAD_CMAKE_ON=	-DUSE_MAD:BOOL=TRUE
MAD_CMAKE_OFF=	-DUSE_MAD:BOOL=FALSE

#OPUS_DESC=		Enable reading opusfile tags
#OPUS_LIB_DEPENDS=	libopusfile.so:${PORTSDIR}/audio/opusfile \
#		libtag.so:${PORTSDIR}/audio/taglib
#OPUS_CMAKE_ON=	-DUSE_OPUS:BOOL=TRUE
#OPUS_CMAKE_OFF=	-DUSE_OPUS:BOOL=FALSE
CMAKE_ARGS+=	-DUSE_OPUS:BOOL=FALSE
PLIST_SUB+=	OPUS="@comment "

SNDFILE_LIB_DEPENDS=	libsndfile.so:${PORTSDIR}/audio/libsndfile
SNDFILE_CMAKE_ON=	-DUSE_SNDFILE:BOOL=TRUE
SNDFILE_CMAKE_OFF=	-DUSE_SNDFILE:BOOL=FALSE

VORBIS_LIB_DEPENDS=	libvorbis.so:${PORTSDIR}/audio/libvorbis \
		libtag.so:${PORTSDIR}/audio/taglib
VORBIS_CMAKE_ON=	-DUSE_VORBIS:BOOL=TRUE
VORBIS_CMAKE_OFF=	-DUSE_VORBIS:BOOL=FALSE

WAVPACK_LIB_DEPENDS=	libwavpack.so:${PORTSDIR}/audio/wavpack
WAVPACK_CMAKE_ON=	-DUSE_WAVPACK:BOOL=TRUE
WAVPACK_CMAKE_OFF=	-DUSE_WAVPACK:BOOL=FALSE

CURL_LIB_DEPENDS=	libcurl.so:${PORTSDIR}/ftp/curl
CURL_CMAKE_ON=	-DUSE_CURL:BOOL=TRUE
CURL_CMAKE_OFF=	-DUSE_CURL:BOOL=FALSE

MMS_LIB_DEPENDS=	libmms.so:${PORTSDIR}/net/libmms
MMS_CMAKE_ON=	-DUSE_MMS:BOOL=TRUE
MMS_CMAKE_OFF=	-DUSE_MMS:BOOL=FALSE

CUE_CMAKE_ON=	-DUSE_CUE:BOOL=TRUE
CUE_CMAKE_OFF=	-DUSE_CUE:BOOL=FALSE

NULLOUT_DESC=	Support a null output
NULLOUT_CMAKE_ON=	-DUSE_NULL:BOOL=TRUE
NULLOUT_CMAKE_OFF=	-DUSE_NULL:BOOL=FALSE

SRCONV_DESC=	Support the sample rate converter
SRCONV_CMAKE_ON=	-DUSE_SRC:BOOL=TRUE
SRCONV_CMAKE_OFF=	-DUSE_SRC:BOOL=FALSE

CROSSFADE_DESC=	Support cross-fade effect
CROSSFADE_CMAKE_ON=	-DUSE_CROSSFADE:BOOL=TRUE
CROSSFADE_CMAKE_OFF=	-DUSE_CROSSFADE:BOOL=FALSE

STEREO_DESC=	Support stereo effect
STEREO_CMAKE_ON=	-DUSE_STEREO:BOOL=TRUE
STEREO_CMAKE_OFF=	-DUSE_STEREO:BOOL=FALSE

ANALYZER_DESC=	Supoort spectrum analyzer visualization
ANALYZER_CMAKE_ON=	-DUSE_ANALYZER:BOOL=TRUE
ANALYZER_CMAKE_OFF=	-DUSE_ANALYZER:BOOL=FALSE

CONVERTER_DESC=	Support file type converter
CONVERTER_LIB_DEPENDS=	libtag.so:${PORTSDIR}/audio/taglib
CONVERTER_CMAKE_ON=	-DUSE_CONVERTER:BOOL=TRUE
CONVERTER_CMAKE_OFF=	-DUSE_CONVERTER:BOOL=FALSE

COPYPASTE_DESC=	Enable copy/paste track infos between playlists
COPYPASTE_CMAKE_ON=	-DUSE_COPYPASTE:BOOL=TRUE
COPYPASTE_CMAKE_OFF=	-DUSE_COPYPASTE:BOOL=FALSE

MPRIS_DESC=	Support the Media Player Remote
MPRIS_USE=	QT4=dbus
MPRIS_CMAKE_ON=	-DUSE_MPRIS:BOOL=TRUE
MPRIS_CMAKE_OFF=	-DUSE_MPRIS:BOOL=FALSE

SCROBBLER_DESC=	Support Libre.fm/Last.fm scrobbler feature
SCROBBLER_CMAKE_ON=	-DUSE_SCROBBLER:BOOL=TRUE
SCROBBLER_CMAKE_OFF=	-DUSE_SCROBBLER:BOOL=FALSE

STATICON_DESC=	Support to show status icon
STATICON_CMAKE_ON=	-DUSE_STATICON:BOOL=TRUE
STATICON_CMAKE_OFF=	-DUSE_STATICON:BOOL=FALSE

SB_DESC=	Browser for IceCast stream directory
SB_CMAKE_ON=	-DUSE_SB:BOOL=TRUE
SB_CMAKE_OFF=	-DUSE_SB:BOOL=FALSE

NOTIFIER_DESC=	Support to popup notifier
NOTIFIER_CMAKE_ON=	-DUSE_NOTIFIER:BOOL=TRUE
NOTIFIER_CMAKE_OFF=	-DUSE_NOTIFIER:BOOL=FALSE

LYRICS_DESC=	Support to show lyrics using lyrics.wikia.com
LYRICS_CMAKE_ON=	-DUSE_LYRICS:BOOL=TRUE
LYRICS_CMAKE_OFF=	-DUSE_LYRICS:BOOL=FALSE

HAL_USE=	QT4=dbus
HAL_CMAKE_ON=	-DUSE_HAL:BOOL=TRUE
HAL_CMAKE_OFF=	-DUSE_HAL:BOOL=FALSE

HOTKEY_DESC=	Support to set shortcut keys
HOTKEY_CMAKE_ON=	-DUSE_HOTKEY:BOOL=TRUE
HOTKEY_CMAKE_OFF=	-DUSE_HOTKEY:BOOL=FALSE

FILEOPS_DESC=	Support file operation
FILEOPS_CMAKE_ON=	-DUSE_FILEOPS:BOOL=TRUE
FILEOPS_CMAKE_OFF=	-DUSE_FILEOPS:BOOL=FALSE

COVER_DESC=	Support to show cover images
COVER_CMAKE_ON=	-DUSE_COVER:BOOL=TRUE
COVER_CMAKE_OFF=	-DUSE_COVER:BOOL=FALSE

KDENOTIFY_DESC=	Support to popup notifier for KDE
KDENOTIFY_USE=	QT4=dbus
KDENOTIFY_CMAKE_ON=	-DUSE_KDENOTIFY:BOOL=TRUE
KDENOTIFY_CMAKE_OFF=	-DUSE_KDENOTIFY:BOOL=FALSE

TRACKCHANGE_DESC=	Enable to run external command each track switching
TRACKCHANGE_CMAKE_ON=	-DUSE_TRACKCHANGE:BOOL=TRUE
TRACKCHANGE_CMAKE_OFF=	-DUSE_TRACKCHANGE:BOOL=FALSE

UDISKS_DESC=	Support removable disc detection (obsolete)
UDISKS2_DESC=	Support removable disc detection using UDisks
UDISKS_USE=	QT4=dbus
UDISKS2_USE=	QT4=dbus
UDISKS_CMAKE_ON=	-DUSE_UDISKS:BOOL=TRUE
UDISKS_CMAKE_OFF=	-DUSE_UDISKS:BOOL=FALSE
UDISKS2_CMAKE_ON=	-DUSE_UDISKS2:BOOL=TRUE
UDISKS2_CMAKE_OFF=	-DUSE_UDISKS2:BOOL=FALSE

QMMP_DIALOG_DESC=	An original dialog
QMMP_DIALOG_CMAKE_ON=	-DUSE_QMMP_DIALOG:BOOL=TRUE
QMMP_DIALOG_CMAKE_OFF=	-DUSE_QMMP_DIALOG:BOOL=FALSE

.include <bsd.port.pre.mk>

PLIST_SUB+=	SHLIB_VER=${PORTVERSION:C/-.*//}

PORTDOCS=	README README.RUS AUTHORS
INSTALLS_ICONS=	yes

CMAKE_ARGS+=	-DUSE_RPATH:BOOL=TRUE \
	-DUSE_FFMPEG_LEGACY:BOOL=FALSE \
	-DCMAKE_REQUIRED_INCLUDES:PATH=${LOCALBASE}/include
CFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib

post-patch:
	@${REINPLACE_CMD} -e 's|/usr/local/|${LOCALBASE}/|' \
		${WRKSRC}/src/plugins/Output/oss4/CMakeLists.txt
	@${REINPLACE_CMD} -e '/pkgconfig/s|$${LIB_DIR}|libdata|' \
		${WRKSRC}/src/qmmp/CMakeLists.txt \
		${WRKSRC}/src/qmmpui/CMakeLists.txt

pre-configure:
	@${RM} -f ${BUILD_WRKSRC}/CMakeCache.txt

post-build:
.if ${PORT_OPTIONS:MDOXYGEN}
	cd ${WRKSRC}/doc && doxygen Doxyfile
.endif

post-install:
.if ${PORT_OPTIONS:MDOCS}
	@${MKDIR} ${STAGEDIR}${DOCSDIR}; \
	cd ${WRKSRC} && ${INSTALL_MAN} ${PORTDOCS} ${STAGEDIR}${DOCSDIR}
.endif
.if ${PORT_OPTIONS:MDOXYGEN}
	@${MKDIR} ${STAGEDIR}${DOCSDIR}/html/search ; \
	cd ${WRKSRC}/doc/html && \
		${INSTALL_MAN} *.html *.png *.css ${STAGEDIR}${DOCSDIR}/html ; \
	cd ${WRKSRC}/doc/html/search && \
		${INSTALL_MAN} *.html *.png *.css *.js ${STAGEDIR}${DOCSDIR}/html/search ; \
	${RM} -f ${WRKDIR}/PLIST.doc ; \
	${FIND} ${STAGEDIR}${DOCSDIR}/html -type f | \
		${SED} 's|${STAGEDIR}${PREFIX}/||' \
		>> ${WRKDIR}/PLIST.doc ; \
	${FIND} ${STAGEDIR}${DOCSDIR}/html -type d | \
		${SED} 's|${STAGEDIR}${PREFIX}/|@dirrm |' \
		| ${SORT} -r >> ${WRKDIR}/PLIST.doc ; \
	cd ${WRKDIR} ; ${SED} -i -e '/PLIST.doc/ r PLIST.doc' ${TMPPLIST}
.endif

.include <bsd.port.post.mk>
