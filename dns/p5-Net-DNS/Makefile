# Created by: James FitzGibbon <jfitz@FreeBSD.org>
# $FreeBSD$

PORTNAME=	Net-DNS
PORTVERSION=	0.73
CATEGORIES=	dns net perl5 ipv6
MASTER_SITES=	CPAN
PKGNAMEPREFIX=	p5-

MAINTAINER=	perl@FreeBSD.org
COMMENT=	Perl5 interface to the DNS resolver, and dynamic updates

LICENSE=	ART10 GPLv1
LICENSE_COMB=	dual

BUILD_DEPENDS=	p5-Digest-HMAC>=1.01:${PORTSDIR}/security/p5-Digest-HMAC
RUN_DEPENDS:=	${BUILD_DEPENDS}
TEST_DEPENDS=	p5-Digest-BubbleBabble>=0:${PORTSDIR}/security/p5-Digest-BubbleBabble \
		p5-Test-Pod>=0:${PORTSDIR}/devel/p5-Test-Pod

OPTIONS_DEFINE=	IDN IPV6

CONFIGURE_ARGS=	--no-IPv6-tests --no-online-tests
USES=		perl5
USE_PERL5=	configure

IDN_BUILD_DEPENDS=	p5-Net-LibIDN>=0:${PORTSDIR}/dns/p5-Net-LibIDN
IDN_RUN_DEPENDS=	p5-Net-LibIDN>=0:${PORTSDIR}/dns/p5-Net-LibIDN
IPV6_BUILD_DEPENDS=	p5-IO-Socket-INET6>=0:${PORTSDIR}/net/p5-IO-Socket-INET6
IPV6_RUN_DEPENDS=	p5-IO-Socket-INET6>=0:${PORTSDIR}/net/p5-IO-Socket-INET6

.include <bsd.port.mk>
