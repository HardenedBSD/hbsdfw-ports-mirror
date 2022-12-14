# Created by: trevor
# $FreeBSD$

PORTNAME=	spiralloops
PORTVERSION=	2.0.0
PORTREVISION=	7
CATEGORIES=	audio
MASTER_SITES=	http://www.pawfal.org/Software/SpiralLoops/dload/
DISTNAME=	SpiralLoops-${PORTVERSION}

MAINTAINER=	ports@FreeBSD.org
COMMENT=	Loop-based sampler

LIB_DEPENDS=	libfltk.so:${PORTSDIR}/x11-toolkits/fltk

NO_STAGE=	yes
DOCDIR=		share/doc/${PORTNAME}
DOC_FILES=	CHANGES COPYING README
GNU_CONFIGURE=	yes
MAKE_ENV=	PTHREAD_LIBS="${PTHREAD_LIBS}" \
		PTHREAD_CFLAGS="${PTHREAD_CFLAGS}"
PLIST=		${WRKDIR}/pkg-plist
WRKSRC=		${WRKDIR}/${DISTNAME}

.include <bsd.port.pre.mk>

post-patch:
	${MV} ${WRKSRC}/Makefile.in ${WRKSRC}/Makefile.in.orig
	${SED} -E "s:-ldl::g; \
		s:^CFLAGS:XCFLAGS:g; \
		s:^CXXFLAGS:XCXXFLAGS:g; \
		s:-O3:${PTHREAD_CFLAGS}:g; \
		s:CFLAGS =:CFLAGS +=:g; \
		s:CXXFLAGS=:CXXFLAGS+=:g; \
		s:-lm:${PTHREAD_LIBS} -lm:g; \
		s:/usr/X11R6:${LOCALBASE}:g" \
		< ${WRKSRC}/Makefile.in.orig > ${WRKSRC}/Makefile.in

	@${FIND} ${WRKSRC} -type f -name "*.C" -o -name "*.cpp" -o -name "*.h" | ${XARGS} \
	   ${REINPLACE_CMD} -e '/^#include <FL/s|.h>$$|.H>|; /^#include "FL/s|.h"$$|.H"|; \
	   s|fl_file_chooser.H|Fl_File_Chooser.H|g'

pre-install:
	${ECHO_CMD} bin/SpiralLoops > ${PLIST}
.if !defined(NOPORTDOCS)
.for i in ${DOC_FILES}
	${ECHO_CMD} ${DOCDIR}/`${BASENAME} ${i}` >> ${PLIST}
.endfor
	${ECHO_CMD} @dirrm ${DOCDIR} >> ${PLIST}
.endif

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/SpiralLoops ${PREFIX}/bin
.if !defined(NOPORTDOCS)
	${MKDIR} ${DOCSDIR}
.for i in ${DOC_FILES}
	${INSTALL_DATA} ${WRKSRC}/${i} ${DOCSDIR}
.endfor
.endif
.include <bsd.port.post.mk>
