# Author: Paco Soler (fransola@uv.es)

ad_page_contract {
}  -query {
  {mode:optional ""}
  {name:optional ""}  
  {username:optional ""}    
} -properties {
}

# Control site_wide_admin
if {![acs_user::site_wide_admin_p  -user_id [ad_conn user_id]]} {
        ad_returnredirect "[dotlrn::get_url]"
}

# If username & name are empty redirect to manage_site_quota
if { ([string length $name] == 0) && ([string length $username] == 0) } {       
        ad_returnredirect "manage_site_quota"
}

# Obtenemos los usuarios
if {$mode eq "username"} {
        db_multirow user select_usernames {* SQL *}
} else {
        db_multirow user select_users {* SQL *}
}
