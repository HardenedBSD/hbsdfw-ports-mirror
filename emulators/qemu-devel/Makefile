# Created by: Juergen Lock <nox@jelal.kn-bremen.de>
# $FreeBSD$

PORTNAME=	qemu
PORTVERSION=	1.6.1
CATEGORIES=	emulators
MASTER_SITES=	http://wiki.qemu.org/download/:release \
		LOCAL/nox:snapshot
PKGNAMESUFFIX=	-devel
DISTFILES=	${DISTNAME}${EXTRACT_SUFX}:release
DIST_SUBDIR=	qemu/${PORTVERSION}

MAINTAINER=	nox@FreeBSD.org
COMMENT=	QEMU CPU Emulator - development version

HAS_CONFIGURE=	yes
USE_BZIP2=	yes
USES=		gmake pkgconfig bison perl5
USE_PERL5=	build
USE_PYTHON_BUILD=	-2.7
USE_XORG=	pixman
USE_GNOME+=	glib20
PATCH_STRIP=	-p1
MAKE_ENV+=	BSD_MAKE="${MAKE}"
MAN1=		qemu.1 qemu-img.1
MAN8=		qemu-nbd.8
ONLY_FOR_ARCHS=	amd64 i386 powerpc powerpc64 # XXX someone wants to debug sparc64 hosts?
CONFLICTS_INSTALL=	qemu-[0-9]*

OPTIONS_DEFINE=	SAMBA X11 GTK2 OPENGL GNUTLS SASL JPEG PNG CURL \
		CDROM_DMA PCAP USBREDIR GNS3 X86_TARGETS \
		STATIC_LINK DOCS
SAMBA_DESC=		samba dependency (for -smb)
GNUTLS_DESC=		gnutls dependency (vnc encryption)
SASL_DESC=		cyrus-sasl dependency (vnc encryption)
JPEG_DESC=		jpeg dependency (vnc lossy compression)
PNG_DESC=		png dependency (vnc compression)
CDROM_DMA_DESC=		IDE CDROM DMA
PCAP_DESC=		pcap dependency (networking with bpf)
SEABIOS_GIT_DESC=	add seabios snapshot (-bios bios.bin-1.6.3.1)
USBREDIR_DESC=		usb device network redirection (experimental!)
GNS3_DESC=		gns3 patches (promiscuous multicast)
X86_TARGETS_DESC=	Don't build non-x86 system targets
BSD_USER_DESC=		Also build bsd-user targets (for testing)
STATIC_LINK_DESC=	Statically link the executables
OPTIONS_DEFAULT=X11 GTK2 OPENGL GNUTLS SASL JPEG PNG CDROM_DMA CURL PCAP

NO_STAGE=	yes

.include <bsd.port.options.mk>

CONFIGURE_ARGS+=	--extra-ldflags=-L${LOCALBASE}/lib
CONFIGURE_ARGS+=	--disable-smartcard-nss
PORTDOCS=	docs qemu-doc.html qemu-tech.html qmp-commands.txt

.if ${PORT_OPTIONS:MX86_TARGETS}
.if ${PORT_OPTIONS:MBSD_USER}
.if ${ARCH} != "amd64"
CONFIGURE_ARGS+=	--enable-nptl --target-list=i386-softmmu,x86_64-softmmu,i386-bsd-user,sparc-bsd-user,arm-bsd-user,armeb-bsd-user,mips-bsd-user,mipsel-bsd-user
.else
CONFIGURE_ARGS+=	--enable-nptl --target-list=i386-softmmu,x86_64-softmmu,i386-bsd-user,x86_64-bsd-user,sparc-bsd-user,sparc64-bsd-user,arm-bsd-user,armeb-bsd-user,mips-bsd-user,mipsel-bsd-user,mips64-bsd-user
.endif
.else
CONFIGURE_ARGS+=	--target-list=i386-softmmu,x86_64-softmmu
.endif
.else
.if empty(PORT_OPTIONS:MBSD_USER)
CONFIGURE_ARGS+=	--disable-bsd-user
.else
CONFIGURE_ARGS+=	--enable-nptl
.if ${ARCH} != "amd64"
CONFIGURE_ARGS+=	--target-list=i386-softmmu,x86_64-softmmu,alpha-softmmu,arm-softmmu,cris-softmmu,lm32-softmmu,m68k-softmmu,microblaze-softmmu,microblazeel-softmmu,mips-softmmu,mipsel-softmmu,mips64-softmmu,mips64el-softmmu,or32-softmmu,ppc-softmmu,ppcemb-softmmu,ppc64-softmmu,sh4-softmmu,sh4eb-softmmu,sparc-softmmu,sparc64-softmmu,s390x-softmmu,xtensa-softmmu,xtensaeb-softmmu,unicore32-softmmu,moxie-softmmu,i386-bsd-user,sparc-bsd-user,arm-bsd-user,armeb-bsd-user,mips-bsd-user,mipsel-bsd-user
.endif
.endif
.endif

.if empty(PORT_OPTIONS:MBSD_USER)
PLIST_SUB+=	BSD_USER="@comment "
.else
PLIST_SUB+=	BSD_USER=""
.if ${ARCH} == "sparc64"
IGNORE=		bsd-user targets not tested on sparc64
.endif
.endif
.if empty(PORT_OPTIONS:MBSD_USER) || ${ARCH} != "amd64"
PLIST_SUB+=	BSD_USER64="@comment "
.else
PLIST_SUB+=	BSD_USER64=""
.endif

.if ${PORT_OPTIONS:MX86_TARGETS}
PLIST_SUB+=	NONX86="@comment "
.else
PLIST_SUB+=	NONX86=""
.endif

.if ${PORT_OPTIONS:MGNS3}
EXTRA_PATCHES+=	${FILESDIR}/hw_e1000_c.patch
.endif

WITHOUT_CPU_CFLAGS=yes	#to avoid problems with register allocation
CFLAGS:=	${CFLAGS:C/-fno-tree-vrp//}
CONFIGURE_ARGS+=	--prefix=${PREFIX} --cc=${CC} --enable-docs \
	--disable-linux-user --disable-linux-aio \
	--disable-kvm --disable-xen \
	--smbd=${LOCALBASE}/sbin/smbd \
	--enable-debug \
	--enable-debug-info \
	--extra-cflags=-I${WRKSRC}\ -I${LOCALBASE}/include\ -DPREFIX=\\\"${PREFIX}\\\"

.if empty(PORT_OPTIONS:MX11)
CONFIGURE_ARGS+=	--disable-sdl
.else
CONFIGURE_ARGS+=	--enable-sdl
USE_SDL=	sdl
.endif

.if empty(PORT_OPTIONS:MGTK2)
CONFIGURE_ARGS+=	--disable-gtk
PLIST_SUB+=	GTK2="@comment "
.else
USE_GNOME+=	gtk20 vte
USES+=		gettext
PLIST_SUB+=	GTK2=""
.endif

.if empty(PORT_OPTIONS:MGNUTLS)
CONFIGURE_ARGS+=	--disable-vnc-tls
.else
LIB_DEPENDS+=	gnutls:${PORTSDIR}/security/gnutls
.endif

.if empty(PORT_OPTIONS:MSASL)
CONFIGURE_ARGS+=	--disable-vnc-sasl
.else
LIB_DEPENDS+=	sasl2:${PORTSDIR}/security/cyrus-sasl2
.endif

.if empty(PORT_OPTIONS:MJPEG)
CONFIGURE_ARGS+=	--disable-vnc-jpeg
.else
LIB_DEPENDS+=	jpeg:${PORTSDIR}/graphics/jpeg
.endif

.if empty(PORT_OPTIONS:MPNG)
CONFIGURE_ARGS+=	--disable-vnc-png
.else
LIB_DEPENDS+=	png15:${PORTSDIR}/graphics/png
.endif

.if empty(PORT_OPTIONS:MCURL)
CONFIGURE_ARGS+=	--disable-curl
.else
LIB_DEPENDS+=	curl:${PORTSDIR}/ftp/curl
.endif

.if empty(PORT_OPTIONS:MOPENGL)
CONFIGURE_ARGS+=	--disable-glx
.else
USE_GL=		yes
.endif

.if empty(PORT_OPTIONS:MUSBREDIR)
CONFIGURE_ARGS+=	--disable-usb-redir
.else
BUILD_DEPENDS+=	usbredir>=0.6:${PORTSDIR}/net/usbredir
RUN_DEPENDS+=	usbredir>=0.6:${PORTSDIR}/net/usbredir
.endif

.if ${PORT_OPTIONS:MPCAP}
CONFIGURE_ARGS+=	--enable-pcap
.endif

.if ${PORT_OPTIONS:MSTATIC_LINK}
.if ${PORT_OPTIONS:MGTK2} || ${PORT_OPTIONS:MX11}
IGNORE=		X11 ui cannot be built static
.endif
CONFIGURE_ARGS+=	--static
.endif

.if ${PORT_OPTIONS:MSAMBA}
RUN_DEPENDS+=	${LOCALBASE}/sbin/smbd:${PORTSDIR}/net/samba36
.endif

.if ${PORT_OPTIONS:MSEABIOS_GIT}
RUN_DEPENDS+=	seabios-devel>=1.6.3.1:${PORTSDIR}/emulators/seabios-devel
.endif

.if defined(NOPORTDOCS)
MAKE_ARGS+=	NOPORTDOCS=1
.else
BUILD_DEPENDS+=	texi2html:${PORTSDIR}/textproc/texi2html
.endif

.if !defined(STRIP) || ${STRIP} == ""
CONFIGURE_ARGS+=--disable-strip
.endif

.if ${ARCH} == "amd64"
MAKE_ARGS+=	ARCH=x86_64
.endif

.if ${ARCH} == "powerpc"
MAKE_ARGS+=	ARCH=ppc
.endif

.if ${ARCH} == "sparc64"
CONFIGURE_ARGS+= --sparc_cpu=v9
.endif

.if ${OSVERSION} < 900033
BUILD_DEPENDS+=	${LOCALBASE}/bin/as:${PORTSDIR}/devel/binutils
CONFIGURE_ENV+=	LD=${LOCALBASE}/bin/ld
CONFIGURE_ENV+=	COMPILER_PATH=${LOCALBASE}/bin
MAKE_ENV+=	COMPILER_PATH=${LOCALBASE}/bin
.endif

CONFIGURE_ARGS+= --python=${PYTHON_CMD}

# -lprocstat actually only _needs_ -lelf after r249666 or r250870 (MFC)
# but it shouldn't matter much
post-patch:
.if ${OSVERSION} < 900000
	@${REINPLACE_CMD} -e '/LIBS/s|-lprocstat||' ${WRKSRC}/configure
.else
	@${REINPLACE_CMD} -e '/LIBS/s|-lprocstat|-lprocstat -lelf|' \
		${WRKSRC}/configure
.endif
	@${REINPLACE_CMD} -e '/libs_qga=/s|glib_libs|glib_libs -lintl|' ${WRKSRC}/configure
.if ${PORT_OPTIONS:MPCAP}
	@cd ${WRKSRC} && ${PATCH} --quiet < ${FILESDIR}/pcap-patch
.endif
.if empty(PORT_OPTIONS:MCDROM_DMA)
	@cd ${WRKSRC} && ${PATCH} --quiet < ${FILESDIR}/cdrom-dma-patch
.endif
	@${REINPLACE_CMD} -E \
		-e "/^by Tibor .TS. S/s|Sch.*z.$$|Schuetz.|" \
		${WRKSRC}/qemu-doc.texi
	@${REINPLACE_CMD} -E \
		-e "s|^(CFLAGS=).*|\1${CFLAGS} -fno-strict-aliasing|" \
		-e "s|^(LDFLAGS=).*|\1${LDFLAGS}|" \
		${WRKSRC}/Makefile.target
	@${REINPLACE_CMD} -E \
		-e "s|^(CFLAGS=).*|\1${CFLAGS} -fno-strict-aliasing -I.|" \
		-e "s|^(LDFLAGS=).*|\1${LDFLAGS}|" \
		${WRKSRC}/Makefile
	@${REINPLACE_CMD} -E \
		-e "1s|^(#! )/usr/bin/perl|\1${PERL}|" \
		${WRKSRC}/scripts/texi2pod.pl

.if ${OSVERSION} >= 800091
# XXX need to disable usb host code on head while it's not ported to the
# new usb stack yet
post-configure:
	@${REINPLACE_CMD} -E \
		-e "s|^(HOST_USB=)bsd|\1stub|" \
		${WRKSRC}/config-host.mak
.endif

post-install:
.if ${PORT_OPTIONS:MDOCS}
	@(cd ${WRKSRC} && ${COPYTREE_SHARE} docs ${DOCSDIR}/)
.endif
	@${INSTALL_SCRIPT} ${FILESDIR}/qemu-ifup.sample ${PREFIX}/etc
	@${INSTALL_SCRIPT} ${FILESDIR}/qemu-ifdown.sample ${PREFIX}/etc
	@if [ ! -f ${PREFIX}/etc/qemu-ifup ]; then \
	    ${CP} -p ${PREFIX}/etc/qemu-ifup.sample ${PREFIX}/etc/qemu-ifup ; \
	fi
	@if [ ! -f ${PREFIX}/etc/qemu-ifdown ]; then \
	    ${CP} -p ${PREFIX}/etc/qemu-ifdown.sample ${PREFIX}/etc/qemu-ifdown ; \
	fi
	@${CAT} ${PKGMESSAGE}

.include <bsd.port.mk>
