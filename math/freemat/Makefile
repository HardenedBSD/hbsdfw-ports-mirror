# Created by: Thierry Thomas <thierry@pompo.net>
# $FreeBSD$

PORTNAME=		FreeMat
PORTVERSION=		4.0
DISTVERSIONSUFFIX=	-Source
PORTREVISION=	6
CATEGORIES=		math science
MASTER_SITES=		SF
MASTER_SITE_SUBDIR=	freemat/FreeMat4
.ifdef WITH_MPI
PKGNAMESUFFIX=		-mpi
.endif

MAINTAINER=		ports@FreeBSD.org
COMMENT=		An environment for rapid engineering and scientific processing

LIB_DEPENDS=		lapack.4:${PORTSDIR}/math/lapack	\
			pcre.3:${PORTSDIR}/devel/pcre

LICENSE=		GPLv2

WRKSRC=			${WRKDIR}/${PORTNAME}-${PORTVERSION}.1${DISTVERSIONSUFFIX}

.ifdef WITH_MPI
IGNORE=			no MPI support at the moment
.endif

USE_FORTRAN=		yes
FFLAGS+=		-O2

USE_GL=			yes
USES=			cmake pkgconfig
USE_QT4=		gui network opengl moc_build rcc_build uic_build \
			qmake_build xml svg
CPPFLAGS+=		${CXXFLAGS} -I${LOCALBASE}/include  ${AMDINC}

SLAVEDIRS=	math/freemat-mpi

DATADIR+=	${PREFIX}/share/${PORTNAME}-${PORTVERSION}

.if !defined(WITHOUT_FFTW)
LIB_DEPENDS+=	fftw3:${PORTSDIR}/math/fftw3		\
		fftw3f:${PORTSDIR}/math/fftw3-float
.endif

.if !defined(WITHOUT_ARPACK)
LIB_DEPENDS+=	arpack.1:${PORTSDIR}/math/arpack
.endif

.if !defined(WITHOUT_AVCALL)
BUILD_DEPENDS+=	${LOCALBASE}/lib/libavcall.a:${PORTSDIR}/devel/ffcall
.endif

.if !defined(WITHOUT_PORTAUDIO)
LIB_DEPENDS+=	portaudio.0:${PORTSDIR}/audio/portaudio
.endif

NO_STAGE=	yes
.include <bsd.port.pre.mk>

.if ${OSVERSION} < 800023
# Add math functions that didn't exist until 8.x
EXTRA_PATCHES+=	${FILESDIR}/extra-patch-libs__libFN__CMakeLists.txt \
		${FILESDIR}/extra-patch-libs__libFN__mathfunc4.cpp \
		${FILESDIR}/extra-patch-libs__libFN__FNFun.cpp
.endif

.if exists(${LOCALBASE}/lib/libatlas.so) && !defined(WITH_BLAS)
WITH_ATLAS=	yes
.endif
.if defined(WITH_ATLAS)
LIB_DEPENDS+=	atlas.2:${PORTSDIR}/math/atlas
BLAS=		-lf77blas
LAPACK=		-lalapack -lcblas
.else
LIB_DEPENDS+=	blas.2:${PORTSDIR}/math/blas	\
		lapack.4:${PORTSDIR}/math/lapack
BLAS=		-lblas
LAPACK=		-llapack
.endif

.if !defined(WITHOUT_UMFPACK)
LIB_DEPENDS+=	amd.1:${PORTSDIR}/math/suitesparse
AMDINC=		-I${LOCALBASE}/include/suitesparse
.endif

pre-everything::
.if !defined(WITH_ATLAS)
	@${ECHO_MSG} '**********************************************************'
	@${ECHO_MSG} '* You can define the following variables:                *'
	@${ECHO_MSG} '* - WITH_ATLAS:       to link with atlas                 *'
	@${ECHO_MSG} '* - WITHOUT_FFTW      remove FFTW support                *'
	@${ECHO_MSG} '* - WITHOUT_ARPACK    remove Arpack support              *'
	@${ECHO_MSG} '* - WITHOUT_AVCALL    remove FFCALL support              *'
	@${ECHO_MSG} '* - WITHOUT_UMFPACK   remove UMFPACK support             *'
	@${ECHO_MSG} '* - WITHOUT_PORTAUDIO remove Audio I/O support           *'
	@${ECHO_MSG} '**********************************************************'
.endif

# Get rid of the generated .moc.cpp files included in the
# upstream distro.  They should be regenerated with the
# currently-installed version of moc-qt4.
post-extract:
	@cd ${WRKSRC} && ${FIND} . -name \*.moc.cpp -delete

pre-configure:
	@${RM} ${WRKSRC}/CMakeCache.txt

# Avoid conflict with QT3
post-configure:
	@${FIND} ${WRKSRC} -name Makefile | ${XARGS}	\
		${REINPLACE_CMD} -e '/^QT_CFLAGS/s|-I${LOCALBASE}/include ||'

post-install:
	@${ECHO_MSG}
	@${ECHO_MSG} "===> Initializing..."
	${PREFIX}/bin/FreeMat -i ${DATADIR}
	@${ECHO_MSG}

.include <bsd.port.post.mk>
