# Created by: markun@onohara.to
# $FreeBSD$

PORTNAME=	clamav
PORTVERSION=	0.98
PORTREVISION=	3
CATEGORIES=	security
MASTER_SITES=	SF

MAINTAINER=	garga@FreeBSD.org
COMMENT=	Command line virus scanner written entirely in C

LICENSE=	GPLv2

OPTIONS_DEFINE=	ARC ARJ LHA UNZOO UNRAR LLVM TESTS MILTER LDAP ICONV STDERR \
		EXPERIMENTAL DOCS IPV6

ARC_DESC=		Enable arch archives support
ARJ_DESC=		Enable arj archives support
LHA_DESC=		Enable lha archives support
UNZOO_DESC=		Enable zoo archives support
UNRAR_DESC=		Enable rar archives support
LLVM_DESC=		Enable JIT Bytecode compiler (bundled LLVM)
TESTS_DESC=		Run compile-time tests (req. python)
MILTER_DESC=		Compile the milter interface
STDERR_DESC=		Print logs to stderr instead of stdout
EXPERIMENTAL_DESC=	Build experimental code

OPTIONS_DEFAULT=	ARC ARJ LHA UNZOO UNRAR LLVM DOCS IPV6

ARC_RUN_DEPENDS=	arc:${PORTSDIR}/archivers/arc
ARJ_RUN_DEPENDS=	arj:${PORTSDIR}/archivers/arj
LHA_RUN_DEPENDS=	lha:${PORTSDIR}/archivers/lha
UNZOO_RUN_DEPENDS=	unzoo:${PORTSDIR}/archivers/unzoo
UNRAR_CONFIGURE_ENABLE=	unrar
MILTER_CONFIGURE_ENABLE=milter
TESTS_CONFIGURE_ENABLE=	check
TESTS_BUILD_DEPENDS=	${LOCALBASE}/include/check.h:${PORTSDIR}/devel/libcheck
ICONV_CONFIGURE_ON=	--with-iconv
ICONV_CONFIGURE_OFF=	--without-iconv
ICONV_USES=		iconv
EXPERIMENTAL_CONFIGURE_ENABLE=	experimental
IPV6_CONFIGURE_ENABLE=	ipv6

GNU_CONFIGURE=	yes
USE_LDCONFIG=	yes
USES=		gmake
USE_RC_SUBR=	clamav-clamd clamav-freshclam

PORTDOCS=	*

DBDIR=		/var/db/clamav
LOGDIR=		/var/log/clamav
RUNDIR=		/var/run/clamav
PLIST_SUB+=	DBDIR=${DBDIR} LOGDIR=${LOGDIR} RUNDIR=${RUNDIR}
PY_NO_THREAD=	${WRKDIR}/.python-has-no-threads
USE_AUTOTOOLS=	libltdl
OPTIONS_SUB=	yes

CONFIGURE_ARGS=	--libdir=${PREFIX}/lib \
		--with-dbdir=${DBDIR} \
		--with-zlib=/usr \
		--disable-clamuko \
		--disable-clamav \
		--enable-bigstack \
		--enable-readdir_r \
		--enable-gethostbyname_r \
		--disable-dependency-tracking \
		--enable-clamdtop
CPPFLAGS+=	-I${LOCALBASE}/include \
		${PTHREAD_CFLAGS}
LDFLAGS+=	-L${LOCALBASE}/lib \
		${PTHREAD_LIBS}

# This port has a problem with -pthread,
# force to use -lthr until it's not fixed.
PTHREAD_LIBS=	-lthr

CONFLICTS?=	clamav-devel-[0-9]* clamav-milter-[0-9]*

CLAMAVUSER?=	clamav
CLAMAVGROUP?=	clamav

CLAMAV_CLAMD_SOCKET?=	${RUNDIR}/clamd.sock
CLAMAV_MILTER_SOCKET?=	${RUNDIR}/clmilter.sock

SUB_FILES=	pkg-install pkg-deinstall
SUB_LIST+=	DBDIR=${DBDIR} \
		LOGDIR=${LOGDIR} \
		RUNDIR=${RUNDIR} \
		CLAMAVUSER=${CLAMAVUSER} \
		CLAMAVGROUP=${CLAMAVGROUP} \
		CLAMAV_CLAMD_SOCKET=${CLAMAV_CLAMD_SOCKET} \
		CLAMAV_MILTER_SOCKET=${CLAMAV_MILTER_SOCKET} \
		CHMOD=${CHMOD} \
		CHOWN=${CHOWN}

SED_CONF=	-E -e 's|^\#?(Example)$$|\#\1|' \
		-e 's|^\#?((Update)?LogFile) .*/([a-z]+\.log)$$|\1 ${LOGDIR}/\3|' \
		-e 's|^\#?(PidFile) .*/([a-z\-]+\.pid)$$|\1 ${RUNDIR}/\2|' \
		-e 's|^\#?(LocalSocket) .*$$|\1 ${CLAMAV_CLAMD_SOCKET}|' \
		-e 's|^\#?(User) .*$$|\1 ${CLAMAVUSER}|' \
		-e 's|^\#?(AllowSupplementaryGroups).*$$|\1 yes|' \
		-e 's|^\#?(ScanMail).*$$|\1 yes|' \
		-e 's|^\#?(DatabaseDirectory) .*$$|\1 ${DBDIR}|' \
		-e 's|^\#?(DatabaseOwner) .*$$|\1 ${CLAMAVUSER}|' \
		-e 's|^\#?(FixStaleSocket).*$$|\1 yes|' \
		-e 's|^\#?(NotifyClamd) .*$$|\1 ${PREFIX}/etc/clamd.conf|' \
		-e 's|^\#?(MilterSocket) */tmp.*$$|\1 ${CLAMAV_MILTER_SOCKET}|' \
		-e 's|^\#?(ClamdSocket).*$$|\1 unix:${CLAMAV_CLAMD_SOCKET}|'

PLIST_SUB+=	CLAMAVUSER=${CLAMAVUSER} \
		CLAMAVGROUP=${CLAMAVGROUP}

.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MLLVM} && ( ${ARCH} == "i386" || ${ARCH} == "amd64" )
CONFIGURE_ARGS+=--enable-llvm
. if ${PORT_OPTIONS:MTESTS}
USE_PYTHON_BUILD=	yes
. endif
.else
CONFIGURE_ARGS+=--disable-llvm
.endif

.if ${PORT_OPTIONS:MMILTER}
USE_RC_SUBR+=	clamav-milter
. if ${PORT_OPTIONS:MLDAP} && exists(${LOCALBASE}/lib/libldap.so)
USE_OPENLDAP=	yes
LDFLAGS+=	-lldap
. endif

. if !exists(/usr/lib/libmilter.a) || exists(${LOCALBASE}/lib/libmilter.a)
BUILD_DEPENDS+=	${LOCALBASE}/lib/libmilter.a:${PORTSDIR}/mail/sendmail
CONFIGURE_ARGS+=--with-sendmail=${LOCALBASE}/sbin/sendmail
. else
CONFIGURE_ARGS+=--with-sendmail=/usr/sbin/sendmail
. endif
.endif

.if ${PORT_OPTIONS:MSTDERR}
EXTRA_PATCHES+=		${FILESDIR}/extra-patch-shared_output.c
.endif

.include <bsd.port.pre.mk>

.if ${ARCH} == "i386"
CFLAGS+=	-march=i486
.endif

post-patch:
	@${REINPLACE_CMD} -e 's|%%PTHREAD_LIBS%%|${PTHREAD_LIBS}|g' \
		${WRKSRC}/${CONFIGURE_SCRIPT}
	@${REINPLACE_CMD} -e 's,^\(pkgconfigdir = \).*$$,\1$$\(prefix\)/libdata/pkgconfig,g' \
		${WRKSRC}/Makefile.in
	@${REINPLACE_CMD} ${SED_CONF} \
		${WRKSRC}/etc/clamd.conf.sample \
		${WRKSRC}/etc/freshclam.conf.sample \
		${WRKSRC}/etc/clamav-milter.conf.sample
	@${REINPLACE_CMD} -e 's|0x100000000|0x100000000ULL|g' \
		${WRKSRC}/libclamunrar/unrar.c

.if ${PORT_OPTIONS:MLLVM} && ${PORT_OPTIONS:MTESTS}
pre-configure:
	@if ! ${PYTHON_CMD} -c "import thread" >/dev/null 2>&1; then \
		${ECHO_MSG} ""; \
		${ECHO_MSG} "==========================================================================="; \
		${ECHO_MSG} "= Unit tests REQUIRES python built with thread support, and yours is not. ="; \
		${ECHO_MSG} "= It will not be called during this build                                 ="; \
		${ECHO_MSG} "==========================================================================="; \
		${ECHO_MSG} ""; \
		${TOUCH} ${PY_NO_THREAD}; \
	fi
.endif

.if ${PORT_OPTIONS:MTESTS} && ${OSVERSION} >= 700000
post-build:
	@if [ ! -f "${PY_NO_THREAD}" ]; then \
		${GMAKE} -C ${WRKSRC} check; \
	fi
.endif

post-install:
	${INSTALL_DATA} ${WRKSRC}/clamav-config.h ${STAGEDIR}${PREFIX}/include
	@${MKDIR} ${STAGEDIR}${DOCSDIR}/html
	${INSTALL_DATA} ${WRKSRC}/NEWS ${WRKSRC}/ChangeLog ${STAGEDIR}${DOCSDIR}
	${INSTALL_DATA} ${WRKSRC}/docs/html/* ${STAGEDIR}${DOCSDIR}/html

.include <bsd.port.post.mk>
