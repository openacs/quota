ad_library {
    TCL library for the quota system

        @author Paco Soler (fransola@uv.es)
    @author Agustin Lopez (Agustin.Lopez@uv.es)
    @creation-date 15 December 2005
}
 
 
namespace eval quota {

########################
# COMMUNTY_QUOTA FUNCTIONS  #
#               FOR OACS 5.1                            #
#######################


##### PARAMETERS
# Get default value of a parámeter
ad_proc -public get_parameter {
        {-param ""}
} {
    Returns the parameter default value with param name
} {  
   return [db_string sql "select default_value from apm_parameters where parameter_name = :param"]
}

# Get default value of a parámeter
ad_proc -public get_parameter_id {
        {-param ""}
} {
    Returns the parameter id of the community instance 
} {     
   return [db_string sql "select parameter_id from apm_parameters where parameter_name = :param"]
}


# Get the quota package_id of the community
ad_proc -public get_quota_package_id {
        {-community_id ""}
} {
    Returns the quota package_id of the community
} {  
   
   set ctrl [db_0or1row get_quota_package_id {* sql*}]
   if {$ctrl == 0} {
                # Sin instancia --> a ver que hacemos, usar los valores por defecto???
                return 0
   } else {
            return $pid
   }
   
}

# Get the parameter instance for the community
ad_proc -public get_community_parameter {
        {-community_id ""}
        {-param ""}
} {
    Returns the parameter instance for the community
} {  
   set pid [quota::get_quota_package_id -community_id $community_id]
   if {$pid == 0} {
      return [quota::get_parameter -param $param]   
   } else {
                set param_id [quota::get_parameter_id -param $param]
                db_0or1row get_community_parameter {* SQL *}
                return $value
   }
}

# Update default value of a parameter
ad_proc -public update_parameter {
        {-param ""}
        {-value ""}
} {
    Update the parameter default value
} {  
        db_dml update_parameter { *SQL* } 
}

# Update default value of a parameter
ad_proc -public update_community_parameter {
        {-community_id ""}
        {-param ""}
        {-value ""}
} {
    Update the parameter default value
} {  
        set pid [quota::get_quota_package_id -community_id $community_id]
        set param_id [quota::get_parameter_id -param $param]
        db_dml update_community_parameter { *SQL* } 
}


##############################
# FUNCIONES

# Devuelve lista de los folders_id que contiene un folder dado
ad_proc -public get_child_folders {
        {-folder_id ""}
} {
    Returns a child folder_id list of parent folder_id
} {
   return [db_list get_child_folders get_child_folders]
}


# Devuelve lista de los folders_id que tiene una comunidad en su file-storage
# Se necesita pasar el root folder_id de la comunidad!!!
ad_proc -public get_filestorage_folders {
        {-folder_id ""}
} {
    Returns a folder_id list of community_filestorage
} {
        # lista para lamacenar los directorios
        
        set l_folders [list $folder_id]
        # Lista auxiliar para almacenar los directorios que nos quedan por tratar
        set l_aux [quota::get_child_folders -folder_id $folder_id]
        set l_folders [concat $l_folders $l_aux]
        # Contador de vueltas
        set cont [llength $l_aux]

        while { $cont > 0 } { 
                set c 0
                set l_aux2 []  
                foreach obj $l_aux {
                        set l_aux1 [quota::get_child_folders -folder_id $obj]                   
                        set l_folders [concat $l_folders $l_aux1]
                        set l_aux2 [concat $l_aux2 $l_aux1]
                        set c [expr $c + [llength $l_aux1]]
                }
                if { $c > 0 } {
                        set l_aux $l_aux2
                } else {                
                        set cont 0
                } 
        }       
   return $l_folders
}

# Devuelve lista de los items_id que contiene el folder de tipo type_s
ad_proc -public get_folder_files {
        {-folder_id ""}
        {-type_s ""}
} {
    Returns folders files
} {
   return [db_list get_folder_files get_folder_files]
}

# Devuelve lista de los items_id de tipo type_s que tiene una comunidad en su file-storage
# Se necesita pasar la lista de directorios de la comunidad!!!
ad_proc -public get_filestorage_files {
        {-folders_list ""}
} {
    Returns a files of the community folders
} {
        set files_list [list]   
        foreach obj $folders_list {
                set files_list [concat $files_list [quota::get_folder_files -folder_id $obj -type_s "file_storage_object"]]
        }       
   return $files_list
}

#Devuelve lista de revisiones de un item_id
ad_proc -public get_revision_files {
        {-item_id ""}
        } {
    Returns revision files
} {
   return [db_list get_revision_files get_revision_files]
}


# Devuelve lista de revision_id de la lista de item_id 
ad_proc -public get_filestorage_revisions {
        {-files_list ""}
} {
    Returns a files of the community folders
} {
        set revision_list [list]        
        foreach obj $files_list {
                set revision_list [concat $revision_list [quota::get_revision_files -item_id $obj ]]
        }       
   return $revision_list
}

# Devuelve el espacio que ocupan los ficheros
ad_proc -public get_filesize {
        {-revision_id ""}
        {-units ""}
} {
    Returns the filesize of revision_id
} {
        set fsize 0
        if {[db_0or1row get_filesize {}] eq 0} {
                return $fsize
        } else {
            switch -exact -- $units { 
                "b"  {set fsize $size} 
                "kb" {set fsize [expr $size / 1024]} 
                "mb" {set fsize [expr $size / 1024 / 1024]} 
                default {set fsize [expr $size / 1024]} 
                }
                return $fsize
        }
}

# Devuelve el espacio que ocupan los ficheros
ad_proc -public get_filestorage_used_quota {
        {-revision_list ""}
} {
    Returns de quota used by list revisions. P.e. Community files 
} {
        set quota 0
        foreach obj $revision_list {
                set quota [expr $quota + [quota::get_filesize -revision_id $obj -units "kb"]]
        }       
   return $quota
}

# Devuelve lista de revision_id de la lista de item_id 
ad_proc -public get_filestorage_user_revisions {
        {-folder_list ""}
        {-user_id ""}
} {
    Returns a revisions files of the community folders
} {
        set revision_list [list]        
        foreach obj $folder_list {
                set revision_list [concat $revision_list [quota::get_folder_user_revisions -folder_id $obj -user_id $user_id]]
        }       
   return $revision_list
}

# devuelve la lista de revision_id de un usuario en el directorio
ad_proc -public get_folder_user_revisions {
        {-folder_id ""}
        {-user_id ""}
} {
    Returns folders user_revisions
} {
   return [db_list get_folder_user_revisions get_folder_user_revisions]
}

# Devuelve las comunidades a las que pertenece un usuario
ad_proc -public get_user_communities {
        {-user_id ""}   
} {
    Devuelve las comunidades a las que pertenece un usuario
} {
        return [db_list get_user_communities {}]
}

###############################
# GLOBAL
# Get user global files used
ad_proc -public get_used_quota_and_files {
        {-user_id ""}
} {
    Get user global quota and files used
} { 
        set quota 0
        set files 0
        set l_revisions [db_list get_user_qf {* SQL *}]
        foreach r_size $l_revisions {
                set files [expr $files + 1]
                set quota [expr $quota  + $r_size/1024] 
        }
        set l_gobal_quota [list $quota $files]
        return $l_gobal_quota
}


# PERSONAL
# Get user personal quota used
ad_proc -public get_used_pquota_and_pfiles {
        {-user_id ""}
} {
    Get user personal quota and files used
} { 
        set root_folder [dotlrn_fs::get_user_root_folder -user_id $user_id]
        set l_folders [quota::get_filestorage_folders -folder_id $root_folder]
        set l_files [quota::get_filestorage_files -folders_list $l_folders]
        set l_revisions [quota::get_filestorage_revisions -files_list $l_files]
        set quota [quota::get_filestorage_used_quota -revision_list $l_revisions]
        return [list $quota [llength $l_revisions]]
}

# COMUNITY
# Get community quota and files used
ad_proc -public get_used_cquota_and_cfiles {
        {-community_id ""}
} {
    Returns de quota used by a community with community_id 
} {
        if {$community_id eq ""} {
                set community_id [dotlrn_community::get_community_id]
        }
        set root_fid [dotlrn_fs::get_community_root_folder -community_id $community_id]
        set l_c_folders [quota::get_filestorage_folders -folder_id $root_fid]
        set l_files [quota::get_filestorage_files -folders_list $l_c_folders]
        set l_rev [quota::get_filestorage_revisions -files_list $l_files]
        set quota [quota::get_filestorage_used_quota -revision_list $l_rev]
        return [list $quota [llength $l_rev]]
}

# USER _ COMMUNITY
# Get user-community quota and files used
ad_proc -public get_used_ucquota_and_ucfiles {
        {-community_id ""}
        {-user_id ""}   
} {
    Returns de quota used by a community with community_id 
} {
        if {$community_id eq ""} {
                set community_id [dotlrn_community::get_community_id]
        }
        set root_fid [dotlrn_fs::get_community_root_folder -community_id $community_id]
        set l_c_folders [quota::get_filestorage_folders -folder_id $root_fid]
        set l_rev [quota::get_filestorage_user_revisions -folder_list $l_c_folders -user_id $user_id]
        set quota [quota::get_filestorage_used_quota -revision_list $l_rev]
        return [list $quota [llength $l_rev]]
}

######################################
# CHECKPOINT
ad_proc -public check_quota {
        {-user_id ""}
        {-community_id ""}
        {-filesize 0}
} {
        Allow upload files
} {  

# Init variables
set used_quota 0
set used_files 0
set used_pquota 0
set used_pfiles 0       
set used_c_quota 0
set used_c_files 0

# Get if user is root and if the control quota is enabled
set is_root [acs_user::site_wide_admin_p  -user_id $user_id]
set is_quota_enabled [quota::get_parameter -param "QuotaEnabled"]
# If the user is root or the control quota is disabled --> We allow the upload without check
if {$is_root || !($is_quota_enabled)} { 
        return 1 
} else {

# Check if the user has a personal quota and get the parameters
  set has_quota [db_0or1row get_quota {* SQL *}]  
  if {$has_quota} {
        set uc_enabled $usercomm_actv
        set max_pquota $personal_quota 
        set max_pfiles $personal_files
        set max_quota $global_quota
        set max_files $global_files     
  } else {
        set uc_enabled 1
        set max_pquota [quota::get_parameter -param "MaxQuotaByUserFolder"]
        set max_pfiles [quota::get_parameter -param "MaxFilesByUserFolder"]
        set max_quota [quota::get_parameter -param "MaxQuotaByUser"]
    set max_files [quota::get_parameter -param "MaxFilesByUser"]
        } 

        if {$uc_enabled} {
                set used_pquota_and_pfiles [quota::get_used_pquota_and_pfiles -user_id $user_id]
                set used_pquota [expr [lindex $used_pquota_and_pfiles 0] + $filesize]
                set used_pfiles [expr [lindex $used_pquota_and_pfiles 1] + 1]
        }
# Check if we are in a community or in an user_folder
  if {[string length $community_id] == 0}  {
        # CHECKING      
                
    if {($used_pquota < $max_pquota) && ($used_pfiles < $max_pfiles)} {
                return 1 
        } else {
                ns_log Notice "QUOTA >>> USER ($user_id) CAN'T UPLOAD TO ITS USER_FOLDER --> QUOTA ($used_pquota/$max_pquota) -- FILES ($used_pfiles/$max_pfiles)"
                return 0 
        } 
        
  } else { 
        # COMMUNITY CASE
        
        if {$uc_enabled} {
                set used_quota_and_files [quota::get_used_quota_and_files -user_id $user_id]
                set used_quota [expr [lindex $used_quota_and_files 0] + $filesize - $used_pquota]
                set used_files [expr [lindex $used_quota_and_files 1] + 1 - $used_pfiles]       
        } else {
        }
        
        # Check if there are a quota instance for the community
    set has_instances [quota::get_quota_package_id -community_id $community_id]
        if {$has_instances == 0} {
          set quota_c_enabled 1
      set max_c_quota [quota::get_parameter -param "MaxQuotaByCommunity"]
      set max_c_files [quota::get_parameter -param "MaxFilesByCommunity"]         
        } else {
          set quota_c_enabled [quota::get_community_parameter -param "QuotaEnabled" -community_id $community_id]        
      set max_c_quota [quota::get_community_parameter -param "MaxQuotaByCommunity" -community_id $community_id]
      set max_c_files [quota::get_community_parameter -param "MaxFilesByCommunity" -community_id $community_id]
    }
        # Check if the community has the community_quota enabled
        if {$quota_c_enabled} {
                set used_cquota_and_cfiles [quota::get_used_cquota_and_cfiles -community_id $community_id]
                set used_c_quota [expr [lindex $used_cquota_and_cfiles 0] + $filesize]
                set used_c_files [expr [lindex $used_cquota_and_cfiles 1] + 1]
        } {
        }  
        
    if {($used_quota <= $max_quota) && ($used_files <= $max_files) && \
                ($used_c_quota <= $max_c_quota) && ($used_c_files <= $max_c_files)} {
                return 1 
        } else {                
                ns_log Notice "QUOTA >>> USER ($user_id) CAN'T UPLOAD TO COMMUNITY ($community_id) --> QUOTA GLOBAL ($used_quota/$max_quota) -- FILES ($used_files/$max_files) -- COMMUNITY QUOTA ($used_c_quota/$max_c_quota) -- FILES ($used_c_files/$max_c_files)"
                return 0 
        } 
  }
}
# end no root and enabled_q
}
# end function
}

