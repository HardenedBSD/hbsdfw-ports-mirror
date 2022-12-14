# $FreeBSD$

PORTNAME=	kumofs
PORTVERSION=	0.4.13
CATEGORIES=	databases
MASTER_SITES=	${MASTER_SITE_LOCAL} \
		http://cloud.github.com/downloads/etolabo/kumofs/
MASTER_SITE_SUBDIR=	kuriyama

MAINTAINER=	kuriyama@FreeBSD.org
COMMENT=	Scalable and highly available distributed key-value store

LIB_DEPENDS=	libmsgpack.so:${PORTSDIR}/devel/msgpack \
		libtokyocabinet.so:${PORTSDIR}/databases/tokyocabinet
RUN_DEPENDS=	rubygem-msgpack>0:${PORTSDIR}/devel/rubygem-msgpack

LICENSE=	AL2
USE_AUTOTOOLS=	libtool autoheader autoconf automake aclocal
ACLOCAL_ARGS=	# empty
AUTOMAKE_ARGS=	--add-missing --copy
CONFIGURE_ARGS=	--with-msgpack=${LOCALBASE} --with-tokyocabinet=${LOCALBASE}
USE_GCC=	4.2+
USE_GMAKE=	yes
USE_RUBY=	yes
USE_RC_SUBR=	kumofs-manager kumofs-server kumofs-gateway
PIDDIR?=	/var/run/kumofs
LOGDIR?=	/var/log/kumofs
PLIST_SUB=	PIDDIR=${PIDDIR} LOGDIR=${LOGDIR}
USERS=		kumofs
GROUPS=		kumofs

MAN1=	kumo-gateway.1 \
	kumo-manager.1 \
	kumo-server.1 \
	kumoctl.1 \
	kumohash.1 \
	kumolog.1 \
	kumomergedb.1 \
	kumostat.1 \
	kumotop.1

NO_STAGE=	yes
pre-configure:
	cd ${WRKSRC}; ${TOUCH} README
	cd ${WRKSRC}; ${LIBTOOLIZE} --force --copy

post-install:
	${MKDIR} ${PIDDIR}
	${CHOWN} ${USERS}:${GROUPS} ${PIDDIR}
	${MKDIR} ${LOGDIR}
	${CHOWN} ${USERS}:${GROUPS} ${LOGDIR}
	${ECHO} "@exec ${CHOWN} ${USERS}:${GROUPS} ${PIDDIR} ${LOGDIR}" >> ${TMPPLIST}

.include <bsd.port.pre.mk>

.if ${ARCH} == "i386"
CONFIGURE_ARGS+=CFLAGS="${CFLAGS} -march=i686" CXXFLAGS="${CXXFLAGS} -march=i686"
.endif

.if ${ARCH} == "sparc64"
BROKEN=		Does not compile on sparc64
.endif

.include <bsd.port.post.mk>
