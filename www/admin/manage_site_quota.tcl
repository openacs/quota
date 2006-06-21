    #
    #  Copyright (C) 2006 University of Valencia
    #
    #  This file is part of dotLRN.
    #
    #  dotLRN is free software; you can redistribute it and/or modify it under the
    #  terms of the GNU General Public License as published by the Free Software
    #  Foundation; either version 2 of the License, or (at your option) any later
    #  version.
    #
    #  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
    #  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
    #  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
    #  details.
    #

ad_page_contract {
}  -query {
  {mode:optional ""}
  {new_MaxFilesByCommunity:optional ""}
  {new_MaxQuotaByCommunity:optional ""}
  {new_MaxFilesByUser:optional ""}
  {new_MaxQuotaByUser:optional ""}
  {new_MaxFilesByUserComm:optional ""}
  {new_MaxQuotaByUserComm:optional ""}
  {new_MaxFilesByUserFolder:optional ""}
  {new_MaxQuotaByUserFolder:optional ""}
  
} -properties {
}

# Control site_wide_admin
if {![acs_user::site_wide_admin_p  -user_id [ad_conn user_id]]} {
        ad_returnredirect "[dotlrn::get_url]"
}

# Control Cuota Activation
if {$mode eq "update_qc"} {
        set QuotaEnabled [quota::get_parameter -param "QuotaEnabled"]
        if {$QuotaEnabled} {
                quota::update_parameter -param "QuotaEnabled" -value 0
        } else {
                quota::update_parameter -param "QuotaEnabled" -value 1          
        }
}

# Update Default Parameters Values
if {$mode eq "update_parameters"} {
        quota::update_parameter -param "MaxFilesByCommunity" -value  $new_MaxFilesByCommunity
        quota::update_parameter -param "MaxQuotaByCommunity" -value $new_MaxQuotaByCommunity
        quota::update_parameter -param "MaxFilesByUser" -value $new_MaxFilesByUser
        quota::update_parameter -param "MaxQuotaByUser" -value $new_MaxQuotaByUser
        quota::update_parameter -param "MaxFilesByUserComm" -value $new_MaxFilesByUserComm
        quota::update_parameter -param "MaxQuotaByUserComm" -value $new_MaxQuotaByUserComm
        quota::update_parameter -param "MaxFilesByUserFolder" -value $new_MaxFilesByUserFolder
        quota::update_parameter -param "MaxQuotaByUserFolder" -value $new_MaxQuotaByUserFolder
}



# Obtenemos valores de los parámetros
set MaxFilesByCommunity [quota::get_parameter -param "MaxFilesByCommunity"]
set MaxQuotaByCommunity [quota::get_parameter -param "MaxQuotaByCommunity"]
set MaxFilesByUser [quota::get_parameter -param "MaxFilesByUser"]
set MaxQuotaByUser [quota::get_parameter -param "MaxQuotaByUser"]
set MaxFilesByUserComm [quota::get_parameter -param "MaxFilesByUserComm"]
set MaxQuotaByUserComm [quota::get_parameter -param "MaxQuotaByUserComm"]
set MaxFilesByUserFolder [quota::get_parameter -param "MaxFilesByUserFolder"]
set MaxQuotaByUserFolder [quota::get_parameter -param "MaxQuotaByUserFolder"]
set QuotaEnabled [quota::get_parameter -param "QuotaEnabled"]


