
<master>

<property name="context">@context;noquote@</property>
<property name="title">Quota</property>

<STYLE type="text/css">
body {color:#003366}
.list0 {border:1px solid #A0BDEB;border-bottom: 2px solid #A0BDEB}
.list01 {border-right:1px solid #A0BDEB;border-bottom: 2px solid #A0BDEB}
.list02  {border:1px solid #A0BDEB}
.list1 {border:1px solid #A0BDEB;border-bottom: 2px solid #A0BDEB; border-left:0px}
.list2  {border:1px solid #A0BDEB; border-left:0px}
a.link {background:#FFFFFF;color:#383C93;font-weight:bold}
a.link:visited{background:#FFFFFF;color:#383C93;font-weight:bold}
a.link:hover {background:#FFFFE0;color:#383C93;font-weight:bold}
</STYLE>
<DIV width="100%" style="background:#ffffff">
<BR>


<H2 style="color:#003366">&nbsp;&nbsp;#quota.Detailed_user_quota#</H2>
<H2 style="color:#003366">&nbsp;&nbsp;&nbsp;&nbsp;<U>#quota.name#</U>: @name@  &nbsp;&nbsp;&nbsp;&nbsp; <U>#quota.user#</U>: @username@</H2>


<if @site_admin@>

<UL>

<LI><H4>#quota.no_quote_for_site_admin#</h4>

<LI><H4>#quota.Global_quota#</H4>
<table cellpadding="5" cellspacing="0">
  <TR>
    <TH class="list01">&nbsp;</TH>
    <TH class="list1">#quota.total#</TH>
    <TH class="list1">#quota.used#</TH>
    <TH class="list1">#quota.rest#</TH>
  </TR>
  <TR>
    <TD class="list0" align="center">#quota.quota_kb#</TD>
    <TD class="list1" align="center"> --- </TD>
    <TD class="list1" align="center">@gq_used@</TD>
    <TD class="list1" align="center"> --- </TD>    
  </TR>
  <TR>
    <TD class="list0" align="center">#quota.quota_files#</TD>
    <TD class="list1" align="center"> --- </TD>
    <TD class="list1" align="center">@gf_used@</TD>
    <TD class="list1" align="center"> --- </TD>       
  </TR>  
</TABLE>
<BR>
<LI><H4>#quota.Personal_folder_quota#</H4>
<table cellpadding="5" cellspacing="0">
  <TR>
    <TH style="border-right:1px solid #A0BDEB">&nbsp;</TH>
    <TH class="list1">#quota.total#</TH>
    <TH class="list1">#quota.used#</TH>
    <TH class="list1">#quota.rest#</TH>
  </TR>
  <TR>
    <TD class="list0" align="center">#quota.quota_kb#</TD>
    <TD class="list1" align="center"> --- </TD>
    <TD class="list1" align="center">@pq_used@</TD>
    <TD class="list1" align="center"> --- </TD>     
  </TR>
  <TR>
    <TD class="list0" align="center">#quota.quota_files#</TD>
    <TD class="list1" align="center">---</TD>
    <TD class="list1" align="center">@pf_used@</TD>
    <TD class="list1" align="center">---</TD>     
  </TR>  
</TABLE>
<BR>
</UL>

</if>
<else>
<UL>
<LI><H4>#quota.Global_quota#</H4>
<table cellpadding="5" cellspacing="0">
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
<BR>
<LI><H4>#quota.Personal_folder_quota#</H4>
<table cellpadding="5" cellspacing="0">
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
<BR>
<LI><H4>#quota.User_quota_by_community#</H4>
<table cellpadding="5" cellspacing="0">
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
<BR>

</CENTER>
</DIV>