# Created by: Jason Helfman <jgh@FreeBSD.org>
# $FreeBSD$

PORTNAME=	libvirt-glib
PORTVERSION=	0.1.7
CATEGORIES=	devel
MASTER_SITES=	ftp://libvirt.org/libvirt/glib/

MAINTAINER=	jgh@FreeBSD.org
COMMENT=	Glib bindings for Libvirt virtualization API

LIB_DEPENDS=	libvirt.so:${PORTSDIR}/devel/libvirt

GNU_CONFIGURE=	yes
USES=	pathfix pkgconfig gmake
USE_LDCONFIG=	yes
USE_AUTOTOOLS=	libtool
USE_GNOME=	intltool introspection
USE_PYTHON=	-2.7
CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib -fstack-protector
CONFIGURE_ARGS+=	--enable-introspection

post-patch-script:
	@${REINPLACE_CMD} 's}--quiet}--quiet --libtool=${LIBTOOL}}' \
		${WRKSRC}/libvirt-*/Makefile.in

.include <bsd.port.mk>
