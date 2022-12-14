# Created by: Maxim Khon <fjoe@FreeBSD.org>
# $FreeBSD$

PORTNAME=	dahdi-kmod26
PORTVERSION=	${DAHDI_VERSION:S/-/./g}
CATEGORIES=	misc
MASTER_SITES=	${MASTER_SITE_LOCAL}\
		http://people.freebsd.org/~fjoe/dahdi/\
		http://downloads.digium.com/pub/telephony/firmware/releases/:firmware
MASTER_SITE_SUBDIR=	fjoe
DISTNAME=	dahdi-freebsd-${DAHDI_VERSION}
DISTFILES=	${DISTNAME}${EXTRACT_SUFX}\
		oslec-linux-${OSLEC_VERSION}${EXTRACT_SUFX}\
		zaphfc-${ZAPHFC_VERSION}${EXTRACT_SUFX}

MAINTAINER=	fjoe@FreeBSD.org
COMMENT=	Digium/Asterisk Hardware Device Interface

RUN_DEPENDS=	${LOCALBASE}/sbin/dahdi_cfg:${PORTSDIR}/misc/dahdi

DAHDI_VERSION=		2.6.1-r10738
DAHDI_TOOLS_VERSION=	2.4.0-rc1
OSLEC_VERSION=		2.6.35.4
ZAPHFC_VERSION=		r5

FIRMWARES=		OCT6114_064 OCT6114_128 OCT6114_256 TC400M HX8 ${_vpmadt032} VPMOCT032 WCT820
OCT6114_064_VERSION=	1.05.01
OCT6114_128_VERSION=	1.05.01
OCT6114_256_VERSION=	1.05.01
TC400M_VERSION=		MR6.12
HX8_VERSION=		2.06
VPMADT032_NAME=		dahdi-fwload-vpmadt032
VPMADT032_DIR=		dahdi_vpmadt032_loader
VPMADT032_VERSION=	1.25.0
VPMOCT032_VERSION=	1.12.0
WCT820_NAME=		dahdi-fw-te820
WCT820_VERSION=		1.76

WRKSRC=		${WRKDIR}/${DISTNAME}
#EXTRA_PATCHES=	${WRKDIR}/zaphfc-${ZAPHFC_VERSION}
#PATCH_STRIP=	-p1
MAKEFILE=	BSDmakefile
NO_PACKAGE=	Should be in sync with the kernel to work correctly
USE_RC_SUBR=	dahdi
MAKE_ARGS=	NO_FETCH=yes WITHOUT_HEADERS=yes #ADDITIONAL_DRIVERS="wcb1xxp"
GROUPS=		dahdi

ONLY_FOR_ARCHS=	i386 amd64 sparc64
CONFLICTS=	zaptel-[0-9]* dahdi-kmod-*

NO_STAGE=	yes

KMODDIR=	${PREFIX}/lib/dahdi
USES=		kmod
.include <bsd.port.pre.mk>

.if ${OSVERSION} < 703000 || (${OSVERSION} >= 800000 && ${OSVERSION} < 800108)
IGNORE=		requires firmware(9) support for kernel modules with hyphens
.endif

.if ${ARCH} == "i386" || ${ARCH} == "amd64"
PLIST_SUB+=	X86=""
_vpmadt032=	VPMADT032
.else
PLIST_SUB+=	X86="@comment "
.endif

.for _f in ${FIRMWARES}
${_f}_NAME?=	dahdi-fw-${_f:L:S/_/-/g}
${_f}_DIR?=	${${_f}_NAME}.bin
${_f}_DISTFILE=	${${_f}_NAME}-${${_f}_VERSION}.tar.gz
DISTFILES+=	${${_f}_DISTFILE}:firmware
.endfor

post-extract:
	@${LN} -s ../../linux-${OSLEC_VERSION}/drivers/staging ${WRKSRC}/drivers
.for _f in ${FIRMWARES}
	${CP} ${DISTDIR}/${${_f}_DISTFILE} ${WRKSRC}/bsd-kmod/${${_f}_DIR}
.endfor

fw-versions: extract
.for _v in ${FIRMWARES:=_VERSION}
	@${ECHO_CMD} "${_v}=`${MAKE} -V ${_v} -f ${WRKSRC}/firmware.mk`"
.endfor

.include <bsd.port.post.mk>
