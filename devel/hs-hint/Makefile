# Created by: Giuseppe Pilichi aka Jacula Modyun <jacula@gmail.com>
# $FreeBSD$

PORTNAME=	hint
PORTVERSION=	0.3.3.6
PORTREVISION=	3
CATEGORIES=	devel haskell

MAINTAINER=	haskell@FreeBSD.org
COMMENT=	Runtime Haskell interpreter (GHC API wrapper)

LICENSE=	BSD

USE_CABAL=	ghc-mtl>=1.0.1.0 ghc-paths haskell-src MonadCatchIO-mtl>=0.3 \
		mtl random utf8-string

INSTALL_PORTEXAMPLES=	cd ${WRKSRC}/examples && ${COPYTREE_SHARE} \* ${EXAMPLESDIR}
	
INSTALL_PORTDATA=	${INSTALL_DATA} ${WRKSRC}/AUTHORS ${DATADIR} \
			  && ${INSTALL_DATA} ${WRKSRC}/Changes ${DATADIR}

NO_STAGE=	yes
.include "${.CURDIR}/../../lang/ghc/bsd.cabal.mk"
.include <bsd.port.mk>
