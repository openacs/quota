# Author: Paco Soler (fransola@uv.es)

ad_page_contract {
}  -query {
  {mode:optional ""}
  {comm_name:optional ""}  
} -properties {
}

# Control site_wide_admin
if {![acs_user::site_wide_admin_p  -user_id [ad_conn user_id]]} {
        ad_returnredirect "[dotlrn::get_url]"
}

# If username & name are empty redirect to manage_site_quota
if { [string length $comm_name] == 0 } {        
        ad_returnredirect "manage_site_quota"
}


db_multirow comm select_communities {* SQL *}
