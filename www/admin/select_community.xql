<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
        
        <fullquery name="select_communities">
                <querytext>
                        select community_id, pretty_name, community_key 
                        from dotlrn_communities_all
                        where pretty_name like '%$comm_name%'
                        order by pretty_name asc
            </querytext>
    </fullquery>        
        
                
</queryset>
