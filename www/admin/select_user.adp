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
<TH align="left"><h2 style="color:#003366">#quota.select_user#</H">
<TH align="right"><h2 style="color:#003366"><A HREF="manage_site_quota">#quota.back#</h2>
</TR>

<TR>
<TD><B>USER_ID</B></TD>
<TD><B>NAME</B></TD>
<TD><B>USERNAME</B></TD>
</TR>
<multiple name="user">
<TR>
<TD><A href="manage_user_quota?uid=@user.user_id@">@user.user_id@</a></TD>
<TD><A href="manage_user_quota?uid=@user.user_id@">@user.last_name@, @user.first_names@</a></TD>
<TD><A href="manage_user_quota?uid=@user.user_id@">@user.username@</a></TD>
</TR>
</multiple>
<TR>
<TD colspan="3">@user:rowcount@ #quota.user#s</a></TD>
</TR>
</TABLE>
