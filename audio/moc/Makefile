# Created by: Revis Zinkov <rzinkov@gmail.com>
# $FreeBSD$

PORTNAME=	moc
PORTVERSION=	2.4.4
PORTREVISION=	11
CATEGORIES=	audio
MASTER_SITES=	ftp://ftp.daper.net/pub/soft/moc/stable/

MAINTAINER=	rzinkov@gmail.com
COMMENT=	Console audio player designed to be powerful and easy to use

USES=		gmake
NO_STAGE=	yes
USE_BZIP2=	yes
USE_LDCONFIG=	yes
GNU_CONFIGURE=	yes

MAN1=		mocp.1

CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib

OPTIONS_DEFINE=	JACK MP3 FFMPEG MUSEPACK VORBIS FLAC SNDFILE SPEEX SAMPLERATE CURL RCC
OPTIONS_DEFAULT=	MP3 VORBIS FLAC CURL
CURL_DESC=	curl support (Internet streams)
RCC_DESC=	RCC support

.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MJACK}
LIB_DEPENDS+=	libjack.so:${PORTSDIR}/audio/jack
.else
CONFIGURE_ARGS+=	--without-jack
.endif

.if ${PORT_OPTIONS:MMP3}
LIB_DEPENDS+=	libmad.so:${PORTSDIR}/audio/libmad \
		libid3tag.so:${PORTSDIR}/audio/libid3tag
PLIST_FILES+=	lib/moc/decoder_plugins/libmp3_decoder.a \
		lib/moc/decoder_plugins/libmp3_decoder.la \
		lib/moc/decoder_plugins/libmp3_decoder.so
.else
CONFIGURE_ARGS+=	--without-mp3
.endif

.if ${PORT_OPTIONS:MMUSEPACK}
LIB_DEPENDS+=	libmpcdec.so:${PORTSDIR}/audio/musepack \
		tag_c.0:${PORTSDIR}/audio/taglib
PLIST_FILES+=	lib/moc/decoder_plugins/libmusepack_decoder.a \
		lib/moc/decoder_plugins/libmusepack_decoder.la \
		lib/moc/decoder_plugins/libmusepack_decoder.so
.else
CONFIGURE_ARGS+=	--without-musepack
.endif

.if ${PORT_OPTIONS:MVORBIS}
LIB_DEPENDS+=	libvorbis.so:${PORTSDIR}/audio/libvorbis
PLIST_FILES+=	lib/moc/decoder_plugins/libvorbis_decoder.a \
		lib/moc/decoder_plugins/libvorbis_decoder.la \
		lib/moc/decoder_plugins/libvorbis_decoder.so
.else
CONFIGURE_ARGS+=	--without-ogg
.endif

.if ${PORT_OPTIONS:MFLAC}
LIB_DEPENDS+=	libFLAC.so:${PORTSDIR}/audio/flac
PLIST_FILES+=	lib/moc/decoder_plugins/libflac_decoder.a \
		lib/moc/decoder_plugins/libflac_decoder.la \
		lib/moc/decoder_plugins/libflac_decoder.so
.else
CONFIGURE_ARGS+=	--without-flac
.endif

.if ${PORT_OPTIONS:MFFMPEG}
LIB_DEPENDS+=	libavcodec.so:${PORTSDIR}/multimedia/ffmpeg
PLIST_FILES+=   lib/moc/decoder_plugins/libffmpeg_decoder.a \
		lib/moc/decoder_plugins/libffmpeg_decoder.la \
		lib/moc/decoder_plugins/libffmpeg_decoder.so
.else
CONFIGURE_ARGS+=	--without-ffmpeg
.endif

.if ${PORT_OPTIONS:MSNDFILE}
LIB_DEPENDS+=	libsndfile.so:${PORTSDIR}/audio/libsndfile
PLIST_FILES+=	lib/moc/decoder_plugins/libsndfile_formats_decoder.a \
		lib/moc/decoder_plugins/libsndfile_formats_decoder.la \
		lib/moc/decoder_plugins/libsndfile_formats_decoder.so
.else
CONFIGURE_ARGS+=	--without-sndfile
.endif

.if ${PORT_OPTIONS:MSPEEX}
LIB_DEPENDS+=	libspeex.so:${PORTSDIR}/audio/speex
PLIST_FILES+=	lib/moc/decoder_plugins/libspeex_decoder.a \
		lib/moc/decoder_plugins/libspeex_decoder.la \
		lib/moc/decoder_plugins/libspeex_decoder.so
.else
CONFIGURE_ARGS+=	--without-speex
.endif

.if ${PORT_OPTIONS:MSAMPLERATE}
LIB_DEPENDS+=	libsamplerate.so:${PORTSDIR}/audio/libsamplerate
.else
CONFIGURE_ARGS+=	--without-samplerate
.endif

.if ${PORT_OPTIONS:MCURL}
LIB_DEPENDS+=	libcurl.so:${PORTSDIR}/ftp/curl
.else
CONFIGURE_ARGS+=	--without-curl
.endif

.if ${PORT_OPTIONS:MRCC}
LIB_DEPENDS+=	librcc.so:${PORTSDIR}/devel/librcc \
		librcd.so:${PORTSDIR}/devel/librcd
.else
CONFIGURE_ARGS+=	--without-rcc
.endif

.include <bsd.port.mk>
