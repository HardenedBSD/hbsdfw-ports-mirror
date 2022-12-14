# Created by: Wen Heping <wenheping@gmail.com>
# $FreeBSD$

PORTNAME=	libsbml
PORTVERSION=	4.2.0
CATEGORIES=	biology devel
MASTER_SITES=	SF
MASTER_SITE_SUBDIR=	sbml/${PORTNAME}/${PORTVERSION}
DISTNAME=	${PORTNAME}-${PORTVERSION}-src

MAINTAINER=	wen@FreeBSD.org
COMMENT=	API Library for Working with SBML File

LIB_DEPENDS=	libxml2.so:${PORTSDIR}/textproc/libxml2

OPTIONS_DEFINE=	PYTHON RUBY

USE_GMAKE=	yes
USE_ZIP=	yes
USE_GCC=	any
GNU_CONFIGURE=	yes
USE_LDCONFIG=	yes
WRKSRC=		${WRKDIR}/${PORTNAME}-${PORTVERSION}
MAKE_JOBS_UNSAFE=	yes

NO_STAGE=	yes
.include <bsd.port.pre.mk>
.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MPYTHON}
.include "../../Mk/bsd.python.mk"
BUILD_DEPENDS+=		${LOCALBASE}/bin/python:${PORTSDIR}/lang/python
CONFIGURE_ARGS+=	--with-python
PLIST_SUB+=		WITH_PYTHON="" \
			SBML_EGGINFO=${PORTNAME}-${PORTVERSION}-${PYTHON_VERSION:S/thon//}.egg-info
.else
PLIST_SUB+=		WITH_PYTHON="@comment "
.endif

.if ${PORT_OPTIONS:MRUBY}
.include "../../Mk/bsd.ruby.mk"
BUILD_DEPENDS+=		${LOCALBASE}/bin/ruby:${PORTSDIR}/lang/ruby19
CONFIGURE_ARGS+=	--with-ruby
PLIST_SUB+=		WITH_RUBY=""
.else
PLIST_SUB+=		WITH_RUBY="@comment "
.endif

post-patch:
	${REINPLACE_CMD} -e 's#%%PREFIX%%#${PREFIX}#' \
		${WRKSRC}/Makefile.in

post-install:
.if ${PORT_OPTIONS:MEXAMPLES}
	${MKDIR} ${EXAMPLESDIR}
	cd ${WRKSRC}/examples \
		&& ${FIND} . -type d -exec ${MKDIR} ${EXAMPLESDIR}/\{} \; \
		&& ${FIND} . -type f -exec ${INSTALL_DATA} \{} ${EXAMPLESDIR}/\{} \;
.endif
.include <bsd.port.post.mk>
