# $FreeBSD$

PORTNAME=	prayer
PORTVERSION=	1.3.5
CATEGORIES=	mail www
MASTER_SITES=	ftp://ftp.csx.cam.ac.uk/pub/software/email/prayer/

MAINTAINER=	bapt@FreeBSD.org
COMMENT=	Prayer Webmail System

LICENSE=	GPLv2

LIB_DEPENDS=	libc-client4.so:${PORTSDIR}/mail/cclient

USES=		iconv shebangfix gmake perl5 uidfix
USE_PERL5=	build

SHEBANG_FILES=	utils/ucsnews.pl \
		templates/old/make_olist.pl \
		templates/src/*.pl

PORTDOCS=	ACCOUNTD CMD_LINE DESIGN DONE DONE-OLD FEATURES ICONLIST \
		INSTALL LOGS NOTICE README ROADMAP SECURITY TODO

USE_RC_SUBR=	prayer

OPTIONS_DEFINE=	SESSIONCACHE TIDY SSL LDAP DOCS
OPTIONS_DEFAULT=	SESSIONCACHE TIDY SSL LDAP

SESSIONCACHE_DESC=	Activate Session Cache

USERS=		_prayer
GROUPS=		prayer

SESSIONCACHE_USE=	BDB=yes
LDAP_USE=		OPENLDAP=yes
TIDY_LIB_DEPENDS=	libtidy-0.99.so:${PORTSDIR}/www/tidy-lib

GID!=		id -g
DESTDIRNAME=	BROOT
MAKE_ARGS+=	RW_USER="${UID}" RW_GROUP="${GID}" RO_GROUP="${GID}" RO_USER="${UID}" \
		CCLIENT_INCLUDE="-I${LOCALBASE}/include/c-client" \
		CCLIENT_LIBS="-L${LOCALBASE}/lib -lc-client4" \
		CC="${CC}" \
		CPPFLAGS="${CFLAGS}" \
		PREFIX="${PREFIX}/prayer" \
		BIN_DIR="${PREFIX}/sbin" \
		PRAYER_CONFIG_FILE="${ETCDIR}/prayer.cf" \
		ACCOUNTD_CONFIG_FILE="${ETCDIR}/accountd.cf"

.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MLDAP_ENABLE}
MAKE_ARGS+=	LDAP_ENABLE=true \
		LDAP_INCLUDE="-I${LOCALBASE}/include" \
		LDAP_LIBS="-L${LOCALBASE}/lib -lldap"
.else
MAKE_ARGS+=	LDAP_ENABLE=false
.endif

.if ${PORT_OPTIONS:MTIDY}
MAKE_ARGS+=	TIDY_ENABLE=true \
		TIDY_INCLUDE=-I${LOCALBASE}/include/tidy \
		TIDY_LIBS="-L${LOCALBASE}/lib -ltidy"
.else
MAKE_ARGS+=	TIDY_ENABLE=false
.endif

.if ${PORT_OPTIONS:MSSL}
MAKE_ARGS+=	CCLIENT_SSL_ENABLE=true \
		SSL_ENABLE=true
.else
MAKE_ARGS+=	CCLIENT_SSL_ENABLE=false \
		SSL_ENABLE=false
.endif

.if ${PORT_OPTIONS:MSESSION_CACHE}
MAKE_ARGS+=	SESSION_CACHE_ENABLE=true \
		DB_INCLUDE=-I${BDB_INCLUDE_DIR} \
		DB_LIBS="-L${BDB_LIB_DIR} -l${BDB_LIB_NAME}"
.else
MAKE_ARGS+=	SESSION_CACHE_ENABLE=false
.endif

pre-patch:
	@${CP} ${WRKSRC}/defaults/Config ${WRKSRC}/Config

post-patch:
# correct chroot
	@${REINPLACE_CMD} "s#\"/chroot/prayer\"#config->var_prefix#" ${WRKSRC}/servers/prayer_chroot.c
# change the user in the default config and cylog util
	@${REINPLACE_CMD} "s#prayer_user           = \"prayer\"#prayer_user           = \"_prayer\"#" ${WRKSRC}/files/etc/prayer.cf.SRC
	@${REINPLACE_CMD} "s#\"prayer\" \"prayer\"#\"_prayer\" \"prayer\"#" ${WRKSRC}/utils/prayer-cyclog.SRC
	@${REINPLACE_CMD} "s,-liconv,${ICONV_LIB}," ${WRKSRC}/Config

pre-install:
	@${MKDIR} ${STAGEDIR}${PREFIX}/etc/prayer \
		${STAGEDIR}${PREFIX}/prayer

post-install:
	@${MKDIR} ${STAGEDIR}${DOCSDIR}
	@cd ${WRKSRC}/docs && ${INSTALL_DATA} ${PORTDOCS} ${STAGEDIR}${DOCSDIR}
	@${MKDIR} ${STAGEDIR}/var/spool/prayer

.include <bsd.port.mk>
