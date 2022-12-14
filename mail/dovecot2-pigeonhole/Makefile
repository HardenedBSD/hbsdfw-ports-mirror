# Created by: Nils Vogels <nivo+kw+ports.bfa274@is-root.com>
# $FreeBSD$

PORTNAME=	dovecot-pigeonhole
PORTVERSION=	0.4.2
PORTREVISION=	1
CATEGORIES=	mail
MASTER_SITES=	http://www.rename-it.nl/dovecot/${DOVECOTVERSION}/
DISTNAME=	${PORTNAME:C/-/-${DOVECOTVERSION}-/}-${PORTVERSION}

MAINTAINER=	bra@fsn.hu
COMMENT=	Sieve plugin for the Dovecot 'deliver' LDA and LMTP

LICENSE=	LGPL21

BUILD_DEPENDS:=	dovecot>=${DOVECOTVERSION}:${PORTSDIR}/mail/dovecot2
RUN_DEPENDS:=	dovecot>=${DOVECOTVERSION}:${PORTSDIR}/mail/dovecot2

DOVECOTVERSION=	2.2

GNU_CONFIGURE=	yes
CONFIGURE_TARGET=	--build=${MACHINE_ARCH}-portbld-freebsd${OSREL}
CONFIGURE_ARGS=	--exec-prefix=${PREFIX} \
		--without-dovecot-install-dirs \
		--docdir=${DOCSDIR} \
		--with-dovecot="${LOCALBASE}/lib/dovecot"
LDFLAGS+=	-L${LOCALBASE}/lib
USE_LDCONFIG=	${PREFIX}/lib/dovecot

PORTDOCS=	doc/extensions/* doc/plugins/* doc/rfc/*

post-patch:
	@${REINPLACE_CMD} -E '\
	s!^(install-data-am:) install-sieve_docDATA!\1!; \
		s!^(uninstall-am:) uninstall-sieve_docDATA!\1!;' \
		${WRKSRC}/doc/Makefile.in

.include <bsd.port.mk>
