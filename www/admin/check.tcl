######################################
# CHECKPOINT
ad_proc -public check_quota {
        {-user_id ""}
        {-community_id ""}
        {-filesize 0}
} {
        Allow upload files
} {  

# Inicializamos variables
set used_quota 0
set used_files 0
set used_pquota 0
set used_pfiles 0       
set used_c_quota 0
set used_c_files 0
set used_uc_quota 0
set used_uc_files 0                     

# Comprobamos si el usuario es ROOT
set is_root [acs_user::site_wide_admin_p  -user_id $user_id]
# Comprobamos si el control de quota esta activado o no
set is_quota_enabled [quota::get_parameter -param "QuotaEnabled"]

# Si el usuario es root o no hay quota habilitada --> dejamos hacer
if {$is_root || !($is_quota_enabled)} {
        # OK -- upload allowed  
        return 1 
} else {
# Obtenemos la comunidad en la que estamos
  #set community_id [dotlrn_community::get_community_id]
# Si estamos en el user_folder
  if {[string length $community_id] == 0}  {
     set community_id  0
  } else { 
  
  # Si estamos en una comunidad
# Obtener el rol del usuario
        if {[dotlrn::user_can_admin_community_p -user_id $user_id -community_id $community_id] == 1} {
        set user_role "ADMIN"
        } else {
            set user_role "STUDENT"
        }
  }
# Comprobamos si el usuario tiene entrada en la user_quota
# y seleccionamos sus valores máximos permitidos
  # set ref_user $user_id
  set has_quota [db_0or1row get_quota {* SQL *}]  
  if {$has_quota} {
    set max_quota $global_quota
    set max_files $global_files
        set max_pquota $personal_quota 
        set max_pfiles $personal_files
        set uc_enabled $usercomm_actv
  } else {
    set max_quota [quota::get_parameter -param "MaxQuotaByUser"]
    set max_files [quota::get_parameter -param "MaxFilesByUser"]
        set max_pquota [quota::get_parameter -param "MaxQuotaByUserFolder"]
        set max_pfiles [quota::get_parameter -param "MaxFilesByUserFolder"]
        set uc_enabled 1
  }

  # Obtenemos quota global usada por del usuario
  set used_quota_and_files [quota::get_used_quota_and_files -user_id $user_id]
  set used_quota [expr [lindex $used_quota_and_files 0] + $filesize]
  set used_files [expr [lindex $used_quota_and_files 1] + 1]

# CASO USER FOLDER
  if {$community_id == 0} {
  set used_pquota_and_pfiles [quota::get_used_pquota_and_pfiles -user_id $user_id]
  set used_pquota [expr [lindex $used_pquota_and_pfiles 0] + $filesize]
  set used_pfiles [expr [lindex $used_pquota_and_pfiles 1] + 1]
                
        # COMPROVACIÓ
        
        
    if {($used_quota < $max_quota) && ($used_files < $max_files) && \
                ($used_pquota < $max_pquota) && ($used_pfiles < $max_pfiles)} {
                # OK    
                return 1 
        } else {
                # No permitimos la operación --> Mensaje de error
                return 0 
        } 
        # fi comprovació
  } else { 
  # CASO COMMUNITY
# Comprobar si la communidad tiene los parametros instanciados
    set has_instances [quota::get_quota_package_id -community_id $community_id]
# Si no hay instancias cogemos parámetros globales      
        if {$has_instances == 0} {
          set quota_c_enabled 1
      set max_c_quota [quota::get_parameter -param "MaxQuotaByCommunity"]
      set max_c_files [quota::get_parameter -param "MaxFilesByCommunity"]
          set max_uc_quota [quota::get_parameter -param "MaxQuotaByUserComm"]
          set max_uc_files [quota::get_parameter -param "MaxFilesByUserComm"]
# Si hay instancias seleccionamos los parámetros de la comunidad        
        } else {
          set quota_c_enabled [quota::get_community_parameter -param "QuotaEnabled" -community_id $community_id]        
      set max_c_quota [quota::get_community_parameter -param "MaxQuotaByCommunity" -community_id $community_id]
      set max_c_files [quota::get_community_parameter -param "MaxFilesByCommunity" -community_id $community_id]
          set max_uc_quota [quota::get_community_parameter -param "MaxQuotaByUserComm" -community_id $community_id]
          set max_uc_files [quota::get_community_parameter -param "MaxFilesByUserComm" -community_id $community_id]
    }
        
        if {$quota_c_enabled} {
                set used_cquota_and_cfiles [quota::get_used_cquota_and_cfiles -community_id $community_id]
                set used_c_quota [expr [lindex $used_cquota_and_cfiles 0] + $filesize]
                set used_c_files [expr [lindex $used_cquota_and_cfiles 1] + 1]
        }
        
        if {($user_role == "STUDENT") && ($uc_enabled == 1)} {
                set used_ucquota_and_ucfiles [quota::get_used_ucquota_and_ucfiles -community_id $community_id -user_id $user_id]
                set used_uc_quota [expr [lindex $used_ucquota_and_ucfiles 0] + $filesize]
                set used_uc_files [expr [lindex $used_ucquota_and_ucfiles 1] + 1]
        }

        # COMPROVACIÓ
    if {($used_quota <= $max_quota) && ($used_files <= $max_files) && \
                ($used_c_quota <= $max_c_quota) && ($used_c_files <= $max_c_files) && \
                ($used_uc_quota <= $max_uc_quota) && ($used_uc_files <= $max_uc_files)} {
                # OK
                return 1 
        } else {
                # No permitimos la operación -->  Mensaje de error
                return 0 
        } 
        # fi comprovació
 } 
 # fin else
 } 
 #fin  no root y enabled
}
# fin check
