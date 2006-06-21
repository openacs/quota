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
<TH align="left"><h2 style="color:#003366">#quota.select_community#</H">
<TH align="right"><h2 style="color:#003366"><A HREF="manage_site_quota">#quota.back#</h2>
</TR>

<TR>
<TD><B>ID</B></TD>
<TD><B>PRETTY NAME</B></TD>
<TD><B>KEY</B></TD>
</TR>
<multiple name="comm">
<TR>
<TD><A href="manage_community_quota?cid=@comm.community_id@">@comm.community_id@</a></TD>
<TD><A href="manage_community_quota?cid=@comm.community_id@">@comm.pretty_name@</a></TD>
<TD><A href="manage_community_quota?cid=@comm.community_id@">@comm.community_key@</a></TD>
</TR>
</multiple>
</TABLE>
