# Created by: Alexey V. Degtyarev
# $FreeBSD$

PORTNAME=	File-ChangeNotify
PORTVERSION=	0.24
CATEGORIES=	devel perl5
MASTER_SITES=	CPAN
PKGNAMEPREFIX=	p5-

MAINTAINER=	alexey@renatasystems.org
COMMENT=	Watch for changes to files

LICENSE=	ART20

RUN_DEPENDS=	p5-Moose>=2:${PORTSDIR}/devel/p5-Moose \
		p5-IO-KQueue>=0:${PORTSDIR}/devel/p5-IO-KQueue \
		p5-MooseX-Params-Validate>=0:${PORTSDIR}/devel/p5-MooseX-Params-Validate \
		p5-MooseX-SemiAffordanceAccessor>=0:${PORTSDIR}/devel/p5-MooseX-SemiAffordanceAccessor \
		p5-namespace-autoclean>=0:${PORTSDIR}/devel/p5-namespace-autoclean
BUILD_DEPENDS:=	${RUN_DEPENDS}
TEST_DEPENDS=	p5-Test-Exception>0:${PORTSDIR}/devel/p5-Test-Exception

MAN3=		File::ChangeNotify.3 \
		File::ChangeNotify::ConfigData.3 \
		File::ChangeNotify::Event.3 \
		File::ChangeNotify::Watcher.3 \
		File::ChangeNotify::Watcher::Default.3 \
		File::ChangeNotify::Watcher::Inotify.3 \
		File::ChangeNotify::Watcher::KQueue.3

USES=		perl5
USE_PERL5=	modbuild

.include <bsd.port.mk>
