# Created by: Klemm <andreas@klemm.gtn.com>
# $FreeBSD$

PORTNAME=	lyx
PORTVERSION=	${MAJOR_VERSION}.${MINOR_VERSION}
CATEGORIES=	print editors
MASTER_SITES=	ftp://ftp.lyx.org/pub/lyx/stable/${MAJOR_VERSION}.x/ \
		http://www-ftp.lip6.fr/ftp/pub/lyx/stable/${MAJOR_VERSION}.x/ \
		ftp://gd.tuwien.ac.at/publishing/tex/lyx/stable/${MAJOR_VERSION}.x/ \
		ftp://ftp.ntua.gr/pub/X11/LyX/stable/${MAJOR_VERSION}.x/ \
		http://sunsite.icm.edu.pl/pub/unix/editors/lyx/stable/${MAJOR_VERSION}.x/ \
		ftp://ftp.chg.ru/pub/X11/lyx/stable/${MAJOR_VERSION}.x/

MAINTAINER=	rakuco@FreeBSD.org
COMMENT=	Document processor interfaced with LaTeX (nearly WYSIWYG)

LICENSE=	GPLv2

LIB_DEPENDS=	libboost_regex.so:${PORTSDIR}/devel/boost-libs \
		libmythes-1.2.so:${PORTSDIR}/textproc/mythes

CONFLICTS=	lyx-1.[0-9]*
MAJOR_VERSION=	2.0
MINOR_VERSION=	6

USES=		desktop-file-utils gmake iconv pkgconfig perl5
USE_PYTHON=	-2.7
USE_QT4=	corelib gui moc_build uic_build rcc_build
USE_XZ=		yes
GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--without-included-boost \
		--without-included-mythes \
		${ICONV_CONFIGURE_ARG} \
		--with-extra-prefix=${LOCALBASE}

OPTIONS_DEFINE=		ASPELL ENCHANT HUNSPELL NLS
OPTIONS_DEFAULT=	HUNSPELL NLS
OPTIONS_SUB=		yes
ENCHANT_DESC=		Spell checking using Enchant

ASPELL_CONFIGURE_OFF=	--without-aspell
ASPELL_LIB_DEPENDS=	libaspell.so:${PORTSDIR}/textproc/aspell
ENCHANT_CONFIGURE_OFF=	--without-enchant
ENCHANT_LIB_DEPENDS=	libenchant.so:${PORTSDIR}/textproc/enchant
HUNSPELL_CONFIGURE_OFF=	--without-hunspell
HUNSPELL_LIB_DEPENDS=	libhunspell-1.3.so:${PORTSDIR}/textproc/hunspell
NLS_CONFIGURE_OFF=	--disable-nls
NLS_USES=		gettext

.include <bsd.port.options.mk>

post-install:
# Manually install the 48x48 icon and .desktop file.
# Will not be needed in the 2.1 series, see LyX tickets 2820 and 7919.
	${MKDIR} ${STAGEDIR}${PREFIX}/share/icons/hicolor/48x48/apps
	${INSTALL_DATA} ${WRKSRC}/lib/images/lyx.png ${STAGEDIR}${PREFIX}/share/icons/hicolor/48x48/apps
	${INSTALL_DATA} ${FILESDIR}/lyx.desktop ${STAGEDIR}${PREFIX}/share/applications

.include <bsd.port.mk>
