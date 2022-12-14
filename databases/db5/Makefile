# Created by: Matthias Andree <mandree@FreeBSD.org>
# $FreeBSD$

PORTNAME=	db5
PORTVERSION=	5.3.21.0
CATEGORIES=	databases java
MASTER_SITES=	http://download.oracle.com/berkeley-db/
PKGNAMEPREFIX?=
#
# the distfiles aren't named db5-* but db-*:
DISTNAME=	db-${PORTVERSION:R}
DIST_SUBDIR=	bdb

MAINTAINER=	mandree@FreeBSD.org
COMMENT=	The Oracle Berkeley DB, revision ${BDBVER}

BDBVER=		${PORTVERSION:R:R}
BDBMAJ=		${BDBVER:R}
CONFIGURE_ARGS=	--enable-cxx --enable-stl \
		--disable-tcl \
		--includedir=${PREFIX}/include/${PORTNAME} \
		--libdir=${PREFIX}/lib/${PORTNAME} \
		--bindir=${PREFIX}/bin/${PORTNAME}
CONFIGURE_SCRIPT=	../dist/configure
GNU_CONFIGURE=	yes
USES=		gmake
INSTALL_TARGET=	install_include install_lib install_utilities
LIBTOOLFILES=	${CONFIGURE_SCRIPT}
WRKSRC=		${WRKDIR}/${DISTNAME}/build_unix
USE_LDCONFIG=	yes
PLIST_SUB=	BDBMAJ=${BDBMAJ} BDBVER=${BDBVER}

OPTIONS_DEFINE=	CRYPTO L10N SQL JAVA
OPTIONS_DEFAULT=CRYPTO
CRYPTO_DESC=	Cryptography support
L10N_DESC=	Localization support (EXPERIMENTAL)
SQL_DESC=	Enable SQL API (EXPERIMENTAL)

.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MDOCS}
INSTALL_TARGET+=install_docs docdir=${DOCSDIR}
PORTDOCS=	*
.endif

.if ${PORT_OPTIONS:MSQL}
CONFIGURE_ARGS+=	--enable-sql_codegen --enable-sql
PLIST_SUB+=	SQL=""
libdb_sql=	libdb_sql
.else
PLIST_SUB+=	SQL="@comment "
libdb_sql=
.endif

.if ${PORT_OPTIONS:MJAVA}
USE_JAVA=	yes
JAVA_VERSION=	1.6+
CONFIGURE_ARGS+=	--enable-java
CPPFLAGS+=	"-I${JAVA_HOME}/include"
CONFIGURE_ENV=	JAVAC="${JAVAC}" JAR="${JAR}" JAVA="${JAVA}"
PLIST_SUB+=	JAVA=""
libdb_java=	libdb_java
.else
PLIST_SUB+=	JAVA="@comment "
libdb_java=
.endif

.if ${PORT_OPTIONS:MCRYPTO}
CONFIGURE_ARGS+=	--with-cryptography=yes
.else
CONFIGURE_ARGS+=	--with-cryptography=no
.endif

.if ${PORT_OPTIONS:ML10N}
CONFIGURE_ARGS+=	--enable-localization
.endif

.if ${PORT_OPTIONS:MDEBUG}
CONFIGURE_ARGS+=	--enable-debug --enable-umrw
.endif

post-patch:
	${REINPLACE_CMD} -e '/^DOCLIST/{s/csharp//;}' ${WRKSRC}/../dist/Makefile.in
	${REINPLACE_CMD} -Ee 's/[[:<:]]atomic_init[[:>:]]/db_atomic_init/g' ${WRKSRC}/../src/mp/mp* ${WRKSRC}/../src/mutex/mut_*

post-install:
.for i in libdb libdb_cxx libdb_stl ${libdb_sql} ${libdb_java}
	${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/${PORTNAME}/${i}-${BDBVER}.so.0
	${LN} -s -f ${PORTNAME}/${i}-${BDBVER}.so.0 ${STAGEDIR}${PREFIX}/lib
	${LN} -s -f ${PORTNAME}/${i}-${BDBMAJ}.so ${STAGEDIR}${PREFIX}/lib
	${LN} -s -f ${i}-${BDBVER}.so.0 ${STAGEDIR}${PREFIX}/lib/${i}-${BDBVER}.so
	${LN} -s -f ${i}-${BDBVER}.so.0 ${STAGEDIR}${PREFIX}/lib/${i}-${BDBMAJ}.so.0
	${LN} -s -f ${i}-${BDBVER}.a ${STAGEDIR}${PREFIX}/lib/${PORTNAME}/${i}.a
	${CHMOD} a-w ${STAGEDIR}${PREFIX}/lib/${PORTNAME}/${i}-${BDBVER}.so.0 \
		${STAGEDIR}${PREFIX}/lib/${PORTNAME}/${i}-${BDBVER}.a \
		${STAGEDIR}${PREFIX}/lib/${PORTNAME}/${i}-${BDBVER}.la
.endfor
	cd ${STAGEDIR}${PREFIX}/bin/${PORTNAME}; \
	for i in *; do ${LN} -s -f ${PORTNAME}/$$i ../$$i-${BDBVER} ; \
		       ${LN} -s -f ${PORTNAME}/$$i ../$$i-${BDBMAJ} ; done
.if ${PORT_OPTIONS:MDOCS}
.for i in api_reference/TCL
	${RM} -r -f ${STAGEDIR}${DOCSDIR}/${i}
.endfor
.if empty(PORT_OPTIONS:MJAVA)
	${RM} -r -f ${STAGEDIR}${DOCSDIR}/java
.for i in gsg gsg_db_rep gsg_txn
	${RM} -r -f ${STAGEDIR}${DOCSDIR}/${i}/JAVA
.endfor
.endif
.if empty(PORT_OPTIONS:MSQL)
	${RM} -r -f ${STAGEDIR}${DOCSDIR}/bdb-sql
.endif
.endif

.include <bsd.port.mk>
