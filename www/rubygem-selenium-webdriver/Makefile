# Created by: Steve Wills <swills@FreeBSD.org>
# $FreeBSD$

PORTNAME=	selenium-webdriver
PORTVERSION=	2.38.0
CATEGORIES=	www rubygems
MASTER_SITES=	RG

MAINTAINER=	ruby@FreeBSD.org
COMMENT=	Tool for writing automated tests of websites

LICENSE=	AL2

RUN_DEPENDS=	rubygem-childprocess>=0.2.5${PORTVERSION}:${PORTSDIR}/devel/rubygem-childprocess \
		rubygem-multi_json>=1:${PORTSDIR}/devel/rubygem-multi_json \
		rubygem-rubyzip>=1:${PORTSDIR}/archivers/rubygem-rubyzip \
		rubygem-websocket>=1.0.4:${PORTSDIR}/www/rubygem-websocket

USE_RUBY=	yes
USE_RUBYGEMS=	yes
RUBYGEM_AUTOPLIST=	yes

.include <bsd.port.mk>
