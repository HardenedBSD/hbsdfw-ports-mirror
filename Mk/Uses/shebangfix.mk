# $FreeBSD$
#
# Replace #! interpreters in scripts by what we actually have.
#
# Standard templates for bash, perl, python,... are included out of
# the box, others can easily be added per port.
#
# MAINTAINER: portmgr@FreeBSD.org
#
# Feature:	shebangfix
# Usage:	USES=shebangfix
#
# To specify that ${WRKSRC}/path1/file and all .pl files in ${WRKSRC}/path2
# should be processed:
#
#   SHEBANG_FILES=	path1/file path2/*.pl
#
# To define a new shebang scheme add the following to the port Makefile:
#
#   SHEBANG_LANG=	lua
#   lua_OLD_CMD=	/usr/bin/lua
#   lua_CMD=	${LOCALBASE}/bin/lua
#
# To override a definition, for example replacing /usr/bin/perl by
# /usr/bin/env perl, add the following:
#
#   perl_CMD=	${SETENV} perl
#

.if !defined(_INCLUDE_USES_SHEBANGFIX_Mk)
_INCLUDE_USES_SHEBANGFIX_MK=	yes

bash_OLD_CMD?=	/bin/bash
bash_CMD?=	${LOCALBASE}/bin/bash
perl_OLD_CMD?=	/usr/bin/perl
perl_CMD?=	${LOCALBASE}/bin/perl
python_OLD_CMD?=	/usr/bin/python
python_CMD?=	${LOCALBASE}/bin/python
ruby_OLD_CMD?=	/usr/bin/ruby
ruby_CMD?=	${LOCALBASE}/bin/ruby
php_OLD_CMD?=	/usr/bin/php
php_CMD?=	${LOCALBASE}/bin/php

SHEBANG_LANG+=	bash perl python ruby php

.for lang in ${SHEBANG_LANG}
.if !defined(${lang}_CMD)
IGNORE+=	missing definition for ${lang}_CMD
.endif
.if !defined(${lang}_OLD_CMD)
IGNORE+=	missing definition for ${lang}_OLD_CMD
.endif
_SHEBANG_REINPLACE_ARGS+=	-e "1s|^\#![[:space:]]*${${lang}_OLD_CMD}|\#!${${lang}_CMD}|"
.endfor

.PHONY: fix-shebang
pre-patch: fix-shebang

fix-shebang:
	@cd ${WRKSRC}; \
		${ECHO_CMD} ${SHEBANG_FILES} | ${XARGS} ${SED} -i '' ${_SHEBANG_REINPLACE_ARGS}

.endif
