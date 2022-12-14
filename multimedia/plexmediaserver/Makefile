# Created by: KalleDK <plexmaintainer@k-moeller.dk>
# $FreeBSD$

PORTNAME=	plexmediaserver
PORTVERSION=	0.9.8.14.263
CATEGORIES=	multimedia
MASTER_SITES=	http://plex.r.worldssl.net/plex-media-server/${PORTVERSION}-${PLEX_BUILD}/
DISTNAME=	PlexMediaServer-${PORTVERSION}-${PLEX_BUILD}-freebsd-amd64

MAINTAINER=	feld@FreeBSD.org
COMMENT=	The Plex Media Server component

USE_BZIP2=	yes
PLEX_BUILD=	139ddbc
NO_BUILD=	yes
WRKSRC=	${WRKDIR}/PlexMediaServer-${PORTVERSION}-${PLEX_BUILD}

USE_RC_SUBR=	plexmediaserver

SUB_FILES=	plexmediaserver
SUB_LIST=	SUPPORT_PATH=${SUPPORT_PATH} SCRIPT_PATH="${SCRIPT_PATH}" USERS=${USERS} GROUPS=${GROUPS}

USERS=	plex
GROUPS=	plex
SUPPORT_PATH?=	${PREFIX}/plexdata
SCRIPT_PATH?=	${DATADIR}

ONLY_FOR_ARCHS=	amd64

.include <bsd.port.pre.mk>

.if ${OSVERSION} < 900000
IGNORE= supplied binaries compiled for FreeBSD 9
.endif

.if ${OSVERSION} >= 1000054
BROKEN=	Waiting for Plex to include Python patch http://bugs.python.org/issue18178
RUN_DEPENDS+=	${LOCALBASE}/lib/compat/libstdc++.so.6:${PORTSDIR}/misc/compat9x
.endif

do-install:
	@(cd ${WRKSRC} && ${COPYTREE_SHARE} Resources ${STAGEDIR}/${SCRIPT_PATH})
	${INSTALL_PROGRAM} ${WRKSRC}/Plex\ DLNA\ Server ${STAGEDIR}/${SCRIPT_PATH}
	${INSTALL_PROGRAM} ${WRKSRC}/Plex\ Media\ Scanner ${STAGEDIR}/${SCRIPT_PATH}
	${INSTALL_PROGRAM} ${WRKSRC}/Plex\ Media\ Server ${STAGEDIR}/${SCRIPT_PATH}
	${INSTALL_SCRIPT} ${WRKSRC}/start.sh ${STAGEDIR}/${SCRIPT_PATH}
	${INSTALL_LIB} ${WRKSRC}/lib* ${STAGEDIR}/${SCRIPT_PATH}
	# Fix permissions to programs and db
	@${CHMOD} a+x ${STAGEDIR}/${SCRIPT_PATH}/Resources/rsync
	@${CHMOD} a+x ${STAGEDIR}/${SCRIPT_PATH}/Resources/Plex\ New\ Transcoder
	@${CHMOD} a+x ${STAGEDIR}/${SCRIPT_PATH}/Resources/Plex\ Transcoder
	@${CHMOD} a+x ${STAGEDIR}/${SCRIPT_PATH}/Resources/Python/bin/python
	@${CHMOD} u+w ${STAGEDIR}/${SCRIPT_PATH}/Resources/com.plexapp.plugins.library.db
	# Python fix
	@${LN} -s ${SCRIPT_PATH}/libpython2.7.so.1 ${STAGEDIR}/${SCRIPT_PATH}/libpython2.7.so

.include <bsd.port.post.mk>
