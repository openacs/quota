<master>
<!-- Copyright (C) 2006 University of Valencia
    Author: Paco Soler
    This file is part of dotLRN.    
-->

<link rel="stylesheet" href="../quota.css" type="text/css">

<style type="text/css">
<!--
td {padding-left:10px; padding-right:10px}
body {color:#003366}
.list0 {border:1px solid #A0BDEB;border-bottom: 2px solid #A0BDEB}
.list01 {border-right:1px solid #A0BDEB;border-bottom: 2px solid #A0BDEB}
.list02  {border:1px solid #A0BDEB}
.list1 {border:1px solid #A0BDEB;border-bottom: 2px solid #A0BDEB; border-left:0px}
.list2  {border:1px solid #A0BDEB; border-left:0px}
a.link {background:#FFFFFF;color:#383C93;font-weight:bold}
a.link:visited{background:#FFFFFF;color:#383C93;font-weight:bold}
a.link:hover {background:#FFFFE0;color:#383C93;font-weight:bold}
table.blanca {background:#ffffff}
-->
</style>
<H1>#quota-portlet.quota_admin#</H1>

<TABLE class="blanca">
<TR>
<TH align="left"><h2 style="color:#003366">@last_name@, @first_names@</h2>
<TH align="right"><h2 style="color:#003366"><A HREF="manage_site_quota">#quota.back#</h2>
</TR>
<TR>
<TD><UL><LI><B>User ID</B>: @user_id@ &nbsp;&nbsp;&nbsp;&nbsp;</UL>
<TD><UL><LI><B>Username</B>: @username@</UL>
</TR>


<!-- USER QUOTA INFO--> 

<if @site_admin@>
<UL>
<LI><H4>#quota.no_quote_for_site_admin#</h4>
</UL>
</if>
<else>
<TR>
<TD>
<UL>
<LI><H4>#quota.Global_quota#</H4>
<TABLE class="blanca" cellpadding="5" cellspacing="0">
  <TR>
    <TH class="list01">&nbsp;</TH>
    <TH class="list1">#quota.total#</TH>
    <TH class="list1">#quota.used#</TH>
    <TH class="list1">#quota.rest#</TH>
  </TR>
  <TR>
    <TD class="list0" align="center">#quota.quota_kb#</TD>
    <TD class="list1" align="center">@gq_total@</TD>
    <TD class="list1" align="center">@gq_used@</TD>
    <TD class="list1" align="center">@gq_rest@</TD>    
  </TR>
  <TR>
    <TD class="list0" align="center">#quota.quota_files#</TD>
    <TD class="list1" align="center">@gf_total@</TD>
    <TD class="list1" align="center">@gf_used@</TD>
    <TD class="list1" align="center">@gf_rest@</TD>       
  </TR>  
</TABLE>
</ul>
</TD>
<TD>
<UL>
<LI><H4>#quota.Personal_folder_quota#</H4>
<TABLE class="blanca" cellpadding="5" cellspacing="0">
  <TR>
    <TH style="border-right:1px solid #A0BDEB">&nbsp;</TH>
    <TH class="list1">#quota.total#</TH>
    <TH class="list1">#quota.used#</TH>
    <TH class="list1">#quota.rest#</TH>
  </TR>
  <TR>
    <TD class="list0" align="center">#quota.quota_kb#</TD>
    <TD class="list1" align="center">@pq_total@</TD>
    <TD class="list1" align="center">@pq_used@</TD>
    <TD class="list1" align="center">@pq_rest@</TD>     
  </TR>
  <TR>
    <TD class="list0" align="center">#quota.quota_files#</TD>
    <TD class="list1" align="center">@pf_total@</TD>
    <TD class="list1" align="center">@pf_used@</TD>
    <TD class="list1" align="center">@pf_rest@</TD>     
  </TR>  
</TABLE>
</ul>
</TD></TR>
<TR>
<TD colspan="2">
<UL>
<LI><H4>#quota.User_quota_by_community#</H4>
<TABLE class="blanca" cellpadding="5" cellspacing="0">
  <TR>
    <TH class="list0" align="left">#quota.community#</TH>
    <TH class="list1" align="center">#quota.used_quota#</TH>
    <TH class="list1" align="center">#quota.quota_files#</TH>
  </TR>
  <multiple name="usercomm">   

  <TR>
    <TD class="list0" align="left">@usercomm.name@</TD>
    <TD class="list1" align="center">@usercomm.q_used@</TD>
    <TD class="list1" align="center">@usercomm.f_used@</TD>
  </TR>
    </multiple> 
</TABLE>
</UL>
</else>
<BR>
</TD>
</TR>

<!-- *************************************************************************--> 
<if @has_quota@ eq 0>
<TR>
<TD class="param">#quota.user_havent_quota#
<TD class="param"><A HREF="manage_user_quota?uid=@user_id@&mode=create_quota">#quota.create_user_quota#</A>
</TR>
</TABLE>
</if><else>
<TR>
<TD class="param">#quota.user_have_quota#
<TD class="param"><A HREF="manage_user_quota?uid=@user_id@&mode=delete_quota">#quota.delete_user_quota#</A>
</TR>

<TR>
<TH colspan="2" align="left">
<if @usercomm_actv@>
<H3>#quota.quota_on# <a href="manage_user_quota?uid=@user_id@&mode=enable_usercomm_quota">#quota.quota_set_off#</a></H3>
</if><else>
<H3>#quota.quota_off# <a href="manage_user_quota?uid=@user_id@&mode=enable_usercomm_quota">#quota.quota_set_on#</a></H3>
</else>
</TR>
<TR>
<TH colspan="2" align="left"><H3>#quota.parameters#</H3>
</TR>
<form name="upload_limit_size" method="post" action="manage_user_quota">
<TR>
<TD class="param">MaxQuotaByUser
<TD class="info">
        <input type="text" name="new_global_quota" value="@global_quota@" maxlength="6"><BR>
        #quota.MaxQuotaByUser_help#     
</TR>
<TR>
<TD class="param">MaxQuotaByUserFolder
<TD class="info">
        <input type="text" name="new_personal_quota" value="@personal_quota@" maxlength="6"><BR>
        #quota.MaxQuotaByUserFolder_help#       
</TR>
<TR>
<TD class="param">MaxFilesByUser
<TD class="info">
        <input type="text" name="new_global_files" value="@global_files@" maxlength="4"><BR>
        #quota.MaxFilesByUser_help#             
</TR>
<TR>
<TD class="param">MaxFilesByUserFolder
<TD class="info">
        <input type="text" name="new_personal_files" value="@personal_files@" maxlength="4"><BR>
        #quota.MaxFilesByUserFolder_help#       <BR>
        <input type="hidden" name="mode" value="update_user_quota">
        <input type="hidden" name="uid" value="@user_id@">
        <input type="submit" name="submit" value="#quota.save_changes#">
        <BR>&nbsp;
</TR>

</FORM>
</TABLE>

</else>
