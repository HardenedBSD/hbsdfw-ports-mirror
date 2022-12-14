# $FreeBSD$

PORTNAME=	hunspell
PORTVERSION=	20131206
CATEGORIES=	german textproc
MASTER_SITES=	http://www.j3e.de/ispell/igerman98/dict/ \
		LOCAL/sunpoet/${PORTNAME}
DISTNAME=	igerman98-${PORTVERSION}
DIST_SUBDIR=	${PORTNAME}

MAINTAINER=	office@FreeBSD.org
COMMENT=	German hunspell dictionaries

LICENSE=	GPLv2 GPLv3
LICENSE_COMB=	dual

BUILD_DEPENDS=	${LOCALBASE}/bin/buildhash:${PORTSDIR}/textproc/ispell \
		${LOCALBASE}/bin/hunspell:${PORTSDIR}/textproc/hunspell

USES=		gmake perl5 shebangfix
USE_BZIP2=	yes
ALL_TARGET=	hunspell-all
USE_PERL5=	build
SHEBANG_FILES=	bin/*.pl

PLIST_FILES=	%%DATADIR%%/de_AT.aff \
		%%DATADIR%%/de_AT.dic \
		%%DATADIR%%/de_CH.aff \
		%%DATADIR%%/de_CH.dic \
		%%DATADIR%%/de_DE.aff \
		%%DATADIR%%/de_DE.dic
PLIST_DIRSTRY=	%%DATADIR%%

CHALIASES=	de_LI
DEALIASES=	de_BE de_LU
.for ALIAS in ${CHALIASES} ${DEALIASES}
PLIST_FILES+=	%%DATADIR%%/${ALIAS}.aff \
		%%DATADIR%%/${ALIAS}.dic
.endfor

do-install:
	${MKDIR} ${STAGEDIR}${DATADIR}/
	${INSTALL_DATA} ${WRKSRC}/hunspell/de_AT.aff ${WRKSRC}/hunspell/de_AT.dic \
		${WRKSRC}/hunspell/de_CH.aff ${WRKSRC}/hunspell/de_CH.dic \
		${WRKSRC}/hunspell/de_DE.aff ${WRKSRC}/hunspell/de_DE.dic ${STAGEDIR}${DATADIR}/
.for ALIAS in ${CHALIASES}
	${LN} -s de_CH.aff ${STAGEDIR}${DATADIR}/${ALIAS}.aff
	${LN} -s de_CH.dic ${STAGEDIR}${DATADIR}/${ALIAS}.dic
.endfor
.for ALIAS in ${DEALIASES}
	${LN} -s de_DE.aff ${STAGEDIR}${DATADIR}/${ALIAS}.aff
	${LN} -s de_DE.dic ${STAGEDIR}${DATADIR}/${ALIAS}.dic
.endfor

.include <bsd.port.mk>
