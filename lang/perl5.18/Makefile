# Created by: mat
# $FreeBSD$

PORTNAME=	perl
PORTVERSION=	${PERL_VERSION}
PORTREVISION=	6
CATEGORIES=	lang devel perl5
MASTER_SITES=	CPAN \
		${MASTER_SITE_LOCAL:S/$/:local/} \
		http://protey.ru/freebsd/distfiles/:local
MASTER_SITE_SUBDIR=	../../src \
			skv/:local
DISTFILES=	${DISTNAME}${EXTRACT_SUFX} \
		BSDPAN-${BSDPAN_VERSION}${EXTRACT_SUFX}:local
DIST_SUBDIR=	perl

MAINTAINER=	perl@FreeBSD.org
COMMENT=	Practical Extraction and Report Language

LICENSE=	ART10 GPLv1
LICENSE_COMB=	dual

CONFLICTS_INSTALL=	perl5.12-* perl5.14-* perl5.16-* perl5.18-*

OPTIONS_DEFINE=	DEBUG GDBM PERL_64BITINT PTHREAD \
		MULTIPLICITY SITECUSTOMIZE USE_PERL
# it seems perl malloc has problems with threaded perl on FreeBSD
OPTIONS_RADIO=	EXCLUSIVE
OPTIONS_RADIO_EXCLUSIVE=	THREADS PERL_MALLOC
OPTIONS_DEFAULT=	PERL_64BITINT THREADS PTHREAD USE_PERL

EXCLUSIVE_DESC=	Exclusive OPTIONS
GDBM_DESC=	GDBM_File extension
PERL_MALLOC_DESC=	Use Perl malloc
PERL_64BITINT_DESC=	Use 64 bit integers (on i386)
THREADS_DESC=		Build threaded perl
PTHREAD_DESC=		Build with -pthread
MULTIPLICITY_DESC=	Use multiplicity
SITECUSTOMIZE_DESC=	Run-time customization of @INC
USE_PERL_DESC=		Rewrite links in /usr/bin

#OPTIONS_EXCLUDE_AMD64=	THREADS
OPTIONS_SUB=		yes
DEBUG_CONFIGURE_ON=	-Doptimize="-g" -DDEBUGGING
DEBUG_CONFIGURE_OFF=	-Doptimize="${CFLAGS}"
GDBM_CONFIGURE_ON=	-Di_gdbm
GDBM_CONFIGURE_OFF=	-Ui_gdbm
GDBM_LIB_DEPENDS=	libgdbm.so:${PORTSDIR}/databases/gdbm
PERL_64BITINT_CONFIGURE_ON=	-Duse64bitint
MULTIPLICITY_CONFIGURE_ON=	-Dusemultiplicity=y
SITECUSTOMIZE_CONFIGURE_ON=	-Dusesitecustomize
THREADS_CONFIGURE_ON=	-Dusethreads=y
THREADS_CONFIGURE_OFF=	-Dusethreads=n
PERL_MALLOC_CONFIGURE_ON=	-Dusemymalloc=y
PERL_MALLOC_CONFIGURE_OFF=	-Dusemymalloc=n

PORTSCOUT=	limitw:1,even

PERL_VERSION=	5.18.1
PERL_VER=	${PERL_VERSION:C/\.[0-9]+$//}
PERL_ARCH=	mach
SITE_PERL_REL?=	lib/perl5/site_perl/${PERL_VER}
SITE_PERL?=	${LOCALBASE}/${SITE_PERL_REL}

USE_BZIP2=	yes
HAS_CONFIGURE=	yes
CONFIGURE_SCRIPT=Configure
CONFIGURE_ARGS=	-sde -Dprefix=${PREFIX} \
	-Darchlib=${PREFIX}/lib/perl5/${PERL_VER}/${PERL_ARCH} \
	-Dprivlib=${PREFIX}/lib/perl5/${PERL_VER} \
	-Dman3dir=${PREFIX}/lib/perl5/${PERL_VER}/perl/man/man3 \
	-Dman1dir=${PREFIX}/man/man1 \
	-Dsitearch=${PREFIX}/${SITE_PERL_REL}/${PERL_ARCH} \
	-Dsitelib=${PREFIX}/${SITE_PERL_REL} -Dscriptdir=${PREFIX}/bin \
	-Dsiteman3dir=${PREFIX}/lib/perl5/${PERL_VER}/man/man3 \
	-Dsiteman1dir=${PREFIX}/man/man1 \
	-Ui_malloc -Ui_iconv -Uinstallusrbinperl \
	-Dcc="${CC}" -Duseshrplib -Dinc_version_list=none \
	-Dccflags=-DAPPLLIB_EXP=\"${BSDPAN_DEST}\"
LOCALE_CLEANUP=	LANG="" LC_ALL="" LC_COLLATE="" LC_CTYPE="" \
		LC_MESSAGES="" LC_MONETARY="" LC_NUMERIC="" \
		LC_TIME=""
CONFIGURE_ENV+=	${LOCALE_CLEANUP} UNAME_v="$$(uname -v | sed 'y/=/ /')"
MAKE_ENV+=	${LOCALE_CLEANUP}

.include <bsd.port.pre.mk>
.include "${PORTSDIR}/Mk/bsd.default-versions.mk"

# if this port is default due PERL5_DEFAULT
# change PKGNAME to reflect this 
.if ${PERL_VER} == ${PERL5_DEFAULT}
PKGNAMESUFFIX=	${PERL_VERSION:C/\.[0-9]+\.[0-9]+$//}
.else
# make PKGNAME unique among other lang/perl5.x
PKGNAMESUFFIX=	${PERL_VER}
# always add default perl5 pkgname to conflicts
CONFLICTS_INSTALL+=	perl5-*
.endif

.if defined(PERL_VENDOR_PREFIX)
CONFIGURE_ARGS+=	\
	-Dvendorprefix=${PERL_VENDOR_PREFIX} \
	-Dvendorarch=${PERL_VENDOR_PREFIX}/lib/perl5/${PERL_VER}/${PERL_ARCH} \
	-Dvendorbin=${PERL_VENDOR_PREFIX}/bin \
	-Dvendorlib=${PERL_VENDOR_PREFIX}/lib/perl5/${PERL_VER} \
	-Dvendorman3dir=${PERL_VENDOR_PREFIX}/lib/perl5/${PERL_VER}/man/man3 \
	-Dvendorman1dir=${PERL_VENDOR_PREFIX}/man/man1
.endif

MAN3PREFIX=	${PREFIX}/lib/perl5/${PERL_VER}/perl
MANDIRS+=	${MAN3PREFIX}

PLIST_SUB+=	PERL_VERSION=${PERL_VERSION} \
		PERL_VER=${PERL_VER} \
		PERL_ARCH=${PERL_ARCH} \
		MAN3=${MAN3PREFIX:S|^${LOCALBASE}/||}/man/man3 \
		SITE_PERL=${SITE_PERL:S|^${LOCALBASE}/||}

.if ${PORT_OPTIONS:MDEBUG}
STRIP=
STRIP_CMD=	${TRUE}
.endif

.if ${OSVERSION} >= 900022
PLIST_SUB+=	MANCONF=""
.else
PLIST_SUB+=	MANCONF="@comment "
.endif

.if ${PORT_OPTIONS:MTHREADS}
WITH_PTHREAD=		yes
.endif

.if ${PORT_OPTIONS:MUSE_PERL}
LINK_USRBIN=	yes
.else
LINK_USRBIN=	no
.endif

NO_LATEST_LINK=	yes

BSDPAN_DEST=	${PREFIX}/lib/perl5/${PERL_VER}/BSDPAN
BSDPAN_FILES=	BSDPAN.pm BSDPAN/Override.pm Config.pm \
		ExtUtils/MM_Unix.pm \
		ExtUtils/MakeMaker.pm \
		ExtUtils/Packlist.pm
BSDPAN_VERSION=	20111107
BSDPAN_WRKSRC=	${WRKDIR}/BSDPAN-${BSDPAN_VERSION}

PKGINSTALL=	${WRKDIR}/pkg-install
PKGDEINSTALL=	${WRKDIR}/pkg-deinstall

post-patch:
	${SED} -e 's|%%PREFIX%%|${PREFIX}|g;' \
		-e 's|%%PERL_VERSION%%|${PERL_VERSION}|g;' \
		-e 's|%%PERL_VER%%|${PERL_VER}|g;' \
		-e 's|%%PERL_ARCH%%|${PERL_ARCH}|g;' \
		-e 's|%%PERL5_SIGNATURE%%|${LOCALBASE}/etc/perl5_version|g;' \
		-e 's|%%LINK_USRBIN%%|${LINK_USRBIN}|g;' \
		${FILESDIR}/use.perl \
		> ${WRKDIR}/use.perl
	${SED} -e 's|%%PREFIX%%|${PREFIX}|g;' \
		-e 's|%%PERL_VER%%|${PERL_VER}|g;' \
		${FILESDIR}/perl-man.conf \
		> ${WRKDIR}/perl-man.conf
	${CP} ${WRKDIR}/use.perl ${PKGINSTALL}
	${CP} ${WRKDIR}/use.perl ${PKGDEINSTALL}
	${SED} -i '' -e 's|%%PERL_PKGNAME%%|${PKGNAME}|g; s|%%PERL_VER%%|${PERL_VER}|g;' \
		-e 's!%%BSDPAN_VERSION%%!${BSDPAN_VERSION}!g;' \
		${BSDPAN_WRKSRC}/ExtUtils/*.pm
	${REINPLACE_CMD} -e 's|/usr/local|${LOCALBASE}|g' \
		${WRKSRC}/Configure ${WRKSRC}/hints/freebsd.sh
.if ${PORT_OPTIONS:MPTHREAD}
	${REINPLACE_CMD} -e 's|%%PTHREAD_LIBS%%|${PTHREAD_LIBS}|g;' \
		-e 's|%%PTHREAD_CFLAGS%%|${PTHREAD_CFLAGS}|g;' \
		${WRKSRC}/hints/freebsd.sh
.else
	${REINPLACE_CMD} -e 's|%%PTHREAD_LIBS%%||g;' \
		-e 's|%%PTHREAD_CFLAGS%%||g;' \
		${WRKSRC}/hints/freebsd.sh
.endif

post-install:
	@${MKDIR} ${STAGEDIR}${PREFIX}/lib/perl5/${PERL_VER}/man/man3
	@${MKDIR} ${STAGEDIR}${SITE_PERL}/${PERL_ARCH}/auto
	@${MKDIR} ${STAGEDIR}${SITE_PERL}/${PERL_ARCH}/machine
	@${MKDIR} ${STAGEDIR}${SITE_PERL}/${PERL_ARCH}/sys
	@${MKDIR} ${STAGEDIR}${SITE_PERL}/auto
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/bin/perl${PERL_VERSION}
.if ${OSVERSION} >= 900022
	@${INSTALL_DATA} ${WRKDIR}/perl-man.conf ${STAGEDIR}${PREFIX}/etc/man.d/perl${PERL_VER}.conf
.endif
.for files in ${BSDPAN_FILES}
	${MKDIR} ${STAGEDIR}${BSDPAN_DEST}/${files:H}
	${INSTALL_DATA} \
		${BSDPAN_WRKSRC}/${files} ${STAGEDIR}${BSDPAN_DEST}/${files}
.endfor

test: build
	@(cd ${WRKSRC}; TEST_JOBS=${MAKE_JOBS_NUMBER} make test_harness)

regression-test: test

.include <bsd.port.post.mk>
