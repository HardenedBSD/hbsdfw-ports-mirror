# Created by: Marc G. Fournier <scrappy@FreeBSD.org>
# $FreeBSD$

DISTVERSION?=	9.0.16
PORTREVISION=	0
PKGNAMESUFFIX?=	${DISTVERSION:R:S/.//}${COMPONENT}

MAINTAINER?=	pgsql@FreeBSD.org

ICU_PATCHFILE?=	pg-9015-icu-2014-02-10.diff.gz
BUILD_DIRS?=	src/timezone src/backend src/backend/utils/mb/conversion_procs \
		src/backend/snowball src/backend/replication/libpqwalreceiver \
		src/bin/initdb src/bin/pg_ctl \
		src/bin/pg_controldata src/bin/pg_resetxlog src/pl
INSTALL_DIRS?=	${BUILD_DIRS}
COMPONENT?=	-server

.if defined(CLIENT_ONLY)
MAN1=		# no MAN1 for 9.0 only

MAN3=		# no MAN3 for 9.0 only

MAN7=		CREATE_CONSTRAINT_TRIGGER.7
.endif

NO_STAGE=	yes
.include "${.CURDIR}/../postgresql91-server/Makefile"
