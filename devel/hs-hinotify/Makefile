# $FreeBSD$

PORTNAME=	hinotify
PORTVERSION=	0.3.5
PORTREVISION=	4
CATEGORIES=	devel haskell

MAINTAINER=	haskell@FreeBSD.org
COMMENT=	Haskell binding to inotify

LICENSE=	BSD

LIB_DEPENDS=	inotify.0:${PORTSDIR}/devel/libinotify

NO_STAGE=	yes
.include "${.CURDIR}/../../lang/ghc/bsd.cabal.mk"
.include <bsd.port.mk>
