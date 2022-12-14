# Created by: nectar@FreeBSD.org
# $FreeBSD$

PORTNAME=	wxPython
PORTVERSION=	2.6.3.3
PORTREVISION?=	7
CATEGORIES=	x11-toolkits python
MASTER_SITES=	SF/wxpython/wxPython/${PORTVERSION}
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}
DISTNAME=	${PORTNAME}-src-${PORTVERSION}

MAINTAINER=	neal@nelson.name
COMMENT=	Python bindings for the wxWidgets/GTK GUI toolkit

RUN_DEPENDS=	${PYTHON_SITELIBDIR}/OpenGL/__init__.py:${PORTSDIR}/graphics/py-opengl

WRKSRC=		${WRKDIR}/${DISTNAME}/wxPython

USE_BZIP2=	yes
USES=		gmake pkgconfig
USE_PYTHON=	yes
USE_PYDISTUTILS=yes
PYDISTUTILS_BUILDARGS=	\
			WX_CONFIG="${WX_CONFIG}" \
			WXPORT="${WXPORT}"
PYDISTUTILS_CONFIGUREARGS=	${PYDISTUTILS_BUILDARGS}
USE_WX=		2.6
WX_COMPS=	contrib
WX_PREMK=	yes
DEMO_DIR=	${PYTHONPREFIX_SITELIBDIR}/wxPython/demo
WXPORT=		gtk2
NO_LATEST_LINK=	yes

.if defined(WITH_COMMON_ONLY)
PYDISTUTILS_NOEGGINFO=	yes
.else
.if defined(WITH_WXPYTHON_UNICODE)
WX_PYTHON_DIR=	wx-${USE_WX}-${WXPORT}-unicode
.else
WX_PYTHON_DIR=	wx-${USE_WX}-${WXPORT}-ansi
.endif
PYDISTUTILS_EGGINFO=	${WX_PYTHON_DIR}/wxPython-${PORTVERSION}-${PYTHON_VERSION:S/thon//}.egg-info \
			wxaddons-${PORTVERSION}-${PYTHON_VERSION:S/thon//}.egg-info
.endif

NO_STAGE=	yes
post-extract:
# only keep the scripts we need
	@${RM} ${WRKSRC}/scripts/*.py

post-patch:
# fix python location
	@${REINPLACE_CMD} -E \
		-e 's|/usr/bin/env python|${PYTHON_CMD}|' \
		${WRKSRC}/scripts/*
	@${RM} ${WRKSRC}/scripts/*.bak

pre-configure:
# uphold PREFIX
	@${REINPLACE_CMD} -E \
		-e "s|([[:space:]]*WXPREFIX[[:space:]]*=).*$$|\1'${PREFIX}'|" \
		${CONFIGURE_WRKSRC}/config.py

post-build:
# Shared amongst ansi/unicode installations
.if defined(WITH_COMMON_ONLY)
. for dir in demo wxversion
	@${PYTHON_CMD} ${PYTHON_LIBDIR}/compileall.py ${WRKSRC}/${dir}
	@${PYTHON_CMD} -O ${PYTHON_LIBDIR}/compileall.py ${WRKSRC}/${dir}
. endfor
.endif
.if !defined(DEBUG_FLAGS)
	@${FIND} ${WRKSRC} -name "*.so" | ${XARGS} ${STRIP_CMD}
.endif

.include <bsd.port.pre.mk>

# wx version
.if exists(${WX_CONFIG})
WX_VERSION!=	${WX_CONFIG} --release
PLIST_SUB+=	WX_VERSION=${WX_VERSION}
.endif

.if defined(WITH_COMMON_ONLY)
## These are not shared amongst installations
PKGNAMESUFFIX=	-common

PYDISTUTILS_BUILDARGS+=	\
			INSTALL_MULTIVERSION=1
.else
## These are shared
RUN_DEPENDS+=	${PYTHON_SITELIBDIR}/wxversion.py:${PORTSDIR}/x11-toolkits/py-wxPython26-common

PYDISTUTILS_BUILDARGS+=	\
			NO_HEADERS=1 \
			NO_SCRIPTS=1 \
			INSTALL_MULTIVERSION=0

. if defined(WITH_WXPYTHON_UNICODE)
WX_UNICODE=	yes

PKGNAMESUFFIX=	-unicode

PYDISTUTILS_BUILDARGS+=	\
			UNICODE=1
. endif # defined(WITH_WXPYTHON_UNICODE)

# plist substitutions and library dirs
PLIST_SUB+=	WX_PYTHON_DIR=${WX_PYTHON_DIR}

.endif # !defined(WITH_COMMON_ONLY)

# install arguments
PYDISTUTILS_INSTALLARGS:=	${PYDISTUTILS_INSTALLARGS} ${PYDISTUTILS_BUILDARGS}

## Shared amongst ansi/unicode installations
# XXX - Override do-install since I was not able to tell setup.py to
# do the right thing
.if defined(WITH_COMMON_ONLY)
do-install:
# DEMO
	@${MKDIR} ${DEMO_DIR}
.for glob in *.py *.pyc *.pyo
	@${INSTALL_DATA} ${WRKSRC}/demo/${glob} ${DEMO_DIR}
.endfor
.for dir in bitmaps bmp_source data
	@${MKDIR} ${DEMO_DIR}/${dir}
. for glob in *
	@${INSTALL_DATA} ${WRKSRC}/demo/${dir}/${glob} ${DEMO_DIR}/${dir}
. endfor
.endfor
# header files
	@${MKDIR} ${PREFIX}/include/wx-${WX_VERSION}/wx/wxPython/i_files
.for glob in *.i *.py
	@${INSTALL_DATA} ${WRKSRC}/src/${glob} \
		${PREFIX}/include/wx-${WX_VERSION}/wx/wxPython/i_files
.endfor
	@${INSTALL_DATA} ${WRKSRC}/include/wx/wxPython/*.h \
		${PREFIX}/include/wx-${WX_VERSION}/wx/wxPython
# scripts
	@${INSTALL_SCRIPT} ${WRKSRC}/scripts/* ${PREFIX}/bin
## wxversion
	@${MKDIR} ${PYTHON_SITELIBDIR:C@^${LOCALBASE}@${PREFIX}@}
# wxversion script
	@${INSTALL_DATA} ${WRKSRC}/wxversion/* \
		${PYTHON_SITELIBDIR:C@^${LOCALBASE}@${PREFIX}@}
.endif # defined(WITH_COMMON_ONLY)

post-install:
.if !defined(WITH_COMMON_ONLY)
# fix installation permissions
	${CHMOD} -R a+rX \
		${PYTHON_SITELIBDIR:C@^${LOCALBASE}@${PREFIX}@}/${WX_PYTHON_DIR}
	@${RM} -rf ${PYTHON_SITELIBDIR:C@^${LOCALBASE}@${PREFIX}@}/${WX_PYTHON_DIR}/*egg-info
.endif
##
# wxversion wxPython available list
##
.if !defined(WITH_COMMON_ONLY)
# add ansi/unicode to the available list
	@${ECHO_CMD} ${WX_PYTHON_DIR} >> \
		${PYTHON_SITELIBDIR:C@^${LOCALBASE}@${PREFIX}@}/wx.pth
	@${CHMOD} ${SHAREMODE} \
		${PYTHON_SITELIBDIR:C@^${LOCALBASE}@${PREFIX}@}/wx.pth
.endif

.include <bsd.port.post.mk>
