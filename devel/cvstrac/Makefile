# Created by: Bruce M Simpson <bms@spc.org>
# $FreeBSD$

PORTNAME?=	cvstrac
PORTVERSION=	2.0.1
CATEGORIES=	devel
MASTER_SITES=	http://www.cvstrac.org/
DISTNAME=	cvstrac-${PORTVERSION}

MAINTAINER=	ports@FreeBSD.org
COMMENT?=	Web-Based Bug And Patch-Set Tracking System For CVS

WRKSRC=		${WRKDIR}/cvstrac-${PORTVERSION}
USE_SQLITE=	yes
USES=		gmake pkgconfig

MAKE_ARGS+=	SRCDIR=${WRKSRC} PREFIX=${PREFIX} LOCALBASE=${LOCALBASE}
MAKE_JOBS_UNSAFE=	yes

NOMAN=
PLIST_FILES=	bin/${PORTNAME}

NO_STAGE=	yes
do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/${PORTNAME} ${PREFIX}/bin
	@${CAT} ${PKGMESSAGE}

.include <bsd.port.mk>
