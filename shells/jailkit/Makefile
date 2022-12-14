# Created by: Sylvio Cesar <sylvio@FreeBSD.org>
# $FreeBSD$

PORTNAME=	jailkit
PORTVERSION=	2.15
CATEGORIES=	shells
MASTER_SITES=	http://olivier.sessink.nl/jailkit/ \
		http://www.sfr-fresh.com/unix/privat/

MAINTAINER=	sylvio@FreeBSD.org
COMMENT=	Utilities to limit user account

GNU_CONFIGURE=	yes
CONFIGURE_ENV=	PYTHONINTERPRETER=${PYTHON_CMD}
USE_PYTHON=	2

SHELLS=		/etc/shells

MAN8=		jailkit.8 \
		jk_addjailuser.8 \
		jk_check.8 \
		jk_chrootlaunch.8 \
		jk_chrootsh.8 \
		jk_cp.8 \
		jk_init.8 \
		jk_jailuser.8 \
		jk_list.8 \
		jk_lsh.8 \
		jk_socketd.8 \
		jk_uchroot.8 \
		jk_update.8
MANCOMPRESSED=	yes

PORTDOCS=	COPYRIGHT README.txt

NO_STAGE=	yes
.include <bsd.port.options.mk>

post-install:
	@${ECHO_MSG} "Updating ${SHELLS}"
	@${CP} ${SHELLS} ${SHELLS}.bak
	@(${GREP} -v ${PREFIX}/sbin/jk_chrootsh ${SHELLS}.bak; \
		${ECHO_CMD} ${PREFIX}/sbin/jk_chrootsh) > ${SHELLS}
	@${RM} -f ${SHELLS}.bak

.if ${PORT_OPTIONS:MDOCS}
	@${MKDIR} ${DOCSDIR}
	${INSTALL_DATA} ${PORTDOCS:S,^,${WRKSRC}/,} ${DOCSDIR}
.endif

.include <bsd.port.mk>
