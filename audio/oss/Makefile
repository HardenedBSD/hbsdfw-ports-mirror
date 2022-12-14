# Created by: Edward Tomasz Napierala <trasz@FreeBSD.org>
# $FreeBSD$

PORTNAME=	oss
DISTVERSION=	4.2-build2008
CATEGORIES=	audio kld
MASTER_SITES=	http://www.opensound.com/developer/sources/stable/bsd/
DISTNAME=	${PORTNAME}-v${DISTVERSION}-src-bsd

MAINTAINER=	ports@FreeBSD.org
COMMENT=	Open Sound System

LICENSE=	BSD

BUILD_DEPENDS=	gawk:${PORTSDIR}/lang/gawk

SSP_UNSAFE=	kernel module does not support ssp
USES=		pkgconfig
USE_BZIP2=	yes
NO_STAGE=	yes
ALL_TARGET=	all install
USE_GNOME=	gtk20
USE_RC_SUBR=	oss
WRKSRC=		${WRKDIR}/build
PATCH_WRKSRC=	${WRKDIR}/${DISTNAME}
SUB_FILES=	pkg-install pkg-deinstall
ONLY_FOR_ARCHS=	amd64 i386
MANCOMPRESSED=	yes

MAN1=		ossinfo.1 ossmix.1 osspartysh.1 ossphone.1 ossplay.1 \
		ossrecord.1 osstest.1 ossxmix.1 soundoff.1 soundon.1
MAN7=		oss_ali5455.7 oss_atiaudio.7 oss_audigyls.7 \
		oss_audioloop.7 oss_audiopci.7 oss_cmi878x.7 \
		oss_cmpci.7 oss_cs4281.7 oss_cs461x.7 oss_digi96.7 \
		oss_emu10k1x.7 oss_envy24.7 oss_envy24ht.7 \
		oss_fmedia.7 oss_geode.7 oss_hdaudio.7 oss_ich.7 \
		oss_imux.7 oss_madi.7 oss_midiloop.7 oss_midimix.7 \
		oss_sblive.7 oss_sbpci.7 oss_sbxfi.7 oss_solo.7 \
		oss_trident.7 oss_userdev.7 oss_via823x.7 \
		oss_via97.7 oss_ymf7xx.7 osscore.7
MAN8=		ossdetect.8 ossdevlinks.8 savemixer.8 vmixctl.8

OSS_CONF_FILES=	oss_audigyls oss_audioloop oss_cs461x oss_emu10k1x \
		oss_envy24 oss_envy24ht oss_fmedia oss_hdaudio \
		oss_ich oss_imux oss_madi oss_midiloop oss_sblive \
		oss_sbpci oss_sbxfi oss_trident oss_usb oss_userdev \
		oss_ymf7xx osscore

PROTO_DIR=	${WRKSRC}/prototype
PROTO_ETCDIR=	${PROTO_DIR}/etc
PROTO_BINDIR=	${PROTO_DIR}/usr/bin
PROTO_SBINDIR=	${PROTO_DIR}/usr/sbin
PROTO_MANDIR=	${PROTO_DIR}/usr/share/man
PROTO_OSSLIBDIR=${PROTO_DIR}${PREFIX}/lib/oss

CONFIGURE_ENV=	CC="${CC}" HOSTCC="${CC}"

OPTIONS_DEFINE=	VORBIS
OPTIONS_DEFAULT=VORBIS

.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MVORBIS}
LIB_DEPENDS+=	libvorbisfile.so:${PORTSDIR}/audio/libvorbis
CONFIGURE_ENV+=	OGG_SUPPORT=YES
.endif

.include <bsd.port.pre.mk>

.if !exists(${SRC_BASE}/sys/Makefile)
IGNORE=		requires kernel source to be installed
.elif !defined(SYSDIR)
MAKE_ENV+=	SYSDIR="${SRC_BASE}/sys"
.endif

pre-patch:
	${FIND} ${PATCH_WRKSRC} -name '*.man' -or \
	    \( -name '*.[ch]' \! -name ossmkdep.c \) | \
	    ${XARGS} ${REINPLACE_CMD} -e 's|/usr/|${PREFIX}/|g' \
	    -e 's|/etc/oss|${PREFIX}/etc/oss|g'

post-patch:
	${REINPLACE_CMD} -e 's|%%LOCALBASE%%|${LOCALBASE}|g' \
	    ${PATCH_WRKSRC}/setup/srcconf.c
	${FIND} ${PATCH_WRKSRC} -name configure -or \
	    -name make.local -or -name soundoff -or -name soundon | \
	    ${XARGS} ${REINPLACE_CMD} -e 's|%%PREFIX%%|${PREFIX}|g'

do-configure:
	${MKDIR} ${WRKSRC}
	(cd ${WRKSRC} && \
	    ${SETENV} ${CONFIGURE_ENV} ${PATCH_WRKSRC}/configure)

do-install:
	${INSTALL_PROGRAM} ${PROTO_BINDIR}/* ${PREFIX}/bin/
# @${ECHO_CMD} "OSSLIBDIR=${PREFIX}/lib/oss" > ${PROTO_ETCDIR}/oss.conf
	${INSTALL_DATA} ${PROTO_ETCDIR}/oss.conf ${PREFIX}/etc/
	-@${MKDIR} ${PREFIX}/lib/oss 2>/dev/null
	${INSTALL_DATA} ${PROTO_OSSLIBDIR}/soundon.user \
	    ${PREFIX}/lib/oss/soundon.user.sample
	${INSTALL_DATA} ${PROTO_OSSLIBDIR}/sysfiles.list ${PREFIX}/lib/oss/
	${INSTALL_DATA} ${PROTO_OSSLIBDIR}/version.dat ${PREFIX}/lib/oss/
	-@${MKDIR} ${PREFIX}/lib/oss/conf 2>/dev/null
.for CONF_FILE in ${OSS_CONF_FILES}
	${INSTALL_DATA} ${PROTO_OSSLIBDIR}/conf/${CONF_FILE}.conf \
	    ${PREFIX}/lib/oss/conf/${CONF_FILE}.conf.sample
.endfor
	-@${MKDIR} ${PREFIX}/lib/oss/etc 2>/dev/null
	${INSTALL_DATA} ${PROTO_OSSLIBDIR}/etc/devices.list \
	    ${PREFIX}/lib/oss/etc/
	-@${MKDIR} ${PREFIX}/lib/oss/include/sys 2>/dev/null
	${INSTALL_DATA} ${PROTO_OSSLIBDIR}/include/sys/soundcard.h \
	    ${PREFIX}/lib/oss/include/sys/
	-@${MKDIR} ${PREFIX}/lib/oss/logs 2>/dev/null
	@${MKDIR} ${PREFIX}/lib/oss/modules
	${INSTALL_KLD} ${PROTO_OSSLIBDIR}/modules/*.ko \
	    ${PREFIX}/lib/oss/modules/
	${INSTALL_MAN} ${PROTO_MANDIR}/man1/*.1.gz ${PREFIX}/man/man1/
	${INSTALL_MAN} ${PROTO_MANDIR}/man7/*.7.gz ${PREFIX}/man/man7/
	${INSTALL_MAN} ${PROTO_MANDIR}/man8/*.8.gz ${PREFIX}/man/man8/
	${INSTALL_PROGRAM} ${PROTO_SBINDIR}/ossdetect ${PREFIX}/sbin/
	${INSTALL_PROGRAM} ${PROTO_SBINDIR}/ossdevlinks ${PREFIX}/sbin/
	${INSTALL_PROGRAM} ${PROTO_SBINDIR}/savemixer ${PREFIX}/sbin/
	${INSTALL_SCRIPT} ${PROTO_SBINDIR}/soundoff ${PREFIX}/sbin/
	${INSTALL_SCRIPT} ${PROTO_SBINDIR}/soundon ${PREFIX}/sbin/
	${INSTALL_PROGRAM} ${PROTO_SBINDIR}/vmixctl ${PREFIX}/sbin/
	@${SH} ${PKGINSTALL} ${PKGNAME} POST-INSTALL
	@${CAT} ${PKGMESSAGE}

.include <bsd.port.post.mk>
