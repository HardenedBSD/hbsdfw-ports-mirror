# Created by: David O'Brien <obrien@NUXI.com>
# $FreeBSD$

PORTNAME=	gdb
PORTVERSION=	6.6
PORTREVISION?=	2
CATEGORIES=	devel
MASTER_SITES=   ${MASTER_SITE_GNU:S,$,:gdb,}	\
		http://aldan.algebra.com/~mi/:gdbtk
MASTER_SITE_SUBDIR=gdb/:gdb
DISTFILES=	${PORTNAME}-${PORTVERSION}${EXTRACT_SUFX}:gdb

MAINTAINER=	mi@aldan.algebra.com
COMMENT?=	GNU GDB of newer version than comes with the system

PKGNAMESUFFIX=	66

OPTIONS_DEFINE=	INSIGHT
INSIGHT_DESC=	Tcl/Tk GUI (experimental!)

CONFLICTS?=	gdb-[7-9]*
USE_BZIP2=	yes
USE_GCC=	any
USES=		gettext iconv gmake
GNU_CONFIGURE=	yes
CONFIGURE_ENV+=	CONFIGURED_M4=m4 CONFIGURED_BISON=byacc
CONFIGURE_ARGS=	--program-suffix=${PORTVERSION:S/.//g} \
		--disable-werror \
		--enable-target=all \
		--enable-tui ${ICONV_CONFIGURE_ARG}
CFLAGS:=	${CFLAGS:C/ +$//}	# blanks at EOL creep in sometimes
CFLAGS+=	-DRL_NO_COMPAT
EXCLUDE=	dejagnu expect readline sim texinfo intl
EXTRACT_AFTER_ARGS=	${EXCLUDE:S/^/--exclude /}
VER=		${PORTVERSION:S/.//}
PLIST_SUB=	VER=${VER}
MAN1=		gdb${VER}.1

NO_STAGE=	yes
.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MINSIGHT}
PKGNAMESUFFIX=	-insight
USE_TK=		84+
LIB_DEPENDS=	itk:${PORTSDIR}/x11-toolkits/itk
RUN_DEPENDS=	${LOCALBASE}/lib/iwidgets:${PORTSDIR}/x11-toolkits/iwidgets
DISTFILES+=	gdbtk-6.6${EXTRACT_SUFX}:gdbtk
PLIST_SUB+=	INSIGHT=''
EXTRA_PATCHES=	${FILESDIR}/itcl33-patch \
		${FILESDIR}/extra-gdb-gdbtk-generic-gdbtk.c \
		${FILESDIR}/extra-gdb-gdbtk-generic-gdbtk-hooks.c
CONFIGURE_ARGS+=--enable-gdbtk \
		--with-tclconfig=${LOCALBASE}/lib/tcl${TCL_VER} \
		--with-tclinclude=${LOCALBASE}/include/tcl${TCL_VER}/generic \
		--with-tkconfig=${LOCALBASE}/lib/tk${TK_VER} \
		--with-tkinclude=${LOCALBASE}/include/tk${TK_VER}/generic \
		--with-itclconfig=${LOCALBASE}/lib/itcl3.4 \
		--with-itkconfig=${LOCALBASE}/lib/itk3.3

pre-everything::
	#
	# The Tk-based GUI (Insight) is patched to work with [incr tcl]
	# version 3.3 and is currently experimental. Bug reports should
	# be accompanied by patches.
	#

pre-configure:
	${MKDIR} ${WRKSRC}/itcl/generic
	${LN} -s ${LOCALBASE}/include/itk3.3/*.h ${WRKSRC}/itcl/generic/
	${LN} -s ${LOCALBASE}/include/itcl3.4/*.h ${WRKSRC}/itcl/generic/
.else
PLIST_SUB+=	INSIGHT='@comment '
CONFLICTS+=	gdb-insight*
.endif

.include <bsd.port.pre.mk>

.if ${ARCH} == "ia64" || ${ARCH} == "powerpc"
BROKEN=		Does not configure on ia64 or powerpc
.endif

.if ${ARCH} == "amd64"
CONFIGURE_TARGET=	x86_64-portbld-freebsd${OSREL}
.endif

post-patch:
	@${REINPLACE_CMD} -e 's/$$/ [GDB v${PORTVERSION} for FreeBSD]/' \
		${WRKSRC}/gdb/version.in
	@${REINPLACE_CMD} -e 's/^READLINE/#READLINE/' \
		-e 's/^readline/#readline/' \
		-e 's,^LIBICONV =.*,LIBICONV=-L${LOCALBASE}/lib ${ICONV_LIB},' \
		${WRKSRC}/gdb/Makefile.in
	${ECHO} 'READLINE = -lreadline' >> ${WRKSRC}/gdb/Makefile.in

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/gdb/gdb ${PREFIX}/bin/gdb${VER}
	${LN} ${PREFIX}/bin/gdb${VER} ${PREFIX}/bin/gdbtui${VER}
	${INSTALL_MAN} ${WRKSRC}/gdb/gdb.1 ${MAN1PREFIX}/man/man1/gdb${VER}.1
.if ${PORT_OPTIONS:MINSIGHT}
	${LN} ${PREFIX}/bin/gdb${VER} ${PREFIX}/bin/insight
	${MKDIR} ${PREFIX}/share/redhat/gui
	${CP} -p ${WRKSRC}/libgui/library/*.tcl	\
		${WRKSRC}/libgui/library/tclIndex \
			${PREFIX}/share/redhat/gui/
	${MKDIR} ${PREFIX}/lib/insight1.0
	${CP} -Rp ${WRKSRC}/gdb/gdbtk/library/*.tcl	\
		${WRKSRC}/gdb/gdbtk/library/*.itcl	\
		${WRKSRC}/gdb/gdbtk/library/*.ith	\
		${WRKSRC}/gdb/gdbtk/library/*.itb	\
		${WRKSRC}/gdb/gdbtk/library/help	\
		${WRKSRC}/gdb/gdbtk/library/images*	\
		${WRKSRC}/gdb/gdbtk/library/tclIndex	\
			${PREFIX}/lib/insight1.0
.endif

.include <bsd.port.post.mk>
