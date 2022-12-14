# Created by: "Choe, Cheng-Dae" whitekid
# $FreeBSD$

PORTNAME=	sqlobject
PORTVERSION=	1.5.0
CATEGORIES=	databases python
MASTER_SITES=	CHEESESHOP
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}
DISTNAME=	SQLObject-${PORTVERSION}

MAINTAINER=	wg@FreeBSD.org
COMMENT=	Python object for manipulation with SQL table row

BUILD_DEPENDS=	${PYTHON_PKGNAMEPREFIX}formencode>=1.2.2:${PORTSDIR}/www/py-formencode
RUN_DEPENDS:=	${BUILD_DEPENDS}

USE_PYTHON=		yes
USE_PYDISTUTILS=	yes
PYDISTUTILS_AUTOPLIST=	yes

OPTIONS_DEFINE=	MYSQL PGSQL SQLITE MSSQL FIREBIRD SYBASE
SYBASE_DESC=	sybase support

PORTDOCS=	*

.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MMYSQL}
RUN_DEPENDS+=	${PYTHON_PKGNAMEPREFIX}MySQLdb>=0:${PORTSDIR}/databases/py-MySQLdb
.endif

.if ${PORT_OPTIONS:MPGSQL}
RUN_DEPENDS+=	${PYTHON_SITELIBDIR}/psycopg2/__init__.py:${PORTSDIR}/databases/py-psycopg2
.endif

.if ${PORT_OPTIONS:MSQLITE}
RUN_DEPENDS+=	${PYTHON_PKGNAMEPREFIX}sqlite3>0:${PORTSDIR}/databases/py-sqlite3
.endif

.if ${PORT_OPTIONS:MMSSQL}
RUN_DEPENDS+=	${PYTHON_SITELIBDIR}/pymssql.py:${PORTSDIR}/databases/py-mssql
.endif

.if ${PORT_OPTIONS:MFIREBIRD}
RUN_DEPENDS+=	${PYTHON_PKGNAMEPREFIX}kinterbasdb>=3.2:${PORTSDIR}/databases/kinterbasdb
.endif

.if ${PORT_OPTIONS:MSYBASE}
RUN_DEPENDS+=	${PYTHON_PKGNAMEPREFIX}sybase>=0.37:${PORTSDIR}/databases/py-sybase
.endif

# currently MaxDB(SAP), ADODB are not supported

post-install:
	${MKDIR} ${STAGEDIR}${DOCSDIR}
	${INSTALL_MAN} ${WRKSRC}/README.txt ${STAGEDIR}${DOCSDIR}
	(cd ${WRKSRC}/docs && ${COPYTREE_SHARE} . ${STAGEDIR}${DOCSDIR})

.include <bsd.port.mk>
