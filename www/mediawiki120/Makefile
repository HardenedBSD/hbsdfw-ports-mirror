# Created by: Gerrit Beine <tux@pinguru.net>
# $FreeBSD$

PORTNAME=	mediawiki
PORTVERSION=	1.20.8
CATEGORIES=	www
MASTER_SITES=	http://dumps.wikimedia.org/mediawiki/${PORTVERSION:R}/
PKGNAMESUFFIX=	120

MAINTAINER=	wen@FreeBSD.org
COMMENT=	The wiki engine used by Wikipedia

LICENSE=	GPLv2

CONFLICTS=	mediawiki-1.1[0-9].* mediawiki-1.21.*

FETCH_ARGS=	-pr
USE_PHP=	ctype hash iconv mbstring pcre session xml zlib readline dom
WANT_PHP_WEB=	yes
MEDIAWIKIDIR?=	www/mediawiki
SUB_FILES=	pkg-message
SUB_LIST+=	MEDIAWIKIDIR="${PREFIX}/${MEDIAWIKIDIR}"

NO_BUILD=	yes

OPTIONS_DEFINE=	MYSQL PGSQL SQLITE LDAP MEMCACHED APC EACCEL XCACHE IMAGICK
OPTIONS_DEFAULT=MYSQL APC

MEMCACHED_DESC=	use memcached
APC_DESC=	use pecl-APC(Mediawiki recommended)
EACCEL_DESC=	use eAccelerator (instead of pecl-APC)
XCACHE_DESC=	use xCache (instead of pecl-APC)
IMAGICK_DESC=	use ImageMagick

.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MMYSQL}
USE_MYSQL=	client
USE_PHP+=	mysql
.endif

.if ${PORT_OPTIONS:MPGSQL}
USE_PHP+=	pgsql
.endif

.if ${PORT_OPTIONS:MSQLITE}
USE_PHP+=	sqlite3
.endif

.if ${PORT_OPTIONS:MLDAP}
USE_PHP+=	ldap
.endif

.if ${PORT_OPTIONS:MMEMCACHED}
RUN_DEPENDS=	memcached:${PORTSDIR}/databases/memcached
.endif

.if ${PORT_OPTIONS:MIMAGICK}
RUN_DEPENDS+=	${LOCALBASE}/lib/php/${PHP_EXT_DIR}/imagick.so:${PORTSDIR}/graphics/pecl-imagick
.endif

.if ${PORT_OPTIONS:MAPC}
RUN_DEPENDS+=	${LOCALBASE}/lib/php/${PHP_EXT_DIR}/apc.so:${PORTSDIR}/www/pecl-APC
.elif ${PORT_OPTIONS:MEACCEL}
RUN_DEPENDS+=	${LOCALBASE}/lib/php/${PHP_EXT_DIR}/eaccelerator.so:${PORTSDIR}/www/eaccelerator
.elif ${PORT_OPTIONS:MXCACHE}
RUN_DEPENDS+=	${LOCALBASE}/lib/php/${PHP_EXT_DIR}/xcache.so:${PORTSDIR}/www/xcache
.endif

do-install:
	@${MKDIR} ${STAGEDIR}${PREFIX}/${MEDIAWIKIDIR}
	${CP} -r ${WRKSRC}/ ${STAGEDIR}${PREFIX}/${MEDIAWIKIDIR}
	${CHOWN} -R ${WWWOWN}:${WWWGRP} ${STAGEDIR}${PREFIX}/${MEDIAWIKIDIR}

	@${FIND} ${WRKSRC}/${file} -not -type d \
		| ${SED} -ne 's,^${WRKSRC},${MEDIAWIKIDIR},p' >> ${TMPPLIST}
	@${FIND} -d ${WRKSRC}/${file} -type d \
		| ${SED} -ne 's,^${WRKSRC},@dirrm ${MEDIAWIKIDIR},p' >> ${TMPPLIST}

.include <bsd.port.mk>
