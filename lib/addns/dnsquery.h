/*
 *  Unix SMB/CIFS implementation.
 *  Internal DNS query structures
 *  Copyright (C) Gerald Carter                2006.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _ADS_DNS_H
#define _ADS_DNS_H

#include "libcli/dns/dns.h"

/* The following definitions come from libads/dns.c  */

NTSTATUS ads_dns_lookup_srv(TALLOC_CTX *ctx,
				const char *name,
				struct dns_rr_srv **dclist,
				int *numdcs);
NTSTATUS ads_dns_lookup_ns(TALLOC_CTX *ctx,
				const char *dnsdomain,
				struct dns_rr_ns **nslist,
				int *numns);
NTSTATUS ads_dns_query_dcs(TALLOC_CTX *ctx,
			   const char *realm,
			   const char *sitename,
			   struct dns_rr_srv **dclist,
			   int *numdcs );
NTSTATUS ads_dns_query_gcs(TALLOC_CTX *ctx,
			   const char *realm,
			   const char *sitename,
			   struct dns_rr_srv **dclist,
			   int *numdcs );
NTSTATUS ads_dns_query_kdcs(TALLOC_CTX *ctx,
			    const char *dns_forest_name,
			    const char *sitename,
			    struct dns_rr_srv **dclist,
			    int *numdcs );
NTSTATUS ads_dns_query_pdc(TALLOC_CTX *ctx,
			   const char *dns_domain_name,
			   struct dns_rr_srv **dclist,
			   int *numdcs );
NTSTATUS ads_dns_query_dcs_guid(TALLOC_CTX *ctx,
				const char *dns_forest_name,
				const char *domain_guid,
				struct dns_rr_srv **dclist,
				int *numdcs );
#endif	/* _ADS_DNS_H */
