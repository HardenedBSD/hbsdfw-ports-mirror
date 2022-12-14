# Created by: Hye-Shik Chang <perky@FreeBSD.org>
# $FreeBSD$

PORTNAME=	dpkg
PORTVERSION=	1.17.5
CATEGORIES=	archivers sysutils
MASTER_SITES=	${MASTER_SITE_DEBIAN_POOL}
DISTNAME=	dpkg_${PORTVERSION}

MAINTAINER=	pawel@FreeBSD.org
COMMENT=	Debian package maintenance system

LICENSE=	GPLv2

BUILD_DEPENDS=	po4a:${PORTSDIR}/textproc/po4a
RUN_DEPENDS=	gtar:${PORTSDIR}/archivers/gtar \
		gpatch:${PORTSDIR}/devel/patch \
		gmd5sum:${PORTSDIR}/sysutils/coreutils

USE_XZ=		yes
GNU_CONFIGURE=	yes
USES=		gmake iconv perl5 pkgconfig
NEED_ROOT=	yes
WRKSRC=		${WRKDIR}/dpkg-${PORTVERSION}

DPKGDIR?=	/var/db/dpkg
PLIST_SUB+=	DPKGDIR=${DPKGDIR:C,^/,,}

SUB_FILES=	pkg-install pkg-deinstall
SUB_LIST+=	DPKGDIR=${DPKGDIR}

CONFIGURE_ARGS+=--with-admindir=${DPKGDIR} --libdir=${PREFIX}/libexec \
		--program-transform-name="" --with-libintl-prefix=${LOCALBASE} \
		--disable-compiler-warnings
CONFIGURE_ENV+=	PERL_LIBDIR="${PREFIX}/${SITE_PERL_REL}"

OPTIONS_DEFINE=	NLS
OPTIONS_SUB=	yes

NLS_CONFIGURE_OFF=	--disable-nls
NLS_USES=		gettext

post-patch:
	@${REINPLACE_CMD} 's|-t$$host|-t${ARCH}-freebsd|g' \
		${WRKSRC}/configure
	@${REINPLACE_CMD} '/^#define TAR/ s|tar|g&|' \
		${WRKSRC}/lib/dpkg/dpkg.h
	@${REINPLACE_CMD} -E 's/(md5|sha1|sha256)sum/g&/g' \
		${WRKSRC}/scripts/Dpkg/Checksums.pm

post-install:
	${SH} ${PKGINSTALL} ${PKGNAME} POST-INSTALL

.include <bsd.port.mk>
