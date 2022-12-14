# Created by: Dmitry Sivachenko <demon@FreeBSD.org>
# $FreeBSD$

PORTNAME=	jabberd
DISTVERSION=	2.3.1
CATEGORIES=	net-im
MASTER_SITES=	https://github.com/jabberd2/jabberd2/releases/download/${PORTNAME}-${DISTVERSION}/ \
		http://freefall.freebsd.org/~matthew/distfiles/

MAINTAINER=	mm@FreeBSD.org
COMMENT=	Online presence and instant messaging server

LICENSE=	GPLv2

LIB_DEPENDS=	libexpat.so:${PORTSDIR}/textproc/expat2 \
		libidn.so:${PORTSDIR}/dns/libidn \
		libudns.so:${PORTSDIR}/dns/udns

OPTIONS_DEFINE=	MYSQL PGSQL LDAP BDB SQLITE PAM PIPE ANON FS DEBUG REQUIRES \
		DOCS SUPERSEDED EXPERIMENTAL
OPTIONS_SINGLE=	SASL
OPTIONS_SINGLE_SASL=	CYRUS GSASL
OPTIONS_DEFAULT=MYSQL DEBUG GSASL
OPTIONS_SUB=	yes

USE_XZ=		yes
FETCH_ARGS=	-Fpr
GNU_CONFIGURE=	yes
USE_PERL5=	run
USE_OPENSSL=	yes
USES=		iconv perl5 compiler:c11
USE_RC_SUBR=	jabberd
USE_LDCONFIG=	${PREFIX}/lib/jabberd
CONFIGURE_ARGS+=	--localstatedir=/var \
		--sysconfdir=${PREFIX}/etc/jabberd \
		--enable-ssl --enable-mio=poll \
		--disable-tests \
		--with-extra-include-path="${LOCALBASE}/include ${EIP}" \
		--with-extra-library-path="${LOCALBASE}/lib ${ELP}"

JABBER_USER=	jabber
JABBER_GROUP=	jabber

USERS=		${JABBER_USER}
GROUPS=		${JABBER_GROUP}

JABBER_ETCDIR=	"${PREFIX}/etc/jabberd"
JABBER_RUNDIR=	"/var/jabberd"

SUB_LIST+=	JABBER_USER=${JABBER_USER} \
		JABBER_GROUP=${JABBER_GROUP} \
		JABBER_ETCDIR="${JABBER_ETCDIR}" \
		JABBER_RUNDIR="${JABBER_RUNDIR}" \
		PERL="${PERL}"

SUB_FILES+=	pkg-install pkg-deinstall

PORTDOCS=	*

DOCFILES=	AUTHORS ChangeLog NEWS README README.config \
		README.protocol TODO

_REQUIRE=	LOGIN

ELP+=	${OPENSSLLIB}
EIP+=	${OPENSSLINC}

DEBUG_CONFIGURE_ENABLE=	debug

PGSQL_USE=		PGSQL=yes
PGSQL_CONFIGURE_ENABLE=	pgsql

SQLITE_CONFIGURE_ENABLE=sqlite
SQLITE_LIB_DEPENDS=	libsqlite3.so:${PORTSDIR}/databases/sqlite3
SQLITE_CFLAGS=		${PTHREAD_CFLAGS}

MYSQL_USE=		MYSQL=yes
MYSQL_CONFIGURE_ENABLE=	mysql

BDB_USE=		BDB=41+
BDB_CONFIGURE_ENABLE=	db
BDB_CONFIGURE_ON=	--oldincludedir=/nonexistant

LDAP_USE=		OPENLDAP=yes
LDAP_CONFIGURE_ENABLE=	ldap

FS_CONFIGURE_ENABLE=	fs
FS_DESC=		Filesystem storage (only for testing)

PAM_CONFIGURE_ENABLE=	pam

PIPE_CONFIGURE_ENABLE=	pipe
PIPE_DESC=		Enable pipe (auth/reg)

ANON_CONFIGURE_ENABLE=	anon
ANON_DESC=		Enable anonymous (auth/reg)

CYRUS_CONFIGURE_ON=	--with-sasl=cyrus
CYRUS_DESC=		Use Cyrus SASL backend (not supported)
CYRUS_LIB_DEPENDS=	libsasl2.so:${PORTSDIR}/security/cyrus-sasl2

GSASL_CONFIGURE_ON=	--with-sasl=gsasl
GSASL_DESC=		Use GSASL backend
GSASL_LIB_DEPENDS=	libgsasl.so:${PORTSDIR}/security/gsasl

SUPERSEDED_CONFIGURE_ENABLE=	superseded
SUPERSEDED_DESC=	Enable superseded features (ns_TIME)

EXPERIMENTAL_CONFIGURE_ENABLE=	experimental
EXPERIMENTAL_DESC=	Enable experimental features (TLS-Everywhere)

.include <bsd.port.options.mk>

.if (${OPSYS} != FreeBSD || ${OSVERSION} < 10000000)
WITH_OPENSSL_PORT=	yes
.endif

.if ${PORT_OPTIONS:MPGSQL}
_REQUIRE+=		postgresql
.endif

.if ${PORT_OPTIONS:MMYSQL}
EIP+=${LOCALBASE}/include/mysql
ELP+=${LOCALBASE}/lib/mysql
_REQUIRE+=	mysql
.endif

.if ${PORT_OPTIONS:MBDB}
EIP+=${BDB_INCLUDE_DIR}
ELP+=${BDB_LIB_DIR}
.endif

.if ${PORT_OPTIONS:MLDAP}
_REQUIRE+=	slapd
.endif

.if ${PORT_OPTIONS:MREQUIRES}
SUB_LIST+=	REQUIRE="${_REQUIRE}"
.else
SUB_LIST+=	REQUIRE="LOGIN"
.endif
REQUIRES_DESC=	Add backend requires to startup script

post-patch:
	@${REINPLACE_CMD} -e 's|"-lsqlite3|"-lsqlite3 ${PTHREAD_LIBS}|g' \
		${WRKSRC}/configure
	@${REINPLACE_CMD} -e 's|%%PERL%%|${PERL}|g' \
		${WRKSRC}/tools/jabberd.in
.if ${PORT_OPTIONS:MCYRUS}
	@${REINPLACE_CMD} -e '/^#error /d' \
		${WRKSRC}/sx/sasl_cyrus.c
.endif

post-install:
.if ${PORT_OPTIONS:MDOCS}
	@${MKDIR} ${STAGEDIR}${DOCSDIR}
.for FILE in ${DOCFILES}
	${INSTALL_DATA} ${WRKSRC}/${FILE} ${STAGEDIR}${DOCSDIR}
.endfor
.for FILE in db-setup.mysql db-setup.pgsql db-setup.sqlite
	${INSTALL_DATA} ${WRKSRC}/tools/${FILE} ${STAGEDIR}${DOCSDIR}
.endfor
.endif

.include <bsd.port.mk>
