# Created by: Mario Sergio Fujikawa Ferreira <lioux@FreeBSD.org>
# $FreeBSD$

PORTNAME=	i2p
PORTVERSION=	0.8.7
CATEGORIES=	net-p2p java security
MASTER_SITES=	${MASTER_SITE_GOOGLE_CODE}:i2p \
		http://mirror.i2p2.de/:i2p \
		http://dist.codehaus.org/jetty/jetty-5.1.x/:jetty
DISTFILES=	\
		i2psource_${PORTVERSION}${EXTRACT_SUFX}:i2p \
		${JETTY_DISTFILE}:jetty
EXTRACT_ONLY=	i2psource_${PORTVERSION}${EXTRACT_SUFX}

MAINTAINER=	ports@FreeBSD.org
COMMENT=	An anonymizing network

LICENSE=	AL2 EULA
LICENSE_COMB=	multi

BUILD_DEPENDS=	${LOCALBASE}/lib/libgmp.a:${PORTSDIR}/math/gmp \
		msgfmt:${PORTSDIR}/devel/gettext
RUN_DEPENDS=	unzip:${PORTSDIR}/archivers/unzip

LICENSE_NAME_EULA=	End User License Agreement
LICENSE_PERMS_EULA=	dist-mirror dist-sell pkg-mirror pkg-sell auto-accept
LICENSE_FILE_EULA=	${WRKSRC}/LICENSE.txt
LICENSE_DISTFILES_ASL=	${JETTY_DISTFILE}
LICENSE_DISTFILES_EULA=	i2psource_${PORTVERSION}${EXTRACT_SUFX}

USE_BZIP2=	yes
USE_RC_SUBR=	i2p

JAVA_BUILD=	jdk
USE_JAVA=	yes
JAVA_VERSION=	1.6+
USE_ANT=	yes

ALL_TARGET=	\
		updater \
		tarball

.ifndef(NOPORTDOCS)
ALL_TARGET+=	javadoc
.endif

JAVADOC_WRKSRC=	${WRKSRC}/build/javadoc

.ifndef(NOPORTDOCS)
PORTDOCS=	*
.endif

PLIST_DIRS=	\
		%%DATADIR%%
PLIST_FILES=	\
		sbin/i2prouter \
		%%DATADIR%%/i2p.tar.bz2 \
		%%DATADIR%%/i2pupdate.zip

JETTY_DISTFILE=	jetty-5.1.15.tgz

SUB_FILES=	wrapper.sh

NO_STAGE=	yes
post-extract:
	@${MKDIR} ${WRKSRC}/apps/jetty/
	@${CP} -f ${DISTDIR}/${JETTY_DISTFILE} ${WRKSRC}/apps/jetty/

post-patch:
# postinstall.sh SHOULD only do post installation house keeping
	@${REINPLACE_CMD} -E \
		-e 's|./i2prouter[[:space:]]+start||' \
		${WRKSRC}/installer/resources/postinstall.sh

do-install:
	@${MKDIR} ${DATADIR}
# install
	@${INSTALL_DATA} ${WRKSRC}/i2p.tar.bz2 \
		${DATADIR}/
# update
	@${INSTALL_DATA} ${WRKSRC}/i2pupdate.zip \
		${DATADIR}/
# wrapper
	@${INSTALL_SCRIPT} ${WRKDIR}/wrapper.sh \
		${PREFIX}/sbin/i2prouter
# doc
.ifndef(NOPORTDOCS)
	@${MKDIR} ${DOCSDIR}
	@${INSTALL_DATA} ${WRKSRC}/installer/resources/readme/readme*.html ${DOCSDIR}
# line taken from textproc/xerces-j maintained by hq@FreeBSD.org
	@cd ${JAVADOC_WRKSRC} && \
		${FIND} * -type d -exec ${MKDIR} "${DOCSDIR}/{}" \; && \
		${FIND} * -not -type d -exec ${INSTALL_DATA} "{}" "${DOCSDIR}/{}" \;
.endif

.include <bsd.port.mk>
