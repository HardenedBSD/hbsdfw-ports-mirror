# $FreeBSD$

PORTREVISION=	0
PKGNAMESUFFIX=	-qt4

MAINTAINER=	crees@FreeBSD.org
COMMENT=	Fast and lightweight QT4 BitTorrent client

LIB_DEPENDS=	${GEN_LIB_DEPENDS}
RUN_DEPENDS=	${GEN_RUN_DEPENDS}

DESCR=		${.CURDIR}/pkg-descr
MASTERDIR=	${.CURDIR}/../transmission-cli
PLIST=		${.CURDIR}/pkg-plist
SLAVEPORT=	qt4

QT_NONSTANDARD=	yes
USE_QT4=	moc_build qmake_build rcc_build uic_build gui dbus network
USE_GNOME=	desktopfileutils
LDFLAGS+=	-lcrypto

EXTRA_CONF_ARGS=--disable-cli \
		--disable-daemon \
		--without-gtk \
		--disable-mac \
		--disable-nls

MAN1=		transmission-qt.1

post-patch: general-patch
	@${REINPLACE_CMD} -e 's|/share/man|/man|g ; /PKGCONFIG/s| openssl||g' \
		${WRKSRC}/qt/qtr.pro

NO_STAGE=	yes
post-build:
	@(cd ${WRKSRC}/qt ; ${QMAKE} ${QMAKE_ARGS} qtr.pro ; ${GMAKE})

do-install:
	@(cd ${WRKSRC}/qt ; ${SETENV} INSTALL_ROOT=${PREFIX} ${MAKE} install)

post-install: general-install
.ifndef (NOPORTDOCS)
	@${MKDIR} ${DOCSDIR}
	@${INSTALL_DATA} ${WRKSRC}/qt/README.txt ${DOCSDIR}/README-qt4
.endif
	@${INSTALL_DATA} ${WRKSRC}/qt/transmission-qt.desktop \
		${PREFIX}/share/applications/
	@${INSTALL_DATA} ${WRKSRC}/qt/icons/transmission.png \
		${PREFIX}/share/pixmaps/transmission-qt.png
	@-update-desktop-database

.include "${MASTERDIR}/Makefile"
