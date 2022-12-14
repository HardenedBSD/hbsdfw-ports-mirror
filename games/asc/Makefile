# Created by: Maxim Sobolev <sobomax@FreeBSD.org>
# $FreeBSD$

PORTNAME=	asc
PORTVERSION=	2.5.0.0
PORTREVISION=	2
CATEGORIES=	games
MASTER_SITES=	SF/${PORTNAME}-hq/ASC%20Source/${PORTVERSION:R} \
		http://www.asc-hq.org/music/
DISTFILES=	${DISTNAME}${EXTRACT_SUFX} ${ASC_MUSICS}
DIST_SUBDIR=	${PORTNAME}
EXTRACT_ONLY=	${DISTNAME}${EXTRACT_SUFX}

MAINTAINER=	ports@FreeBSD.org
COMMENT=	Turn based, multiplayer strategic game with nice graphics

LICENSE=	GPLv2

BUILD_DEPENDS=	zip:${PORTSDIR}/archivers/zip \
		${LOCALBASE}/lib/libloki.so:${PORTSDIR}/devel/loki
LIB_DEPENDS=	libvorbis.so:${PORTSDIR}/audio/libvorbis \
		libboost_regex.so:${PORTSDIR}/devel/boost-libs \
		libsigc-1.2.so:${PORTSDIR}/devel/libsigc++12 \
		libexpat.so:${PORTSDIR}/textproc/expat2
RUN_DEPENDS:=	${BUILD_DEPENDS}

OPTIONS_DEFINE=	MUSIC XVID
MUSIC_DESC=	Install extra music files

USES=		perl5 pkgconfig
USE_BZIP2=	yes
USE_SDL=	image mixer sound sdl
USE_WX=		2.4+
WX_CONF_ARGS=	absolute
USE_LUA=	5.1
LUA_COMPS=	lua
USE_PERL5=	build
USE_GMAKE=	yes
GNU_CONFIGURE=	yes

MAN6=		asc.6 asc_demount.6 asc_mapedit.6 asc_mount.6 \
		asc_weaponguide.6
PLIST_FILES=	bin/asc bin/asc_demount bin/asc_mapedit bin/asc_mount \
		bin/asc_weaponguide \
		%%DATADIR%%/asc2_dlg.zip %%DATADIR%%/main.ascdat
PLIST_DIRS=	${ASC_MUSICDIR} %%DATADIR%%

CFLAGS+=	-D_UNICODE_BROKEN_
CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib

NO_STAGE=	yes
.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MMUSIC}
ASC_MUSICS=	frontiers.ogg time_to_strike.ogg machine_wars.ogg
ASC_MUSICDIR=	%%DATADIR%%/music
.for file in ${ASC_MUSICS}
PLIST_FILES+=	${ASC_MUSICDIR}/${file}
.endfor
.else
.undef ASC_MUSICS
.undef ASC_MUSICDIR
.endif

.if ${PORT_OPTIONS:MXVID}
LIB_DEPENDS+=	libxvidcore.so:${PORTSDIR}/multimedia/xvid
.else
CONFIGURE_ENV+=	ac_cv_lib_xvidcore_xvid_encore=no
.endif

post-extract:
.if ${PORT_OPTIONS:MMUSIC}
.for file in ${ASC_MUSICS}
	@${TAR} -C ${DISTDIR}/${DIST_SUBDIR} -cf - ${file} | \
		${TAR} -C ${WRKSRC}/data/music --unlink -xf -
.endfor
.endif

post-patch:
	@${FIND} ${WRKSRC} -name "Makefile.in" -print0 | ${XARGS} -0 \
		${REINPLACE_CMD} -e \
		's|/games/|/|g'
	@${REINPLACE_CMD} -e \
		's|/games/|/|g ; \
		 s|lua >=|lua-5.1 >=|g ; \
		 /if test/s|==|=|g' ${WRKSRC}/configure

post-install:
	@${CAT} ${PKGMESSAGE}

.include <bsd.port.mk>
