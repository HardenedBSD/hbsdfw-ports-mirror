# Created by: Jimmy Olgeni <olgeni@uli.it>
# $FreeBSD$

PORTNAME=	blender
PORTVERSION=	2.69
PORTREVISION=	3
CATEGORIES=	graphics games
MASTER_SITES=	http://download.blender.org/source/ \
		http://mirror.cs.umn.edu/blender.org/source/ \
		http://public.planetmirror.com/pub/blender/source/

MAINTAINER=	mva@FreeBSD.org
COMMENT=	3D modeling/rendering/animation/gaming package

LICENSE=	GPLv2

LIB_DEPENDS=	libjpeg.so:${PORTSDIR}/graphics/jpeg \
		libpng15.so:${PORTSDIR}/graphics/png \
		libfreetype.so:${PORTSDIR}/print/freetype2

USE_XORG=	x11 xext xmu
USE_GL=		glew
USES=		cmake:outsource shebangfix
USE_PYTHON=	3.3

CMAKE_ARGS+=	-DWITH_PYTHON_INSTALL:BOOL=OFF \
		-DWITH_PYTHON_INSTALL_NUMPY:BOOL=OFF

python_CMD=	${PYTHON_CMD}
SHEBANG_FILES=	release/bin/blender-thumbnailer.py \
		release/scripts/modules/bl_i18n_utils/merge_po.py \
		release/scripts/modules/bl_i18n_utils/utils_rtl.py \
		release/scripts/modules/blend_render_info.py

SUB_FILES=	blender blenderplayer

OUTDIR=		${INSTALL_WRKSRC}/bin/2.69

.include "${.CURDIR}/Makefile.options"

# TODO: WITH_CYCLES_STANDALONE WITH_CYCLES_STANDALONE_GUI

MOD_BOOLEAN_CMAKE_ON=		-DWITH_MOD_BOOLEAN:BOOL=ON
MOD_BOOLEAN_CMAKE_OFF=		-DWITH_MOD_BOOLEAN:BOOL=OFF
MOD_BOOLEAN_LIB_DEPENDS=	libboost_thread.so:${PORTSDIR}/devel/boost-libs
MOD_FLUID_CMAKE_ON=		-DWITH_MOD_FLUID:BOOL=ON
MOD_FLUID_CMAKE_OFF=		-DWITH_MOD_FLUID:BOOL=OFF
MOD_REMESH_CMAKE_ON=		-DWITH_MOD_REMESH:BOOL=ON
MOD_REMESH_CMAKE_OFF=		-DWITH_MOD_REMESH:BOOL=OFF
MOD_SMOKE_CMAKE_ON=		-DWITH_MOD_SMOKE:BOOL=ON
MOD_SMOKE_CMAKE_OFF=		-DWITH_MOD_SMOKE:BOOL=OFF
AVI_CMAKE_ON=			-DWITH_CODEC_AVI:BOOL=ON
AVI_CMAKE_OFF=			-DWITH_CODEC_AVI:BOOL=OFF
BULLET_CMAKE_ON=		-DWITH_BULLET:BOOL=ON
BULLET_CMAKE_OFF=		-DWITH_BULLET:BOOL=OFF
CINEON_CMAKE_ON=		-DWITH_IMAGE_CINEON:BOOL=ON
CINEON_CMAKE_OFF=		-DWITH_IMAGE_CINEON:BOOL=OFF
CAMERATRACK_CMAKE_ON=		-DWITH_LIBMV:BOOL=ON
CAMERATRACK_CMAKE_OFF=		-DWITH_LIBMV:BOOL=OFF
CAMERATRACK_LIB_DEPENDS=	libunwind.so:${PORTSDIR}/devel/libunwind
COLLADA_CMAKE_ON=		-DWITH_OPENCOLLADA:BOOL=ON
COLLADA_CMAKE_OFF=		-DWITH_OPENCOLLADA:BOOL=OFF
COLLADA_LIB_DEPENDS=		libOpenCOLLADABaseUtils.so:${PORTSDIR}/graphics/opencollada
COMPOSITOR_CMAKE_ON=		-DWITH_COMPOSITOR:BOOL=ON
COMPOSITOR_CMAKE_OFF=		-DWITH_COMPOSITOR:BOOL=OFF
DDS_CMAKE_ON=			-DWITH_IMAGE_DDS:BOOL=ON
DDS_CMAKE_OFF=			-DWITH_IMAGE_DDS:BOOL=OFF
FFMPEG_CMAKE_ON=		-DWITH_CODEC_FFMPEG:BOOL=ON
FFMPEG_CMAKE_OFF=		-DWITH_CODEC_FFMPEG:BOOL=OFF
FFMPEG_LIB_DEPENDS=		libavutil.so:${PORTSDIR}/multimedia/ffmpeg
FFTW3_CMAKE_ON=			-DWITH_FFTW3:BOOL=ON
FFTW3_CMAKE_OFF=		-DWITH_FFTW3:BOOL=OFF
FFTW3_LIB_DEPENDS=		libfftw3.so:${PORTSDIR}/math/fftw3
FRAMESERVER_CMAKE_ON=		-DWITH_IMAGE_FRAMESERVER:BOOL=ON
FRAMESERVER_CMAKE_OFF=		-DWITH_IMAGE_FRAMESERVER:BOOL=OFF
FREESTYLE_CMAKE_ON=		-DWITH_FREESTYLE:BOOL=ON
FREESTYLE_CMAKE_OFF=		-DWITH_FREESTYLE:BOOL=OFF
GAMEENGINE_CMAKE_ON=		-DWITH_GAMEENGINE:BOOL=ON
GAMEENGINE_CMAKE_OFF=		-DWITH_GAMEENGINE:BOOL=OFF
HDR_CMAKE_ON=			-DWITH_IMAGE_HDR:BOOL=ON
HDR_CMAKE_OFF=			-DWITH_IMAGE_HDR:BOOL=OFF
INPUT_NDOF_CMAKE_ON=		-DWITH_INPUT_NDOF:BOOL=ON
INPUT_NDOF_CMAKE_OFF=		-DWITH_INPUT_NDOF:BOOL=OFF
JACK_CMAKE_ON=			-DWITH_JACK:BOOL=ON
JACK_CMAKE_OFF=			-DWITH_JACK:BOOL=OFF
JACK_LIB_DEPENDS=		libjack.so:${PORTSDIR}/audio/jack
LZO_CMAKE_ON=			-DWITH_LZO:BOOL=ON
LZO_CMAKE_OFF=			-DWITH_LZO:BOOL=OFF
LZMA_CMAKE_ON=			-DWITH_LZMA:BOOL=ON
LZMA_CMAKE_OFF=			-DWITH_LZMA:BOOL=OFF
LIBMV_CMAKE_ON=			-DWITH_LIBMV:BOOL=ON
LIBMV_CMAKE_OFF=		-DWITH_LIBMV:BOOL=OFF
MENU_USES=			desktop-file-utils
NLS_CMAKE_ON=			-DWITH_INTERNATIONAL:BOOL=ON
NLS_CMAKE_OFF=			-DWITH_INTERNATIONAL:BOOL=OFF
NLS_USES=			gettext iconv
OPENCOLORIO_CMAKE_ON=		-DWITH_OPENCOLORIO:BOOL=ON
OPENCOLORIO_CMAKE_OFF=		-DWITH_OPENCOLORIO:BOOL=OFF
OPENCOLORIO_LIB_DEPENDS=	libOpenColorIO.so:${PORTSDIR}/graphics/opencolorio
OPENEXR_CMAKE_ON=		-DWITH_IMAGE_OPENEXR:BOOL=ON
OPENEXR_CMAKE_OFF=		-DWITH_IMAGE_OPENEXR:BOOL=OFF
OPENEXR_LIB_DEPENDS=		libIlmImf.so:${PORTSDIR}/graphics/OpenEXR
OPENJPEG_CMAKE_ON=		-DWITH_SYSTEM_OPENJPEG:BOOL=ON \
				-DWITH_IMAGE_OPENJPEG:BOOL=ON
OPENJPEG_CMAKE_OFF=		-DWITH_IMAGE_OPENJPEG:BOOL=OFF
OPENJPEG_LIB_DEPENDS=		libopenjpeg.so:${PORTSDIR}/graphics/openjpeg
OPENMP_CMAKE_ON=		-DWITH_OPENMP:BOOL=ON
OPENMP_CMAKE_OFF=		-DWITH_OPENMP:BOOL=OFF
RAYOPTIMIZATION_CMAKE_ON=	-DWITH_RAYOPTIMIZATION:BOOL=ON
RAYOPTIMIZATION_CMAKE_OFF=	-DWITH_RAYOPTIMIZATION:BOOL=OFF
SAMPLERATE_CMAKE_ON=		-DWITH_SAMPLERATE:BOOL=ON
SAMPLERATE_CMAKE_OFF=		-DWITH_SAMPLERATE:BOOL=OFF
SAMPLERATE_LIB_DEPENDS=		libsamplerate.so:${PORTSDIR}/audio/libsamplerate
SNDFILE_CMAKE_ON=		-DWITH_CODEC_SNDFILE:BOOL=ON
SNDFILE_CMAKE_OFF=		-DWITH_CODEC_SNDFILE:BOOL=OFF
SNDFILE_LIB_DEPENDS=		libsndfile.so:${PORTSDIR}/audio/libsndfile
TIFF_CMAKE_ON=			-DWITH_IMAGE_TIFF:BOOL=ON
TIFF_CMAKE_OFF=			-DWITH_IMAGE_TIFF:BOOL=OFF
TIFF_LIB_DEPENDS=		libtiff.so:${PORTSDIR}/graphics/tiff
XINPUT_CMAKE_ON=		-DWITH_X11_XINPUT:BOOL=ON
XINPUT_CMAKE_OFF=		-DWITH_X11_XINPUT:BOOL=OFF
XINPUT_USE=			XORG=xi
XF86VMODE_CMAKE_ON=		-DWITH_X11_XF86VMODE:BOOL=ON
XF86VMODE_CMAKE_OFF=		-DWITH_X11_XF86VMODE:BOOL=OFF
XF86VMODE_USE=			XORG=xi xxf86vm

.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MMOD_OCEANSIM}
.if ${PORT_OPTIONS:MFFTW3}
CMAKE_ARGS+=	-DWITH_MOD_OCEANSIM:BOOL=ON
.else
BROKEN=		MOD_OCEANSIM requires FFTW3
.endif
.else
CMAKE_ARGS+=	-DWITH_MOD_OCEANSIM:BOOL=OFF
.endif

.if ${PORT_OPTIONS:MCYCLES}
CMAKE_ARGS+=	-DWITH_CYCLES:BOOL=ON
.if !${PORT_OPTIONS:MOPENEXR} || !${PORT_OPTIONS:MTIFF}
BROKEN=		CYCLES requires OPENEXR and TIFF
.endif
LIB_DEPENDS+=	libOpenImageIO.so:${PORTSDIR}/graphics/openimageio
.else
CMAKE_ARGS+=	-DWITH_CYCLES:BOOL=OFF
.endif

.if ${PORT_OPTIONS:MCYCLESOSL}
.if !${PORT_OPTIONS:MCYCLES}
IGNORE=	support for the OpenShadingLanguage in cycles obviously requires CYCLES
.endif
CMAKE_ARGS+=	-DWITH_CYCLES_OSL:BOOL=ON \
		-DLLVM_STATIC:BOOL=OFF \
		-DWITH_LLVM:BOOL=ON \
		-DLLVM_VERSION:STRING="3.3" \
		-DLLVM_CONFIG:STRING="${LOCALBASE}/bin/llvm-config33"
LIB_DEPENDS+=	liboslexec.so:${PORTSDIR}/graphics/openshadinglanguage
BUILD_DEPENDS+=	llvm-config33:${PORTSDIR}/devel/llvm33
.else
CMAKE_ARGS+=	-DWITH_CYCLES_OSL:BOOL=OFF
.endif

.if ${PORT_OPTIONS:MHEADLESS}
.if ${PORT_OPTIONS:MXINPUT} || ${PORT_OPTIONS:MXF86VMODE}
BROKEN=	HEADLESS does not require any X11 dependency
.endif
CMAKE_ARGS+=	-DWITH_HEADLESS:BOOL=ON
.else
CMAKE_ARGS+=	-DWITH_HEADLESS:BOOL=OFF
.endif

.if ${PORT_OPTIONS:MOPENAL}
.if ${PORT_OPTIONS:MSAMPLERATE}
USE_OPENAL=	al alut
CMAKE_ARGS+=	-DWITH_OPENAL:BOOL=ON
.else
BROKEN=		OPENAL requires SAMPLERATE
.endif
.else
CMAKE_ARGS+=	-DWITH_OPENAL:BOOL=OFF
.endif

.if ${PORT_OPTIONS:MPLAYER}
.if ${PORT_OPTIONS:MGAMEENGINE}
CMAKE_ARGS+=	-DWITH_PLAYER:BOOL=ON
.else
BROKEN=		PLAYER requires GAMEENGINE
.endif
.else
CMAKE_ARGS+=	-DWITH_PLAYER:BOOL=OFF
.endif

.if ${PORT_OPTIONS:MREDCODE}
.if ${PORT_OPTIONS:MOPENJPEG} && ${PORT_OPTIONS:MFFMPEG}
CMAKE_ARGS+=	-DWITH_IMAGE_REDCODE:BOOL=ON
.else
BROKEN=		REDCODE requires OPENJPEG and FFMPEG
.endif
.else
CMAKE_ARGS+=	-DWITH_IMAGE_REDCODE:BOOL=OFF
.endif

.if ${PORT_OPTIONS:MSDL}
.if ${PORT_OPTIONS:MSAMPLERATE}
USE_SDL=	sdl
CMAKE_ARGS+=	-DWITH_SDL:BOOL=ON
.else
BROKEN=		SDL requires SAMPLERATE
.endif
.else
CMAKE_ARGS+=	-DWITH_SDL:BOOL=OFF
.endif

post-patch:
	@cd ${WRKSRC}/intern/cycles && ${REINPLACE_CMD} \
		-e 's/__align/cycles_align/' \
		-e 's/__global/cycles_global/g' \
		util/util_types.h kernel/kernel_compat_cuda.h \
		kernel/kernel_displace.h kernel/kernel_film.h \
		kernel/kernel_passes.h kernel/kernel_path.h \
		kernel/kernel_random.h

# We ignore MAKE_ARGS, since those would set DESTDIR for make stage,
# which in turn would cause make install to install everything in a
# wrong location
do-install:
	@(cd ${INSTALL_WRKSRC} && ${SETENV} ${MAKE_ENV} ${MAKE_CMD} \
		${MAKE_FLAGS} ${MAKEFILE} ${INSTALL_TARGET})

post-install:
	${INSTALL_SCRIPT} ${WRKDIR}/blender ${STAGEDIR}${PREFIX}/bin/blender
	${INSTALL_PROGRAM} ${INSTALL_WRKSRC}/bin/blender \
		${STAGEDIR}${PREFIX}/bin/blender-bin
	${INSTALL_SCRIPT} ${INSTALL_WRKSRC}/bin/blender-thumbnailer.py \
		${STAGEDIR}${PREFIX}/bin/blender-thumbnailer.py
	@${ECHO} bin/blender >> ${TMPPLIST}
	@${ECHO} bin/blender-bin >> ${TMPPLIST}
	@${ECHO} bin/blender-thumbnailer.py >> ${TMPPLIST}

.if ${PORT_OPTIONS:MPLAYER}
	${INSTALL_SCRIPT} ${WRKDIR}/blenderplayer \
		${STAGEDIR}${PREFIX}/bin/blenderplayer
	${INSTALL_PROGRAM} ${INSTALL_WRKSRC}/bin/blenderplayer \
		${STAGEDIR}${PREFIX}/bin/blenderplayer-bin
	@${ECHO} bin/blenderplayer >> ${TMPPLIST}
	@${ECHO} bin/blenderplayer-bin >> ${TMPPLIST}
.endif

.if ${PORT_OPTIONS:MMENU}
	${MKDIR} ${STAGEDIR}${DESKTOPDIR}
	${INSTALL_DATA} ${INSTALL_WRKSRC}/bin/${PORTNAME}.desktop \
		${STAGEDIR}${DESKTOPDIR}
	@-update-desktop-database -q
	@${ECHO} share/applications/${PORTNAME}.desktop >> ${TMPPLIST}
.endif

	${MKDIR} ${STAGEDIR}${DATADIR}
	(cd ${OUTDIR} && ${COPYTREE_SHARE} scripts ${STAGEDIR}${DATADIR})
	${INSTALL_DATA} ${INSTALL_WRKSRC}/bin/${PORTNAME}.svg \
		${STAGEDIR}${PREFIX}/share/pixmaps/${PORTNAME}.svg
	@(cd ${OUTDIR}; ${FIND} scripts -type f) | ${SORT} | ${SED} "s|^|${DATADIR_REL}/|" >> ${TMPPLIST}
	@(cd ${OUTDIR}; ${FIND} scripts -type d) | ${SORT} -r | ${SED} "s|^|@dirrm ${DATADIR_REL}/|" >> ${TMPPLIST}
	@${ECHO} share/pixmaps/${PORTNAME}.svg >> ${TMPPLIST}

.if ${PORT_OPTIONS:MOPENCOLORIO}
	cd ${OUTDIR} && ${COPYTREE_SHARE} datafiles/colormanagement ${STAGEDIR}${DATADIR}
	@(cd ${OUTDIR}; ${FIND} datafiles/colormanagement -type f) | ${SORT} | ${SED} "s|^|${DATADIR_REL}/|" >> ${TMPPLIST}
	@(cd ${OUTDIR}; ${FIND} datafiles/colormanagement -type d) | ${SORT} -r | ${SED} "s|^|@dirrm ${DATADIR_REL}/|" >> ${TMPPLIST}
.endif

.if ${PORT_OPTIONS:MNLS}
	cd ${OUTDIR} && ${COPYTREE_SHARE} datafiles/locale ${STAGEDIR}${DATADIR}
	@(cd ${OUTDIR}; ${FIND} datafiles/locale -type f -name languages) | ${SORT} | ${SED} "s|^|${DATADIR_REL}/|" >> ${TMPPLIST}
	@(cd ${OUTDIR}; ${FIND} datafiles/locale -type f -name ${PORTNAME}.mo) | ${SORT} | ${SED} "s|^|${DATADIR_REL}/|" >> ${TMPPLIST}
	cd ${OUTDIR} && ${COPYTREE_SHARE} datafiles/fonts ${STAGEDIR}${DATADIR}
	@(cd ${OUTDIR}; ${FIND} datafiles/fonts -type f) | ${SORT} | ${SED} "s|^|${DATADIR_REL}/|" >> ${TMPPLIST}
	@(cd ${OUTDIR}; ${FIND} datafiles/fonts -type d) | ${SORT} -r | ${SED} "s|^|@dirrm ${DATADIR_REL}/|" >> ${TMPPLIST}
	@(cd ${OUTDIR}; ${FIND} datafiles/locale -type d) | ${SORT} -r | ${SED} "s|^|@dirrm ${DATADIR_REL}/|" >> ${TMPPLIST}
.endif
	@${ECHO} @dirrm ${DATADIR_REL}/datafiles >> ${TMPPLIST}
	@${ECHO} @dirrm ${DATADIR_REL} >> ${TMPPLIST}

.if !defined(NO_INSTALL_MANPAGES)
	${INSTALL_MAN} ${INSTALL_WRKSRC}/bin/${PORTNAME}.1 \
		${STAGEDIR}${MAN1PREFIX}/man/man1
	@${ECHO} man/man1/${PORTNAME}.1.gz >> ${TMPPLIST}
.endif

.include <bsd.port.mk>
