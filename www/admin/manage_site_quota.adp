<master>
<%
    #
    #  Copyright (C) 2004 University of Valencia
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
%>
<link rel="stylesheet" href="../quota.css" type="text/css">

<H1>#quota-portlet.quota_admin#</H1>


<TABLE>
<TR>
<TH colspan="2" align="left">
<if @QuotaEnabled@>
<H3>#quota.quota_on# <a href="manage_site_quota?mode=update_qc">#quota.quota_set_off#</a></H3>
</if><else>
<H3>#quota.quota_off# <a href="manage_site_quota?mode=update_qc">#quota.quota_set_on#</a></H3>
</else>
</TR>
<TR>
<TH colspan="2" align="left"><H3>#quota.parameters#</H3>
</TR>
<form name="upload_limit_size" method="post" action="manage_site_quota">
<TR>
<TD class="param">MaxQuotaByCommunity
<TD class="info">
        <input type="text" name="new_MaxQuotaByCommunity" value="@MaxQuotaByCommunity@" maxlength="6"><BR>
        #quota.MaxQuotaByCommunity_help#                
</TR>
<TR>
<TD class="param">MaxQuotaByUser
<TD class="info">
        <input type="text" name="new_MaxQuotaByUser" value="@MaxQuotaByUser@" maxlength="6"><BR>
        #quota.MaxQuotaByUser_help#     
</TR>
<TR>
<TD class="param">MaxQuotaByUserFolder
<TD class="info">
        <input type="text" name="new_MaxQuotaByUserFolder" value="@MaxQuotaByUserFolder@" maxlength="6"><BR>
        #quota.MaxQuotaByUserFolder_help#       
</TR>
<!--
<TR>
<TD class="param">MaxQuotaByUserComm
<TD class="info">
        <input type="text" name="new_MaxQuotaByUserComm" value="@MaxQuotaByUserComm@" maxlength="6"><BR>
        #quota.MaxQuotaByUserComm_help#         
</TR>
-->
<TR>
<TD class="param">MaxFilesByCommunity
<TD class="info">
        <input type="text" name="new_MaxFilesByCommunity" value="@MaxFilesByCommunity@" maxlength="4"><BR>
        #quota.MaxFilesByCommunity_help#
</TR>
<TR>
<TD class="param">MaxFilesByUser
<TD class="info">
        <input type="text" name="new_MaxFilesByUser" value="@MaxFilesByUser@" maxlength="4"><BR>
        #quota.MaxFilesByUser_help#             
</TR>
<TR>
<TD class="param">MaxFilesByUserFolder
<TD class="info">
        <input type="text" name="new_MaxFilesByUserFolder" value="@MaxFilesByUserFolder@" maxlength="4"><BR>
        #quota.MaxFilesByUserFolder_help#<br>   
        <input type="hidden" name="mode" value="update_parameters">
        <input type="submit" name="submit" value="#quota.save_changes#">                
</TR>
<!--
<TR>
<TD class="param">MaxFilesByUserComm
<TD class="info">
        <input type="text" name="new_MaxFilesByUserComm" value="@MaxFilesByUserComm@" maxlength="3"><BR>
        #quota.MaxFilesByUserComm_help#<br>
        <input type="hidden" name="mode" value="update_parameters">
        <input type="submit" name="submit" value="#quota.save_changes#">                
</TR>
-->

</FORM>
</TABLE>


<TABLE border="0">
<TR>
<TH colspan="2" align="left">
<H3>#quota.quota_by_community#</H3>
</TR>
<TR>
<form name="manage_community_quota" method="post" action="select_community">
<TD class="param">#quota.name# 
<TD class="info">
        <input type="text" name="comm_name" maxlength="20"> &nbsp;&nbsp;&nbsp;&nbsp;
        <input type="submit" name="submit" value="#quota.Search#">
</form>
</TR>
</TABLE>

<TABLE border="0">
<TR>
<TH colspan="4" align="left">
<H3>#quota.quota_by_user#</H3>
</TR>
<TR>
<form name="manage_user_quota" method="post" action="select_user">
<TD class="param">#quota.name#
<TD class="info">
        <input type="text" name="name" size="50" maxlength="50"> &nbsp;&nbsp;&nbsp;&nbsp;
        <input type="hidden" name="mode" value="name">  
        <input type="submit" name="submit" value="#quota.Search#">
</form>
</TR>   
<TR>    
<form name="manage_username_quota" method="post" action="select_user">
<TD class="param">#quota.username#
<TD class="info">
        <input type="text" name="username" maxlength="20"> &nbsp;&nbsp;&nbsp;&nbsp;
        <input type="hidden" name="mode" value="username">
        <input type="submit" name="submit" value="#quota.Search#">      
</form>
</TR>
</TABLE>
