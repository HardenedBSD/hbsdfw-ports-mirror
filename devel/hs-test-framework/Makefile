# $FreeBSD$

PORTNAME=	test-framework
PORTVERSION=	0.8
PORTREVISION=	5
CATEGORIES=	devel haskell

MAINTAINER=	haskell@FreeBSD.org
COMMENT=	Framework for running and organising tests, with HUnit and QuickCheck support

LICENSE=	BSD

USE_CABAL=	ansi-terminal>=0.4.0 ansi-wl-pprint>=0.5.1 \
		extensible-exceptions>=0.1.1 hostname>=1.0 random>=1.0 \
		regex-posix>=0.72 xml>=1.3.5

NO_STAGE=	yes
.include "${.CURDIR}/../../lang/ghc/bsd.cabal.mk"
.include <bsd.port.mk>
