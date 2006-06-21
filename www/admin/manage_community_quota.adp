<master>
<!-- Copyright (C) 2006 University of Valencia
    Author: Paco Soler
    This file is part of dotLRN.    
-->

<link rel="stylesheet" href="../quota.css" type="text/css">

<style type="text/css">
<!--
td {padding-left:10px; padding-right:10px}
-->
</style>
<H1>#quota-portlet.quota_admin#</H1>

<TABLE>
<TR>
<TH align="left"><h2 style="color:#003366">@pretty_name@</h2>
<TH align="right"><h2 style="color:#003366"><A HREF="manage_site_quota">#quota.back#</h2>
</TR>
<TR>
<TD class="param">Community ID: @community_id@ &nbsp;&nbsp;&nbsp;&nbsp;
<TD class="param">Community Key: @community_key@
</TR>
</TABLE>
<if @has_instances@ eq 0>
<H4>This community hasn't instancied the package quota. To set special values for this community it's needed to add the applet "QUOTA"
<BR>
<A HREF="@community_url@applet-add?applet_key=dotlrn_quota&referer=@referer@">Instance package quota for this community now</A>
</H4>


</if>
<else>
<TABLE>
<TR>
<TH colspan="2" align="left">
<if @QuotaEnabled@>
<H3>#quota.quota_on# <a href="manage_community_quota?mode=update_cqc&cid=@community_id@">#quota.quota_set_off#</a></H3>
</if><else>
<H3>#quota.quota_off# <a href="manage_community_quota?mode=update_cqc&cid=@community_id@">#quota.quota_set_on#</a></H3>
</else>
</TR>
<TR>
<TH colspan="2" align="left"><H3>#quota.parameters#</H3>
</TR>
<form name="upload_limit_size" method="post" action="manage_community_quota">

<TR>
<TD class="param">MaxQuotaByCommunity
<TD class="info">
        <input type="text" name="new_MaxQuotaByCommunity" value="@MaxQuotaByCommunity@" maxlength="6"><BR>
        #quota.MaxQuotaByCommunity_help#                
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
        #quota.MaxFilesByCommunity_help#<BR>
        <input type="hidden" name="cid" value="@community_id@">
        <input type="hidden" name="mode" value="update_community_parameters">
        <input type="submit" name="submit" value="#quota.save_changes#">                
</TR>

<!--
<TR>
<TD class="param">MaxFilesByUserComm
<TD class="info">
        <input type="text" name="new_MaxFilesByUserComm" value="@MaxFilesByUserComm@" maxlength="3"><BR>
        #quota.MaxFilesByUserComm_help# <br>

</TR>
-->

</FORM>
</TABLE>
</else>
