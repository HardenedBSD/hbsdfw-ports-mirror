# Created by: Greg Larkin <glarkin@FreeBSD.org>
# $FreeBSD$

PORTNAME=	SVN-Dumpfile
PORTVERSION=	0.13.107
PORTREVISION=	2
CATEGORIES=	devel perl5
MASTER_SITES=	CPAN
PKGNAMEPREFIX=	p5-

MAINTAINER=	ports@FreeBSD.org
COMMENT=	Perl extension to access and manipulate Subversion dumpfiles

BUILD_DEPENDS=	p5-Data-GUID>=0:${PORTSDIR}/devel/p5-Data-GUID \
		p5-TimeDate>=2.27:${PORTSDIR}/devel/p5-TimeDate \
		p5-Readonly>=1.03:${PORTSDIR}/devel/p5-Readonly
RUN_DEPENDS:=	${BUILD_DEPENDS}

USES=		perl5
USE_PERL5=	configure

MAN3=		SVN::Dumpfile.3 \
		SVN::Dumpfile::Node.3 \
		SVN::Dumpfile::Node::Content.3 \
		SVN::Dumpfile::Node::Headers.3 \
		SVN::Dumpfile::Node::Properties.3 \
		SVN::Dumpfile::Tutorial.3

NO_STAGE=	yes
.include <bsd.port.mk>
