
ad_page_contract {
} -query {      
        {community_id:integer,optional ""}
        
} -properties {
  
} -validate {

}

set context [list [list "one-community-admin" [_ dotlrn.Admin]] [_ dotlrn.Manage_Members]]

# prevent this page from being called when not in a community
# (i.e. the main dotlrn instance
if {[empty_string_p [dotlrn_community::get_community_id]]} {
    ad_returnredirect "[dotlrn::get_url]"
}

set community_name [db_string sql "select pretty_name from dotlrn_communities_all where community_id = $community_id"]

# Community Max Quota
# Comprobar si la communidad tiene los parametros instanciados
    set has_instances [quota::get_quota_package_id -community_id $community_id]
# Si no hay instancias cogemos parámetros globales      
        if {$has_instances == 0} {
      set cq_total [quota::get_parameter -param "MaxQuotaByCommunity"]
      set cf_total [quota::get_parameter -param "MaxFilesByCommunity"]
          #set max_uc_quota [quota::get_parameter -param "MaxQuotaByUserComm"]
          #set max_uc_files [quota::get_parameter -param "MaxFilesByUserComm"]
# Si hay instancias seleccionamos los parámetros de la comunidad        
        } else {
      set cq_total [quota::get_community_parameter -param "MaxQuotaByCommunity" -community_id $community_id]
      set cf_total [quota::get_community_parameter -param "MaxFilesByCommunity" -community_id $community_id]
          #set max_uc_quota [quota::get_community_parameter -param "MaxQuotaByUserComm" -community_id]
          #set max_uc_files [quota::get_community_parameter -param "MaxFilesByUserComm" -community_id]
    }


# Community Used Quota
set used_cquota_and_cfiles [quota::get_used_cquota_and_cfiles -community_id $community_id]
set cq_used [lindex $used_cquota_and_cfiles 0]
set cf_used [lindex $used_cquota_and_cfiles 1]
set cb_used [lindex $used_cquota_and_cfiles 2]



# Quota disponible
set cq_rest [expr $cq_total - $cq_used]
set cf_rest [expr $cf_total - $cf_used]

if {$cq_rest < 0} {
        set cq_rest 0
}
if {$cf_rest < 0} {
        set cf_rest 0
}



ad_return_template
