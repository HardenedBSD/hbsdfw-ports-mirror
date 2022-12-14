# Created by: Sergey Skvortsov <skv@protey.ru>
# $FreeBSD$

PORTNAME=	thrift
PORTVERSION=	${THRIFT_PORTVERSION}	# get these from bsd.thrift.mk. any upgrade needs to check ALL dependencies
PORTEPOCH=	1
CATEGORIES=	devel
MASTER_SITES=	APACHE
MASTER_SITE_SUBDIR=	/thrift/${PORTVERSION}

MAINTAINER=	komarov@valerka.net
COMMENT=	Framework for scalable cross-language services development

LICENSE=	AL2

USE_AUTOTOOLS=	autoconf autoheader:env aclocal automake libtool
ACLOCAL_ARGS=	-I${WRKSRC}/aclocal
AUTOMAKE_ARGS=	--foreign --add-missing --copy

USES=			pkgconfig gmake
GNU_CONFIGURE=		yes
USE_LDCONFIG=		yes
MAKE_JOBS_UNSAFE=	yes

WRKSRC=		${WRKDIR}/${PORTNAME}-${PORTVERSION}
CONFIGURE_ENV+=	${MAKE_ENV}

# For C++ support, use devel/thrift-cpp
# For C glib support, use devel/thrift-c_glib.
# For Perl support, use devel/p5-Thrift.
# For Python support, use devel/py-thrift.
# For Ruby support, use devel/rubygem-thrift.
# For PHP support, use devel/php5-thrift.
# For nodejs support, use devel/node-thrift.
# Other languages are not yet supported, please feel free to contribute
# using one of the leaf ports as an example.
CONFIGURE_ARGS+=	\
		--without-c_glib \
		--without-cpp \
		--without-qt4 \
		--without-csharp \
		--without-erlang \
		--without-haskell \
		--without-java \
		--without-perl \
		--without-php \
		--without-php_extension \
		--without-python \
		--without-ruby

NO_STAGE=	yes
PLIST_FILES=	bin/thrift

.include <bsd.port.pre.mk>
.include "bsd.thrift.mk"

PLIST_SUB+=	PORTVERSION="${PORTVERSION}"

.if ${ARCH} == "ia64" || ${ARCH} == "powerpc" || ${ARCH} == "sparc64"
BROKEN=		Does not compile on ia64, powerpc, or sparc64
.endif

pre-configure:
	@${REINPLACE_CMD} '/config.h/d' ${WRKSRC}/lib/cpp/Makefile.am

post-install:
	@${ECHO_MSG}
	@${ECHO_MSG} "For use with C++, the same compiler as used to build this port must be used"
	@${ECHO_MSG} "to compile and link your generated IDL bindings."
	@${ECHO_MSG}
	@${ECHO_MSG} "Note: The Thrift white paper may be downloaded from:"
	@${ECHO_MSG} "http://thrift.apache.org/static/thrift-20070401.pdf"
	@${ECHO_MSG}

.include <bsd.port.post.mk>
