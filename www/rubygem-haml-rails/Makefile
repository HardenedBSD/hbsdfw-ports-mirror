# $FreeBSD$

PORTNAME=	haml-rails
PORTVERSION=	0.4
CATEGORIES=	www rubygems
MASTER_SITES=	RG

MAINTAINER=	ruby@FreeBSD.org
COMMENT=	Haml generator for Rails

RUN_DEPENDS=	rubygem-actionpack>=3.1:${PORTSDIR}/www/rubygem-actionpack \
		rubygem-activesupport>=3.1:${PORTSDIR}/devel/rubygem-activesupport \
		rubygem-haml>=3.1:${PORTSDIR}/www/rubygem-haml \
		rubygem-railties>=3.1:${PORTSDIR}/www/rubygem-railties

USE_RUBY=	yes
USE_RUBYGEMS=	yes
RUBYGEM_AUTOPLIST=	yes

NO_STAGE=	yes

.include <bsd.port.mk>
