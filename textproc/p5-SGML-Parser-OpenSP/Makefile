# Created by: Naram Qashat <cyberbotx@cyberbotx.com>
# $FreeBSD$

PORTNAME=	SGML-Parser-OpenSP
PORTVERSION=	0.994
PORTREVISION=	2
CATEGORIES=	textproc perl5
MASTER_SITES=	CPAN
PKGNAMEPREFIX=	p5-

MAINTAINER=	cyberbotx@cyberbotx.com
COMMENT=	Parse SGML documents using OpenSP

# The port's README says the port "is licensed under the same terms as Perl
# itself".
LICENSE=	ART10 GPLv1
LICENSE_COMB=	dual

BUILD_DEPENDS=	onsgmls:${PORTSDIR}/textproc/opensp \
		p5-Class-Accessor>=0:${PORTSDIR}/devel/p5-Class-Accessor \
		p5-Test-Exception>=0:${PORTSDIR}/devel/p5-Test-Exception
RUN_DEPENDS:=	${BUILD_DEPENDS}

USES=		dos2unix perl5
USE_PERL5=	configure
CC=		${CXX}
CONFIGURE_ARGS+="INC=-I${LOCALBASE}/include"

MAN3=		SGML::Parser::OpenSP.3 SGML::Parser::OpenSP::Tools.3

NO_STAGE=	yes
post-patch:
	(cd ${WRKSRC} ; \
	 ${REINPLACE_CMD} "s|%%LOCALBASE%%|${LOCALBASE}|g" Makefile.PL )

.include <bsd.port.mk>
