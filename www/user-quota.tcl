ad_page_contract {
} -query {      
        user_id:integer,notnull
} -properties {
   usercomm:multirow
} -validate {

}

# prevent this page from being called when not in a community
# (i.e. the main dotlrn instance
#if {[empty_string_p [dotlrn_community::get_community_id]]} {
#    ad_returnredirect "[dotlrn::get_url]"
#}


#template::multirow create usercomm name q_total f_total q_used f_used q_rest f_rest is_admin
template::multirow create usercomm name q_used f_used


set context [list [list "one-community-admin" [_ dotlrn.Admin]] [_ dotlrn.Manage_Members]]
set community_id [dotlrn_community::get_community_id]

# Get user information
db_1row get_user_info "select username, first_names, last_name  from acs_users_all where user_id = :user_id"
 append name $last_name ", " $first_names

set site_admin [acs_user::site_wide_admin_p  -user_id $user_id]



###############################################
# Obtenemos quota global y del directorio personal máxima permitida para el usuario
set has_quota [db_0or1row get_user_quota "select * from user_quota where ref_user = :user_id"]  
  if {$has_quota} {
    set gq_total $global_quota
    set gf_total $global_files
        set pq_total $personal_quota 
        set pf_total $personal_files    
  } else {
    set gq_total [quota::get_parameter -param "MaxQuotaByUser"]
    set gf_total [quota::get_parameter -param "MaxFilesByUser"]
        set pq_total [quota::get_parameter -param "MaxQuotaByUserFolder"]
        set pf_total [quota::get_parameter -param "MaxFilesByUserFolder"]       
  }




####################################
# Obtenemos quota del directorio personal usada por del usuario
set used_pquota_and_pfiles [quota::get_used_pquota_and_pfiles -user_id $user_id]
set pq_used [lindex $used_pquota_and_pfiles 0]
set pf_used [lindex $used_pquota_and_pfiles 1]

# Quota directorio personal disponible
set pq_rest [expr $pq_total - $pq_used]
set pf_rest [expr $pf_total - $pf_used]

if {$pq_rest < 0} {
        set pq_rest 0
}
if {$pf_rest < 0} {
        set pf_rest 0
}


##############################################
# USER_COMMUNITY QUOTA
set gq_used 0
set gf_used 0
# Obtenim les comunitats de l'usuari
 set l_comm [quota::get_user_communities -user_id $user_id]
 
 foreach com $l_comm {
        # Comprobamos is es administrador o profe
        set admin [dotlrn::user_can_admin_community_p -user_id $user_id -community_id $com]
        # Comprobar si la communidad tiene los parametros instanciados
    #set has_instances [quota::get_quota_package_id -community_id $com]
        # Si no hay instancias cogemos parámetros globales      
        #if {$has_instances == 0} {
        #  set ucq_total [quota::get_parameter -param "MaxQuotaByUserComm"]
        #  set ucf_total [quota::get_parameter -param "MaxFilesByUserComm"]
        # Si hay instancias seleccionamos los parámetros de la comunidad        
        #} else {      
        #  set ucq_total [quota::get_community_parameter -param "MaxQuotaByUserComm" -community_id $com]
        #  set ucf_total [quota::get_community_parameter -param "MaxFilesByUserComm" -community_id $com]
    #}
        set l_quota [quota::get_used_ucquota_and_ucfiles -community_id $com -user_id $user_id]
        set names [dotlrn_community::get_community_name $com]
        set qu [lindex $l_quota 0]
        set fu [lindex $l_quota 1]
        #set qr [expr $ucq_total - $qu]
        #set fr [expr $ucf_total - $fu]
        #template::multirow append usercomm $names $ucq_total $ucf_total $qu $fu $qr $fr $admin
        template::multirow append usercomm $names $qu $fu
        set gq_used [expr $gq_used + $qu]
        set gf_used [expr $gf_used + $fu]

 }
 
 
 # Obtenemos quota global usada por del usuario
# set used_quota_and_files [quota::get_used_quota_and_files -user_id $user_id]
# Aquesta funció ja no serveix perque hem canviat la política de quotes.
# Quota disponible
set gq_rest [expr $gq_total - $gq_used]
set gf_rest [expr $gf_total - $gf_used]

if {$gq_rest < 0} {
        set gq_rest 0
}
if {$gf_rest < 0} {
        set gf_rest 0
}


ad_return_template
