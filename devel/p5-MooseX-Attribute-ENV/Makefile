# Created by: alan <Alan@Wave2.org>
# $FreeBSD$

PORTNAME=	MooseX-Attribute-ENV
PORTVERSION=	0.02
PORTREVISION=	1
CATEGORIES=	devel perl5
MASTER_SITES=	CPAN
PKGNAMEPREFIX=	p5-

MAINTAINER=	Alan@Wave2.org
COMMENT=	Set default of an attribute to a value from %ENV

LICENSE=	ART10 GPLv1
LICENSE_COMB=	dual

BUILD_DEPENDS=	p5-Moose>=1.19:${PORTSDIR}/devel/p5-Moose
RUN_DEPENDS:=	${BUILD_DEPENDS}

USES=		perl5
USE_PERL5=	configure

MAN3=		MooseX::Attribute::ENV.3

NO_STAGE=	yes
.include <bsd.port.mk>
