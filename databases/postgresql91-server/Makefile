# Created by: Marc G. Fournier <scrappy@FreeBSD.org>
# $FreeBSD$

PORTNAME?=	postgresql
DISTVERSION?=	9.1.12
PORTREVISION?=	0
CATEGORIES?=	databases
MASTER_SITES=	PGSQL
MASTER_SITE_SUBDIR=	source/v${DISTVERSION}
PKGNAMESUFFIX?=	${DISTVERSION:R:S/.//}${COMPONENT}

MAINTAINER?=	pgsql@FreeBSD.org
COMMENT?=	The most advanced open-source database available anywhere

CONFLICTS?=	${PORTNAME}[^${PORTVERSION:R:R}]?-client* \
		${PORTNAME}${COMPONENT}-[^${PORTVERSION:R:R}].* \
		${PORTNAME}9[^${PORTVERSION:R:E}]-client* \
		${PORTNAME}${COMPONENT}-9.[^${PORTVERSION:R:E}].*

WRKSRC=		${WRKDIR}/postgresql-${DISTVERSION}
DIST_SUBDIR=	postgresql

ICU_PATCHFILE?=	pg-923-icu-2014-02-10.diff.gz

.if !defined(SLAVE_ONLY)
UNIQUENAME?=	${PORTNAME}${DISTVERSION:R:S/.//}
.else # Contrib has different options from -client/-server
UNIQUENAME?=	${PORTNAME}${DISTVERSION:R:S/.//}${PKGNAMESUFFIX}
.endif

PKGINSTALL?=	${PKGDIR}/pkg-install${COMPONENT}
USE_BZIP2=	yes
.if !defined(NO_BUILD)
USES+=	gmake
GNU_CONFIGURE=	yes
.endif

PG_USER=	pgsql
PG_GROUP=	pgsql
PG_UID=	70

LDFLAGS+=	-L${LOCALBASE}/lib
INCLUDES+=	-I${LOCALBASE}/include
CONFIGURE_ARGS+=--with-libraries=${PREFIX}/lib \
		--with-includes=${PREFIX}/include \
		--enable-thread-safety
CONFIGURE_ENV+=	INCLUDES="${INCLUDES}" \
		PTHREAD_CFLAGS="${PTHREAD_CFLAGS}" \
		PTHREAD_LIBS="${PTHREAD_LIBS}" \
		LDFLAGS_SL="${LDFLAGS_SL}"

PLIST=		${PKGDIR}/pkg-plist${COMPONENT}

INSTALL_DIRS?=	src/timezone src/backend \
		src/backend/utils/mb/conversion_procs \
		src/backend/snowball src/backend/replication/libpqwalreceiver \
		src/bin/initdb src/bin/pg_ctl \
		src/bin/pg_controldata src/bin/pg_resetxlog src/pl \
		src/bin/pg_basebackup
BUILD_DIRS?=	src/port ${INSTALL_DIRS}

.if !defined(CLIENT_ONLY) && !defined(SLAVE_ONLY)
COMPONENT=	-server
SERVER_ONLY=	yes
USE_RC_SUBR=	postgresql
USE_PGSQL=	yes
WANT_PGSQL_VER=	${DISTVERSION:C/([0-9][0-9]*)\.([0-9][0-9]*).*/\1\2/g}
USERS=		${PG_USER}
GROUPS=	${PG_GROUP}
SUB_FILES+=	502.pgsql
.endif

.if !defined(CLIENT_ONLY)
MAKE_ENV=	PATH=${PREFIX}/bin:${PATH}
CONFIGURE_ENV+=	PATH=${PREFIX}/bin:${PATH}
.endif

.if !defined(SLAVE_ONLY)
OPTIONS_DEFINE+=	NLS DTRACE PAM LDAP GSSAPI OPTIMIZED_CFLAGS XML TZDATA DEBUG KRB5
OPTIONS_SINGLE= KRB5
OPTIONS_SINGLE_KRB5= MIT_KRB5 HEIMDAL_KRB5

KRB5_DESC=       Build with kerberos provider support
NLS_DESC=	Use internationalized messages
DTRACE_DESC=	Build with DTrace probes (server only)
PAM_DESC=	Build with PAM Support
LDAP_DESC=	Build with LDAP authentication support (server only)
MIT_KRB5_DESC=	Build with MIT kerberos support
HEIMDAL_KRB5_DESC=	Builds with Heimdal kerberos
GSSAPI_DESC=	Build with GSSAPI support
OPTIMIZED_CFLAGS_DESC=	Builds with compiler optimizations (-O3)
XML_DESC=	Build with XML data type (server)
TZDATA_DESC=	Use internal timezone database (server)
DEBUG_DESC=	Builds with debugging symbols
OSSP_UUID_DESC=	Enable / disable ossp-uuid support

# See http://people.freebsd.org/~girgen/postgresql-icu/README.html for more info
OPTIONS_DEFINE+=	ICU
ICU_DESC=	Use ICU for unicode collation (server)

# See http://www.freebsd.org/cgi/query-pr.cgi?pr=ports/76999 for more info
# (requires dump/restore if modified.)
OPTIONS_DEFINE+=	INTDATE
INTDATE_DESC=	Builds with 64-bit date/time type (server)

OPTIONS_DEFINE+=	SSL
SSL_DESC=	Build with OpenSSL support

OPTIONS_DEFAULT=	NLS XML TZDATA INTDATE SSL
.endif # !SLAVE_ONLY

NO_STAGE=	yes
.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MSSL}
USE_OPENSSL=	yes
CONFIGURE_ARGS+=--with-openssl
.endif

.if !defined(SLAVE_ONLY)
.  if ( defined(SERVER_ONLY) && ${PORT_OPTIONS:MICU} ) || make(makesum)
USE_AUTOTOOLS=	autoconf
CONFIGURE_ARGS+=--with-icu
PATCH_SITES+=	http://people.freebsd.org/~girgen/postgresql-icu/:icu
PATCHFILES+=	${ICU_PATCHFILE}:icu
LIB_DEPENDS+=	libicudata.so:${PORTSDIR}/devel/icu
.  endif
.endif # !SLAVE_ONLY

.if ${PORT_OPTIONS:MOSSP_UUID}
BUILD_DEPENDS+=	${LOCALBASE}/lib/libuuid.a:${PORTSDIR}/misc/ossp-uuid
CONFIGURE_ARGS+=--with-ossp-uuid
PLIST_SUB+=	OSSP=""
.else
PLIST_SUB+=	OSSP="@comment "
.endif

.if !defined(SLAVE_ONLY)

PATCH_DIST_STRIP=-p1

.  if ${PORT_OPTIONS:MDTRACE}
CONFIGURE_ARGS+=--enable-dtrace
LDFLAGS+=-lelf
.    if ${OSVERSION} < 900021
IGNORE=	need userland DTrace support found in FreeBSD 9.0
.    endif
.  endif

.  if ${PORT_OPTIONS:MPAM}
CONFIGURE_ARGS+=--with-pam
.  endif

.  if ${PORT_OPTIONS:MLDAP}
.    if defined (SERVER_ONLY)
CONFIGURE_ARGS+=--with-ldap
USE_OPENLDAP=	yes
.    endif
.  endif

.  if ${PORT_OPTIONS:MXML}
CONFIGURE_ARGS+=--with-libxml
LIB_DEPENDS+=	libxml2.so:${PORTSDIR}/textproc/libxml2
.  endif

.  if ${PORT_OPTIONS:MTZDATA}
PLIST_SUB+=	TZDATA=""
.  else
CONFIGURE_ARGS+=--with-system-tzdata=/usr/share/zoneinfo
PLIST_SUB+=	TZDATA="@comment "
.  endif

.  if empty(PORT_OPTIONS:MINTDATE)
CONFIGURE_ARGS+=--disable-integer-datetimes
.  endif

.  if ${PORT_OPTIONS:MNLS}
CONFIGURE_ARGS+=--enable-nls
PLIST_SUB+=	GETTEXT=""
USES+=	gettext
.  else
CONFIGURE_ARGS+=--disable-nls
PLIST_SUB+=	GETTEXT="@comment "
.  endif

.  if ${PORT_OPTIONS:MOPTIMIZED_CFLAGS}
CFLAGS+=	-O3 -funroll-loops
.  endif

.  if ${PORT_OPTIONS:MDEBUG}
CONFIGURE_ARGS+=--enable-debug
INSTALL_TARGET=	install
.  else
INSTALL_TARGET=	install-strip
.  endif

.if ${PORT_OPTIONS:MGSSAPI}
CONFIGURE_ARGS+=--with-gssapi
.if empty(PORT_OPTIONS:MMIT_KRB5) && empty(PORT_OPTIONS:MHEIMDAL_KRB5)
# Kerberos libraries will pull the proper GSSAPI library
# via linker dependencies, but otherwise we must specify
# it explicitely: ld --as-needed is used for compilation,
# so configure's -lgssapi_krb5 won't go.
LDFLAGS+=	-lgssapi
LDFLAGS_SL+=	-lgssapi
.endif
.else
CONFIGURE_ARGS+=--without-gssapi
.endif

.  if ${PORT_OPTIONS:MMIT_KRB5}
.   if defined(IGNORE_WITH_SRC_KRB5) && (exists(/usr/lib/libkrb5.so) || exists(/usr/bin/krb5-config))
IGNORE=	requires that you remove heimdal's /usr/bin/krb5-config and /usr/lib/libkrb5.so*, and set NO_KERBEROS=true in /etc/src.conf to build successfully with MIT-KRB
.   else
CONFIGURE_ARGS+=--with-krb5
# Allow defining a home built MIT Kerberos by setting KRB5_HOME
.    if defined(KRB5_HOME) && exists(${KRB5_HOME}/lib/libgssapi_krb5.a) && exists(${KRB5_HOME}/bin/krb5-config)
LIB_DEPENDS+=	krb5.3:${PORTSDIR}/security/krb5
.    endif
.   endif
.  endif

.  if ${PORT_OPTIONS:MHEIMDAL_KRB5}
CONFIGURE_ARGS+=--with-krb5
.  endif

.endif # !SLAVE_ONLY

.if defined(CLIENT_ONLY)
MAN1?=		pg_basebackup.1
MAN1+=		clusterdb.1 createdb.1 createlang.1 createuser.1   \
		dropdb.1 droplang.1 dropuser.1 ecpg.1 initdb.1	   \
		pg_config.1 pg_controldata.1 pg_ctl.1		   \
		pg_dump.1 pg_dumpall.1 pg_resetxlog.1 pg_restore.1 \
		postgres.1 postmaster.1 psql.1 reindexdb.1 vacuumdb.1

MAN3+=		SPI_connect.3 SPI_copytuple.3 SPI_cursor_close.3 SPI_cursor_fetch.3 \
		SPI_cursor_find.3 SPI_cursor_move.3 SPI_cursor_open.3 \
		SPI_cursor_open_with_args.3 SPI_cursor_open_with_paramlist.3 \
		SPI_exec.3 SPI_execp.3 SPI_execute.3 SPI_execute_plan.3 \
		SPI_execute_plan_with_paramlist.3 SPI_execute_with_args.3 \
		SPI_finish.3 SPI_fname.3 SPI_fnumber.3 SPI_freeplan.3 \
		SPI_freetuple.3 SPI_freetuptable.3 SPI_getargcount.3 \
		SPI_getargtypeid.3 SPI_getbinval.3 SPI_getnspname.3 \
		SPI_getrelname.3 SPI_gettype.3 SPI_gettypeid.3 \
		SPI_getvalue.3 SPI_is_cursor_plan.3 SPI_modifytuple.3 \
		SPI_palloc.3 SPI_pfree.3 SPI_pop.3 SPI_prepare.3 \
		SPI_prepare_cursor.3 SPI_prepare_params.3 SPI_push.3 \
		SPI_repalloc.3 SPI_returntuple.3 SPI_saveplan.3 \
		SPI_scroll_cursor_fetch.3 SPI_scroll_cursor_move.3 \
		dblink.3 dblink_build_sql_delete.3 dblink_build_sql_insert.3 \
		dblink_build_sql_update.3 dblink_cancel_query.3 \
		dblink_close.3 dblink_connect.3 dblink_connect_u.3 \
		dblink_disconnect.3 dblink_error_message.3 dblink_exec.3 \
		dblink_fetch.3 dblink_get_connections.3 dblink_get_notify.3 \
		dblink_get_pkey.3 dblink_get_result.3 dblink_is_busy.3 \
		dblink_open.3 dblink_send_query.3

MAN7?=		ALTER_COLLATION.7 ALTER_EXTENSION.7 ALTER_FOREIGN_TABLE.7 \
		CREATE_COLLATION.7 CREATE_EXTENSION.7 CREATE_FOREIGN_TABLE.7 \
		DROP_COLLATION.7 DROP_EXTENSION.7 DROP_FOREIGN_TABLE.7 \
		SECURITY_LABEL.7
MAN7+=		ABORT.7 ALTER_AGGREGATE.7 ALTER_CONVERSION.7		      \
		ALTER_DATABASE.7 ALTER_DEFAULT_PRIVILEGES.7		      \
		ALTER_DOMAIN.7 ALTER_FOREIGN_DATA_WRAPPER.7 ALTER_FUNCTION.7  \
		ALTER_GROUP.7 ALTER_LARGE_OBJECT.7 ALTER_SERVER.7	      \
		ALTER_USER_MAPPING.7 ALTER_INDEX.7 ALTER_LANGUAGE.7	      \
		ALTER_OPERATOR_CLASS.7 ALTER_OPERATOR_FAMILY.7		      \
		ALTER_ROLE.7						      \
		ALTER_SCHEMA.7 ALTER_SEQUENCE.7 ALTER_TABLE.7		      \
		ALTER_TEXT_SEARCH_CONFIGURATION.7			      \
		ALTER_TEXT_SEARCH_DICTIONARY.7				      \
		ALTER_TEXT_SEARCH_PARSER.7				      \
		ALTER_TEXT_SEARCH_TEMPLATE.7				      \
		ALTER_TRIGGER.7 ALTER_USER.7 ALTER_VIEW.7 ANALYZE.7 BEGIN.7   \
		CHECKPOINT.7 CLOSE.7 CLUSTER.7 COMMENT.7 COMMIT.7	      \
		COMMIT_PREPARED.7					      \
		COPY.7 CREATE_AGGREGATE.7 CREATE_CAST.7			      \
		CREATE_CONVERSION.7					      \
		CREATE_DATABASE.7 CREATE_DOMAIN.7			      \
		CREATE_FOREIGN_DATA_WRAPPER.7 CREATE_FUNCTION.7		      \
		CREATE_GROUP.7 CREATE_INDEX.7 CREATE_LANGUAGE.7		      \
		CREATE_OPERATOR.7 CREATE_OPERATOR_CLASS.7		      \
		CREATE_OPERATOR_FAMILY.7 CREATE_ROLE.7			      \
		CREATE_RULE.7 CREATE_SCHEMA.7 CREATE_SEQUENCE.7		      \
		CREATE_SERVER.7 CREATE_TABLE.7 CREATE_TABLE_AS.7	      \
		CREATE_TEXT_SEARCH_CONFIGURATION.7			      \
		CREATE_TEXT_SEARCH_DICTIONARY.7				      \
		CREATE_TEXT_SEARCH_PARSER.7				      \
		CREATE_TEXT_SEARCH_TEMPLATE.7 CREATE_TRIGGER.7		      \
		CREATE_TYPE.7 CREATE_USER.7 CREATE_USER_MAPPING.7	      \
		CREATE_VIEW.7 DEALLOCATE.7 DECLARE.7 DELETE.7 DISCARD.7	      \
		DO.7 DROP_AGGREGATE.7 DROP_CAST.7 DROP_CONVERSION.7	      \
		DROP_DATABASE.7 DROP_DOMAIN.7 DROP_FOREIGN_DATA_WRAPPER.7     \
		DROP_FUNCTION.7 DROP_GROUP.7 DROP_INDEX.7 DROP_LANGUAGE.7     \
		DROP_OPERATOR.7 DROP_OPERATOR_CLASS.7 DROP_OPERATOR_FAMILY.7  \
		DROP_OWNED.7 DROP_ROLE.7 DROP_RULE.7			      \
		DROP_SCHEMA.7 DROP_SEQUENCE.7 DROP_SERVER.7 DROP_TABLE.7      \
		DROP_TEXT_SEARCH_CONFIGURATION.7			      \
		DROP_TEXT_SEARCH_DICTIONARY.7				      \
		DROP_TEXT_SEARCH_PARSER.7				      \
		DROP_TEXT_SEARCH_TEMPLATE.7 DROP_TRIGGER.7		      \
		DROP_TYPE.7 DROP_USER.7 DROP_USER_MAPPING.7 DROP_VIEW.7 END.7 \
		EXECUTE.7 EXPLAIN.7 FETCH.7 GRANT.7 INSERT.7 LISTEN.7 LOAD.7  \
		LOCK.7 MOVE.7 NOTIFY.7 PREPARE.7 PREPARE_TRANSACTION.7	      \
		REASSIGN_OWNED.7 REINDEX.7 RESET.7			      \
		REVOKE.7 ROLLBACK.7 ROLLBACK_PREPARED.7 SELECT.7	      \
		SELECT_INTO.7 SET.7					      \
		SET_CONSTRAINTS.7 SET_ROLE.7 SET_TRANSACTION.7 SHOW.7	      \
		SET_SESSION_AUTHORIZATION.7 START_TRANSACTION.7		      \
		TABLE.7 TRUNCATE.7 UNLISTEN.7 UPDATE.7 VACUUM.7		      \
		ALTER_OPERATOR.7 ALTER_TABLESPACE.7 ALTER_TYPE.7	      \
		CREATE_TABLESPACE.7 DROP_TABLESPACE.7			      \
		RELEASE_SAVEPOINT.7 ROLLBACK_TO_SAVEPOINT.7		      \
		SAVEPOINT.7 VALUES.7 WITH.7
.endif

PLIST_SUB+=	PG_USER=${PG_USER} \
		PG_GROUP=${PG_GROUP}
SUB_LIST+=	PG_GROUP=${PG_GROUP} \
		PG_USER=${PG_USER} \
		PG_UID=${PG_UID}

# For testing files in FILESDIR
.include <bsd.port.pre.mk>

.if defined(SERVER_ONLY)
pre-build:
	@${SH} ${PKGINSTALL} ${PORTNAME} PRE-INSTALL
.endif

.if !defined(NO_BUILD) && !target(do-build)

do-build:
	@ cd ${WRKSRC}/src/backend && ${SETENV} ${MAKE_ENV} ${GMAKE} symlinks
	@ for dir in ${BUILD_DIRS}; do \
		cd ${WRKSRC}/$${dir} && ${SETENV} ${MAKE_ENV} ${GMAKE}; \
	done

.  if exists(${FILESDIR}/pkg-message${COMPONENT}.in)
SUB_FILES+=	pkg-message${COMPONENT}
PKGMESSAGE=	${WRKSRC}/pkg-message${COMPONENT}
.  endif
.  if exists(${FILESDIR}/pkg-install${COMPONENT}.in)
SUB_FILES+=	pkg-install${COMPONENT}
PLIST_SUB+=	PG_USER=${PG_USER}
.  endif

post-patch:
.  if ${PORT_OPTIONS:MICU}
	@${REINPLACE_CMD} -E -e \
		"s|^(m4_if.*)2.6[0-9](.*Autoconf version )2.6[0-9]|\1${AUTOCONF_VERSION}\2${AUTOCONF_VERSION}|g" \
		${WRKSRC}/configure.in
.  endif

do-install:
	@for dir in ${INSTALL_DIRS}; do \
	    cd ${WRKSRC}/$${dir} && \
		${SETENV} ${MAKE_ENV} ${GMAKE} ${INSTALL_TARGET}; \
	done
.  if defined(SERVER_ONLY)
	@ ${MKDIR} ${PREFIX}/share/postgresql ;\
	${MKDIR} ${PREFIX}/etc/periodic/daily ;\
	${INSTALL_SCRIPT} ${WRKDIR}/502.pgsql \
			${PREFIX}/etc/periodic/daily
	${MKDIR} ${PREFIX}/${PG_USER} && ${CHOWN} ${PG_USER}:${PG_GROUP} ${PREFIX}/${PG_USER}
.  endif # SERVER_ONLY
.  if defined(CLIENT_ONLY)
	@ cd ${WRKSRC}/src && ${SETENV} ${MAKE_ENV} ${GMAKE} install-local
.  endif
	@ if [ -r ${PKGMESSAGE} ]; then \
		${MKDIR} ${DOCSDIR} ;\
		${INSTALL_DATA} ${PKGMESSAGE} ${DOCSDIR}/README${COMPONENT} ;\
		${CAT} ${PKGMESSAGE} ;\
	fi
.endif # !NO_BUILD

.if defined(SERVER_ONLY)
check:
	@if [ `id -u` != 0 ] ; then \
	  ${ECHO} "Running postgresql regressions tests" ;\
	  cd ${WRKSRC}; ${GMAKE} check ;\
	 else \
	  ${ECHO} "You cannot run regression tests when postgresql is built as user root." ; \
	  ${ECHO} "Clean and rebuild the port as a regular user to run the tests." ;\
	 fi
.endif

.include <bsd.port.post.mk>
