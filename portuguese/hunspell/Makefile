# $FreeBSD$

PORTNAME=	hunspell
PORTVERSION=	20131125
CATEGORIES=	portuguese textproc
MASTER_SITES=	http://natura.di.uminho.pt/download/sources/Dictionaries/hunspell/ \
		http://www.broffice.org/files/:BR \
		LOCAL/sunpoet/${PORTNAME}:BR
DISTFILES=	hunspell-pt_PT-${PORTVERSION}.tar.gz \
		pt_BR-2012-06-09AOC.zip:BR
DIST_SUBDIR=	${PORTNAME}

MAINTAINER=	office@FreeBSD.org
COMMENT=	Portuguese hunspell dictionaries

NO_BUILD=	yes
WRKSRC=		${WRKDIR}/hunspell-pt_PT-${PORTVERSION}

PLIST_FILES=	%%DATADIR%%/pt_BR.aff \
		%%DATADIR%%/pt_BR.dic \
		%%DATADIR%%/pt_PT.aff \
		%%DATADIR%%/pt_PT.dic
PLIST_DIRSTRY=	%%DATADIR%%

do-install:
	${MKDIR} ${STAGEDIR}${DATADIR}/
	${INSTALL_DATA} ${WRKDIR}/pt_BR.aff ${WRKDIR}/pt_BR.dic \
	  	${WRKSRC}/pt_PT.aff ${WRKSRC}/pt_PT.dic ${STAGEDIR}${DATADIR}/

.include <bsd.port.mk>
