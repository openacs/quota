<master>

<property name="context">@context;noquote@</property>
<property name="title">Quota</property>

<STYLE type="text/css">
body {color:#003366}
.list0 {border:1px solid #A0BDEB;border-bottom: 2px solid #A0BDEB}
.list02  {border:1px solid #A0BDEB}
.list1 {border:1px solid #A0BDEB;border-bottom: 2px solid #A0BDEB; border-left:0px}
.list2  {border:1px solid #A0BDEB; border-left:0px}
a.link {background:#FFFFFF;color:#383C93;font-weight:bold}
a.link:visited{background:#FFFFFF;color:#383C93;font-weight:bold}
a.link:hover {background:#FFFFE0;color:#383C93;font-weight:bold}
</STYLE>
<DIV width="100%" style="background:#ffffff">
<BR>
<H2>&nbsp;&nbsp;COMMUNITY QUOTA: @community_name@</H2>
<CENTER>

<table width="95%" cellpadding="5" cellspacing="0">
  <TR>
    <TH class="list0">#quota.community#</TH>
    <TH class="list1">#quota.total#</TH>
    <TH class="list1">#quota.used#</TH>
    <TH class="list1">#quota.rest#</TH>
  </TR>
  <TR>    
    <TD class="list0" align="center">#quota.quota_kb#</TD>
    <TD class="list1" align="center">@cq_total@</TD>
    <TD class="list1" align="center">@cq_used@</TD>
    <TD class="list1" align="center">@cq_rest@</TD>    
  </TR>
  <TR>
    <TD class="list0" align="center">#quota.quota_files#</TD>
    <TD class="list1" align="center">@cf_total@</TD>
    <TD class="list1" align="center">@cf_used@</TD>
    <TD class="list1" align="center">@cf_rest@</TD>    
  </TR>  
</TABLE>

<BR>&nbsp;
</CENTER>

