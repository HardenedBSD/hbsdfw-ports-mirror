# Created by: Edwin Groothuis <edwin@mavetju.org>
# $FreeBSD$

PORTNAME=	tinderbox
PORTVERSION=	4.1.0
CATEGORIES=	ports-mgmt
MASTER_SITES=	http://tinderbox.marcuscom.com/ \
		http://T32.TecNik93.com/FreeBSD/ports/${PORTNAME}/sources/
DIST_SUBDIR=	${PORTNAME}

MAINTAINER=	itetcu@FreeBSD.org
COMMENT=	Port build tinderbox system

RUN_DEPENDS=	dialog4ports-static:${PORTSDIR}/ports-mgmt/dialog4ports-static

CONFLICTS=	tinderbox-devel-[0-9]*

OPTIONS_MULTI=		DB
OPTIONS_MULTI_DB=	PGSQL MYSQL SQLITE

OPTIONS_RADIO=		WEB
OPTIONS_RADIO_WEB=	APACHE HIAWATHA LIGHTTPD NGINX

OPTIONS_DEFINE=		CHECK_ROOT EMAILS LSOF LOG_COMPRESS

CHECK_ROOT_DESC=	Check if ./tc is run by uid 0
EMAILS_DESC=		Support for build failure/completion emails
LSOF_DESC=		For killMountProcesses() when using nullfs
LOG_COMPRESS_DESC=	Support bzip log compression
HIAWATHA_DESC=		Hiawatha server
NGINX_DESC=		Nginx server

OPTIONS_DEFAULT=	MYSQL APACHE CHECK_ROOT EMAILS LSOF \
			LOG_COMPRESS

NO_BUILD=	yes
WANT_PERL=	yes
SUB_FILES=	pkg-message

.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MAPACHE} || ${PORT_OPTIONS:MHIAWATHA} || ${PORT_OPTIONS:MLIGHTTPD} || ${PORT_OPTIONS:MNGINX}
WEBUI=		yes
.endif

.if defined(WEBUI)
WANT_PHP_WEB=	yes
USE_PHP=	session
PLIST_SUB+=	WEBUI=""
.else
PLIST_SUB+=	WEBUI="@comment "
.endif

.if ${PORT_OPTIONS:MPGSQL}
USE_PGSQL=	yes
.if defined(WEBUI)
USE_PHP+=	pgsql pdo_pgsql
.endif
RUN_DEPENDS+=	p5-DBD-Pg>=0:${PORTSDIR}/databases/p5-DBD-Pg
.endif

.if ${PORT_OPTIONS:MMYSQL}
.if defined(WEBUI)
USE_PHP+=	mysql pdo_mysql
.endif
USE_MYSQL=	yes
RUN_DEPENDS+=	p5-DBD-mysql>=0:${PORTSDIR}/databases/p5-DBD-mysql
.endif

.if ${PORT_OPTIONS:MSQLITE}
.if defined(WEBUI)
USE_PHP+=	sqlite3 pdo_sqlite
.endif
RUN_DEPENDS+=	p5-DBD-SQLite>=0:${PORTSDIR}/databases/p5-DBD-SQLite
.endif

.if ${PORT_OPTIONS:MAPACHE}
USE_APACHE_RUN=	22+
.elif ${PORT_OPTIONS:MLIGHTTPD}
RUN_DEPENDS+=	lighttpd:${PORTSDIR}/www/lighttpd
.elif ${PORT_OPTIONS:MHIAWATHA}
RUN_DEPENDS+=	hiawatha:${PORTSDIR}/www/hiawatha
.elif ${PORT_OPTIONS:MNGINX}
RUN_DEPENDS+=	nginx:${PORTSDIR}/www/nginx
.endif

.if ${PORT_OPTIONS:MEMAILS}
RUN_DEPENDS+=	p5-Net>=0:${PORTSDIR}/net/p5-Net
.endif

.if ${PORT_OPTIONS:MLSOF}
RUN_DEPENDS+=	lsof:${PORTSDIR}/sysutils/lsof
.endif

.if ${PORT_OPTIONS:MLOG_COMPRESS}
RUN_DEPENDS+=	p5-Compress-Bzip2>=0:${PORTSDIR}/archivers/p5-Compress-Bzip2
.endif

post-patch:
.if ! ${PORT_OPTIONS:MCHECK_ROOT}
	${REINPLACE_CMD} -e 's/^if \[ `id -u` != 0 \]; then/if false; then/' \
		${WRKSRC}/tc
.endif

do-install:
	@${MKDIR} ${STAGEDIR}${PREFIX}/tinderbox/scripts
	${TAR} -C ${WRKSRC} --exclude man --exclude '*.orig' --exclude '*.bak' -cf - . \
		| tar -xf - --unlink -C ${STAGEDIR}${PREFIX}/tinderbox/scripts
	${TAR} -C ${WRKSRC}/man/man1 --exclude '*.orig' --exclude '*.bak' -cf - . \
		| tar -xf - --unlink -C ${STAGEDIR}${MAN1PREFIX}/man/man1
	${INSTALL_SCRIPT} ${WRKSRC}/etc/rc.d/tinderd ${STAGEDIR}${PREFIX}/etc/rc.d/${PORTNAME}

.include <bsd.port.mk>
