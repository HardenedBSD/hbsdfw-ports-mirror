# Created by: Hye-Shik Chang
# $FreeBSD$

PORTNAME=	llvm31
PORTVERSION=	3.1
PORTREVISION=	1
CATEGORIES=	devel lang
MASTER_SITES=	http://llvm.org/releases/${PORTVERSION}/
DISTNAME=	llvm-${PORTVERSION}.src

MAINTAINER=	brooks@FreeBSD.org
COMMENT=	Low Level Virtual Machine

LIB_DEPENDS=	execinfo:${PORTSDIR}/devel/libexecinfo
.if defined(PACKAGE_BUILDING) || defined(MAINTAINER_MODE)
BUILD_DEPENDS=	bash:${PORTSDIR}/shells/bash
.endif
.if defined(MAINTAINER_MODE)
BUILD_DEPENDS+=	f2c:${PORTSDIR}/lang/f2c
.endif

CONFLICTS=	llvm-[3]* llvm-devel-[23]* llvm29-*

USES=		gmake perl5 shebangfix
GNU_CONFIGURE=	yes
USE_LDCONFIG=	yes
USE_PYTHON_BUILD=	2

python_OLD_CMD=	/usr/bin/env python
python_CMD=	/usr/bin/env python2
SHEBANG_FILES=	test/Scripts/coff-dump.py test/Scripts/elf-dump \
		test/Scripts/macho-dumpx utils/clang-parse-diagnostics-file \
		utils/lit/lit/main.py utils/lit/lit/ProgressBar.py \
		utils/lit/lit.py utils/llvm-build/llvm-build \
		utils/llvm-lit/llvm-lit.in utils/Misc/zkill \
		utils/release/findRegressions-nightly.py \
		utils/release/findRegressions-simple.py \
		utils/Target/ARM/analyze-match-table.py

# Suggested tweaks from http://llvm.org/docs/Packaging.html
CONFIGURE_ARGS+=	--enable-shared
MAKE_ARGS+=		REQUIRES_RTTI=1
LIBNAME=		libLLVM-${DISTVERSION:C/\.r[0-9]*//}.so

CONFIGURE_ARGS+=	--enable-bindings=none

OPTIONS_DEFINE=	ASSERTS DOCS LTOPLUGIN

ASSERTS_DESC=	Enable assertions (thread unsafe)
LTOPLUGIN_DESC=	Build LTO plugin (requires gold)

MAN1=		bugpoint.1 lit.1 llc.1 lli.1 llvm-ar.1 llvm-as.1 \
		llvm-bcanalyzer.1 llvm-config.1 llvm-cov.1 llvm-diff.1 \
		llvm-dis.1 llvm-extract.1 llvm-ld.1 llvm-link.1 llvm-nm.1 \
		llvm-prof.1 llvm-ranlib.1 llvm-stress.1 opt.1 tblgen.1

PLIST_SUB+=		PORTVERSION=${PORTVERSION}

NO_STAGE=	yes
.include <bsd.port.options.mk>

.if defined(MAINTAINER_MODE)
CONFIGURE_ARGS+=	--with-f2c=${LOCALBASE}
.else
CONFIGURE_ARGS+=	--enable-optimized
.endif

.if ${PORT_OPTIONS:MDOCS}
CONFIGURE_ARGS+=	--enable-docs
.else
CONFIGURE_ARGS+=	--disable-docs
.endif

.if ${PORT_OPTIONS:MASSERTS}
CONFIGURE_ARGS+=	--enable-assertions
.else
CONFIGURE_ARGS+=	--disable-assertions
.endif

.if ${PORT_OPTIONS:MLTOPLUGIN}
BUILD_DEPENDS+=		ld.gold:${PORTSDIR}/devel/binutils
RUN_DEPENDS+=		ld.gold:${PORTSDIR}/devel/binutils
CONFIGURE_ARGS+=	--with-binutils-include=${LOCALBASE}/include
PLIST_FILES+=		lib/LLVMgold.so
.endif

.include <bsd.port.pre.mk>

.if ${ARCH} == "arm"
BROKEN=		Does not compile on arm
.elif ${ARCH} == "sparc64"
BROKEN=		does not compile on sparc64
.endif

.if ${ARCH} == "amd64" || ${ARCH} == "ia64"
CONFIGURE_ARGS+=	--enable-pic --with-pic
.endif

.if ${ARCH} == "i386"
CONFIGURE_ARGS+=	--with-optimize-option=-O2
.endif

post-patch:
	${REINPLACE_CMD} -e 's|\(PROJ_docsdir.*:=\).*$$|\1${DOCSDIR}|g' \
	    ${WRKSRC}/Makefile.config.in
	${REINPLACE_CMD} -e 's|\(PROJ_mandir.*:=\).*$$|\1${MANPREFIX}/man|g' \
	    ${WRKSRC}/Makefile.config.in

.if empty(PORT_OPTIONS:MDOCS)
post-build:
	@cd ${WRKSRC}/docs/CommandGuide && ${GMAKE} ${MAN1}
.endif

post-install:
	${MV} ${PREFIX}/lib/${LIBNAME} ${PREFIX}/lib/${LIBNAME}.0
	${LN} -s ${LIBNAME}.0 ${PREFIX}/lib/${LIBNAME}
.if empty(PORT_OPTIONS:MDOCS)
.for man in ${MAN1}
	@${INSTALL_MAN} ${WRKSRC}/docs/CommandGuide/${man} \
	     ${MANPREFIX}/man/man1/
.endfor
.endif

TEST_CMD=	'(cd ${WRKSRC}/test; ${SETENV} ${MAKE_ENV} LD_LIBRARY_PATH=${WRKSRC}/Release/lib ${GMAKE} check-local-lit)'
regression-test: ${BUILD_COOKIE}
	if [ `${ID} -u` = 0 ]; then \
		${CHOWN} -R nobody ${WRKSRC}/test; \
		su -m nobody -c ${TEST_CMD}; \
	else \
		${SH} -c ${TEST_CMD}; \
	fi

PLIST_FILE_LIST=	bin/bugpoint \
			bin/llc \
			bin/lli \
			bin/llvm* \
			bin/macho-dump \
			bin/opt \
			lib/BugpointPasses.so \
			lib/LLVMHello.so \
			lib/libLTO.* \
			lib/libLLVM* \
			lib/libprofile_rt.a \
			lib/libprofile_rt.so
PLIST_DIR_LIST=		include/llvm-c \
			include/llvm
build-plist:
	${RM} -f ${PLIST}
	cd ${PREFIX} && \
	    (ls ${PLIST_FILE_LIST}; ${FIND} ${PLIST_DIR_LIST} -type f) | \
	    ${SED} -e 's|${PORTVERSION}|%%PORTVERSION%%|' | \
	    ${SORT} >> ${PLIST}
	${FIND} ${DOCSDIR} -type f | \
	    ${SED} -e 's|${DOCSDIR}|%%PORTDOCS%%%%DOCSDIR%%|' | \
	    ${SORT} >> ${PLIST}
	cd ${PREFIX} && \
	    ${FIND} ${PLIST_DIR_LIST} -type d | \
	    ${SORT} -r | ${SED} -e 's|^|@dirrm |' >> ${PLIST}
	${FIND} ${DOCSDIR} -type d | ${SORT} -r | \
	    ${SED} -e 's|${DOCSDIR}|%%DOCSDIR%%|' \
	     -e 's|^|%%PORTDOCS%%@dirrm |' >> ${PLIST}

.include <bsd.port.post.mk>
