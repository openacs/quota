# Copyright (C) 2006 University of Valencia
# Author: Paco Soler
# This file is part of dotLRN.    

ad_page_contract {
}  -query {
  {mode:optional ""}
  {cid:optional ""}
  {new_MaxFilesByCommunity:optional ""}
  {new_MaxQuotaByCommunity:optional ""}
  {new_MaxFilesByUserComm:optional ""}
  {new_MaxQuotaByUserComm:optional ""}
} -properties {
}


# Control site_wide_admin
if {![acs_user::site_wide_admin_p  -user_id [ad_conn user_id]]} {
        ad_returnredirect "[dotlrn::get_url]"
}

# Get community_id
#set cid [dotlrn_community::get_community_id]

# Get community datails
db_1row get_community_info {* SQL *} 
set community_url [dotlrn_community::get_community_url $cid]
set referer [ns_conn url]
append referer "?cid=" $cid

# Check if the community has instanced the quota package
set has_instances [quota::get_quota_package_id -community_id $cid]
if {$has_instances > 0} {

# Control Cuota Activation
if {$mode eq "update_cqc"} {
        set QuotaEnabled [quota::get_community_parameter -community_id $cid -param "QuotaEnabled"]      
        if {$QuotaEnabled} {
                quota::update_community_parameter -param "QuotaEnabled" -value 0 -community_id $cid
        } else {
                quota::update_community_parameter -param "QuotaEnabled" -value 1 -community_id $cid
        }
}

# Update Default Parameters Values
if {$mode eq "update_community_parameters"} {
        quota::update_community_parameter -param "MaxFilesByCommunity" \
            -value  $new_MaxFilesByCommunity -community_id $cid
        quota::update_community_parameter -param "MaxQuotaByCommunity" \
            -value $new_MaxQuotaByCommunity -community_id $cid
        quota::update_community_parameter -param "MaxFilesByUserComm" \
            -value $new_MaxFilesByUserComm -community_id $cid
        quota::update_community_parameter -param "MaxQuotaByUserComm" \
            -value $new_MaxQuotaByUserComm -community_id $cid
}


# Get parameter instances values
set MaxFilesByCommunity [quota::get_community_parameter -param "MaxFilesByCommunity" -community_id $cid]
set MaxQuotaByCommunity [quota::get_community_parameter -param "MaxQuotaByCommunity" -community_id $cid]
set MaxFilesByUserComm [quota::get_community_parameter -param "MaxFilesByUserComm" -community_id $cid]
set MaxQuotaByUserComm [quota::get_community_parameter -param "MaxQuotaByUserComm" -community_id $cid]
set QuotaEnabled [quota::get_community_parameter -param "QuotaEnabled" -community_id $cid]

}
