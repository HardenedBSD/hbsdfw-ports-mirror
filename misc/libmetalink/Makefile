# Created by: Mario Sergio Fujikawa Ferreira <lioux@FreeBSD.org>
# $FreeBSD$

PORTNAME=	libmetalink
PORTVERSION=	0.0.3
PORTREVISION=	1
CATEGORIES=	misc
MASTER_SITES=	http://launchpad.net/libmetalink/trunk/${PORTVERSION}/+download/

MAINTAINER=	ports@FreeBSD.org
COMMENT=	Metalink library written in C language

LIB_DEPENDS=	expat.6:${PORTSDIR}/textproc/expat2

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/COPYING

FETCH_ARGS=
USE_BZIP2=	yes
USE_GCC=	yes
GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	\
		--with-libexpat-prefix="${LOCALBASE}" \
		--with-libxml2="no"
USE_LDCONFIG=	yes

# Examples to install
EXAMPLES_FILES=	\
	doc/sample.c \
	doc/ubuntu-7_10-server-i386_iso.metalink

.ifndef(NOPORTEXAMPLES)
PORTEXAMPLES=	*
.endif

NO_STAGE=	yes
post-patch:
# do not automagically install either documents or examples
	@${REINPLACE_CMD} -E \
		-e 's|^(install:).*|\1|' \
		${WRKSRC}/doc/Makefile.in
# fix pkgconfig install destination
	@${REINPLACE_CMD} -E \
		-e 's|^(pkgconfigdir[[:space:]]*=).*$$|\1${PREFIX}/libdata/pkgconfig|' \
		${WRKSRC}/lib/Makefile.in

post-install:
# examples
.ifndef(NOPORTEXAMPLES)
	@${MKDIR} ${EXAMPLESDIR}
.for file in ${EXAMPLES_FILES}
	@${INSTALL_DATA} ${WRKSRC}/${file} ${EXAMPLESDIR}
.endfor
.endif

.include <bsd.port.mk>
